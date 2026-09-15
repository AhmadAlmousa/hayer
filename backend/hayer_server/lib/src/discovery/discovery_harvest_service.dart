import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:crypto/crypto.dart';
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../places/catalog_observation_writer.dart';
import '../places/catalog_place_service.dart';
import '../places/discovery_query.dart';
import '../places/place_candidate.dart';
import '../places/place_observation.dart';
import '../places/place_services.dart';
import '../places/place_source.dart';
import '../places/provider_operation.dart';
import '../places/taxonomy.dart';
import '../places/taxonomy_service.dart';
import '../security/rate_limiter.dart';
import 'discovery_area.dart';
import 'discovery_harvest_manifest_service.dart';
import 'discovery_harvest_plan.dart';
import 'discovery_harvest_scheduler.dart';
import 'discovery_metrics.dart';
import 'discovery_policy_service.dart';

/// Calibrated provider pages for harvests.
abstract interface class HarvestPageSource {
  String get calibrationVersion;
  int get pageSize;

  Future<List<PlaceCandidate>> fetchPage({
    required String query,
    required double latitude,
    required double longitude,
    required int radiusMeters,
    required String language,
    required String countryCode,
    required int offset,
  });
}

/// What the refresh-job worker lends a harvest it runs under its lease.
abstract interface class HarvestJobControl {
  Future<bool> ownsLease();
  Future<void> heartbeat();
  Future<void> finish(JobStatus status, [String? code]);
  void registerOperation(ProviderOperation operation);
}

typedef _Requested = ({
  DiscoveryHarvestRow? job,
  DateTime? retryAfter,
  bool fresh,
  bool created,
});

/// Grows the shared catalog around committed Discover areas.
///
/// A committed search or explicit Deepen resolves one canonical cell. Under a
/// transaction-scoped advisory lock on that cell, a request joins the active
/// job for the same country, cell, radius, manifest revision and calibration;
/// returns fresh coverage without provider work (committed searches only);
/// returns a completed job's cooldown; or spends the user's harvest quota and
/// enqueues one job. Jobs run in the refresh-job worker through the shared
/// Vela-derived source and observation writer, within the policy's request
/// and time budget.
abstract final class DiscoveryHarvestService {
  /// A compatibility query is skipped while its Swipe coverage is this full
  /// and fresh: the default Swipe deck size.
  static const compatibilitySufficientResults = 20;

  static const _uuid = Uuid();
  static const _deepenScope = 'discovery-deepen';

  /// Test seams.
  static DateTime Function() clock = _now;
  static Future<HarvestPageSource> Function(
    Session session,
    CachePolicy policy,
  )
  sourceFor = _servicesSource;
  static Future<String> Function(Session session) calibrationVersionFor =
      _activeCalibrationVersion;

  static Future<DiscoveryAreaReceipt> ensureArea(
    Session session, {
    required DiscoverViewport viewport,
    String? countryCode,
  }) => _request(
    session,
    viewport: viewport,
    countryCode: countryCode,
    trigger: DiscoveryHarvestTrigger.committedSearch,
  );

  static Future<DiscoveryAreaReceipt> deepen(
    Session session, {
    required DiscoverViewport viewport,
    String? countryCode,
    required String idempotencyKey,
  }) async {
    if (idempotencyKey.length < 8 || idempotencyKey.length > 128) {
      throw ApiException(
        code: 'bad_request',
        message: 'The retry key is invalid.',
      );
    }
    return _request(
      session,
      viewport: viewport,
      countryCode: countryCode,
      trigger: DiscoveryHarvestTrigger.deepen,
      idempotencyKey: idempotencyKey,
    );
  }

  static Future<DiscoveryHarvestStatus> status(
    Session session, {
    required String jobId,
  }) async {
    if (jobId.trim().isEmpty || jobId.length > 64) {
      throw ApiException(
        code: 'bad_request',
        message: 'The exploration id is invalid.',
      );
    }
    final job = await DiscoveryHarvestRow.db.findFirstRow(
      session,
      where: (table) => table.jobId.equals(jobId),
    );
    if (job == null) {
      throw ApiException(
        code: 'not_found',
        message: 'That exploration was not found.',
      );
    }
    final policy = await DiscoveryPolicyService.load(session);
    return statusOf(job, policy.discovery!);
  }

