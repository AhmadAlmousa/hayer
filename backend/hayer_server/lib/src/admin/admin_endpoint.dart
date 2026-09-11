import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:serverpod/serverpod.dart';

import '../analytics/analytics_query_service.dart';
import 'admin_audit_writer.dart';
import 'admin_authorization.dart';
import 'admin_gateway_access.dart';
import 'poi_issue_moderation_service.dart';
import '../generated/protocol.dart';
import '../places/calibration.dart';
import '../places/google_web_place_source.dart';
import '../places/place_services.dart';
import '../places/place_source.dart';
import '../places/reverse_geocoding_service.dart';
import '../places/taxonomy.dart';
import '../places/taxonomy_service.dart';
import '../storage/catalog_pruner.dart';

class AdminEndpoint extends Endpoint {
  AdminEndpoint()
    : this._(
        AdminAuthorization.requireOperator,
        const DatabaseAdminAuditWriter(),
      );

  factory AdminEndpoint.forTesting({
    required Future<String> Function(Session session) authorizer,
    AdminAuditWriter auditWriter = const DatabaseAdminAuditWriter(),
  }) => AdminEndpoint._(
    authorizer,
    auditWriter,
  );

  AdminEndpoint._(this._authorizer, this._auditWriter);

  final Future<String> Function(Session session) _authorizer;
  final AdminAuditWriter _auditWriter;

  @override
  bool get requireLogin => true;

  @override
  Set<Scope> get requiredScopes => {AdminGatewayAccess.adminScope};

  static const _uuid = Uuid();
  static final _geocoder = ReverseGeocodingService();

  Future<AdminLiveUsage> liveUsage(Session session) async {
    await _authorize(session);
    return AnalyticsQueryService.live(session);
  }

  Future<AdminAnalyticsOverview> analyticsOverview(
    Session session, {
    required AnalyticsFilter filter,
  }) async {
    await _authorize(session);
    return AnalyticsQueryService.overview(
      session,
      filter: filter,
      cacheSummary: await summary(session),
    );
  }

  Future<AdminUsageAnalytics> usageAnalytics(
    Session session, {
    required AnalyticsFilter filter,
  }) async {
    await _authorize(session);
    return AnalyticsQueryService.usage(session, filter: filter);
  }

  Future<AdminPlaceAnalytics> placeAnalytics(
    Session session, {
    required AnalyticsFilter filter,
    required PlaceRanking ranking,
    int minimumSamples = 5,
  }) async {
    await _authorize(session);
    return AnalyticsQueryService.places(
      session,
      filter: filter,
      ranking: ranking,
      minimumSamples: minimumSamples,
    );
  }

  Future<List<LocationSuggestion>> suggestAdminLocation(
    Session session, {
    required String query,
    String countryCode = 'SA',
  }) async {
    await _authorize(session);
    final normalized = query.trim();
    if (normalized.length < 3 || normalized.length > 120) return const [];
    try {
      final places = await PlaceServices.forSession(session);
      return await places.search.suggest(
        input: normalized,
        countryCode: _country(countryCode),
      );
    } on PlaceSourceException catch (error) {
      throw ApiException(code: error.code, message: error.message);
    }
  }

  Future<AdminMapLocation> reverseAdminLocation(
    Session session, {
    required double latitude,
    required double longitude,
    String countryCode = 'SA',
  }) async {
    await _authorize(session);
    _coordinates(latitude, longitude);
    try {
      final value = await _geocoder.reverseDetails(
        latitude: latitude,
        longitude: longitude,
        languageCode: 'en',
      );
      return AdminMapLocation(
        address: value.formattedAddress,
        latitude: latitude,
        longitude: longitude,
        countryCode: value.countryCode ?? _country(countryCode),
        cityName: value.city,
      );
    } on ReverseGeocodingException catch (error) {
      throw ApiException(code: 'location_unavailable', message: error.message);
    }
  }

  Future<AdminTaxonomyVersion> taxonomyDraft(Session session) async {
    final operatorName = await _authorize(session);
    return TaxonomyService.editableDraft(
      session,
      operatorName: operatorName,
    );
  }

  Future<List<AdminTaxonomyVersion>> taxonomyHistory(Session session) async {
    await _authorize(session);
    return TaxonomyService.history(session);
  }

  Future<AdminTaxonomyVersion> saveTaxonomyDraft(
    Session session, {
    required String reason,
    required String version,
    required int revision,
    required List<AdminTaxonomyItem> items,
  }) async {
    final operatorName = await _authorize(session);
    _reason(reason);
    return session.db.transaction((transaction) async {
      final draft = await TaxonomyService.saveDraft(
        session,
        version: version,
        revision: revision,
        items: items,
        operatorName: operatorName,
        transaction: transaction,
      );
      await _audit(
        session,
        operatorName: operatorName,
        action: 'taxonomy.draft.save',
        targetType: 'taxonomy',
        targetId: version,
        reason: reason,
        after: {
          'revision': '${draft.revision}',
          'items': '${draft.items.length}',
        },
        transaction: transaction,
      );
      return draft;
    });
  }

