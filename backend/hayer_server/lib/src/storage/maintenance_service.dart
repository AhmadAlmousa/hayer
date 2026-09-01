import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Bounded housekeeping that complements expiry checks on every API call.
class MaintenanceService {
  const MaintenanceService._();

  static Future<void> run(Serverpod pod) async {
    final session = await pod.createSession(enableLogging: true);
    try {
      final now = DateTime.now().toUtc();
      await HayerSessionRow.db.updateWhere(
        session,
        where: (table) =>
            table.status.equals(SessionStatus.active) &
            (table.expiresAt <= now),
        columnValues: (table) => [table.status(SessionStatus.expired)],
      );
      await IdempotencyRow.db.deleteWhere(
        session,
        where: (table) => table.expiresAt <= now,
      );
      await RateLimitRow.db.deleteWhere(
        session,
        where: (table) => table.expiresAt <= now,
      );
      final settings = await CacheSettingsRow.db.findFirstRow(
        session,
        where: (table) => table.settingsKey.equals('default'),
      );
      final retentionCutoff = now.subtract(
        Duration(days: settings?.retentionDays ?? 365),
      );
      await PoiCatalogRow.db.deleteWhere(
        session,
        where: (table) =>
            (table.lastSeenAt < retentionCutoff) &
            table.quarantinedAt.equals(null),
      );
      await OperationalMetricRow.db.deleteWhere(
        session,
        where: (table) =>
            table.bucketStartedAt < now.subtract(const Duration(days: 90)),
      );
    } catch (error, stackTrace) {
      session.log(
        'Scheduled maintenance failed.',
        level: LogLevel.error,
        exception: error,
        stackTrace: stackTrace,
      );
    } finally {
      await session.close();
    }
  }
}