  static Future<DiscoveryAreaReceipt> _request(
    Session session, {
    required DiscoverViewport viewport,
    required String? countryCode,
    required DiscoveryHarvestTrigger trigger,
    String? idempotencyKey,
  }) async {
    final country = DiscoveryArea.resolveCountry(viewport, countryCode);
    final cell = DiscoveryArea.cell(viewport, countryCode: country);
    final policy = await DiscoveryPolicyService.load(session);
    final discovery = policy.discovery!;
    final manifest = await DiscoveryHarvestManifestService.activeRow(session);
    final calibrationVersion = await calibrationVersionFor(session);
    final compatibility = await _compatibilityQueries(session);
    final harvestKey =
        'discovery:$country:${cell.cellId}:${cell.radiusMeters}'
        ':m${manifest.revision}:$calibrationVersion';
    final userId = session.authenticated!.userIdentifier;
    final requestHash = sha256
        .convert(
          utf8.encode(
            jsonEncode({
              'country': country,
              'cell': cell.cellId,
              'radius': cell.radiusMeters,
            }),
          ),
        )
        .toString();
    final now = clock();

    final requested = await session.db.transaction<_Requested>((
      transaction,
    ) async {
      // Serializes requests for this cell across server processes, whether
      // or not any coverage or job exists yet.
      await session.db.unsafeQuery(
        'SELECT pg_advisory_xact_lock(hashtextextended(@cell, 0))',
        parameters: QueryParameters.named({
          'cell': 'discovery:$country:${cell.cellId}:${cell.radiusMeters}',
        }),
        transaction: transaction,
      );
      if (idempotencyKey != null) {
        final remembered = await IdempotencyRow.db.findFirstRow(
          session,
          where: (table) =>
              table.scope.equals(_deepenScope) &
              table.userId.equals(userId) &
              table.idempotencyKey.equals(idempotencyKey),
          transaction: transaction,
        );
        if (remembered != null) {
          if (remembered.requestHash != requestHash) {
            throw ApiException(
              code: 'conflict',
              message: 'This retry key was already used for another area.',
            );
          }
          final job = await DiscoveryHarvestRow.db.findFirstRow(
            session,
            where: (table) => table.jobId.equals(remembered.responseId),
            transaction: transaction,
          );
          if (job != null) {
            return (job: job, retryAfter: null, fresh: false, created: false);
          }
        }
      }
      Future<void> remember(String jobId) async {
        if (idempotencyKey == null) return;
        await IdempotencyRow.db.insert(
          session,
          [
            IdempotencyRow(
              scope: _deepenScope,
              userId: userId,
              idempotencyKey: idempotencyKey,
              requestHash: requestHash,
              responseId: jobId,
              createdAt: now,
              expiresAt: now.add(const Duration(hours: 24)),
            ),
          ],
          transaction: transaction,
          ignoreConflicts: true,
        );
      }

      final active = await DiscoveryHarvestRow.db.findFirstRow(
        session,
        where: (table) =>
            table.harvestKey.equals(harvestKey) &
            (table.state.equals(DiscoveryHarvestState.pending) |
                table.state.equals(DiscoveryHarvestState.running)),
        transaction: transaction,
      );
      if (active != null) {
        await remember(active.jobId);
        return (job: active, retryAfter: null, fresh: false, created: false);
      }

      final coverage = await DiscoveryCoverageRow.db.findFirstRow(
        session,
        where: (table) =>
            table.countryCode.equals(country) &
            table.cellId.equals(cell.cellId) &
            table.radiusMeters.equals(cell.radiusMeters),
        transaction: transaction,
      );
      if (trigger == DiscoveryHarvestTrigger.committedSearch &&
          _fresh(coverage, manifest, policy.freshHours, now)) {
        return (job: null, retryAfter: null, fresh: true, created: false);
      }

      final last = await DiscoveryHarvestRow.db.findFirstRow(
        session,
        where: (table) =>
            table.countryCode.equals(country) &
            table.cellId.equals(cell.cellId) &
            table.radiusMeters.equals(cell.radiusMeters) &
            table.completedAt.notEquals(null) &
            (table.state.equals(DiscoveryHarvestState.succeeded) |
                table.state.equals(DiscoveryHarvestState.partial) |
                table.state.equals(DiscoveryHarvestState.failed)),
        orderBy: (table) => table.completedAt,
        orderDescending: true,
        transaction: transaction,
      );
      final cooldownEnds = last?.completedAt?.add(
        Duration(minutes: discovery.harvestCooldownMinutes),
      );
      if (last != null && cooldownEnds != null && cooldownEnds.isAfter(now)) {
        return (
          job: last,
          retryAfter: cooldownEnds,
          fresh: false,
          created: false,
        );
      }

      // Only a new job spends the user's harvest allocation.
      await RateLimiter.check(
        session,
        operation: 'discovery-harvest',
        subject: userId,
        limit: discovery.userHarvestsPerHour,
        window: const Duration(hours: 1),
        transaction: transaction,
      );
      final plan = DiscoveryHarvestPlan(
        cell: cell,
        manifestVersion: manifest.version,
        manifestRevision: manifest.revision,
        manifestEntries: manifest.entries,
        compatibility: compatibility,
        calibrationVersion: calibrationVersion,
      );
      final jobId = _uuid.v7();
      final requestedBy = _requester(session, userId);
      await RefreshJobRow.db.insertRow(
        session,
        RefreshJobRow(
          jobId: jobId,
          coverageKey: harvestKey,
          status: JobStatus.pending,
          requestedBy: requestedBy,
          reason: 'discover:${trigger.name}',
          createdAt: now,
          planJson: plan.encode(),
        ),
        transaction: transaction,
      );
      final bounds = cell.bounds;
      final job = await DiscoveryHarvestRow.db.insertRow(
        session,
        DiscoveryHarvestRow(
          jobId: jobId,
          harvestKey: harvestKey,
          requester: DiscoveryHarvestRequester.user,
          requestedBy: requestedBy,
          trigger: trigger,
          countryCode: country,
          cellId: cell.cellId,
          radiusMeters: cell.radiusMeters,
          centerLatitude: cell.latitude,
          centerLongitude: cell.longitude,
          south: bounds.south,
          west: bounds.west,
          north: bounds.north,
          east: bounds.east,
          manifestVersion: manifest.version,
          manifestRevision: manifest.revision,
          calibrationVersion: calibrationVersion,
          state: DiscoveryHarvestState.pending,
          queryOutcomes: const [],
          attemptedQueries: 0,
          completedQueries: 0,
          totalQueries: plan.totalQueries,
          observedPlaces: 0,
          upstreamRequests: 0,
          createdAt: now,
        ),
        transaction: transaction,
      );
      await remember(jobId);
      return (job: job, retryAfter: null, fresh: false, created: true);
    });

    if (trigger == DiscoveryHarvestTrigger.committedSearch) {
      // A committed search is Discover's cache lookup: fresh coverage is a
      // hit, and a search that needs a new harvest is a miss.
      await DiscoveryMetrics.record(
        session,
        mode: DiscoveryMetricMode.discovery,
        operation: DiscoveryMetricOperation.browse,
        cacheHits: requested.fresh ? 1 : 0,
        cacheMisses: requested.created ? 1 : 0,
      );
    }
    final knownPlaces = await DiscoveryQuery.knownPlaceCount(
      session,
      viewport: viewport,
      countryCode: country,
    );
    return DiscoveryAreaReceipt(
      coverage: await coverageFor(
        session,
        countryCode: country,
        viewport: viewport,
        eligibleCatalogCount: knownPlaces,
        policy: policy,
      ),
      job: requested.job == null ? null : statusOf(requested.job!, discovery),
      retryAfter: requested.retryAfter,
      fetchedAt: clock(),
    );
  }