  Future<TaxonomyValidation> validateTaxonomyDraft(
    Session session, {
    required String reason,
    required String version,
    required int revision,
    required AdminMapLocation location,
    int radiusMeters = 3000,
  }) async {
    final operatorName = await _authorize(session);
    _reason(reason);
    _coordinates(location.latitude, location.longitude);
    if (radiusMeters < 500 || radiusMeters > 10000) {
      throw ApiException(
        code: 'bad_request',
        message: 'Choose a canary radius between 500 m and 10 km.',
      );
    }
    final draft = await TaxonomyService.draft(session, version: version);
    if (draft.version != version || draft.revision != revision) {
      throw ApiException(
        code: 'conflict',
        message: 'The taxonomy draft changed. Reload before validating.',
      );
    }
    final errors = PlaceTaxonomy.validate(draft.items);
    final active = await TaxonomyService.activeItems(session);
    final activeById = {for (final item in active) item.id: item};
    var canaries = draft.items
        .where((item) {
          if (!item.enabled) return false;
          final previous = activeById[item.id];
          return previous == null ||
              previous.enabled != item.enabled ||
              previous.searchQueryEn != item.searchQueryEn ||
              previous.searchQueryAr != item.searchQueryAr;
        })
        .toList(growable: false);
    if (canaries.isEmpty) {
      canaries = draft.items
          .where(
            (item) => item.enabled && item.kind == TaxonomyKind.category,
          )
          .toList(growable: false);
    }
    if (canaries.length > 60) {
      errors.add('A single validation can include at most 60 changed queries.');
      canaries = const [];
    }
    final samples = <TaxonomyCanarySample>[];
    if (errors.isEmpty) {
      final source = (await PlaceServices.forSession(session)).source;
      for (var start = 0; start < canaries.length; start += 3) {
        final batch = canaries.skip(start).take(3);
        samples.addAll(
          await Future.wait(
            batch.map(
              (item) => _taxonomyCanary(
                source,
                item,
                location,
                radiusMeters,
              ),
            ),
          ),
        );
      }
      for (final sample in samples) {
        if (sample.errorCode != null) {
          errors.add('${sample.itemId}: ${sample.errorCode}');
        } else if (sample.resultCount == 0) {
          errors.add('${sample.itemId}: live canary returned no places.');
        }
      }
    }
    final validatedAt = DateTime.now().toUtc();
    await session.db.transaction((transaction) async {
      await TaxonomyService.recordValidation(
        session,
        version: version,
        revision: revision,
        location: location,
        radiusMeters: radiusMeters,
        errors: errors,
        transaction: transaction,
      );
      await _audit(
        session,
        operatorName: operatorName,
        action: 'taxonomy.draft.validate',
        targetType: 'taxonomy',
        targetId: version,
        reason: reason,
        after: {
          'revision': '$revision',
          'passed': '${errors.isEmpty}',
          'canaries': '${samples.length}',
        },
        transaction: transaction,
      );
    });
    return TaxonomyValidation(
      passed: errors.isEmpty,
      errors: errors,
      samples: samples,
      validatedAt: validatedAt,
    );
  }

  Future<AdminTaxonomyVersion> publishTaxonomy(
    Session session, {
    required String reason,
    required String version,
    required int revision,
  }) async {
    final operatorName = await _authorize(session);
    _reason(reason);
    return session.db.transaction((transaction) async {
      final result = await TaxonomyService.publish(
        session,
        version: version,
        revision: revision,
        transaction: transaction,
      );
      await _audit(
        session,
        operatorName: operatorName,
        action: 'taxonomy.publish',
        targetType: 'taxonomy',
        targetId: version,
        reason: reason,
        after: {'revision': '$revision'},
        transaction: transaction,
      );
      return result;
    });
  }

  Future<AdminTaxonomyVersion> rollbackTaxonomy(
    Session session, {
    required String reason,
    required String version,
  }) async {
    final operatorName = await _authorize(session);
    _reason(reason);
    return session.db.transaction((transaction) async {
      final result = await TaxonomyService.rollback(
        session,
        version: version,
        transaction: transaction,
      );
      await _audit(
        session,
        operatorName: operatorName,
        action: 'taxonomy.rollback',
        targetType: 'taxonomy',
        targetId: version,
        reason: reason,
        transaction: transaction,
      );
      return result;
    });
  }

  Future<CacheDashboardSummary> summary(Session session) async {
    await _authorize(session);
    final now = DateTime.now().toUtc();
    final freshAfter = now.subtract(const Duration(hours: 72));
    final catalogCount = await PoiCatalogRow.db.count(session);
    final freshCount = await PoiCatalogRow.db.count(
      session,
      where: (table) =>
          table.quarantinedAt.equals(null) &
          (table.sourceCheckedAt >= freshAfter),
    );
    final quarantinedCount = await PoiCatalogRow.db.count(
      session,
      where: (table) => table.quarantinedAt.notEquals(null),
    );
    final coverageCount = await PoiCoverageRow.db.count(session);
    final pendingJobs = await RefreshJobRow.db.count(
      session,
      where: (table) =>
          table.status.equals(JobStatus.pending) |
          table.status.equals(JobStatus.running),
    );
    final activeCalibration = await CalibrationRow.db.findFirstRow(
      session,
      where: (table) => table.status.equals(CalibrationStatus.active),
      orderBy: (table) => table.activatedAt,
      orderDescending: true,
    );
    return CacheDashboardSummary(
      catalogCount: catalogCount,
      freshCount: freshCount,
      staleCount: (catalogCount - freshCount - quarantinedCount).clamp(
        0,
        catalogCount,
      ),
      quarantinedCount: quarantinedCount,
      coverageCount: coverageCount,
      pendingJobs: pendingJobs,
      cacheHitRate: await _metric(session, 'cache_hit_rate'),
      sourceSuccessRate: await _metric(session, 'source_success_rate'),
      calibrationVersion: activeCalibration?.version ?? 'bundled',
      generatedAt: now,
    );
  }

  Future<CatalogPlacePage> catalog(
    Session session, {
    required int page,
    required int pageSize,
    String? query,
    bool includeQuarantined = false,
  }) async {
    await _authorize(session);
    final safePage = page.clamp(0, 100000);
    final safeSize = pageSize.clamp(1, 100);
    final search = query?.trim();
    Expression<dynamic> Function(PoiCatalogRowTable) where = (table) =>
        includeQuarantined
        ? table.providerPlaceId.notEquals('')
        : table.quarantinedAt.equals(null);
    if (search != null && search.isNotEmpty) {
      where = (table) =>
          (includeQuarantined
              ? table.providerPlaceId.notEquals('')
              : table.quarantinedAt.equals(null)) &
          table.name.ilike('%${search.replaceAll('%', r'\%')}%');
    }
    final total = await PoiCatalogRow.db.count(session, where: where);
    final rows = await PoiCatalogRow.db.find(
      session,
      where: where,
      orderBy: (table) => table.lastSeenAt,
      orderDescending: true,
      offset: safePage * safeSize,
      limit: safeSize,
    );
    return CatalogPlacePage(
      items: rows.map((row) => row.snapshot).toList(growable: false),
      total: total,
      page: safePage,
      pageSize: safeSize,
    );
  }

