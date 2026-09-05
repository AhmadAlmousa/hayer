import 'dart:math';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../places/catalog_place_service.dart';
import '../places/place_services.dart';
import '../places/place_source.dart';
import '../places/taxonomy.dart';
import '../places/taxonomy_service.dart';

/// Executes refresh requests created by the operations dashboard.
abstract final class RefreshJobService {
  static bool _running = false;

  static Future<void> run(Serverpod pod) async {
    if (_running) return;
    _running = true;
    final session = await pod.createSession(enableLogging: true);
    try {
      await _recoverInterruptedJobs(session);
      for (var count = 0; count < 3; count++) {
        final job = await _claimNext(session);
        if (job == null) break;
        await _execute(session, job);
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

  static Future<RefreshJobRow?> _claimNext(Session session) async {
    final job = await RefreshJobRow.db.findFirstRow(
      session,
      where: (table) => table.status.equals(JobStatus.pending),
      orderBy: (table) => table.createdAt,
    );
    if (job == null) return null;
    job.status = JobStatus.running;
    job.startedAt = DateTime.now().toUtc();
    job.completedAt = null;
    job.errorCode = null;
    return RefreshJobRow.db.updateRow(session, job);
  }

  static Future<void> _execute(
    Session session,
    RefreshJobRow job,
  ) async {
    final coverage = await PoiCoverageRow.db.findFirstRow(
      session,
      where: (table) => table.coverageKey.equals(job.coverageKey),
    );
    if (coverage == null) {
      await _fail(session, job, 'coverage_not_found');
      return;
    }
    try {
      final plan = RefreshJobPlan.fromCoverage(
        coverage,
        taxonomyItems: await TaxonomyService.activeItems(session),
      );
      coverage.invalidatedAt = DateTime.now().toUtc();
      coverage.lastFailureCode = null;
      await PoiCoverageRow.db.updateRow(session, coverage);

      final services = await PlaceServices.forSession(session);
      await CatalogPlaceService(
        source: services.source,
        calibrationVersion: services.calibration.version,
      ).buildDeck(
        session,
        categoryId: plan.categoryId,
        subcategoryIds: plan.subcategoryIds,
        latitude: plan.latitude,
        longitude: plan.longitude,
        radiusMeters: plan.radiusMeters,
        deckSize: plan.deckSize,
        countryCode: plan.countryCode,
      );
      final latest = await RefreshJobRow.db.findFirstRow(
        session,
        where: (table) => table.jobId.equals(job.jobId),
      );
      if (latest == null || latest.status == JobStatus.cancelled) return;
      latest.status = JobStatus.succeeded;
      latest.completedAt = DateTime.now().toUtc();
      latest.errorCode = null;
      await RefreshJobRow.db.updateRow(session, latest);
    } on PlaceSourceException catch (error) {
      await _recordCoverageFailure(session, coverage, error.code);
      await _fail(session, job, error.code);
    } catch (error) {
      final code = error is FormatException
          ? 'invalid_coverage'
          : 'refresh_failed';
      await _recordCoverageFailure(session, coverage, code);
      await _fail(session, job, code);
    }
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
    await PoiCoverageRow.db.updateRow(session, latest);
  }

  static Future<void> _fail(
    Session session,
    RefreshJobRow job,
    String code,
  ) async {
    final latest = await RefreshJobRow.db.findFirstRow(
      session,
      where: (table) => table.jobId.equals(job.jobId),
    );
    if (latest == null || latest.status == JobStatus.cancelled) return;
    latest.status = JobStatus.failed;
    latest.completedAt = DateTime.now().toUtc();
    latest.errorCode = _safeErrorCode(code);
    await RefreshJobRow.db.updateRow(session, latest);
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
