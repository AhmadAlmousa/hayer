import 'dart:math';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../places/catalog_place_service.dart';
import '../places/place_services.dart';
import '../places/place_source.dart';
import '../places/provider_operation.dart';
import '../places/taxonomy.dart';
import '../places/taxonomy_service.dart';

/// Executes refresh requests created by the operations dashboard.
abstract final class RefreshJobService {
  static bool _running = false;
  static final Map<String, ProviderOperation> _activeOperations = {};
  static final Map<String, DateTime> _cancelledJobs = {};

  static Future<void> run(Serverpod pod) async {
    if (_running) return;
    _running = true;
    final session = await pod.createSession(enableLogging: true);
    try {
      await _recoverInterruptedJobs(session);
      for (var count = 0; count < 3; count++) {
        final job = await claimNext(session);
        if (job == null) break;
        await executeClaimed(session, job);
      }
    } catch (error, stackTrace) {
      session.log(
        'Dashboard refresh-job runner failed.',
        level: LogLevel.error,
        exception: error,
        stackTrace: stackTrace,
      );
    } finally {
      await session.close();
      _running = false;
    }
  }

  static Future<void> _recoverInterruptedJobs(Session session) async {
    final staleStart = DateTime.now().toUtc().subtract(
      const Duration(minutes: 5),
    );
    await RefreshJobRow.db.updateWhere(
      session,
      where: (table) =>
          table.status.equals(JobStatus.running) &
          (table.startedAt.equals(null) | (table.startedAt < staleStart)),
      columnValues: (table) => [
        table.status(JobStatus.pending),
        table.startedAt(null),
        table.errorCode(null),
      ],
    );
  }

  /// Atomically leases the oldest pending job to this worker.
  static Future<RefreshJobRow?> claimNext(Session session) =>
      session.db.transaction((transaction) async {
        final job = await RefreshJobRow.db.findFirstRow(
          session,
          where: (table) => table.status.equals(JobStatus.pending),
          orderBy: (table) => table.createdAt,
          transaction: transaction,
          lockMode: LockMode.forUpdate,
          lockBehavior: LockBehavior.skipLocked,
        );
        if (job == null) return null;
        job.status = JobStatus.running;
        job.startedAt = DateTime.now().toUtc();
        job.completedAt = null;
        job.errorCode = null;
        return RefreshJobRow.db.updateRow(
          session,
          job,
          transaction: transaction,
        );
      });

  /// Executes a claimed job. [refresh] is an integration-test seam; production
  /// obtains the active place services and performs a forced live refresh.
  static Future<void> executeClaimed(
    Session session,
    RefreshJobRow job, {
    RefreshJobAction? refresh,
  }) async {
    ProviderOperation? activeOperation;
    final coverage = await PoiCoverageRow.db.findFirstRow(
      session,
      where: (table) => table.coverageKey.equals(job.coverageKey),
    );
    if (coverage == null) {
      await _fail(session, job, 'coverage_not_found');
      return;
    }
    try {
      if (!await _ownsLease(session, job)) return;
      final plan = RefreshJobPlan.fromCoverage(
        coverage,
        taxonomyItems: await TaxonomyService.activeItems(session),
      );
      final outcome = await (refresh ?? _refresh)(
        session,
        plan,
        (operation) {
          activeOperation = operation;
          _registerOperation(job.jobId, operation);
        },
      );
      if (!await _ownsLease(session, job)) return;
      final failureCode = switch (outcome.origin) {
        CatalogDeckOrigin.live => null,
        CatalogDeckOrigin.partialLive => _outcomeCode(
          'partial',
          outcome.sourceFailureCode,
        ),
        CatalogDeckOrigin.staleFallback => _outcomeCode(
          'stale_fallback',
          outcome.sourceFailureCode,
        ),
        CatalogDeckOrigin.freshCache => 'cache_only',
      };
      if (failureCode == null) {
        await _recordCoverageSuccess(session, coverage);
        await _finish(session, job, JobStatus.succeeded);
      } else {
        await _recordCoverageFailure(session, coverage, failureCode);
        await _finish(session, job, JobStatus.failed, failureCode);
      }
    } on PlaceSourceException catch (error) {
      if (!await _ownsLease(session, job)) return;
      await _recordCoverageFailure(session, coverage, error.code);
      await _fail(session, job, error.code);
    } catch (error) {
      if (!await _ownsLease(session, job)) return;
      final code = error is FormatException
          ? 'invalid_coverage'
          : 'refresh_failed';
      await _recordCoverageFailure(session, coverage, code);
      await _fail(session, job, code);
    } finally {
      if (identical(_activeOperations[job.jobId], activeOperation)) {
        _activeOperations.remove(job.jobId);
      }
      _cancelledJobs.remove(job.jobId);
    }
  }