  Future<CoveragePage> coverage(
    Session session, {
    required int page,
    required int pageSize,
    String? query,
  }) async {
    await _authorize(session);
    final safePage = page.clamp(0, 100000);
    final safeSize = pageSize.clamp(1, 100);
    final search = query?.trim();
    final hasSearch = search != null && search.isNotEmpty;
    final pattern = hasSearch ? '%${_escapeLike(search)}%' : '';
    Expression<dynamic> where(PoiCoverageRowTable table) => hasSearch
        ? table.coverageKey.ilike(pattern) |
              table.queryKey.ilike(pattern) |
              table.countryCode.ilike(pattern)
        : table.coverageKey.notEquals('');
    final total = await PoiCoverageRow.db.count(session, where: where);
    final rows = await PoiCoverageRow.db.find(
      session,
      where: where,
      orderBy: (table) => table.refreshedAt,
      orderDescending: true,
      offset: safePage * safeSize,
      limit: safeSize,
    );
    return CoveragePage(
      items: rows.map(_coverageRecord).toList(growable: false),
      total: total,
      page: safePage,
      pageSize: safeSize,
    );
  }

  Future<RefreshJobPage> refreshJobs(
    Session session, {
    required int page,
    required int pageSize,
    String? query,
    JobStatus? status,
  }) async {
    await _authorize(session);
    final safePage = page.clamp(0, 100000);
    final safeSize = pageSize.clamp(1, 100);
    final search = query?.trim();
    final hasSearch = search != null && search.isNotEmpty;
    final pattern = hasSearch ? '%${_escapeLike(search)}%' : '';
    Expression<dynamic> where(RefreshJobRowTable table) {
      final searchExpression = hasSearch
          ? table.jobId.ilike(pattern) |
                table.coverageKey.ilike(pattern) |
                table.requestedBy.ilike(pattern)
          : table.jobId.notEquals('');
      return status == null
          ? searchExpression
          : table.status.equals(status) & searchExpression;
    }

    final total = await RefreshJobRow.db.count(session, where: where);
    final rows = await RefreshJobRow.db.find(
      session,
      where: where,
      orderBy: (table) => table.createdAt,
      orderDescending: true,
      offset: safePage * safeSize,
      limit: safeSize,
    );
    return RefreshJobPage(
      items: rows.map(_refreshJobView).toList(growable: false),
      total: total,
      page: safePage,
      pageSize: safeSize,
    );
  }

  Future<AdminPoiIssuePage> poiIssues(
    Session session, {
    required int page,
    required int pageSize,
    String? query,
    PoiIssueStatus? status,
  }) async {
    await _authorize(session);
    final safePage = page.clamp(0, 100000);
    final safeSize = pageSize.clamp(1, 100);
    final search = query?.trim();
    final hasSearch = search != null && search.isNotEmpty;
    final pattern = hasSearch ? '%${_escapeLike(search)}%' : '';
    Expression<dynamic> where(PoiIssueReportRowTable table) {
      final searchExpression = hasSearch
          ? table.reportId.ilike(pattern) |
                table.placeId.ilike(pattern) |
                table.placeName.ilike(pattern)
          : table.reportId.notEquals('');
      return status == null
          ? searchExpression
          : table.status.equals(status) & searchExpression;
    }

    final counts = await Future.wait([
      PoiIssueReportRow.db.count(
        session,
        where: (table) => table.status.equals(PoiIssueStatus.open),
      ),
      PoiIssueReportRow.db.count(
        session,
        where: (table) => table.status.equals(PoiIssueStatus.inReview),
      ),
      PoiIssueReportRow.db.count(
        session,
        where: (table) => table.status.equals(PoiIssueStatus.resolved),
      ),
      PoiIssueReportRow.db.count(
        session,
        where: (table) => table.status.equals(PoiIssueStatus.dismissed),
      ),
    ]);
    final total = await PoiIssueReportRow.db.count(session, where: where);
    final rows = await PoiIssueReportRow.db.find(
      session,
      where: where,
      orderBy: (table) => table.createdAt,
      orderDescending: true,
      offset: safePage * safeSize,
      limit: safeSize,
    );
    if (rows.isEmpty) {
      return AdminPoiIssuePage(
        items: const [],
        total: total,
        page: safePage,
        pageSize: safeSize,
        openCount: counts[0],
        inReviewCount: counts[1],
        resolvedCount: counts[2],
        dismissedCount: counts[3],
      );
    }

    final placeIds = rows.map((row) => row.placeId).toSet();
    final related = await PoiIssueReportRow.db.find(
      session,
      where: (table) => table.placeId.inSet(placeIds),
    );
    final catalog = await PoiCatalogRow.db.find(
      session,
      where: (table) => table.providerPlaceId.inSet(placeIds),
    );
    final catalogByPlaceId = {
      for (final row in catalog) row.providerPlaceId: row,
    };
    final recurrenceByKey = <String, int>{};
    final sessionsByKey = <String, Set<String>>{};
    for (final report in related) {
      final key = _poiIssueGroupKey(report.placeId, report.issueType);
      recurrenceByKey.update(key, (value) => value + 1, ifAbsent: () => 1);
      sessionsByKey.putIfAbsent(key, () => <String>{}).add(report.sessionId);
    }

    return AdminPoiIssuePage(
      items: [
        for (final row in rows)
          _adminPoiIssue(
            row,
            catalog: catalogByPlaceId[row.placeId],
            recurrenceCount:
                recurrenceByKey[_poiIssueGroupKey(
                  row.placeId,
                  row.issueType,
                )] ??
                1,
            affectedSessionCount:
                sessionsByKey[_poiIssueGroupKey(row.placeId, row.issueType)]
                    ?.length ??
                1,
          ),
      ],
      total: total,
      page: safePage,
      pageSize: safeSize,
      openCount: counts[0],
      inReviewCount: counts[1],
      resolvedCount: counts[2],
      dismissedCount: counts[3],
    );
  }

  Future<bool> claimPoiIssue(
    Session session, {
    required String reportId,
  }) => _mutatePoiIssue(
    session,
    reportId: reportId,
    action: PoiIssueModerationAction.claim,
    reason: 'Claimed for review.',
  );