  /// The coverage descriptor for [viewport]: its known place count, the
  /// harvest footprints that intersect it and the jobs exploring it.
  static Future<DiscoveryCoverage> coverageFor(
    Session session, {
    required String countryCode,
    required DiscoverViewport viewport,
    required int eligibleCatalogCount,
    CachePolicy? policy,
  }) async {
    final loaded = policy ?? await DiscoveryPolicyService.load(session);
    final discovery = loaded.discovery!;
    final manifest = await DiscoveryHarvestManifestService.activeRow(session);
    final now = clock();
    final rows = await DiscoveryCoverageRow.db.find(
      session,
      where: (table) =>
          table.countryCode.equals(countryCode) &
          (table.south < viewport.north) &
          (table.north > viewport.south) &
          (table.west < viewport.east) &
          (table.east > viewport.west),
      orderBy: (table) => table.updatedAt,
      orderDescending: true,
      limit: 20,
    );
    final jobs = await DiscoveryHarvestRow.db.find(
      session,
      where: (table) =>
          table.countryCode.equals(countryCode) &
          (table.state.equals(DiscoveryHarvestState.pending) |
              table.state.equals(DiscoveryHarvestState.running)) &
          (table.south < viewport.north) &
          (table.north > viewport.south) &
          (table.west < viewport.east) &
          (table.east > viewport.west),
      orderBy: (table) => table.createdAt,
      limit: 5,
    );
    final enabled = [
      for (final entry in DiscoveryHarvestManifestService.enabledInOrder(
        manifest.entries,
      ))
        entry.id,
    ];
    final freshAfter = now.subtract(Duration(hours: loaded.freshHours));
    return DiscoveryCoverage(
      eligibleCatalogCount: eligibleCatalogCount,
      footprints: [
        for (final row in rows)
          _footprint(
            row,
            manifestRevision: manifest.revision,
            enabled: enabled,
            freshAfter: freshAfter,
            discovery: discovery,
            now: now,
          ),
      ],
      pendingJobs: [for (final job in jobs) statusOf(job, discovery)],
    );
  }

