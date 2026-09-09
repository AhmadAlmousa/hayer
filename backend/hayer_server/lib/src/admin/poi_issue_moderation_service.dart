import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../places/poi_issue_policy.dart';

enum PoiIssueModerationAction { claim, release, resolve, dismiss, reopen }

abstract final class PoiIssueModerationService {
  static const _uuid = Uuid();

  static Future<bool> mutate(
    Session session, {
    required String operatorName,
    required String reportId,
    required PoiIssueModerationAction action,
    required String reason,
    String? sourceEvidence,
  }) async {
    _validateOperator(operatorName);
    _validateReason(reason);
    if (sourceEvidence != null) _validateReason(sourceEvidence);
    if ((action == PoiIssueModerationAction.resolve ||
            action == PoiIssueModerationAction.dismiss) &&
        sourceEvidence == null) {
      throw ApiException(
        code: 'bad_request',
        message: 'Source evidence is required to close a report.',
      );
    }
    if (reportId.isEmpty || reportId.length > 128) {
      throw ApiException(
        code: 'bad_request',
        message: 'Report identifier is invalid.',
      );
    }

    await session.db.transaction((transaction) async {
      final row = await PoiIssueReportRow.db.findFirstRow(
        session,
        where: (table) => table.reportId.equals(reportId),
        transaction: transaction,
        lockMode: LockMode.forUpdate,
      );
      if (row == null) {
        throw ApiException(code: 'not_found', message: 'Report not found.');
      }
      final before = _auditData(row);
      final now = DateTime.now().toUtc();
      switch (action) {
        case PoiIssueModerationAction.claim:
          if (row.status == PoiIssueStatus.inReview &&
              row.ownerName == operatorName) {
            return;
          }
          if (row.status != PoiIssueStatus.open) {
            throw ApiException(
              code: 'conflict',
              message: 'Only an open report can be claimed.',
            );
          }
          row
            ..status = PoiIssueStatus.inReview
            ..ownerName = operatorName;
        case PoiIssueModerationAction.release:
          _requireOwner(row, operatorName);
          row
            ..status = PoiIssueStatus.open
            ..ownerName = null;
        case PoiIssueModerationAction.resolve:
          _requireOwner(row, operatorName);
          row
            ..status = PoiIssueStatus.resolved
            ..resolution = reason.trim()
            ..sourceEvidence = sourceEvidence!.trim()
            ..resolvedAt = now
            ..activeDedupeKey = null;
        case PoiIssueModerationAction.dismiss:
          _requireOwner(row, operatorName);
          row
            ..status = PoiIssueStatus.dismissed
            ..resolution = reason.trim()
            ..sourceEvidence = sourceEvidence!.trim()
            ..resolvedAt = now
            ..activeDedupeKey = null;
        case PoiIssueModerationAction.reopen:
          if (row.status != PoiIssueStatus.resolved &&
              row.status != PoiIssueStatus.dismissed) {
            throw ApiException(
              code: 'conflict',
              message: 'Only a closed report can be reopened.',
            );
          }
          final activeDedupeKey = PoiIssuePolicy.activeDedupeKey(
            reporterHash: row.reporterHash,
            placeId: row.placeId,
            issueType: row.issueType,
          );
          final conflicting = await PoiIssueReportRow.db.findFirstRow(
            session,
            where: (table) =>
                table.activeDedupeKey.equals(activeDedupeKey) &
                table.reportId.notEquals(row.reportId),
            transaction: transaction,
          );
          if (conflicting != null) {
            throw ApiException(
              code: 'conflict',
              message: 'A newer active report already covers this issue.',
            );
          }
          row
            ..status = PoiIssueStatus.open
            ..ownerName = null
            ..resolution = null
            ..sourceEvidence = null
            ..resolvedAt = null
            ..activeDedupeKey = activeDedupeKey;
      }
      row.updatedAt = now;
      await PoiIssueReportRow.db.updateRow(
        session,
        row,
        transaction: transaction,
      );
      await _audit(
        session,
        operatorName: operatorName,
        action: action,
        row: row,
        reason: reason,
        before: before,
        transaction: transaction,
      );
    });
    return true;
  }

  static void _requireOwner(PoiIssueReportRow row, String operatorName) {
    if (row.status != PoiIssueStatus.inReview ||
        row.ownerName != operatorName) {
      throw ApiException(
        code: 'conflict',
        message: 'Claim this report before closing or releasing it.',
      );
    }
  }

  static void _validateOperator(String value) {
    if (!RegExp(r'^[A-Za-z0-9._-]{1,64}$').hasMatch(value)) {
      throw ApiException(
        code: 'unauthorized',
        message: 'Operator name is invalid.',
      );
    }
  }

  static void _validateReason(String value) {
    if (value.trim().length < 4 || value.trim().length > 500) {
      throw ApiException(
        code: 'bad_request',
        message: 'Enter a reason between 4 and 500 characters.',
      );
    }
  }

  static Map<String, String> _auditData(PoiIssueReportRow row) => {
    'status': row.status.name,
    'placeId': row.placeId,
    'issueType': row.issueType.name,
    if (row.ownerName != null) 'owner': row.ownerName!,
    if (row.resolution != null) 'resolution': row.resolution!,
    if (row.sourceEvidence != null) 'sourceEvidence': row.sourceEvidence!,
  };

  static Future<void> _audit(
    Session session, {
    required String operatorName,
    required PoiIssueModerationAction action,
    required PoiIssueReportRow row,
    required String reason,
    required Map<String, String> before,
    required Transaction transaction,
  }) async {
    final salt = session.passwords['adminIpHashSalt'] ?? 'unconfigured';
    final ipHash = sha256.convert(utf8.encode('$salt:rpc')).toString();
    await AdminAuditRow.db.insertRow(
      session,
      AdminAuditRow(
        auditId: _uuid.v7(),
        operatorName: operatorName,
        ipHash: ipHash,
        action: 'poi_issue.${action.name}',
        targetType: 'poi_issue',
        targetId: row.reportId,
        reason: reason.trim(),
        beforeData: before,
        afterData: _auditData(row),
        occurredAt: DateTime.now().toUtc(),
      ),
      transaction: transaction,
    );
  }
}
