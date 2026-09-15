import 'dart:math' as math;

import 'package:serverpod/serverpod.dart';

import '../discovery/discovery_metrics.dart';
import '../discovery/discovery_policy_service.dart';
import '../generated/protocol.dart';
import '../security/rate_limiter.dart';
import 'catalog_observation_writer.dart';
import 'place_candidate.dart';
import 'place_detail_view.dart';
import 'place_observation.dart';
import 'place_services.dart';
import 'place_source.dart';
import 'provider_operation.dart';

/// One calibrated provider page for a focused detail search.
abstract interface class FocusedPlaceSource {
  String get calibrationVersion;

  Future<List<PlaceCandidate>> fetch({
    required String query,
    required double latitude,
    required double longitude,
    required String language,
    required String countryCode,
  });
}

typedef _Stored = ({
  PlaceSnapshot snapshot,
  DateTime checkedAt,
  String countryCode,
  bool quarantined,
});

typedef _Attempt = ({
  PlaceDetailRefreshState state,
  String? failureCode,
  DateTime? checkedAt,
  int upstreamRequests,
});

/// Resolves a place's details for Swipe and Discover from the shared catalog,
/// refreshing through the shared Vela-derived source only when needed.
///
/// A fresh snapshot, or one whose missing fields the provider was asked about
/// within the freshness window, is returned without a provider request.
/// Otherwise one focused search runs under a database lease, so concurrent
/// users, modes and server processes refresh a place once, and unsuccessful or
/// incomplete attempts cool down per place. Every valid observation reaches the
/// catalog through the shared writer, without Swipe evidence or coverage; the
/// requested place changes only on an exact provider id match. Swipe session
/// snapshots are never rewritten.
abstract final class PlaceDetailResolver {
  static const provider = 'google-web';

  /// The contract's bound on one synchronous refresh. The stored policy can
  /// tighten it but not extend it, so client timeouts hold.
  static const maximumRefreshSeconds = 10;

  /// Refreshes one user may start per hour, protecting the provider budget
  /// that Swipe searches share.
  static const refreshesPerUserPerHour = 30;

  /// The focused search's span; `SearchPb` never searches a smaller one.
  static const focusRadiusMeters = 3000;

  static const _busyCooldown = Duration(minutes: 1);
  static const _leaseMargin = Duration(seconds: 30);
  static const _uuid = Uuid();

  /// Test seams.
  static DateTime Function() clock = _now;
  static Future<FocusedPlaceSource> Function(
    Session session,
    CachePolicy policy,
  )
  sourceFor = _servicesSource;