  static Future<CatalogDeckOutcome> _refresh(
    Session session,
    RefreshJobPlan plan,
    void Function(ProviderOperation operation) onProviderOperation,
  ) async {
    final services = await PlaceServices.forSession(session);
    return CatalogPlaceService(
      source: services.source,
      calibrationVersion: services.calibration.version,
    ).buildDeckWithOutcome(
      session,
      categoryId: plan.categoryId,
      subcategoryIds: plan.subcategoryIds,
      latitude: plan.latitude,
      longitude: plan.longitude,
      radiusMeters: plan.radiusMeters,
      deckSize: plan.deckSize,
      countryCode: plan.countryCode,
      forceRefresh: true,
      onProviderOperation: onProviderOperation,
    );
  }

  /// Cancels provider work owned by this process. The persisted status remains
  /// authoritative; another worker is still bounded by the provider deadline.
  static void cancelActive(String jobId) {
    final now = DateTime.now().toUtc();
    _cancelledJobs.removeWhere(
      (_, expiresAt) => !expiresAt.isAfter(now),
    );
    _cancelledJobs[jobId] = now.add(const Duration(minutes: 1));
    _activeOperations[jobId]?.cancel('The refresh job was cancelled.');
  }

  static void _registerOperation(
    String jobId,
    ProviderOperation operation,
  ) {
    _activeOperations[jobId] = operation;
    final cancellationExpiresAt = _cancelledJobs[jobId];
    if (cancellationExpiresAt != null &&
        cancellationExpiresAt.isAfter(DateTime.now().toUtc())) {
      operation.cancel('The refresh job was cancelled.');
    }
  }

  static Future<bool> _ownsLease(
    Session session,
    RefreshJobRow job,
  ) async {
    final startedAt = job.startedAt;
    if (startedAt == null) return false;
    return await RefreshJobRow.db.findFirstRow(
          session,
          where: (table) =>
              table.jobId.equals(job.jobId) &
              table.status.equals(JobStatus.running) &
              table.startedAt.equals(startedAt),
        ) !=
        null;
  }

  static Future<void> _recordCoverageFailure(
    Session session,
    PoiCoverageRow coverage,
    String code,
  ) async {
    final latest = await PoiCoverageRow.db.findFirstRow(
      session,
      where: (table) => table.coverageKey.equals(coverage.coverageKey),
    );
    if (latest == null) return;
    latest.lastFailureCode = _safeErrorCode(code);
    latest.invalidatedAt ??= DateTime.now().toUtc();
    await PoiCoverageRow.db.updateRow(session, latest);
  }

  static Future<void> _recordCoverageSuccess(
    Session session,
    PoiCoverageRow coverage,
  ) async {
    final latest = await PoiCoverageRow.db.findFirstRow(
      session,
      where: (table) => table.coverageKey.equals(coverage.coverageKey),
    );
    if (latest == null) return;
    latest.lastFailureCode = null;
    latest.invalidatedAt = null;
    await PoiCoverageRow.db.updateRow(session, latest);
  }

