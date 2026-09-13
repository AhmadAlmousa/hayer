import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../places/poi_issue_policy.dart';
import '../places/place_services.dart';
import '../places/place_source.dart';
import '../places/reverse_geocoding_service.dart';
import '../places/route_estimate_policy_service.dart';
import '../security/rate_limiter.dart';

class PlaceEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  static final _geocoder = ReverseGeocodingService.shared;
  static const _uuid = Uuid();

  Future<List<LocationSuggestion>> suggest(
    Session session, {
    required String query,
    double? latitude,
    double? longitude,
    String countryCode = 'SA',
  }) async {
    final input = query.trim();
    if (input.length < 3) return const [];
    if (input.length > 120) {
      throw ApiException(
        code: 'bad_request',
        message: 'The search text is too long.',
      );
    }
    await RateLimiter.check(
      session,
      operation: 'place-suggest',
      subject: session.authenticated!.userIdentifier,
      limit: 30,
      window: const Duration(minutes: 1),
    );
    try {
      final places = await PlaceServices.forSession(session);
      return await places.search.suggest(
        input: input,
        latitude: latitude,
        longitude: longitude,
        countryCode: _country(countryCode),
      );
    } on PlaceSourceException catch (error) {
      throw ApiException(code: error.code, message: error.message);
    }
  }

  Future<String> reverseGeocode(
    Session session, {
    required double latitude,
    required double longitude,
    String languageCode = 'en',
  }) async {
    if (!latitude.isFinite ||
        !longitude.isFinite ||
        latitude < -90 ||
        latitude > 90 ||
        longitude < -180 ||
        longitude > 180) {
      throw ApiException(
        code: 'bad_request',
        message: 'The location coordinates are invalid.',
      );
    }
    await RateLimiter.check(
      session,
      operation: 'reverse-geocode',
      subject: session.authenticated!.userIdentifier,
      limit: 10,
      window: const Duration(minutes: 1),
    );
    try {
      return await _geocoder.reverse(
        latitude: latitude,
        longitude: longitude,
        languageCode: const {'ar', 'en'}.contains(languageCode)
            ? languageCode
            : 'en',
      );
    } on ReverseGeocodingException catch (error) {
      throw ApiException(code: 'location_unavailable', message: error.message);
    }
  }

  Future<RouteEstimate> routeEstimate(
    Session session, {
    required String sessionId,
    required String placeId,
    double? originLatitude,
    double? originLongitude,
  }) async {
    if ((originLatitude == null) != (originLongitude == null)) {
      throw ApiException(
        code: 'bad_request',
        message: 'Both origin coordinates are required.',
      );
    }
    if (originLatitude != null &&
        (!_validLatitude(originLatitude) ||
            !_validLongitude(originLongitude!))) {
      throw ApiException(
        code: 'bad_request',
        message: 'The location coordinates are invalid.',
      );
    }
    final userId = session.authenticated!.userIdentifier;
    await RateLimiter.check(
      session,
      operation: 'route-estimate',
      subject: userId,
      limit: 60,
      window: const Duration(minutes: 1),
    );
    final sessionRow = await HayerSessionRow.db.findFirstRow(
      session,
      where: (table) => table.sessionId.equals(sessionId),
    );
    if (sessionRow == null) {
      throw ApiException(code: 'not_found', message: 'Session not found.');
    }
    final membership = await ParticipantRow.db.findFirstRow(
      session,
      where: (table) =>
          table.sessionId.equals(sessionId) & table.userId.equals(userId),
    );
    if (membership == null) {
      throw ApiException(
        code: 'forbidden',
        message: 'You are not a participant in this session.',
      );
    }
    final policy = await RouteEstimatePolicyService.load(session);
    if (!policy.enabled) {
      throw ApiException(
        code: 'route_estimates_disabled',
        message: 'Route estimates are disabled.',
      );
    }
    if (originLatitude != null &&
        (sessionRow.mode != SessionMode.multiplayer ||
            !policy.allowParticipantLocation)) {
      throw ApiException(
        code: 'personal_location_disabled',
        message: 'Personal route origins are disabled for this session.',
      );
    }
    final place = await SessionPlaceRow.db.findFirstRow(
      session,
      where: (table) =>
          table.sessionId.equals(sessionId) & table.placeId.equals(placeId),
    );
    if (place == null) {
      throw ApiException(
        code: 'not_found',
        message: 'Place not found in this session.',
      );
    }
    final settings = await RouteEstimatePolicyService.settings(session);
    try {
      final services = await PlaceServices.forSession(session);
      final estimate = await services.routes.estimate(
        originLatitude: originLatitude ?? sessionRow.anchorLatitude,
        originLongitude: originLongitude ?? sessionRow.anchorLongitude,
        destinationLatitude: place.snapshot.latitude,
        destinationLongitude: place.snapshot.longitude,
        countryCode: sessionRow.countryCode,
        cacheMinutes: policy.cacheMinutes,
        requestsPerMinute: settings?.routeRequestsPerMinute ?? 30,
        burst: settings?.routeBurst ?? 6,
      );
      return RouteEstimate(
        distanceMeters: estimate.distanceMeters,
        durationSeconds: estimate.durationSeconds,
        trafficAware: estimate.trafficAware,
        checkedAt: estimate.checkedAt,
      );
    } on PlaceSourceException catch (error) {
      throw ApiException(code: error.code, message: error.message);
    }
  }

  Future<String> reportIssue(
    Session session, {
    required String sessionId,
    required String placeId,
    required PoiIssueType issueType,
    String? details,
    required String idempotencyKey,
  }) async {
    final String? normalizedDetails;
    try {
      PoiIssuePolicy.validateRequestIdentifiers(
        sessionId: sessionId,
        placeId: placeId,
        idempotencyKey: idempotencyKey,
      );
      normalizedDetails = PoiIssuePolicy.normalizeDetails(issueType, details);
    } on FormatException catch (error) {
      throw ApiException(code: 'bad_request', message: error.message);
    }

    final userId = session.authenticated!.userIdentifier;
    final salt =
        session.passwords['adminIpHashSalt'] ??
        (session.server.runMode == ServerpodRunMode.test
            ? 'test-only-poi-reporter-salt'
            : null);
    if (salt == null || salt.trim().isEmpty || salt == 'unconfigured') {
      throw ApiException(
        code: 'server_error',
        message: 'Issue reporting is temporarily unavailable.',
      );
    }
    final reporterHash = PoiIssuePolicy.reporterHash(
      salt: salt,
      userId: userId,
    );
    final activeDedupeKey = PoiIssuePolicy.activeDedupeKey(
      reporterHash: reporterHash,
      placeId: placeId,
      issueType: issueType,
    );
    final requestHash = sha256
        .convert(
          utf8.encode(
            jsonEncode({
              'sessionId': sessionId,
              'placeId': placeId,
              'issueType': issueType.name,
              'details': normalizedDetails,
            }),
          ),
        )
        .toString();
    final now = DateTime.now().toUtc();
    final proposedReportId = _uuid.v7();

    return session.db.transaction((transaction) async {
      final idempotencyRows = await IdempotencyRow.db.insert(
        session,
        [
          IdempotencyRow(
            scope: 'poi-issue-report',
            userId: reporterHash,
            idempotencyKey: idempotencyKey,
            requestHash: requestHash,
            responseId: proposedReportId,
            createdAt: now,
            expiresAt: now.add(const Duration(hours: 24)),
          ),
        ],
        transaction: transaction,
        ignoreConflicts: true,
      );
      if (idempotencyRows.isEmpty) {
        final existingKey = await IdempotencyRow.db.findFirstRow(
          session,
          where: (table) =>
              table.scope.equals('poi-issue-report') &
              table.userId.equals(reporterHash) &
              table.idempotencyKey.equals(idempotencyKey),
          transaction: transaction,
        );
        if (existingKey == null) {
          throw StateError(
            'Idempotency row disappeared after an issue-report conflict.',
          );
        }
        if (existingKey.requestHash != requestHash) {
          throw ApiException(
            code: 'conflict',
            message: 'This retry key was already used for another report.',
          );
        }
        return existingKey.responseId;
      }

      final membership = await ParticipantRow.db.findFirstRow(
        session,
        where: (table) =>
            table.sessionId.equals(sessionId) & table.userId.equals(userId),
        transaction: transaction,
      );
      if (membership == null) {
        throw ApiException(
          code: 'forbidden',
          message: 'You can only report places from your own session.',
        );
      }
      final place = await SessionPlaceRow.db.findFirstRow(
        session,
        where: (table) =>
            table.sessionId.equals(sessionId) & table.placeId.equals(placeId),
        transaction: transaction,
      );
      if (place == null) {
        throw ApiException(
          code: 'not_found',
          message: 'That place is not part of this session.',
        );
      }

      // Different retry keys for the same reporter/place/type must serialize
      // before consulting the nullable unique dedupe key.
      await session.db.unsafeQuery(
        'SELECT pg_advisory_xact_lock(hashtextextended(@dedupeKey, 0))',
        parameters: QueryParameters.named({'dedupeKey': activeDedupeKey}),
        transaction: transaction,
      );
      final activeReport = await PoiIssueReportRow.db.findFirstRow(
        session,
        where: (table) => table.activeDedupeKey.equals(activeDedupeKey),
        transaction: transaction,
      );
      if (activeReport != null) {
        final idempotency = idempotencyRows.single
          ..responseId = activeReport.reportId;
        await IdempotencyRow.db.updateRow(
          session,
          idempotency,
          columns: (table) => [table.responseId],
          transaction: transaction,
        );
        return activeReport.reportId;
      }

      await RateLimiter.check(
        session,
        operation: 'poi-issue-report-hour',
        subject: reporterHash,
        limit: 6,
        window: const Duration(hours: 1),
        transaction: transaction,
      );
      await RateLimiter.check(
        session,
        operation: 'poi-issue-report-day',
        subject: reporterHash,
        limit: 20,
        window: const Duration(days: 1),
        transaction: transaction,
      );
      await PoiIssueReportRow.db.insertRow(
        session,
        PoiIssueReportRow(
          reportId: proposedReportId,
          reporterHash: reporterHash,
          activeDedupeKey: activeDedupeKey,
          sessionId: sessionId,
          placeId: placeId,
          placeName: place.snapshot.name,
          reportedSnapshot: place.snapshot,
          issueType: issueType,
          details: normalizedDetails,
          status: PoiIssueStatus.open,
          createdAt: now,
          updatedAt: now,
        ),
        transaction: transaction,
      );
      return proposedReportId;
    });
  }

  String _country(String value) {
    final normalized = value.trim().toUpperCase();
    const supported = {'SA', 'AE', 'KW', 'QA', 'BH', 'OM'};
    return supported.contains(normalized) ? normalized : 'SA';
  }

  bool _validLatitude(double value) =>
      value.isFinite && value >= -90 && value <= 90;

  bool _validLongitude(double value) =>
      value.isFinite && value >= -180 && value <= 180;
}
