import 'package:hayer_client/hayer_client.dart';

abstract interface class AdminOperations {
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

  static const _credentials = '';
  static const _operatorName = 'gateway';

  @override
  Future<CacheDashboardSummary> summary() =>
      client.admin.summary(credentials: _credentials);

  @override
  Future<CatalogPlacePage> catalog({
    required int page,
    required int pageSize,
    required String query,
    required bool includeQuarantined,
  }) => client.admin.catalog(
    credentials: _credentials,
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
  }) => client.admin.coverage(
    credentials: _credentials,
    page: page,
    pageSize: pageSize,
    query: query,
  );

  @override
  Future<RefreshJobPage> refreshJobs({
    required int page,
    required int pageSize,
    required String query,
    JobStatus? status,
  }) => client.admin.refreshJobs(
    credentials: _credentials,
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
  }) => client.admin.auditLog(
    credentials: _credentials,
    page: page,
    pageSize: pageSize,
    query: query,
  );

  @override
  Future<List<MetricPoint>> metricTrend({int hours = 24}) =>
      client.admin.metricTrend(credentials: _credentials, hours: hours);

  @override
  Future<CatalogPrunePreview> prunePreview() =>
      client.admin.prunePreview(credentials: _credentials);

  @override
  Future<int> pruneCatalog({required String reason}) =>
      client.admin.pruneCatalog(
        credentials: _credentials,
        operatorName: _operatorName,
        reason: reason,
      );

  @override
  Future<CachePolicy> policy() =>
      client.admin.policy(credentials: _credentials);

  @override
  Future<CachePolicy> updatePolicy({
    required String reason,
    required CachePolicy policy,
  }) => client.admin.updatePolicy(
    credentials: _credentials,
    operatorName: _operatorName,
    reason: reason,
    policy: policy,
  );

  @override
  Future<bool> quarantine({
    required String providerPlaceId,
    required String reason,
  }) => client.admin.quarantine(
    credentials: _credentials,
    operatorName: _operatorName,
    providerPlaceId: providerPlaceId,
    reason: reason,
  );

  @override
  Future<bool> restore({
    required String providerPlaceId,
    required String reason,
  }) => client.admin.restore(
    credentials: _credentials,
    operatorName: _operatorName,
    providerPlaceId: providerPlaceId,
    reason: reason,
  );

  @override
  Future<String> refreshCoverage({
    required String coverageKey,
    required String reason,
  }) => client.admin.refreshCoverage(
    credentials: _credentials,
    operatorName: _operatorName,
    coverageKey: coverageKey,
    reason: reason,
  );

  @override
  Future<bool> cancelRefreshJob({
    required String jobId,
    required String reason,
  }) => client.admin.cancelRefreshJob(
    credentials: _credentials,
    operatorName: _operatorName,
    jobId: jobId,
    reason: reason,
  );

  @override
  Future<int> invalidateCoverage({
    required String coverageKey,
    required String reason,
  }) => client.admin.invalidateCoverage(
    credentials: _credentials,
    operatorName: _operatorName,
    coverageKey: coverageKey,
    reason: reason,
  );

  @override
  Future<CalibrationValidation> validateCalibration({
    required String version,
    required String documentJson,
  }) => client.admin.validateCalibration(
    credentials: _credentials,
    operatorName: _operatorName,
    version: version,
    documentJson: documentJson,
  );

  @override
  Future<bool> activateCalibration({
    required String version,
    required String reason,
  }) => client.admin.activateCalibration(
    credentials: _credentials,
    operatorName: _operatorName,
    version: version,
    reason: reason,
  );

  @override
  Future<bool> rollbackCalibration({
    required String version,
    required String reason,
  }) => client.admin.rollbackCalibration(
    credentials: _credentials,
    operatorName: _operatorName,
    version: version,
    reason: reason,
  );
}