  Future<bool> releasePoiIssue(
    Session session, {
    required String reportId,
    required String reason,
  }) => _mutatePoiIssue(
    session,
    reportId: reportId,
    action: PoiIssueModerationAction.release,
    reason: reason,
  );

  Future<bool> resolvePoiIssue(
    Session session, {
    required String reportId,
    required String resolution,
    required String sourceEvidence,
  }) => _mutatePoiIssue(
    session,
    reportId: reportId,
    action: PoiIssueModerationAction.resolve,
    reason: resolution,
    sourceEvidence: sourceEvidence,
  );

  Future<bool> dismissPoiIssue(
    Session session, {
    required String reportId,
    required String resolution,
    required String sourceEvidence,
  }) => _mutatePoiIssue(
    session,
    reportId: reportId,
    action: PoiIssueModerationAction.dismiss,
    reason: resolution,
    sourceEvidence: sourceEvidence,
  );

  Future<bool> reopenPoiIssue(
    Session session, {
    required String reportId,
    required String reason,
  }) => _mutatePoiIssue(
    session,
    reportId: reportId,
    action: PoiIssueModerationAction.reopen,
    reason: reason,
  );

  Future<AdminAuditPage> auditLog(
    Session session, {
    required int page,
    required int pageSize,
    String? query,
  }) async {
    await _authorize(session);
    final safePage = page.clamp(0, 100000);
    final safeSize = pageSize.clamp(1, 100);
    final search = query?.trim();
    final hasSearch = search != null && search.isNotEmpty;
    final pattern = hasSearch ? '%${_escapeLike(search)}%' : '';
    Expression<dynamic> where(AdminAuditRowTable table) => hasSearch
        ? table.operatorName.ilike(pattern) |
              table.action.ilike(pattern) |
              table.targetType.ilike(pattern) |
              table.reason.ilike(pattern)
        : table.auditId.notEquals('');
    final total = await AdminAuditRow.db.count(session, where: where);
    final rows = await AdminAuditRow.db.find(
      session,
      where: where,
      orderBy: (table) => table.occurredAt,
      orderDescending: true,
      offset: safePage * safeSize,
      limit: safeSize,
    );
    return AdminAuditPage(
      items: rows.map(_adminAuditEntry).toList(growable: false),
      total: total,
      page: safePage,
      pageSize: safeSize,
    );
  }

  Future<List<MetricPoint>> metricTrend(
    Session session, {
    int hours = 24,
  }) async {
    await _authorize(session);
    final safeHours = hours.clamp(1, 168);
    final rows = await OperationalMetricRow.db.find(
      session,
      where: (table) =>
          table.metricName.inSet(const {
            'cache_hit_rate',
            'source_success_rate',
          }) &
          (table.bucketStartedAt >=
              DateTime.now().toUtc().subtract(Duration(hours: safeHours))),
      orderBy: (table) => table.bucketStartedAt,
    );
    final aggregates = <String, _MetricAggregate>{};
    for (final row in rows) {
      final key = '${row.bucketStartedAt.toIso8601String()}:${row.metricName}';
      aggregates.putIfAbsent(key, () => _MetricAggregate(row)).add(row);
    }
    final result = aggregates.values.map((value) => value.toPoint()).toList()
      ..sort((left, right) {
        final byTime = left.bucketStartedAt.compareTo(right.bucketStartedAt);
        return byTime != 0
            ? byTime
            : left.metricName.compareTo(right.metricName);
      });
    return result;
  }

  Future<CatalogPrunePreview> prunePreview(Session session) async {
    await _authorize(session);
    final policy = await _policyRow(session);
    final retentionDays = policy?.retentionDays ?? 365;
    final cutoff = DateTime.now().toUtc().subtract(
      Duration(days: retentionDays),
    );
    return CatalogPrunePreview(
      eligibleCount: await CatalogPruner.eligibleCount(
        session,
        cutoff: cutoff,
      ),
      retentionDays: retentionDays,
      cutoff: cutoff,
    );
  }

  Future<int> pruneCatalog(
    Session session, {
    required String reason,
  }) async {
    final operatorName = await _authorize(session);
    _reason(reason);
    return session.db.transaction((transaction) async {
      final policy = await _policyRow(
        session,
        transaction: transaction,
        lockMode: LockMode.forShare,
      );
      final retentionDays = policy?.retentionDays ?? 365;
      final cutoff = DateTime.now().toUtc().subtract(
        Duration(days: retentionDays),
      );
      final eligibleCount = await CatalogPruner.eligibleCount(
        session,
        cutoff: cutoff,
        transaction: transaction,
      );
      final removed = await CatalogPruner.prune(
        session,
        cutoff: cutoff,
        transaction: transaction,
      );
      await _audit(
        session,
        operatorName: operatorName,
        action: 'catalog.prune',
        targetType: 'poi',
        targetId: 'retention',
        reason: reason,
        before: {'eligibleCount': '$eligibleCount'},
        after: {'removedCount': '$removed', 'cutoff': '$cutoff'},
        transaction: transaction,
      );
      return removed;
    });
  }

  Future<CachePolicy> policy(Session session) async {
    await _authorize(session);
    final row = await CacheSettingsRow.db.findFirstRow(
      session,
      where: (table) => table.settingsKey.equals('default'),
    );
    if (row == null) return _defaultPolicy();
    return _toPolicy(row);
  }

