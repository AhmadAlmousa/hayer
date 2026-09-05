import 'package:hayer_client/hayer_client.dart';

abstract interface class AdminOperations {
  Future<AdminLiveUsage> liveUsage();

  Future<AdminAnalyticsOverview> analyticsOverview(AnalyticsFilter filter);

  Future<AdminUsageAnalytics> usageAnalytics(AnalyticsFilter filter);

  Future<AdminPlaceAnalytics> placeAnalytics({
    required AnalyticsFilter filter,
    required PlaceRanking ranking,
    required int minimumSamples,
  });

  Future<List<LocationSuggestion>> suggestAdminLocation({
    required String query,
    required String countryCode,
  });

  Future<AdminMapLocation> reverseAdminLocation({
    required double latitude,
    required double longitude,
    required String countryCode,
  });

  Future<AdminTaxonomyVersion> taxonomyDraft();

  Future<List<AdminTaxonomyVersion>> taxonomyHistory();

  Future<AdminTaxonomyVersion> saveTaxonomyDraft({
    required String reason,
    required String version,
    required int revision,
    required List<AdminTaxonomyItem> items,
  });

  Future<TaxonomyValidation> validateTaxonomyDraft({
    required String reason,
    required String version,
    required int revision,
    required AdminMapLocation location,
    required int radiusMeters,
  });

  Future<AdminTaxonomyVersion> publishTaxonomy({
    required String reason,
    required String version,
    required int revision,
  });

  Future<AdminTaxonomyVersion> rollbackTaxonomy({
    required String reason,
    required String version,
  });

  Future<CacheDashboardSummary> summary();

  Future<CatalogPlacePage> catalog({
    required int page,
    required int pageSize,
    required String query,
    required bool includeQuarantined,
  });

  Future<CoveragePage> coverage({
    required int page,
    required int pageSize,
    required String query,
  });

  Future<RefreshJobPage> refreshJobs({
    required int page,
    required int pageSize,
    required String query,
    JobStatus? status,
  });

  Future<AdminAuditPage> auditLog({
    required int page,
    required int pageSize,
    required String query,
  });

  Future<List<MetricPoint>> metricTrend({int hours = 24});

  Future<CatalogPrunePreview> prunePreview();

  Future<int> pruneCatalog({required String reason});

  Future<CachePolicy> policy();

  Future<CachePolicy> updatePolicy({
    required String reason,
    required CachePolicy policy,
  });

  Future<bool> quarantine({
    required String providerPlaceId,
    required String reason,
  });

  Future<bool> restore({
    required String providerPlaceId,
    required String reason,
  });

  Future<String> refreshCoverage({
    required String coverageKey,
    required String reason,
  });

  Future<bool> cancelRefreshJob({
    required String jobId,
    required String reason,
  });

  Future<int> invalidateCoverage({
    required String coverageKey,
    required String reason,
  });

  Future<CalibrationValidation> validateCalibration({
    required String version,
    required String documentJson,
  });

  Future<bool> activateCalibration({
    required String version,
    required String reason,
  });

  Future<bool> rollbackCalibration({
    required String version,
    required String reason,
  });
}

class ServerpodAdminOperations implements AdminOperations {
  const ServerpodAdminOperations(this.client);

  final Client client;

  @override
  Future<AdminLiveUsage> liveUsage() => client.admin.liveUsage();

  @override
  Future<AdminAnalyticsOverview> analyticsOverview(AnalyticsFilter filter) =>
      client.admin.analyticsOverview(filter: filter);

  @override
  Future<AdminUsageAnalytics> usageAnalytics(AnalyticsFilter filter) =>
      client.admin.usageAnalytics(filter: filter);

  @override
  Future<AdminPlaceAnalytics> placeAnalytics({
    required AnalyticsFilter filter,
    required PlaceRanking ranking,
    required int minimumSamples,
  }) => client.admin.placeAnalytics(
    filter: filter,
    ranking: ranking,
    minimumSamples: minimumSamples,
  );

  @override
  Future<List<LocationSuggestion>> suggestAdminLocation({
    required String query,
    required String countryCode,
  }) =>
      client.admin.suggestAdminLocation(query: query, countryCode: countryCode);

  @override
  Future<AdminMapLocation> reverseAdminLocation({
    required double latitude,
    required double longitude,
    required String countryCode,
  }) => client.admin.reverseAdminLocation(
    latitude: latitude,
    longitude: longitude,
    countryCode: countryCode,
  );