  static DiscoveryHarvestStatus statusOf(
    DiscoveryHarvestRow job,
    DiscoveryPolicy discovery,
  ) {
    final now = clock();
    return DiscoveryHarvestStatus(
      jobId: job.jobId,
      state: job.state,
      trigger: job.trigger,
      bounds: DiscoverViewport(
        south: job.south,
        west: job.west,
        north: job.north,
        east: job.east,
      ),
      manifestRevision: job.manifestRevision,
      completedQueries: job.completedQueries,
      totalQueries: job.totalQueries,
      observedPlaces: job.observedPlaces,
      fetchedAt: now,
      retryAfter: cooldownEnd(job, discovery, now),
      failureCode: job.failureCode,
    );
  }

  /// When a finished, uncancelled job's cell may be harvested again, while
  /// that is still ahead of [now].
  static DateTime? cooldownEnd(
    DiscoveryHarvestRow job,
    DiscoveryPolicy discovery,
    DateTime now,
  ) {
    final completedAt = job.completedAt;
    if (completedAt == null ||
        !const {
          DiscoveryHarvestState.succeeded,
          DiscoveryHarvestState.partial,
          DiscoveryHarvestState.failed,
        }.contains(job.state)) {
      return null;
    }
    final end = completedAt.add(
      Duration(minutes: discovery.harvestCooldownMinutes),
    );
    return end.isAfter(now) ? end : null;
  }

  /// Cancels pending user harvests when Discover is turned off. Running ones
  /// stop at their next page.
  static Future<int> cancelPendingUserHarvests(
    Session session, {
    required Transaction transaction,
  }) async {
    final rows = await session.db.unsafeQuery(
      '''
WITH cancelled AS (
  UPDATE "hayer_discovery_harvest"
  SET "state" = 'cancelled',
    "completedAt" = CAST(@now AS timestamp),
    "failureCode" = 'feature_disabled'
  WHERE "state" = 'pending' AND "requester" = 'user'
  RETURNING "jobId"
)
UPDATE "hayer_refresh_job" AS job
SET "status" = 'cancelled',
  "completedAt" = CAST(@now AS timestamp),
  "errorCode" = 'feature_disabled'
FROM cancelled
WHERE job."jobId" = cancelled."jobId" AND job."status" = 'pending'
RETURNING job."jobId"
''',
      parameters: QueryParameters.named({
        'now': DateTime.now().toUtc().toIso8601String(),
      }),
      transaction: transaction,
    );
    return rows.length;
  }