  static Future<PlaceDetailResult> resolve(
    Session session, {
    required PoiIdentity identity,
    String? sessionId,
  }) async {
    if (identity.provider.trim().isEmpty ||
        identity.provider.length > 80 ||
        identity.placeId.trim().isEmpty ||
        identity.placeId.length > 500) {
      throw _badRequest('The place identity is invalid.');
    }
    if (sessionId != null && (sessionId.isEmpty || sessionId.length > 128)) {
      throw _badRequest('The session identifier is invalid.');
    }
    if (identity.provider != provider) throw _notFound();
    final placeId = identity.placeId;
    final userId = session.authenticated!.userIdentifier;
    final mode = sessionId == null
        ? DiscoveryMetricMode.discovery
        : DiscoveryMetricMode.swipe;

    SessionPlaceRow? sessionPlace;
    if (sessionId != null) {
      final membership = await ParticipantRow.db.findFirstRow(
        session,
        where: (table) =>
            table.sessionId.equals(sessionId) & table.userId.equals(userId),
      );
      if (membership == null) {
        throw ApiException(
          code: 'forbidden',
          message: 'You can only open places from your own session.',
        );
      }
      sessionPlace = await SessionPlaceRow.db.findFirstRow(
        session,
        where: (table) =>
            table.sessionId.equals(sessionId) & table.placeId.equals(placeId),
      );
      if (sessionPlace == null) {
        throw ApiException(
          code: 'not_found',
          message: 'That place is not part of this session.',
        );
      }
    }

    final policy = await DiscoveryPolicyService.load(session);
    var stored =
        await _stored(session, placeId, sessionPlace: sessionPlace) ??
        (throw _notFound());
    var refresh = await _refreshRow(session, placeId);
    PlaceDetailResult result(
      PlaceDetailRefreshState state, {
      DateTime? retryAfter,
    }) => _result(
      placeId: placeId,
      stored: stored,
      refresh: refresh,
      state: state,
      policy: policy,
      sessionPlace: sessionPlace,
      retryAfter: retryAfter,
    );

    final now = clock();
    if (!_needsRefresh(stored, refresh, policy, now)) {
      await _hit(session, mode);
      return result(PlaceDetailRefreshState.notNeeded);
    }
    if (_leased(refresh, now)) {
      return result(PlaceDetailRefreshState.refreshing);
    }
    if (refresh?.retryAfter case final retryAfter?
        when retryAfter.isAfter(now)) {
      await _hit(session, mode);
      return result(PlaceDetailRefreshState.notNeeded);
    }
    try {
      await RateLimiter.check(
        session,
        operation: 'place-detail-refresh',
        subject: userId,
        limit: refreshesPerUserPerHour,
        window: const Duration(hours: 1),
      );
    } on ApiException catch (error) {
      if (error.code != 'rate_limited') rethrow;
      return result(
        PlaceDetailRefreshState.budgetExceeded,
        retryAfter: now.add(Duration(seconds: error.retryAfterSeconds ?? 60)),
      );
    }

    final detailPolicy = policy.detailRefresh!;
    final seconds = math.min(
      detailPolicy.maximumSeconds,
      maximumRefreshSeconds,
    );
    final token = _uuid.v4();
    final leased = await _acquire(
      session,
      placeId,
      token: token,
      observedAttempt: refresh?.lastAttemptAt,
      now: now,
      leaseExpiresAt: now.add(Duration(seconds: seconds)).add(_leaseMargin),
    );
    if (!leased) {
      // Another request refreshed or is refreshing this place meanwhile.
      stored =
          await _stored(session, placeId, sessionPlace: sessionPlace) ?? stored;
      refresh = await _refreshRow(session, placeId);
      return result(
        _leased(refresh, clock())
            ? PlaceDetailRefreshState.refreshing
            : PlaceDetailRefreshState.notNeeded,
      );
    }

    _Attempt attempt = (
      state: PlaceDetailRefreshState.failed,
      failureCode: 'place_source_unavailable',
      checkedAt: null,
      upstreamRequests: 0,
    );
    try {
      attempt = await _attempt(
        session,
        placeId: placeId,
        stored: stored,
        policy: policy,
        seconds: seconds,
        mode: mode,
      );
      stored =
          await _stored(session, placeId, sessionPlace: sessionPlace) ?? stored;
    } finally {
      final completedAt = clock();
      final cooldown = Duration(minutes: detailPolicy.cooldownMinutes);
      final succeeded = attempt.state == PlaceDetailRefreshState.succeeded;
      await _release(
        session,
        placeId,
        token: token,
        attempt: attempt,
        succeededAt: succeeded ? attempt.checkedAt : null,
        retryAfter: switch (attempt.state) {
          PlaceDetailRefreshState.succeeded =>
            PlaceDetailView.missingFields(stored.snapshot).isEmpty
                ? null
                : completedAt.add(cooldown),
          PlaceDetailRefreshState.budgetExceeded => completedAt.add(
            _busyCooldown,
          ),
          _ => completedAt.add(cooldown),
        },
        now: completedAt,
      );
    }
    refresh = await _refreshRow(session, placeId);
    await DiscoveryMetrics.record(
      session,
      mode: mode,
      operation: DiscoveryMetricOperation.detailRefresh,
      cacheMisses: 1,
      detailRefreshes: attempt.state == PlaceDetailRefreshState.budgetExceeded
          ? 0
          : 1,
      upstreamRequests: attempt.upstreamRequests,
    );
    return result(attempt.state);
  }