  static Future<void> _fail(
    Session session,
    RefreshJobRow job,
    String code,
  ) async {
    await _finish(session, job, JobStatus.failed, code);
  }

  static Future<void> _finish(
    Session session,
    RefreshJobRow job,
    JobStatus status, [
    String? code,
  ]) async {
    final startedAt = job.startedAt;
    if (startedAt == null) return;
    await RefreshJobRow.db.updateWhere(
      session,
      where: (table) =>
          table.jobId.equals(job.jobId) &
          table.status.equals(JobStatus.running) &
          table.startedAt.equals(startedAt),
      columnValues: (table) => [
        table.status(status),
        table.completedAt(DateTime.now().toUtc()),
        table.errorCode(code == null ? null : _safeErrorCode(code)),
      ],
    );
  }

  static String _outcomeCode(String prefix, String? sourceCode) {
    final safeSource = sourceCode == null ? '' : _safeErrorCode(sourceCode);
    return safeSource.isEmpty ? prefix : '${prefix}_$safeSource';
  }

  static String _safeErrorCode(String value) {
    final normalized = value
        .toLowerCase()
        .replaceAll(RegExp('[^a-z0-9_]+'), '_')
        .replaceAll(RegExp('_+'), '_')
        .replaceAll(RegExp(r'^_|_$'), '');
    return normalized.isEmpty
        ? 'refresh_failed'
        : normalized.substring(
            0,
            min(normalized.length, 80),
          );
  }
}

typedef RefreshJobAction = Future<CatalogDeckOutcome> Function(
  Session session,
  RefreshJobPlan plan,
  void Function(ProviderOperation operation) onProviderOperation,
);

class RefreshJobPlan {
  const RefreshJobPlan({
    required this.categoryId,
    required this.subcategoryIds,
    required this.latitude,
    required this.longitude,
    required this.radiusMeters,
    required this.deckSize,
    required this.countryCode,
  });

  factory RefreshJobPlan.fromCoverage(
    PoiCoverageRow coverage, {
    List<AdminTaxonomyItem>? taxonomyItems,
  }) {
    final categoryIds = coverage.queryKey
        .split(',')
        .map((value) => value.trim())
        .where((value) => value.isNotEmpty)
        .toSet();
    String? categoryId;
    final dynamicCategories = {
      for (final item in taxonomyItems ?? const <AdminTaxonomyItem>[])
        if (item.kind == TaxonomyKind.category) item.id,
    };
    bool isCategory(String value) => taxonomyItems == null
        ? PlaceTaxonomy.categories.containsKey(value)
        : dynamicCategories.contains(value);
    for (final value in categoryIds) {
      if (!isCategory(value)) continue;
      if (categoryId != null) {
        throw const FormatException('Coverage contains multiple categories.');
      }
      categoryId = value;
    }
    if (categoryId == null) {
      throw const FormatException('Coverage category is missing.');
    }
    final subcategories = categoryIds.where((value) => value != categoryId);
    final validChildren = taxonomyItems == null
        ? PlaceTaxonomy.categories[categoryId]!.subcategories.keys.toSet()
        : taxonomyItems
              .where(
                (item) =>
                    item.kind != TaxonomyKind.category &&
                    item.parentCategoryIds.contains(categoryId),
              )
              .map((item) => item.id)
              .toSet();
    if (subcategories.any((value) => !validChildren.contains(value))) {
      throw const FormatException('Coverage contains an unknown subcategory.');
    }
    return RefreshJobPlan(
      categoryId: categoryId,
      subcategoryIds: subcategories.toList()..sort(),
      latitude: coverage.anchorLatitude,
      longitude: coverage.anchorLongitude,
      radiusMeters: coverage.radiusMeters,
      deckSize: max(coverage.resultCount, 20).clamp(1, 50),
      countryCode: coverage.countryCode,
    );
  }

  final String categoryId;
  final List<String> subcategoryIds;
  final double latitude;
  final double longitude;
  final int radiusMeters;
  final int deckSize;
  final String countryCode;
}