  /// Runs a claimed harvest job. The worker owns the lease; this spends the
  /// plan's budget page by page and records every outcome.
  static Future<void> execute(
    Session session,
    RefreshJobRow job,
    HarvestJobControl control,
  ) async {
    final DiscoveryHarvestPlan plan;
    try {
      plan = DiscoveryHarvestPlan.decode(job.planJson!);
    } on FormatException {
      await control.finish(JobStatus.failed, 'invalid_plan');
      return;
    }
    var harvest = await DiscoveryHarvestRow.db.findFirstRow(
      session,
      where: (table) => table.jobId.equals(job.jobId),
    );
    if (harvest == null) {
      await control.finish(JobStatus.failed, 'harvest_not_found');
      return;
    }
    final policy = await DiscoveryPolicyService.load(session);
    final discovery = policy.discovery!;
    final userHarvest = harvest.requester == DiscoveryHarvestRequester.user;
    if (harvest.state == DiscoveryHarvestState.cancelled ||
        (userHarvest && !discovery.enabled)) {
      await control.finish(JobStatus.cancelled, 'feature_disabled');
      await DiscoveryHarvestRow.db.updateRow(
        session,
        harvest
          ..state = DiscoveryHarvestState.cancelled
          ..completedAt ??= clock()
          ..failureCode ??= 'feature_disabled',
      );
      return;
    }
    harvest = await DiscoveryHarvestRow.db.updateRow(
      session,
      harvest
        ..state = DiscoveryHarvestState.running
        ..startedAt = job.startedAt ?? clock()
        ..completedAt = null
        ..failureCode = null
        ..queryOutcomes = const []
        ..attemptedQueries = 0
        ..completedQueries = 0
        ..observedPlaces = 0
        ..upstreamRequests = 0,
    );

    final source = await sourceFor(session, policy);
    final cell = plan.cell;
    final startedAt = clock();
    final skipped = <String>{};
    for (final query in plan.compatibility) {
      final coverage = await PoiCoverageRow.db.findFirstRow(
        session,
        where: (table) =>
            table.coverageKey.equals(_swipeCoverageKey(plan, query)),
      );
      if (coverage != null &&
          coverage.invalidatedAt == null &&
          coverage.calibrationVersion == source.calibrationVersion &&
          coverage.expiresAt.isAfter(startedAt) &&
          coverage.resultCount >= compatibilitySufficientResults) {
        skipped.add(query.id);
      }
    }
    final broad = plan.broad;
    final scheduler = DiscoveryHarvestScheduler(
      broad: broad,
      compatibility: plan.compatibility,
      skippedCompatibility: skipped,
      pageSize: source.pageSize,
      desiredCandidates: discovery.harvestDesiredCandidatesPerQuery,
    );
    final writer = CatalogObservationWriter(
      calibrationVersion: source.calibrationVersion,
    );
    const metrics = CatalogObservationMetrics(
      mode: DiscoveryMetricMode.discovery,
      operation: DiscoveryMetricOperation.harvest,
    );
    final compatibilityObservations = <String, List<PlaceSnapshot>>{};
    final operation = ProviderOperation(
      timeout: Duration(seconds: discovery.harvestMaximumSeconds),
      maximumRequests: discovery.harvestMaximumRequests,
      background: true,
    );
    control.registerOperation(operation);
    int spent() => math.min(operation.requestCount, operation.maximumRequests);
    final heartbeat = Timer.periodic(
      const Duration(seconds: 30),
      (_) => unawaited(control.heartbeat()),
    );
    String? stopCode;
    var disabled = false;
    var leaseLost = false;
    try {
      while (true) {
        final request = scheduler.next();
        if (request == null) break;
        if (!await control.ownsLease()) {
          scheduler.release(request);
          leaseLost = true;
          break;
        }
        if (userHarvest &&
            !(await DiscoveryPolicyService.load(session)).discovery!.enabled) {
          scheduler.release(request);
          disabled = true;
          break;
        }
        if (operation.isStopped) {
          scheduler.release(request);
          stopCode = _stopCode(operation);
          break;
        }
        final before = spent();
        try {
          final candidates = await operation.within(
            () => source.fetchPage(
              query: request.text,
              latitude: cell.latitude,
              longitude: cell.longitude,
              radiusMeters: cell.radiusMeters,
              language: request.languageCode,
              countryCode: cell.countryCode,
              offset: request.offset,
            ),
          );
          final observedAt = clock();
          final compatibility =
              request.query.kind == DiscoveryHarvestQueryKind.compatibility;
          final observations = [
            for (final candidate in candidates)
              if (PlaceObservation.isValid(candidate))
                PlaceObservation.snapshot(
                  candidate,
                  observedAt,
                  categoryIds: compatibility ? [request.query.id] : const [],
                ),
          ];
          if (compatibility) {
            compatibilityObservations
                .putIfAbsent(request.query.id, () => [])
                .addAll(observations);
          } else if (observations.isNotEmpty) {
            await writer.write(
              session,
              observations,
              countryCode: cell.countryCode,
              observedAt: observedAt,
              metrics: metrics,
            );
          }
          scheduler.recordSuccess(
            request,
            returned: candidates.length,
            observed: observations.length,
            upstreamRequests: spent() - before,
          );
        } on PlaceSourceException catch (error) {
          if (operation.isStopped) {
            stopCode = _stopCode(operation);
            scheduler.recordFailure(
              request,
              code: stopCode,
              upstreamRequests: spent() - before,
              retryable: false,
            );
            break;
          }
          scheduler.recordFailure(
            request,
            code: _safeCode(error.code),
            upstreamRequests: spent() - before,
            retryable: true,
          );
        }
        await DiscoveryHarvestRow.db.updateWhere(
          session,
          where: (table) =>
              table.jobId.equals(job.jobId) &
              table.state.equals(DiscoveryHarvestState.running),
          columnValues: (table) => [
            table.attemptedQueries(scheduler.attemptedQueries),
            table.completedQueries(scheduler.completedQueries),
            table.totalQueries(scheduler.totalQueries),
            table.observedPlaces(scheduler.observedPlaces),
            table.upstreamRequests(spent()),
          ],
        );
        await control.heartbeat();
      }
    } finally {
      heartbeat.cancel();
    }
    final upstreamRequests = spent();
    operation.cancel('The harvest finished.');

    // Compatibility results are genuine Swipe query evidence. A query that
    // finished with no failed page also stands as Swipe coverage.
    final completedAt = clock();
    for (final query in plan.compatibility) {
      final observations = compatibilityObservations[query.id];
      final complete = scheduler.compatibilityComplete(query) && !leaseLost;
      if (observations == null && !complete) continue;
      await writer.write(
        session,
        observations ?? const [],
        countryCode: cell.countryCode,
        observedAt: completedAt,
        evidence: CatalogObservationEvidence(
          parentCategoryId: query.id,
          queries: [
            PlaceQuery(
              query: query.query,
              categoryId: query.id,
              arabicFallbackQuery: query.fallbackQuery,
            ),
          ],
        ),
        coverage: complete
            ? CatalogObservationCoverage(
                coverageKey: _swipeCoverageKey(plan, query),
                queryKey: query.id,
                countryCode: cell.countryCode,
                latitude: cell.latitude,
                longitude: cell.longitude,
                radiusMeters: cell.radiusMeters,
                refreshedAt: completedAt,
                expiresAt: completedAt.add(Duration(hours: policy.freshHours)),
              )
            : null,
        metrics: metrics,
      );
    }
    await DiscoveryMetrics.record(
      session,
      mode: DiscoveryMetricMode.discovery,
      operation: DiscoveryMetricOperation.harvest,
      upstreamRequests: upstreamRequests,
    );

    final stored = await RefreshJobRow.db.findFirstRow(
      session,
      where: (table) => table.jobId.equals(job.jobId),
    );
    final operatorCancelled = stored?.status == JobStatus.cancelled;
    // A recovered job another worker has claimed belongs to that worker now.
    if (leaseLost && !operatorCancelled) return;

    final DiscoveryHarvestState state;
    if (operatorCancelled || disabled) {
      state = DiscoveryHarvestState.cancelled;
    } else if (scheduler.completedQueries == scheduler.totalQueries) {
      state = DiscoveryHarvestState.succeeded;
    } else if (scheduler.completedQueries > 0 || scheduler.observedPlaces > 0) {
      state = DiscoveryHarvestState.partial;
    } else {
      state = DiscoveryHarvestState.failed;
    }
    final failureCode = switch (state) {
      DiscoveryHarvestState.succeeded => null,
      DiscoveryHarvestState.cancelled =>
        disabled ? 'feature_disabled' : 'cancelled',
      _ => stopCode ?? scheduler.firstFailureCode ?? 'harvest_failed',
    };
    await DiscoveryHarvestRow.db.updateRow(
      session,
      harvest
        ..state = state
        ..queryOutcomes = scheduler.outcomes
        ..attemptedQueries = scheduler.attemptedQueries
        ..completedQueries = scheduler.completedQueries
        ..totalQueries = scheduler.totalQueries
        ..observedPlaces = scheduler.observedPlaces
        ..upstreamRequests = upstreamRequests
        ..completedAt = completedAt
        ..failureCode = failureCode,
    );
    await _recordCoverage(
      session,
      plan,
      completed: scheduler.completedIds(DiscoveryHarvestQueryKind.broad),
      state: state,
      completedAt: completedAt,
      jobId: job.jobId,
      failureCode: failureCode,
    );
    if (!operatorCancelled) {
      await control.finish(
        switch (state) {
          DiscoveryHarvestState.succeeded => JobStatus.succeeded,
          DiscoveryHarvestState.cancelled => JobStatus.cancelled,
          _ => JobStatus.failed,
        },
        state == DiscoveryHarvestState.partial
            ? 'partial_$failureCode'
            : failureCode,
      );
    }
  }

