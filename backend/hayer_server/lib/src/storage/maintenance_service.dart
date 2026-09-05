import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'catalog_pruner.dart';

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
      await CityResolutionRow.db.deleteWhere(
        session,
        where: (table) => table.expiresAt <= now,
      );
      // Three-character join codes are intentionally short-lived. Cascading
      // deletes release codes after a small recovery window and bound storage.
      await HayerSessionRow.db.deleteWhere(
        session,
        where: (table) =>
            table.expiresAt <= now.subtract(const Duration(days: 7)),
      );
      final settings = await CacheSettingsRow.db.findFirstRow(
        session,
        where: (table) => table.settingsKey.equals('default'),
      );
      final retentionCutoff = now.subtract(
        Duration(days: settings?.retentionDays ?? 365),
      );
      await CatalogPruner.prune(session, cutoff: retentionCutoff);
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