  Future<CachePolicy> updatePolicy(
    Session session, {
    required String reason,
    required CachePolicy policy,
  }) async {
    final operatorName = await _authorize(session);
    _reason(reason);
    _validatePolicy(policy);
    return session.db.transaction((transaction) async {
      final before = await CacheSettingsRow.db.findFirstRow(
        session,
        where: (table) => table.settingsKey.equals('default'),
        transaction: transaction,
        lockMode: LockMode.forUpdate,
      );
      if (policy.version != (before?.version ?? 0)) {
        throw ApiException(
          code: 'conflict',
          message: 'The cache policy changed. Reload before saving.',
        );
      }
      final next = CacheSettingsRow(
        id: before?.id,
        settingsKey: 'default',
        version: policy.version + 1,
        freshHours: policy.freshHours,
        staleFallbackDays: policy.staleFallbackDays,
        retentionDays: policy.retentionDays,
        extractorAttempts: policy.extractorAttempts,
        perCreationConcurrency: policy.perCreationConcurrency,
        globalRequestsPerMinute: policy.globalRequestsPerMinute,
        globalBurst: policy.globalBurst,
        routeEstimatesEnabled: policy.routeEstimatesEnabled,
        allowParticipantLocation: policy.allowParticipantLocation,
        defaultRouteOrigin: policy.defaultRouteOrigin,
        routeEstimateCacheMinutes: policy.routeEstimateCacheMinutes,
        routeRequestsPerMinute: policy.routeRequestsPerMinute,
        routeBurst: policy.routeBurst,
        updatedBy: _operator(operatorName),
        updatedAt: DateTime.now().toUtc(),
      );
      late CacheSettingsRow saved;
      if (before == null) {
        final inserted = await CacheSettingsRow.db.insert(
          session,
          [next],
          ignoreConflicts: true,
          transaction: transaction,
        );
        if (inserted.isEmpty) {
          throw ApiException(
            code: 'conflict',
            message: 'The cache policy changed. Reload before saving.',
          );
        }
        saved = inserted.single;
      } else {
        saved = await CacheSettingsRow.db.updateRow(
          session,
          next,
          transaction: transaction,
        );
      }
      await _audit(
        session,
        operatorName: operatorName,
        action: 'cache_policy.update',
        targetType: 'cache_policy',
        targetId: 'default',
        reason: reason,
        before: before == null ? null : _policyAuditData(_toPolicy(before)),
        after: _policyAuditData(_toPolicy(saved)),
        transaction: transaction,
      );
      return _toPolicy(saved);
    });
  }

  Future<bool> quarantine(
    Session session, {
    required String providerPlaceId,
    required String reason,
  }) => _setQuarantine(
    session,
    providerPlaceId: providerPlaceId,
    reason: reason,
    quarantine: true,
  );

  Future<bool> restore(
    Session session, {
    required String providerPlaceId,
    required String reason,
  }) => _setQuarantine(
    session,
    providerPlaceId: providerPlaceId,
    reason: reason,
    quarantine: false,
  );

  Future<String> refreshCoverage(
    Session session, {
    required String coverageKey,
    required String reason,
  }) async {
    final operatorName = await _authorize(session);
    _reason(reason);
    return session.db.transaction((transaction) async {
      final existing = await RefreshJobRow.db.findFirstRow(
        session,
        where: (table) =>
            table.coverageKey.equals(coverageKey) &
            (table.status.equals(JobStatus.pending) |
                table.status.equals(JobStatus.running)),
        transaction: transaction,
        lockMode: LockMode.forUpdate,
      );
      if (existing != null) return existing.jobId;
      final jobId = _uuid.v7();
      await RefreshJobRow.db.insertRow(
        session,
        RefreshJobRow(
          jobId: jobId,
          coverageKey: coverageKey,
          status: JobStatus.pending,
          requestedBy: _operator(operatorName),
          reason: reason.trim(),
          createdAt: DateTime.now().toUtc(),
        ),
        transaction: transaction,
      );
      await _audit(
        session,
        operatorName: operatorName,
        action: 'coverage.refresh',
        targetType: 'coverage',
        targetId: coverageKey,
        reason: reason,
        transaction: transaction,
      );
      return jobId;
    });
  }

  Future<bool> cancelRefreshJob(
    Session session, {
    required String jobId,
    required String reason,
  }) async {
    final operatorName = await _authorize(session);
    _reason(reason);
    return session.db.transaction((transaction) async {
      final row = await RefreshJobRow.db.findFirstRow(
        session,
        where: (table) => table.jobId.equals(jobId),
        transaction: transaction,
      );
      if (row == null) {
        throw ApiException(
          code: 'not_found',
          message: 'Refresh job not found.',
        );
      }
      if (row.status != JobStatus.pending && row.status != JobStatus.running) {
        throw ApiException(
          code: 'conflict',
          message: 'Only pending or running refresh jobs can be cancelled.',
        );
      }
      final previousStatus = row.status;
      final updated = await RefreshJobRow.db.updateWhere(
        session,
        where: (table) =>
            table.jobId.equals(jobId) &
            (table.status.equals(JobStatus.pending) |
                table.status.equals(JobStatus.running)),
        columnValues: (table) => [
          table.status(JobStatus.cancelled),
          table.completedAt(DateTime.now().toUtc()),
        ],
        transaction: transaction,
      );
      if (updated.isEmpty) {
        throw ApiException(
          code: 'conflict',
          message: 'The refresh job finished before it could be cancelled.',
        );
      }
      await _audit(
        session,
        operatorName: operatorName,
        action: 'coverage.refresh.cancel',
        targetType: 'refresh_job',
        targetId: jobId,
        reason: reason,
        before: {'status': previousStatus.name},
        after: {'status': JobStatus.cancelled.name},
        transaction: transaction,
      );
      return true;
    });
  }

  Future<int> invalidateCoverage(
    Session session, {
    required String coverageKey,
    required String reason,
  }) async {
    final operatorName = await _authorize(session);
    _reason(reason);
    return session.db.transaction((transaction) async {
      final rows = await PoiCoverageRow.db.updateWhere(
        session,
        where: (table) => table.coverageKey.equals(coverageKey),
        columnValues: (table) => [table.invalidatedAt(DateTime.now().toUtc())],
        transaction: transaction,
      );
      await _audit(
        session,
        operatorName: operatorName,
        action: 'coverage.invalidate',
        targetType: 'coverage',
        targetId: coverageKey,
        reason: reason,
        after: {'invalidatedCount': '${rows.length}'},
        transaction: transaction,
      );
      return rows.length;
    });
  }