  static bool _needsRefresh(
    _Stored stored,
    PoiDetailRefreshRow? refresh,
    CachePolicy policy,
    DateTime now,
  ) {
    if (stored.quarantined) return false;
    final freshAfter = now.subtract(Duration(hours: policy.freshHours));
    if (stored.checkedAt.isBefore(freshAfter)) return true;
    if (PlaceDetailView.missingFields(stored.snapshot).isEmpty) return false;
    final checkedAt = refresh?.lastCheckedAt;
    return checkedAt == null || checkedAt.isBefore(freshAfter);
  }

  static bool _leased(PoiDetailRefreshRow? refresh, DateTime now) =>
      refresh?.leaseExpiresAt?.isAfter(now) ?? false;

  static Future<void> _hit(Session session, DiscoveryMetricMode mode) =>
      DiscoveryMetrics.record(
        session,
        mode: mode,
        operation: DiscoveryMetricOperation.detailRefresh,
        cacheHits: 1,
      );

  static Future<_Attempt> _attempt(
    Session session, {
    required String placeId,
    required _Stored stored,
    required CachePolicy policy,
    required int seconds,
    required DiscoveryMetricMode mode,
  }) async {
    ProviderOperation? operation;
    int spent() {
      final used = operation;
      return used == null
          ? 0
          : math.min(used.requestCount, used.maximumRequests);
    }

    final FocusedPlaceSource source;
    final List<PlaceCandidate> candidates;
    try {
      source = await sourceFor(session, policy);
      candidates = await ProviderOperation.run(
        () => source.fetch(
          query: stored.snapshot.name,
          latitude: stored.snapshot.latitude,
          longitude: stored.snapshot.longitude,
          language: 'en',
          countryCode: stored.countryCode,
        ),
        timeout: Duration(seconds: seconds),
        maximumRequests: policy.detailRefresh!.maximumRequests,
        onCreate: (created) => operation = created,
      );
    } on PlaceSourceException catch (error) {
      if (error.code == 'rate_limited') {
        return (
          state: PlaceDetailRefreshState.budgetExceeded,
          failureCode: 'rate_limited',
          checkedAt: null,
          upstreamRequests: spent(),
        );
      }
      return (
        state: PlaceDetailRefreshState.failed,
        failureCode: _failureCode(error.code),
        checkedAt: null,
        upstreamRequests: spent(),
      );
    } catch (error, stackTrace) {
      session.log(
        'A place detail refresh failed.',
        level: LogLevel.warning,
        exception: error,
        stackTrace: stackTrace,
      );
      return (
        state: PlaceDetailRefreshState.failed,
        failureCode: 'place_source_unavailable',
        checkedAt: null,
        upstreamRequests: spent(),
      );
    }

    final observedAt = clock();
    final observations = [
      for (final candidate in candidates)
        if (PlaceObservation.isValid(candidate))
          PlaceObservation.snapshot(candidate, observedAt),
    ];
    if (observations.isNotEmpty) {
      await CatalogObservationWriter(
        calibrationVersion: source.calibrationVersion,
      ).write(
        session,
        observations,
        countryCode: stored.countryCode,
        observedAt: observedAt,
        metrics: CatalogObservationMetrics(
          mode: mode,
          operation: DiscoveryMetricOperation.detailRefresh,
        ),
      );
    }
    final matched = observations.any((place) => place.placeId == placeId);
    return (
      state: matched
          ? PlaceDetailRefreshState.succeeded
          : PlaceDetailRefreshState.noMatch,
      failureCode: matched ? null : 'no_match',
      checkedAt: observedAt,
      upstreamRequests: spent(),
    );
  }

