import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../security/rate_limiter.dart';
import 'poi_issue_policy.dart';

typedef _ReportedPlace = ({
  PoiIssueSource source,
  String? sessionId,
  String placeId,
  PlaceSnapshot snapshot,
});

/// Files POI issue reports from a swipe session or from Discover through one
/// pipeline: validation, reporter hashing, idempotency, per-reporter
/// deduplication, quotas and moderation storage. The server always resolves
/// the reported snapshot itself.
abstract final class PoiIssueReportService {
  static const _uuid = Uuid();

  /// Reports a place in the reporter's own swipe session.
  static Future<String> reportSessionPlace(
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

    return _submit(
      session,
      request: {
        'sessionId': sessionId,
        'placeId': placeId,
        'issueType': issueType.name,
        'details': normalizedDetails,
      },
      issueType: issueType,
      details: normalizedDetails,
      idempotencyKey: idempotencyKey,
      resolve: (transaction, userId) async {
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
        return (
          source: PoiIssueSource.session,
          sessionId: sessionId,
          placeId: placeId,
          snapshot: place.snapshot,
        );
      },
    );
  }

  /// Reports a shared catalog place by its server-issued catalog id, without
  /// a swipe session.
  static Future<String> reportCatalogPlace(
    Session session, {
    required int catalogId,
    required PoiIssueType issueType,
    String? details,
    required String idempotencyKey,
  }) async {
    final String? normalizedDetails;
    try {
      PoiIssuePolicy.validateCatalogRequest(
        catalogId: catalogId,
        idempotencyKey: idempotencyKey,
      );
      normalizedDetails = PoiIssuePolicy.normalizeDetails(issueType, details);
    } on FormatException catch (error) {
      throw ApiException(code: 'bad_request', message: error.message);
    }

    return _submit(
      session,
      request: {
        'source': PoiIssueSource.discovery.name,
        'catalogId': catalogId,
        'issueType': issueType.name,
        'details': normalizedDetails,
      },
      issueType: issueType,
      details: normalizedDetails,
      idempotencyKey: idempotencyKey,
      resolve: (transaction, _) async {
        final rows = await session.db.unsafeQuery(
          '''
SELECT "providerPlaceId", "snapshot"
FROM "hayer_poi_catalog"
WHERE "catalogId" = @catalogId
''',
          parameters: QueryParameters.named({'catalogId': catalogId}),
          transaction: transaction,
        );
        if (rows.isEmpty) {
          throw ApiException(
            code: 'not_found',
            message: 'That place is not in the catalog.',
          );
        }
        final row = rows.single.toColumnMap();
        final snapshot = row['snapshot'];
        return (
          source: PoiIssueSource.discovery,
          sessionId: null,
          placeId: row['providerPlaceId']! as String,
          snapshot: PlaceSnapshot.fromJson(
            ((snapshot is String ? jsonDecode(snapshot) : snapshot)! as Map)
                .cast<String, dynamic>(),
          ),
        );
      },
    );
  }

  static Future<String> _submit(
    Session session, {
    required Map<String, Object?> request,
    required PoiIssueType issueType,
    required String? details,
    required String idempotencyKey,
    required Future<_ReportedPlace> Function(
      Transaction transaction,
      String userId,
    )
    resolve,
  }) async {
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
    final requestHash = sha256
        .convert(utf8.encode(jsonEncode(request)))
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

      final place = await resolve(transaction, userId);
      // One active report per reporter, place and issue type, whichever mode
      // it was filed from.
      final activeDedupeKey = PoiIssuePolicy.activeDedupeKey(
        reporterHash: reporterHash,
        placeId: place.placeId,
        issueType: issueType,
      );

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
          source: place.source,
          sessionId: place.sessionId,
          placeId: place.placeId,
          placeName: place.snapshot.name,
          reportedSnapshot: place.snapshot,
          issueType: issueType,
          details: details,
          status: PoiIssueStatus.open,
          createdAt: now,
          updatedAt: now,
        ),
        transaction: transaction,
      );
      return proposedReportId;
    });
  }
}