  Future<CalibrationValidation> validateCalibration(
    Session session, {
    required String version,
    required String documentJson,
  }) async {
    final operatorName = await _authorize(session);
    final normalizedVersion = version.trim();
    if (!RegExp(r'^[A-Za-z0-9][A-Za-z0-9._-]{0,79}$').hasMatch(
      normalizedVersion,
    )) {
      throw ApiException(
        code: 'invalid_request',
        message: 'Calibration version is invalid.',
      );
    }
    final validatedOperator = _operator(operatorName);
    final existing = await CalibrationRow.db.findFirstRow(
      session,
      where: (table) => table.version.equals(normalizedVersion),
    );
    if (existing != null &&
        (existing.status == CalibrationStatus.active ||
            existing.status == CalibrationStatus.superseded)) {
      throw ApiException(
        code: 'conflict',
        message:
            'Activated calibration versions are immutable. Use a new version.',
      );
    }
    final errors = <String>[];
    PlaceCalibration? calibration;
    var liveCanaryPassed = false;
    try {
      final decoded = jsonDecode(documentJson);
      if (decoded is! Map<String, Object?>) {
        errors.add('Document root must be a JSON object.');
      } else {
        calibration = PlaceCalibration.fromJson(decoded);
        if (calibration.version != normalizedVersion) {
          errors.add('Document version must match the requested version.');
        }
      }
    } catch (error) {
      errors.add(error.toString());
    }
    final fixturePassed = errors.isEmpty;
    if (fixturePassed && calibration != null) {
      final source = GoogleWebPlaceSource(calibration: calibration);
      try {
        final results = await source
            .search(
              query: 'restaurants in Riyadh',
              categoryId: 'restaurant',
              latitude: 24.7136,
              longitude: 46.6753,
              radiusMeters: 3000,
              desiredCount: 3,
              language: 'en',
              countryCode: 'SA',
            )
            .timeout(const Duration(seconds: 25));
        liveCanaryPassed = results.isNotEmpty;
        if (!liveCanaryPassed) {
          errors.add('The Riyadh live canary returned no valid places.');
        }
      } catch (error) {
        errors.add('Riyadh live canary failed: $error');
      } finally {
        source.close();
      }
    }
    final now = DateTime.now().toUtc();
    await session.db.transaction((transaction) async {
      final current = await CalibrationRow.db.findFirstRow(
        session,
        where: (table) => table.version.equals(normalizedVersion),
        transaction: transaction,
        lockMode: LockMode.forUpdate,
      );
      if (current != null &&
          (current.status == CalibrationStatus.active ||
              current.status == CalibrationStatus.superseded)) {
        throw ApiException(
          code: 'conflict',
          message: 'Activated calibration versions are immutable. Use a new version.',
        );
      }
      final row = CalibrationRow(
        id: current?.id,
        version: normalizedVersion,
        status: errors.isEmpty && liveCanaryPassed
            ? CalibrationStatus.valid
            : CalibrationStatus.invalid,
        document: {'json': documentJson},
        fixturePassed: fixturePassed,
        liveCanaryPassed: liveCanaryPassed,
        validationErrors: errors,
        createdBy: validatedOperator,
        createdAt: current?.createdAt ?? now,
        validatedAt: now,
      );
      if (current == null) {
        final inserted = await CalibrationRow.db.insert(
          session,
          [row],
          ignoreConflicts: true,
          transaction: transaction,
        );
        if (inserted.isEmpty) {
          throw ApiException(
            code: 'conflict',
            message: 'This calibration version changed during validation.',
          );
        }
      } else {
        await CalibrationRow.db.updateRow(
          session,
          row,
          transaction: transaction,
        );
      }
    });
    return CalibrationValidation(
      version: normalizedVersion,
      fixturePassed: fixturePassed,
      liveCanaryPassed: liveCanaryPassed,
      errors: errors,
      validatedAt: now,
    );
  }

  Future<bool> activateCalibration(
    Session session, {
    required String version,
    required String reason,
  }) async {
    final operatorName = await _authorize(session);
    _reason(reason);
    return session.db.transaction((transaction) async {
      final candidate = await CalibrationRow.db.findFirstRow(
        session,
        where: (table) => table.version.equals(version),
        transaction: transaction,
        lockMode: LockMode.forUpdate,
      );
      if (candidate == null ||
          !candidate.fixturePassed ||
          !candidate.liveCanaryPassed ||
          candidate.status != CalibrationStatus.valid) {
        throw ApiException(
          code: 'conflict',
          message: 'Validate this calibration before activation.',
        );
      }
      await CalibrationRow.db.updateWhere(
        session,
        where: (table) => table.status.equals(CalibrationStatus.active),
        columnValues: (table) => [table.status(CalibrationStatus.superseded)],
        transaction: transaction,
      );
      candidate.status = CalibrationStatus.active;
      candidate.activatedAt = DateTime.now().toUtc();
      await CalibrationRow.db.updateRow(
        session,
        candidate,
        transaction: transaction,
      );
      await _audit(
        session,
        operatorName: operatorName,
        action: 'calibration.activate',
        targetType: 'calibration',
        targetId: version,
        reason: reason,
        transaction: transaction,
      );
      return true;
    });
  }

  Future<bool> rollbackCalibration(
    Session session, {
    required String version,
    required String reason,
  }) async {
    final operatorName = await _authorize(session);
    _reason(reason);
    return session.db.transaction((transaction) async {
      final candidate = await CalibrationRow.db.findFirstRow(
        session,
        where: (table) => table.version.equals(version),
        transaction: transaction,
        lockMode: LockMode.forUpdate,
      );
      if (candidate == null ||
          !candidate.fixturePassed ||
          !candidate.liveCanaryPassed ||
          candidate.status != CalibrationStatus.superseded) {
        throw ApiException(
          code: 'conflict',
          message: 'Only a previously validated calibration can be restored.',
        );
      }
      await CalibrationRow.db.updateWhere(
        session,
        where: (table) => table.status.equals(CalibrationStatus.active),
        columnValues: (table) => [table.status(CalibrationStatus.superseded)],
        transaction: transaction,
      );
      candidate.status = CalibrationStatus.active;
      candidate.activatedAt = DateTime.now().toUtc();
      await CalibrationRow.db.updateRow(
        session,
        candidate,
        transaction: transaction,
      );
      await _audit(
        session,
        operatorName: operatorName,
        action: 'calibration.rollback',
        targetType: 'calibration',
        targetId: version,
        reason: reason,
        transaction: transaction,
      );
      return true;
    });
  }

