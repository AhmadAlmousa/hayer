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

  Future<AdminDiscoveryTaxonomyVersion> discoveryTaxonomyDraft();

  Future<List<AdminDiscoveryTaxonomyVersion>> discoveryTaxonomyHistory();

  Future<AdminDiscoveryTaxonomyVersion> saveDiscoveryTaxonomyDraft({
    required String reason,
    required String version,
    required int revision,
    required List<DiscoveryTaxonomyNode> roots,
  });

  Future<DiscoveryTaxonomyValidation> validateDiscoveryTaxonomyDraft({
    required String reason,
    required String version,
    required int revision,
  });

  Future<AdminDiscoveryTaxonomyVersion> publishDiscoveryTaxonomy({
    required String reason,
    required String version,
    required int revision,
  });

  Future<AdminDiscoveryTaxonomyVersion> rollbackDiscoveryTaxonomy({
    required String reason,
    required String version,
    required int expectedActiveRevision,
  });

  Future<AdminDiscoveryUnmappedTypePage> discoveryUnmappedTypes({
    required int page,
    required int pageSize,
    String? query,
    DiscoveryTypeMappingIssue? issue,
  });

  Future<AdminDiscoveryHarvestManifestVersion> discoveryHarvestManifestDraft();

  Future<List<AdminDiscoveryHarvestManifestVersion>>
  discoveryHarvestManifestHistory();

  Future<AdminDiscoveryHarvestManifestVersion>
  saveDiscoveryHarvestManifestDraft({
    required String reason,
    required String version,
    required int revision,
    required List<DiscoveryHarvestManifestEntry> entries,
  });

  Future<DiscoveryHarvestManifestValidation>
  validateDiscoveryHarvestManifestDraft({
    required String reason,
    required String version,
    required int revision,
  });

  Future<AdminDiscoveryHarvestManifestVersion> publishDiscoveryHarvestManifest({
    required String reason,
    required String version,
    required int revision,
  });

  Future<AdminDiscoveryHarvestManifestVersion>
  rollbackDiscoveryHarvestManifest({
    required String reason,
    required String version,
    required int expectedActiveRevision,
  });

  Future<AdminDiscoveryHarvestJobPage> discoveryHarvestJobs({
    required int page,
    required int pageSize,
    String? query,
    DiscoveryHarvestState? state,
    DiscoveryHarvestRequester? requester,
    DiscoveryHarvestTrigger? trigger,
  });

  Future<DiscoveryGrowthMetrics> discoveryGrowthMetrics({
    required DateTime from,
    required DateTime to,
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

  Future<AdminPoiIssuePage> poiIssues({
    required int page,
    required int pageSize,
    required String query,
    PoiIssueStatus? status,
  });

  Future<bool> claimPoiIssue({required String reportId});

  Future<bool> releasePoiIssue({
    required String reportId,
    required String reason,
  });

  Future<bool> resolvePoiIssue({
    required String reportId,
    required String resolution,
    required String sourceEvidence,
  });

  Future<bool> dismissPoiIssue({
    required String reportId,
    required String resolution,
    required String sourceEvidence,
  });

  Future<bool> reopenPoiIssue({
    required String reportId,
    required String reason,
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
  Future<AdminDiscoveryTaxonomyVersion> discoveryTaxonomyDraft() =>
      client.admin.discoveryTaxonomyDraft();

  @override
  Future<List<AdminDiscoveryTaxonomyVersion>> discoveryTaxonomyHistory() =>
      client.admin.discoveryTaxonomyHistory();

  @override
  Future<AdminDiscoveryTaxonomyVersion> saveDiscoveryTaxonomyDraft({
    required String reason,
    required String version,
    required int revision,
    required List<DiscoveryTaxonomyNode> roots,
  }) => client.admin.saveDiscoveryTaxonomyDraft(
    reason: reason,
    version: version,
    revision: revision,
    roots: roots,
  );

  @override
  Future<DiscoveryTaxonomyValidation> validateDiscoveryTaxonomyDraft({
    required String reason,
    required String version,
    required int revision,
  }) => client.admin.validateDiscoveryTaxonomyDraft(
    reason: reason,
    version: version,
    revision: revision,
  );

  @override
  Future<AdminDiscoveryTaxonomyVersion> publishDiscoveryTaxonomy({
    required String reason,
    required String version,
    required int revision,
  }) => client.admin.publishDiscoveryTaxonomy(
    reason: reason,
    version: version,
    revision: revision,
  );

  @override
  Future<AdminDiscoveryTaxonomyVersion> rollbackDiscoveryTaxonomy({
    required String reason,
    required String version,
    required int expectedActiveRevision,
  }) => client.admin.rollbackDiscoveryTaxonomy(
    reason: reason,
    version: version,
    expectedActiveRevision: expectedActiveRevision,
  );

  @override
  Future<AdminDiscoveryUnmappedTypePage> discoveryUnmappedTypes({
    required int page,
    required int pageSize,
    String? query,
    DiscoveryTypeMappingIssue? issue,
  }) => client.admin.discoveryUnmappedTypes(
    page: page,
    pageSize: pageSize,
    query: query,
    issue: issue,
  );

  @override
  Future<AdminDiscoveryHarvestManifestVersion>
  discoveryHarvestManifestDraft() =>
      client.admin.discoveryHarvestManifestDraft();

  @override
  Future<List<AdminDiscoveryHarvestManifestVersion>>
  discoveryHarvestManifestHistory() =>
      client.admin.discoveryHarvestManifestHistory();

  @override
  Future<AdminDiscoveryHarvestManifestVersion>
  saveDiscoveryHarvestManifestDraft({
    required String reason,
    required String version,
    required int revision,
    required List<DiscoveryHarvestManifestEntry> entries,
  }) => client.admin.saveDiscoveryHarvestManifestDraft(
    reason: reason,
    version: version,
    revision: revision,
    entries: entries,
  );

  @override
  Future<DiscoveryHarvestManifestValidation>
  validateDiscoveryHarvestManifestDraft({
    required String reason,
    required String version,
    required int revision,
  }) => client.admin.validateDiscoveryHarvestManifestDraft(
    reason: reason,
    version: version,
    revision: revision,
  );

  @override
  Future<AdminDiscoveryHarvestManifestVersion> publishDiscoveryHarvestManifest({
    required String reason,
    required String version,
    required int revision,
  }) => client.admin.publishDiscoveryHarvestManifest(
    reason: reason,
    version: version,
    revision: revision,
  );

  @override
  Future<AdminDiscoveryHarvestManifestVersion>
  rollbackDiscoveryHarvestManifest({
    required String reason,
    required String version,
    required int expectedActiveRevision,
  }) => client.admin.rollbackDiscoveryHarvestManifest(
    reason: reason,
    version: version,
    expectedActiveRevision: expectedActiveRevision,
  );

  @override
  Future<AdminDiscoveryHarvestJobPage> discoveryHarvestJobs({
    required int page,
    required int pageSize,
    String? query,
    DiscoveryHarvestState? state,
    DiscoveryHarvestRequester? requester,
    DiscoveryHarvestTrigger? trigger,
  }) => client.admin.discoveryHarvestJobs(
    page: page,
    pageSize: pageSize,
    query: query,
    state: state,
    requester: requester,
    trigger: trigger,
  );

  @override
  Future<DiscoveryGrowthMetrics> discoveryGrowthMetrics({
    required DateTime from,
    required DateTime to,
  }) => client.admin.discoveryGrowthMetrics(from: from, to: to);

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
  Future<AdminPoiIssuePage> poiIssues({
    required int page,
    required int pageSize,
    required String query,
    PoiIssueStatus? status,
  }) => client.admin.poiIssues(
    page: page,
    pageSize: pageSize,
    query: query,
    status: status,
  );

  @override
  Future<bool> claimPoiIssue({required String reportId}) =>
      client.admin.claimPoiIssue(reportId: reportId);

  @override
  Future<bool> releasePoiIssue({
    required String reportId,
    required String reason,
  }) => client.admin.releasePoiIssue(reportId: reportId, reason: reason);

  @override
  Future<bool> resolvePoiIssue({
    required String reportId,
    required String resolution,
    required String sourceEvidence,
  }) => client.admin.resolvePoiIssue(
    reportId: reportId,
    resolution: resolution,
    sourceEvidence: sourceEvidence,
  );

  @override
  Future<bool> dismissPoiIssue({
    required String reportId,
    required String resolution,
    required String sourceEvidence,
  }) => client.admin.dismissPoiIssue(
    reportId: reportId,
    resolution: resolution,
    sourceEvidence: sourceEvidence,
  );

  @override
  Future<bool> reopenPoiIssue({
    required String reportId,
    required String reason,
  }) => client.admin.reopenPoiIssue(reportId: reportId, reason: reason);

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