  /// The canonical catalog record, or the session's own snapshot of a place
  /// the catalog no longer holds. Quarantined records are only reachable from
  /// a session that already shows them, and are never refreshed.
  static Future<_Stored?> _stored(
    Session session,
    String placeId, {
    required SessionPlaceRow? sessionPlace,
  }) async {
    final catalog = await PoiCatalogRow.db.findFirstRow(
      session,
      where: (table) =>
          table.provider.equals(provider) &
          table.providerPlaceId.equals(placeId),
    );
    if (catalog != null) {
      final quarantined = catalog.quarantinedAt != null;
      if (quarantined && sessionPlace == null) return null;
      return (
        snapshot: catalog.snapshot,
        checkedAt: catalog.sourceCheckedAt,
        countryCode: catalog.countryCode,
        quarantined: quarantined,
      );
    }
    if (sessionPlace == null) return null;
    final owner = await HayerSessionRow.db.findFirstRow(
      session,
      where: (table) => table.sessionId.equals(sessionPlace.sessionId),
    );
    return (
      snapshot: sessionPlace.snapshot,
      checkedAt: sessionPlace.snapshot.sourceCheckedAt,
      countryCode: owner?.countryCode ?? 'SA',
      quarantined: false,
    );
  }

  static Future<PoiDetailRefreshRow?> _refreshRow(
    Session session,
    String placeId,
  ) => PoiDetailRefreshRow.db.findFirstRow(
    session,
    where: (table) =>
        table.provider.equals(provider) & table.providerPlaceId.equals(placeId),
  );

  /// Takes the place's refresh lease only if no attempt has started since
  /// [observedAttempt] was read, no live lease is held and no cooldown runs.
  static Future<bool> _acquire(
    Session session,
    String placeId, {
    required String token,
    required DateTime? observedAttempt,
    required DateTime now,
    required DateTime leaseExpiresAt,
  }) async {
    final rows = await session.db.unsafeQuery(
      '''
INSERT INTO "hayer_poi_detail_refresh" AS refresh (
  "provider", "providerPlaceId", "state", "leaseToken", "leaseExpiresAt",
  "lastAttemptAt", "attemptCount", "updatedAt"
)
VALUES (
  @provider, @placeId, 'refreshing', @token,
  CAST(@leaseExpiresAt AS timestamp), CAST(@now AS timestamp), 1,
  CAST(@now AS timestamp)
)
ON CONFLICT ("provider", "providerPlaceId") DO UPDATE SET
  "state" = 'refreshing',
  "leaseToken" = EXCLUDED."leaseToken",
  "leaseExpiresAt" = EXCLUDED."leaseExpiresAt",
  "lastAttemptAt" = EXCLUDED."lastAttemptAt",
  "attemptCount" = refresh."attemptCount" + 1,
  "updatedAt" = EXCLUDED."updatedAt"
WHERE refresh."lastAttemptAt" IS NOT DISTINCT FROM
    CAST(@observedAttempt AS timestamp)
  AND (
    refresh."leaseExpiresAt" IS NULL
    OR refresh."leaseExpiresAt" <= EXCLUDED."lastAttemptAt"
  )
  AND (
    refresh."retryAfter" IS NULL
    OR refresh."retryAfter" <= EXCLUDED."lastAttemptAt"
  )
RETURNING "leaseToken"
''',
      parameters: QueryParameters.named({
        'provider': provider,
        'placeId': placeId,
        'token': token,
        'leaseExpiresAt': leaseExpiresAt.toIso8601String(),
        'now': now.toIso8601String(),
        'observedAttempt': observedAttempt?.toIso8601String(),
      }),
    );
    return rows.isNotEmpty;
  }