  Future<bool> _setQuarantine(
    Session session, {
    required String providerPlaceId,
    required String reason,
    required bool quarantine,
  }) async {
    final operatorName = await _authorize(session);
    _reason(reason);
    return session.db.transaction((transaction) async {
      final row = await PoiCatalogRow.db.findFirstRow(
        session,
        where: (table) => table.providerPlaceId.equals(providerPlaceId),
        transaction: transaction,
        lockMode: LockMode.forUpdate,
      );
      if (row == null) {
        throw ApiException(
          code: 'not_found',
          message: 'Catalog place not found.',
        );
      }
      final before = {
        'quarantined': '${row.quarantinedAt != null}',
        if (row.quarantineReason != null) 'reason': row.quarantineReason!,
      };
      row.quarantinedAt = quarantine ? DateTime.now().toUtc() : null;
      row.quarantineReason = quarantine ? reason.trim() : null;
      await PoiCatalogRow.db.updateRow(
        session,
        row,
        transaction: transaction,
      );
      await _audit(
        session,
        operatorName: operatorName,
        action: quarantine ? 'catalog.quarantine' : 'catalog.restore',
        targetType: 'poi',
        targetId: providerPlaceId,
        reason: reason,
        before: before,
        after: {
          'quarantined': '$quarantine',
          if (row.quarantineReason != null) 'reason': row.quarantineReason!,
        },
        transaction: transaction,
      );
      return true;
    });
  }

  Future<bool> _mutatePoiIssue(
    Session session, {
    required String reportId,
    required PoiIssueModerationAction action,
    required String reason,
    String? sourceEvidence,
  }) async {
    final operatorName = await _authorize(session);
    return PoiIssueModerationService.mutate(
      session,
      operatorName: operatorName,
      reportId: reportId,
      action: action,
      reason: reason,
      sourceEvidence: sourceEvidence,
    );
  }

  String _poiIssueGroupKey(String placeId, PoiIssueType issueType) =>
      '$placeId\u0000${issueType.name}';

  AdminPoiIssue _adminPoiIssue(
    PoiIssueReportRow row, {
    required PoiCatalogRow? catalog,
    required int recurrenceCount,
    required int affectedSessionCount,
  }) => AdminPoiIssue(
    reportId: row.reportId,
    placeId: row.placeId,
    placeName: row.placeName,
    issueType: row.issueType,
    details: row.details,
    status: row.status,
    ownerName: row.ownerName,
    resolution: row.resolution,
    sourceEvidence: row.sourceEvidence,
    reportedSnapshot: row.reportedSnapshot,
    currentSnapshot: catalog?.snapshot,
    quarantinedAt: catalog?.quarantinedAt,
    quarantineReason: catalog?.quarantineReason,
    recurrenceCount: recurrenceCount,
    affectedSessionCount: affectedSessionCount,
    createdAt: row.createdAt,
    updatedAt: row.updatedAt,
    resolvedAt: row.resolvedAt,
  );

  Future<TaxonomyCanarySample> _taxonomyCanary(
    PlaceSource source,
    AdminTaxonomyItem item,
    AdminMapLocation location,
    int radiusMeters,
  ) async {
    try {
      final places = await source
          .search(
            query: item.searchQueryEn,
            categoryId: item.id,
            latitude: location.latitude,
            longitude: location.longitude,
            radiusMeters: radiusMeters,
            desiredCount: 3,
            language: 'en',
            countryCode: _country(location.countryCode),
          )
          .timeout(const Duration(seconds: 25));
      return TaxonomyCanarySample(
        itemId: item.id,
        resultCount: places.length,
        sampleNames: places
            .take(3)
            .map((place) => place.name)
            .toList(growable: false),
      );
    } on PlaceSourceException catch (error) {
      return TaxonomyCanarySample(
        itemId: item.id,
        resultCount: 0,
        sampleNames: const [],
        errorCode: error.code,
      );
    } catch (_) {
      return TaxonomyCanarySample(
        itemId: item.id,
        resultCount: 0,
        sampleNames: const [],
        errorCode: 'canary_unavailable',
      );
    }
  }

  String _country(String value) {
    final normalized = value.trim().toUpperCase();
    const supported = {'SA', 'AE', 'KW', 'QA', 'BH', 'OM'};
    if (!supported.contains(normalized)) {
      throw ApiException(
        code: 'bad_request',
        message: 'Choose a supported GCC country.',
      );
    }
    return normalized;
  }

  void _coordinates(double latitude, double longitude) {
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
  }

  Future<double> _metric(Session session, String name) async {
    final rows = await session.db.unsafeQuery(
      '''
SELECT COALESCE(
  SUM("metricValue" * "sampleCount") / NULLIF(SUM("sampleCount"), 0),
  0
) AS value
FROM "hayer_operational_metric"
WHERE "metricName" = @name
  AND "bucketStartedAt" >= @after
''',
      parameters: QueryParameters.named({
        'name': name,
        'after': DateTime.now().toUtc().subtract(const Duration(hours: 24)),
      }),
    );
    if (rows.isEmpty) return 0;
    return (rows.first.toColumnMap()['value'] as num?)?.toDouble() ?? 0;
  }

  Future<CacheSettingsRow?> _policyRow(
    Session session, {
    Transaction? transaction,
    LockMode? lockMode,
  }) => CacheSettingsRow.db.findFirstRow(
    session,
    where: (table) => table.settingsKey.equals('default'),
    transaction: transaction,
    lockMode: lockMode,
  );

  CoverageRecord _coverageRecord(PoiCoverageRow row) => CoverageRecord(
    coverageKey: row.coverageKey,
    queryKey: row.queryKey,
    language: row.language,
    countryCode: row.countryCode,
    anchorLatitude: row.anchorLatitude,
    anchorLongitude: row.anchorLongitude,
    radiusMeters: row.radiusMeters,
    calibrationVersion: row.calibrationVersion,
    resultCount: row.resultCount,
    refreshedAt: row.refreshedAt,
    expiresAt: row.expiresAt,
    lastFailureCode: row.lastFailureCode,
    invalidatedAt: row.invalidatedAt,
  );

