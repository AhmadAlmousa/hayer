import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Persists append-only administration audit records.
abstract interface class AdminAuditWriter {
  Future<void> write(
    Session session,
    AdminAuditRow row, {
    required Transaction transaction,
  });
}

/// Writes administration audit records to the primary database.
final class DatabaseAdminAuditWriter implements AdminAuditWriter {
  const DatabaseAdminAuditWriter();

  @override
  Future<void> write(
    Session session,
    AdminAuditRow row, {
    required Transaction transaction,
  }) async {
    await AdminAuditRow.db.insertRow(
      session,
      row,
      transaction: transaction,
    );
  }
}