  static Future<void> _recordCoverage(
    Session session,
    DiscoveryHarvestPlan plan, {
    required List<String> completed,
    required DiscoveryHarvestState state,
    required DateTime completedAt,
    required String jobId,
    required String? failureCode,
  }) async {
    final cancelled = state == DiscoveryHarvestState.cancelled;
    if (cancelled && completed.isEmpty) return;
    final cell = plan.cell;
    final existing = await DiscoveryCoverageRow.db.findFirstRow(
      session,
      where: (table) =>
          table.countryCode.equals(cell.countryCode) &
          table.cellId.equals(cell.cellId) &
          table.radiusMeters.equals(cell.radiusMeters),
    );
    // A newer manifest revision's record is never overwritten by an older
    // plan's results.
    if (existing != null && existing.manifestRevision > plan.manifestRevision) {
      return;
    }
    final sameRevision = existing?.manifestRevision == plan.manifestRevision;
    final completions = <String, DateTime>{
      if (existing != null && sameRevision) ...existing.queryCompletedAt,
      for (final id in completed) id: completedAt,
    };
    final bounds = cell.bounds;
    final row = DiscoveryCoverageRow(
      id: existing?.id,
      countryCode: cell.countryCode,
      cellId: cell.cellId,
      radiusMeters: cell.radiusMeters,
      centerLatitude: cell.latitude,
      centerLongitude: cell.longitude,
      south: bounds.south,
      west: bounds.west,
      north: bounds.north,
      east: bounds.east,
      manifestRevision: plan.manifestRevision,
      queryCompletedAt: completions,
      lastAttemptAt: cancelled ? existing?.lastAttemptAt : completedAt,
      lastSuccessAt: state == DiscoveryHarvestState.succeeded
          ? completedAt
          : (sameRevision ? existing?.lastSuccessAt : null),
      lastJobId: cancelled ? existing?.lastJobId : jobId,
      lastFailureCode: cancelled ? existing?.lastFailureCode : failureCode,
      updatedAt: completedAt,
    );
    if (existing != null) {
      await DiscoveryCoverageRow.db.updateRow(session, row);
      return;
    }
    final inserted = await DiscoveryCoverageRow.db.insert(session, [
      row,
    ], ignoreConflicts: true);
    if (inserted.isNotEmpty) return;
    // A concurrent harvest of the same cell recorded it first.
    await _recordCoverage(
      session,
      plan,
      completed: completed,
      state: state,
      completedAt: completedAt,
      jobId: jobId,
      failureCode: failureCode,
    );
  }