  RefreshJobView _refreshJobView(RefreshJobRow row) => RefreshJobView(
    jobId: row.jobId,
    coverageKey: row.coverageKey,
    status: row.status,
    requestedBy: row.requestedBy,
    reason: row.reason,
    createdAt: row.createdAt,
    startedAt: row.startedAt,
    completedAt: row.completedAt,
    errorCode: row.errorCode,
  );

  AdminAuditEntry _adminAuditEntry(AdminAuditRow row) => AdminAuditEntry(
    auditId: row.auditId,
    operatorName: row.operatorName,
    action: row.action,
    targetType: row.targetType,
    targetId: row.targetId,
    reason: row.reason,
    beforeData: row.beforeData,
    afterData: row.afterData,
    occurredAt: row.occurredAt,
  );

  String _escapeLike(String value) => value
      .replaceAll(r'\', r'\\')
      .replaceAll('%', r'\%')
      .replaceAll('_', r'\_');

  CachePolicy _defaultPolicy() => CachePolicy(
    version: 0,
    freshHours: 72,
    staleFallbackDays: 30,
    retentionDays: 365,
    extractorAttempts: 2,
    perCreationConcurrency: 3,
    globalRequestsPerMinute: 30,
    globalBurst: 6,
    routeEstimatesEnabled: true,
    allowParticipantLocation: true,
    defaultRouteOrigin: RouteOriginMode.sessionAnchor,
    routeEstimateCacheMinutes: 10,
    routeRequestsPerMinute: 30,
    routeBurst: 6,
    updatedAt: DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
  );

  CachePolicy _toPolicy(CacheSettingsRow row) => CachePolicy(
    version: row.version,
    freshHours: row.freshHours,
    staleFallbackDays: row.staleFallbackDays,
    retentionDays: row.retentionDays,
    extractorAttempts: row.extractorAttempts,
    perCreationConcurrency: row.perCreationConcurrency,
    globalRequestsPerMinute: row.globalRequestsPerMinute,
    globalBurst: row.globalBurst,
    routeEstimatesEnabled: row.routeEstimatesEnabled,
    allowParticipantLocation: row.allowParticipantLocation,
    defaultRouteOrigin: row.defaultRouteOrigin,
    routeEstimateCacheMinutes: row.routeEstimateCacheMinutes,
    routeRequestsPerMinute: row.routeRequestsPerMinute,
    routeBurst: row.routeBurst,
    updatedAt: row.updatedAt,
  );

  void _validatePolicy(CachePolicy policy) {
    if (policy.freshHours < 1 ||
        policy.freshHours > 720 ||
        policy.staleFallbackDays < 1 ||
        policy.staleFallbackDays > 180 ||
        policy.freshHours > policy.staleFallbackDays * 24 ||
        policy.retentionDays < 30 ||
        policy.retentionDays < policy.staleFallbackDays ||
        policy.retentionDays > 730 ||
        policy.extractorAttempts < 1 ||
        policy.extractorAttempts > 3 ||
        policy.perCreationConcurrency < 1 ||
        policy.perCreationConcurrency > 5 ||
        policy.globalRequestsPerMinute < 1 ||
        policy.globalRequestsPerMinute > 300 ||
        policy.globalBurst < 1 ||
        policy.globalBurst > 30 ||
        policy.routeEstimateCacheMinutes < 1 ||
        policy.routeEstimateCacheMinutes > 120 ||
        policy.routeRequestsPerMinute < 1 ||
        policy.routeRequestsPerMinute > 300 ||
        policy.routeBurst < 1 ||
        policy.routeBurst > 30 ||
        (!policy.allowParticipantLocation &&
            policy.defaultRouteOrigin == RouteOriginMode.participantLocation)) {
      throw ApiException(
        code: 'bad_request',
        message: 'One or more policy values are outside safe bounds.',
      );
    }
  }

  Future<String> _authorize(Session session) => _authorizer(session);

  String _operator(String value) {
    final result = value.trim();
    if (result.length < 2 || result.length > 80) {
      throw ApiException(
        code: 'bad_request',
        message: 'Operator name is invalid.',
      );
    }
    return result;
  }

  void _reason(String value) {
    if (value.trim().length < 4 || value.trim().length > 500) {
      throw ApiException(
        code: 'bad_request',
        message: 'Enter a reason between 4 and 500 characters.',
      );
    }
  }

  /// Flattens a policy into the audit row's free-form string map.
  ///
  /// Serverpod stamps `__className__` into every model's JSON. Copying it into
  /// the diff makes the protocol deserialize the stored map back into
  /// `CachePolicy` on read, which then fails casting the stringified fields.
  static Map<String, String> _policyAuditData(CachePolicy policy) =>
      (policy.toJson()..remove('__className__')).map(
        (key, value) => MapEntry(key, '$value'),
      );

  Future<void> _audit(
    Session session, {
    required String operatorName,
    required String action,
    required String targetType,
    String? targetId,
    required String reason,
    Map<String, String>? before,
    Map<String, String>? after,
    required Transaction transaction,
  }) async {
    final salt = session.passwords['adminIpHashSalt'] ?? 'unconfigured';
    final ipHash = sha256.convert(utf8.encode('$salt:rpc')).toString();
    await _auditWriter.write(
      session,
      AdminAuditRow(
        auditId: _uuid.v7(),
        operatorName: _operator(operatorName),
        ipHash: ipHash,
        action: action,
        targetType: targetType,
        targetId: targetId,
        reason: reason.trim(),
        beforeData: before,
        afterData: after,
        occurredAt: DateTime.now().toUtc(),
      ),
      transaction: transaction,
    );
  }
}

class _MetricAggregate {
  _MetricAggregate(OperationalMetricRow row)
    : bucketStartedAt = row.bucketStartedAt,
      metricName = row.metricName;

  final DateTime bucketStartedAt;
  final String metricName;
  double weightedTotal = 0;
  int sampleCount = 0;

  void add(OperationalMetricRow row) {
    weightedTotal += row.metricValue * row.sampleCount;
    sampleCount += row.sampleCount;
  }

  MetricPoint toPoint() => MetricPoint(
    bucketStartedAt: bucketStartedAt,
    metricName: metricName,
    metricValue: sampleCount == 0 ? 0 : weightedTotal / sampleCount,
    sampleCount: sampleCount,
  );
}
