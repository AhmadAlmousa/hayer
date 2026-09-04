import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:serverpod/serverpod.dart';

import 'admin_gateway_access.dart';
import '../generated/protocol.dart';
import '../places/calibration.dart';
import '../places/google_web_place_source.dart';

class AdminEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  static const _uuid = Uuid();

  Future<CacheDashboardSummary> summary(
    Session session, {
    required String credentials,
  }) async {
    _authorize(session, credentials);
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
    required String credentials,
    required int page,
    required int pageSize,
    String? query,
    bool includeQuarantined = false,
  }) async {
    _authorize(session, credentials);
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

  Future<CachePolicy> policy(
    Session session, {
    required String credentials,
  }) async {
    _authorize(session, credentials);
    final row = await CacheSettingsRow.db.findFirstRow(
      session,
      where: (table) => table.settingsKey.equals('default'),
    );
    if (row == null) return _defaultPolicy();
    return _toPolicy(row);
  }

  Future<CachePolicy> updatePolicy(
    Session session, {
    required String credentials,
    required String operatorName,
    required String reason,
    required CachePolicy policy,
  }) async {
    operatorName = _authorize(session, credentials);
    _reason(reason);
    _validatePolicy(policy);
    final now = DateTime.now().toUtc();
    final before = await CacheSettingsRow.db.findFirstRow(
      session,
      where: (table) => table.settingsKey.equals('default'),
    );
    if (before != null && policy.version != before.version) {
      throw ApiException(
        code: 'conflict',
        message: 'The cache policy changed. Reload before saving.',
      );
    }
    final next = CacheSettingsRow(
      id: before?.id,
      settingsKey: 'default',
      version: (before?.version ?? 0) + 1,
      freshHours: policy.freshHours,
      staleFallbackDays: policy.staleFallbackDays,
      retentionDays: policy.retentionDays,
      extractorAttempts: policy.extractorAttempts,
      perCreationConcurrency: policy.perCreationConcurrency,
      globalRequestsPerMinute: policy.globalRequestsPerMinute,
      globalBurst: policy.globalBurst,
      updatedBy: _operator(operatorName),
      updatedAt: now,
    );
    if (before == null) {
      await CacheSettingsRow.db.insertRow(session, next);
    } else {
      await CacheSettingsRow.db.updateRow(session, next);
    }
    await _audit(
      session,
      operatorName: operatorName,
      action: 'cache_policy.update',
      targetType: 'cache_policy',
      targetId: 'default',
      reason: reason,
      before: before == null
          ? null
          : _toPolicy(
              before,
            ).toJson().map((key, value) => MapEntry(key, '$value')),
      after: _toPolicy(
        next,
      ).toJson().map((key, value) => MapEntry(key, '$value')),
    );
    return _toPolicy(next);
  }

  Future<bool> quarantine(
    Session session, {
    required String credentials,
    required String operatorName,
    required String providerPlaceId,
    required String reason,
  }) => _setQuarantine(
    session,
    credentials: credentials,
    operatorName: operatorName,
    providerPlaceId: providerPlaceId,
    reason: reason,
    quarantine: true,
  );

  Future<bool> restore(
    Session session, {
    required String credentials,
    required String operatorName,
    required String providerPlaceId,
    required String reason,
  }) => _setQuarantine(
    session,
    credentials: credentials,
    operatorName: operatorName,
    providerPlaceId: providerPlaceId,
    reason: reason,
    quarantine: false,
  );

  Future<String> refreshCoverage(
    Session session, {
    required String credentials,
    required String operatorName,
    required String coverageKey,
    required String reason,
  }) async {
    operatorName = _authorize(session, credentials);
    _reason(reason);
    final existing = await RefreshJobRow.db.findFirstRow(
      session,
      where: (table) =>
          table.coverageKey.equals(coverageKey) &
          (table.status.equals(JobStatus.pending) |
              table.status.equals(JobStatus.running)),
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
    );
    await _audit(
      session,
      operatorName: operatorName,
      action: 'coverage.refresh',
      targetType: 'coverage',
      targetId: coverageKey,
      reason: reason,
    );
    return jobId;
  }

  Future<int> invalidateCoverage(
    Session session, {
    required String credentials,
    required String operatorName,
    required String coverageKey,
    required String reason,
  }) async {
    operatorName = _authorize(session, credentials);
    _reason(reason);
    final rows = await PoiCoverageRow.db.updateWhere(
      session,
      where: (table) => table.coverageKey.equals(coverageKey),
      columnValues: (table) => [table.invalidatedAt(DateTime.now().toUtc())],
    );
    await _audit(
      session,
      operatorName: operatorName,
      action: 'coverage.invalidate',
      targetType: 'coverage',
      targetId: coverageKey,
      reason: reason,
    );
    return rows.length;
  }

  Future<CalibrationValidation> validateCalibration(
    Session session, {
    required String credentials,
    required String operatorName,
    required String version,
    required String documentJson,
  }) async {
    operatorName = _authorize(session, credentials);
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
    final row = CalibrationRow(
      id: existing?.id,
      version: normalizedVersion,
      status: errors.isEmpty && liveCanaryPassed
          ? CalibrationStatus.valid
          : CalibrationStatus.invalid,
      document: {'json': documentJson},
      fixturePassed: fixturePassed,
      liveCanaryPassed: liveCanaryPassed,
      validationErrors: errors,
      createdBy: validatedOperator,
      createdAt: existing?.createdAt ?? now,
      validatedAt: now,
    );
    if (existing == null) {
      await CalibrationRow.db.insertRow(session, row);
    } else {
      await CalibrationRow.db.updateRow(session, row);
    }
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
    required String credentials,
    required String operatorName,
    required String version,
    required String reason,
  }) async {
    operatorName = _authorize(session, credentials);
    _reason(reason);
    final candidate = await CalibrationRow.db.findFirstRow(
      session,
      where: (table) => table.version.equals(version),
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
    await session.db.transaction((transaction) async {
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
    });
    await _audit(
      session,
      operatorName: operatorName,
      action: 'calibration.activate',
      targetType: 'calibration',
      targetId: version,
      reason: reason,
    );
    return true;
  }

  Future<bool> rollbackCalibration(
    Session session, {
    required String credentials,
    required String operatorName,
    required String version,
    required String reason,
  }) async {
    operatorName = _authorize(session, credentials);
    _reason(reason);
    final candidate = await CalibrationRow.db.findFirstRow(
      session,
      where: (table) => table.version.equals(version),
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
    await session.db.transaction((transaction) async {
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
    });
    await _audit(
      session,
      operatorName: operatorName,
      action: 'calibration.rollback',
      targetType: 'calibration',
      targetId: version,
      reason: reason,
    );
    return true;
  }

  Future<bool> _setQuarantine(
    Session session, {
    required String credentials,
    required String operatorName,
    required String providerPlaceId,
    required String reason,
    required bool quarantine,
  }) async {
    operatorName = _authorize(session, credentials);
    _reason(reason);
    final row = await PoiCatalogRow.db.findFirstRow(
      session,
      where: (table) => table.providerPlaceId.equals(providerPlaceId),
    );
    if (row == null) {
      throw ApiException(
        code: 'not_found',
        message: 'Catalog place not found.',
      );
    }
    row.quarantinedAt = quarantine ? DateTime.now().toUtc() : null;
    row.quarantineReason = quarantine ? reason.trim() : null;
    await PoiCatalogRow.db.updateRow(session, row);
    await _audit(
      session,
      operatorName: operatorName,
      action: quarantine ? 'catalog.quarantine' : 'catalog.restore',
      targetType: 'poi',
      targetId: providerPlaceId,
      reason: reason,
    );
    return true;
  }

  Future<double> _metric(Session session, String name) async {
    final rows = await session.db.unsafeQuery(
      '''
SELECT COALESCE(AVG("metricValue"), 0) AS value
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

  CachePolicy _defaultPolicy() => CachePolicy(
    version: 0,
    freshHours: 72,
    staleFallbackDays: 30,
    retentionDays: 365,
    extractorAttempts: 2,
    perCreationConcurrency: 3,
    globalRequestsPerMinute: 30,
    globalBurst: 6,
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
        policy.globalBurst > 30) {
      throw ApiException(
        code: 'bad_request',
        message: 'One or more policy values are outside safe bounds.',
      );
    }
  }

  String _authorize(Session session, String _) {
    final request = session.request;
    final operator = AdminGatewayAccess.resolveOperator(
      authenticatedValues:
          request?.headers[AdminGatewayAccess.authenticatedHeader],
      usernameValues: request?.headers[AdminGatewayAccess.usernameHeader],
    );
    if (operator == null) {
      throw ApiException(
        code: 'unauthorized',
        message: 'Dashboard access must pass through the protected gateway.',
      );
    }
    return operator;
  }

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

  Future<void> _audit(
    Session session, {
    required String operatorName,
    required String action,
    required String targetType,
    String? targetId,
    required String reason,
    Map<String, String>? before,
    Map<String, String>? after,
  }) async {
    final salt = session.passwords['adminIpHashSalt'] ?? 'unconfigured';
    final ipHash = sha256.convert(utf8.encode('$salt:rpc')).toString();
    await AdminAuditRow.db.insertRow(
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
    );
  }
}