  static DiscoveryCoverageFootprint _footprint(
    DiscoveryCoverageRow row, {
    required int manifestRevision,
    required List<String> enabled,
    required DateTime freshAfter,
    required DiscoveryPolicy discovery,
    required DateTime now,
  }) {
    final completed = row.manifestRevision == manifestRevision
        ? [
            for (final id in enabled)
              if (row.queryCompletedAt[id] case final at?
                  when !at.isBefore(freshAfter))
                id,
          ]
        : const <String>[];
    final retryAfter = row.lastAttemptAt?.add(
      Duration(minutes: discovery.harvestCooldownMinutes),
    );
    return DiscoveryCoverageFootprint(
      cellId: row.cellId,
      bounds: DiscoverViewport(
        south: row.south,
        west: row.west,
        north: row.north,
        east: row.east,
      ),
      manifestRevision: row.manifestRevision,
      completedQueryGroups: completed,
      incompleteQueryGroups: [
        for (final id in enabled)
          if (!completed.contains(id)) id,
      ],
      lastAttemptAt: row.lastAttemptAt,
      lastSuccessAt: row.lastSuccessAt,
      retryAfter: retryAfter != null && retryAfter.isAfter(now)
          ? retryAfter
          : null,
    );
  }

  /// Fresh when the coverage belongs to the active manifest revision and
  /// every enabled query completed within the freshness window.
  static bool _fresh(
    DiscoveryCoverageRow? coverage,
    DiscoveryHarvestManifestRow manifest,
    int freshHours,
    DateTime now,
  ) {
    if (coverage == null || coverage.manifestRevision != manifest.revision) {
      return false;
    }
    final freshAfter = now.subtract(Duration(hours: freshHours));
    final entries = DiscoveryHarvestManifestService.enabledInOrder(
      manifest.entries,
    );
    return entries.isNotEmpty &&
        entries.every(
          (entry) =>
              coverage.queryCompletedAt[entry.id]?.isBefore(freshAfter) ==
              false,
        );
  }