  /// Records the attempt's outcome and releases the lease, unless it expired
  /// and another request has taken it over.
  static Future<void> _release(
    Session session,
    String placeId, {
    required String token,
    required _Attempt attempt,
    required DateTime? succeededAt,
    required DateTime? retryAfter,
    required DateTime now,
  }) => session.db.unsafeExecute(
    '''
UPDATE "hayer_poi_detail_refresh" SET
  "state" = @state,
  "leaseToken" = NULL,
  "leaseExpiresAt" = NULL,
  "lastCheckedAt" = COALESCE(CAST(@checkedAt AS timestamp), "lastCheckedAt"),
  "lastSuccessAt" = COALESCE(CAST(@succeededAt AS timestamp), "lastSuccessAt"),
  "retryAfter" = CAST(@retryAfter AS timestamp),
  "lastFailureCode" = @failureCode,
  "updatedAt" = CAST(@now AS timestamp)
WHERE "provider" = @provider
  AND "providerPlaceId" = @placeId
  AND "leaseToken" = @token
''',
    parameters: QueryParameters.named({
      'state': attempt.state.name,
      'checkedAt': attempt.checkedAt?.toIso8601String(),
      'succeededAt': succeededAt?.toIso8601String(),
      'retryAfter': retryAfter?.toIso8601String(),
      'failureCode': attempt.failureCode,
      'now': now.toIso8601String(),
      'provider': provider,
      'placeId': placeId,
      'token': token,
    }),
  );

  static PlaceDetailResult _result({
    required String placeId,
    required _Stored stored,
    required PoiDetailRefreshRow? refresh,
    required PlaceDetailRefreshState state,
    required CachePolicy policy,
    required SessionPlaceRow? sessionPlace,
    DateTime? retryAfter,
  }) {
    final now = clock();
    final fresh = !stored.checkedAt.isBefore(
      now.subtract(Duration(hours: policy.freshHours)),
    );
    var place = PlaceDetailView.present(stored.snapshot, fresh: fresh);
    if (sessionPlace != null) {
      // Distance belongs to the session's anchor, not the shared record.
      place = place.copyWith(
        distanceMeters: sessionPlace.snapshot.distanceMeters,
      );
    }
    final retry = retryAfter ?? refresh?.retryAfter;
    return PlaceDetailResult(
      identity: PoiIdentity(provider: provider, placeId: placeId),
      place: place,
      stale: !fresh,
      refreshState: state,
      missingFields: PlaceDetailView.missingFields(place),
      lastAttemptAt: refresh?.lastAttemptAt,
      lastSuccessAt: refresh?.lastSuccessAt,
      retryAfter: retry != null && retry.isAfter(now) ? retry : null,
      fetchedAt: now,
    );
  }

  static String _failureCode(String code) =>
      RegExp(r'^[a-z_]{1,64}$').hasMatch(code)
      ? code
      : 'place_source_unavailable';

  static Future<FocusedPlaceSource> _servicesSource(
    Session session,
    CachePolicy policy,
  ) async {
    final services = await PlaceServices.forSession(session);
    services.source.configureRateLimit(
      requestsPerMinute: policy.globalRequestsPerMinute,
      burst: policy.globalBurst,
    );
    return _ServicesSource(services);
  }

  static DateTime _now() => DateTime.now().toUtc();

  static ApiException _badRequest(String message) =>
      ApiException(code: 'bad_request', message: message);

  static ApiException _notFound() => ApiException(
    code: 'not_found',
    message: 'That place is not in the catalog.',
  );
}

final class _ServicesSource implements FocusedPlaceSource {
  const _ServicesSource(this._services);

  final PlaceServices _services;

  @override
  String get calibrationVersion => _services.calibration.version;

  @override
  Future<List<PlaceCandidate>> fetch({
    required String query,
    required double latitude,
    required double longitude,
    required String language,
    required String countryCode,
  }) => _services.source.fetchPage(
    query: query,
    latitude: latitude,
    longitude: longitude,
    radiusMeters: PlaceDetailResolver.focusRadiusMeters,
    language: language,
    countryCode: countryCode,
    offset: 0,
  );
}