  @override
  Future<AdminTaxonomyVersion> taxonomyDraft() => client.admin.taxonomyDraft();

  @override
  Future<List<AdminTaxonomyVersion>> taxonomyHistory() =>
      client.admin.taxonomyHistory();

  @override
  Future<AdminTaxonomyVersion> saveTaxonomyDraft({
    required String reason,
    required String version,
    required int revision,
    required List<AdminTaxonomyItem> items,
  }) => client.admin.saveTaxonomyDraft(
    reason: reason,
    version: version,
    revision: revision,
    items: items,
  );

  @override
  Future<TaxonomyValidation> validateTaxonomyDraft({
    required String reason,
    required String version,
    required int revision,
    required AdminMapLocation location,
    required int radiusMeters,
  }) => client.admin.validateTaxonomyDraft(
    reason: reason,
    version: version,
    revision: revision,
    location: location,
    radiusMeters: radiusMeters,
  );

  @override
  Future<AdminTaxonomyVersion> publishTaxonomy({
    required String reason,
    required String version,
    required int revision,
  }) => client.admin.publishTaxonomy(
    reason: reason,
    version: version,
    revision: revision,
  );

  @override
  Future<AdminTaxonomyVersion> rollbackTaxonomy({
    required String reason,
    required String version,
  }) => client.admin.rollbackTaxonomy(reason: reason, version: version);

  @override
  Future<CacheDashboardSummary> summary() => client.admin.summary();

  @override
  Future<CatalogPlacePage> catalog({
    required int page,
    required int pageSize,
    required String query,
    required bool includeQuarantined,
  }) => client.admin.catalog(
    page: page,
    pageSize: pageSize,
    query: query,
    includeQuarantined: includeQuarantined,
  );

  @override
  Future<CoveragePage> coverage({
    required int page,
    required int pageSize,
    required String query,
  }) => client.admin.coverage(page: page, pageSize: pageSize, query: query);

  @override
  Future<RefreshJobPage> refreshJobs({
    required int page,
    required int pageSize,
    required String query,
    JobStatus? status,
  }) => client.admin.refreshJobs(
    page: page,
    pageSize: pageSize,
    query: query,
    status: status,
  );

  @override
  Future<AdminAuditPage> auditLog({
    required int page,
    required int pageSize,
    required String query,
  }) => client.admin.auditLog(page: page, pageSize: pageSize, query: query);

  @override
  Future<List<MetricPoint>> metricTrend({int hours = 24}) =>
      client.admin.metricTrend(hours: hours);

  @override
  Future<CatalogPrunePreview> prunePreview() => client.admin.prunePreview();

  @override
  Future<int> pruneCatalog({required String reason}) =>
      client.admin.pruneCatalog(reason: reason);

  @override
  Future<CachePolicy> policy() => client.admin.policy();

  @override
  Future<CachePolicy> updatePolicy({
    required String reason,
    required CachePolicy policy,
  }) => client.admin.updatePolicy(reason: reason, policy: policy);

  @override
  Future<bool> quarantine({
    required String providerPlaceId,
    required String reason,
  }) =>
      client.admin.quarantine(providerPlaceId: providerPlaceId, reason: reason);

  @override
  Future<bool> restore({
    required String providerPlaceId,
    required String reason,
  }) => client.admin.restore(providerPlaceId: providerPlaceId, reason: reason);

  @override
  Future<String> refreshCoverage({
    required String coverageKey,
    required String reason,
  }) => client.admin.refreshCoverage(coverageKey: coverageKey, reason: reason);

  @override
  Future<bool> cancelRefreshJob({
    required String jobId,
    required String reason,
  }) => client.admin.cancelRefreshJob(jobId: jobId, reason: reason);

  @override
  Future<int> invalidateCoverage({
    required String coverageKey,
    required String reason,
  }) =>
      client.admin.invalidateCoverage(coverageKey: coverageKey, reason: reason);

  @override
  Future<CalibrationValidation> validateCalibration({
    required String version,
    required String documentJson,
  }) => client.admin.validateCalibration(
    version: version,
    documentJson: documentJson,
  );

  @override
  Future<bool> activateCalibration({
    required String version,
    required String reason,
  }) => client.admin.activateCalibration(version: version, reason: reason);

  @override
  Future<bool> rollbackCalibration({
    required String version,
    required String reason,
  }) => client.admin.rollbackCalibration(version: version, reason: reason);
}