  static Future<List<DiscoveryHarvestQuery>> _compatibilityQueries(
    Session session,
  ) async {
    final items = await TaxonomyService.activeItems(session);
    final categories =
        items
            .where((item) => item.kind == TaxonomyKind.category && item.enabled)
            .toList()
          ..sort((a, b) {
            final byOrder = a.sortOrder.compareTo(b.sortOrder);
            return byOrder != 0 ? byOrder : a.id.compareTo(b.id);
          });
    return [
      for (final category in categories)
        DiscoveryHarvestQuery(
          id: category.id,
          kind: DiscoveryHarvestQueryKind.compatibility,
          query: category.searchQueryEn,
          fallbackQuery: category.searchQueryAr,
        ),
    ];
  }

  static String _swipeCoverageKey(
    DiscoveryHarvestPlan plan,
    DiscoveryHarvestQuery query,
  ) => catalogCoverageKey(
    categoryIds: [query.id],
    countryCode: plan.cell.countryCode,
    latitude: plan.cell.latitude,
    longitude: plan.cell.longitude,
    radiusMeters: plan.cell.radiusMeters,
  );

  static String _stopCode(ProviderOperation operation) {
    if (operation.requestCount >= operation.maximumRequests) {
      return 'budget_exhausted';
    }
    if (!DateTime.now().isBefore(operation.deadline)) {
      return 'deadline_exceeded';
    }
    return 'cancelled';
  }

  static String _safeCode(String value) {
    final normalized = value
        .toLowerCase()
        .replaceAll(RegExp('[^a-z0-9_]+'), '_')
        .replaceAll(RegExp('_+'), '_')
        .replaceAll(RegExp(r'^_|_$'), '');
    if (normalized.isEmpty) return 'place_source_unavailable';
    return normalized.substring(0, math.min(normalized.length, 60));
  }

  /// A pseudonymous requester label: user ids stay out of admin job lists.
  static String _requester(Session session, String userId) {
    final salt =
        session.passwords['adminIpHashSalt'] ??
        (session.server.runMode == ServerpodRunMode.test
            ? 'test-only-harvest-requester-salt'
            : null);
    if (salt == null || salt.trim().isEmpty || salt == 'unconfigured') {
      return 'user';
    }
    final digest = sha256
        .convert(utf8.encode('$salt:harvest-requester:$userId'))
        .toString();
    return 'user:${digest.substring(0, 16)}';
  }

  static Future<HarvestPageSource> _servicesSource(
    Session session,
    CachePolicy policy,
  ) async {
    final services = await PlaceServices.forSession(session);
    services.source.configureRateLimit(
      requestsPerMinute: policy.globalRequestsPerMinute,
      burst: policy.globalBurst,
    );
    return _ServicesHarvestSource(services);
  }

  static Future<String> _activeCalibrationVersion(Session session) async =>
      (await PlaceServices.forSession(session)).calibration.version;

  static DateTime _now() => DateTime.now().toUtc();
}

final class _ServicesHarvestSource implements HarvestPageSource {
  const _ServicesHarvestSource(this._services);

  final PlaceServices _services;

  @override
  String get calibrationVersion => _services.calibration.version;

  @override
  int get pageSize => _services.calibration.pageSize;

  @override
  Future<List<PlaceCandidate>> fetchPage({
    required String query,
    required double latitude,
    required double longitude,
    required int radiusMeters,
    required String language,
    required String countryCode,
    required int offset,
  }) => _services.source.fetchPage(
    query: query,
    latitude: latitude,
    longitude: longitude,
    radiusMeters: radiusMeters,
    language: language,
    countryCode: countryCode,
    offset: offset,
  );
}
