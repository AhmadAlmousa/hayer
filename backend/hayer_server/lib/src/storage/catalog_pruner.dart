import 'package:serverpod/serverpod.dart';

import '../discovery/discovery_metrics.dart';

/// Removes catalog records that are outside retention and are not referenced
/// by an immutable session snapshot.
abstract final class CatalogPruner {
  static Future<int> eligibleCount(
    Session session, {
    required DateTime cutoff,
    Transaction? transaction,
  }) async {
    final rows = await session.db.unsafeQuery(
      '''
SELECT COUNT(*)::int AS count
FROM "hayer_poi_catalog" AS catalog
WHERE catalog."lastSeenAt" < @cutoff
  AND catalog."quarantinedAt" IS NULL
  AND NOT EXISTS (
    SELECT 1
    FROM "hayer_session_place" AS session_place
    WHERE session_place."placeId" = catalog."providerPlaceId"
  )
''',
      parameters: QueryParameters.named({'cutoff': cutoff}),
      transaction: transaction,
    );
    if (rows.isEmpty) return 0;
    return (rows.first.toColumnMap()['count'] as num?)?.toInt() ?? 0;
  }

  static Future<int> prune(
    Session session, {
    required DateTime cutoff,
    Transaction? transaction,
  }) async {
    final rows = await session.db.unsafeQuery(
      '''
WITH pruned AS (
  DELETE FROM "hayer_poi_catalog" AS catalog
  WHERE catalog."lastSeenAt" < @cutoff
    AND catalog."quarantinedAt" IS NULL
    AND NOT EXISTS (
      SELECT 1
      FROM "hayer_session_place" AS session_place
      WHERE session_place."placeId" = catalog."providerPlaceId"
    )
  RETURNING catalog."provider", catalog."providerPlaceId"
), refresh AS (
  -- Detail refresh metadata describes a catalog record and leaves with it.
  DELETE FROM "hayer_poi_detail_refresh" AS refresh
  USING pruned
  WHERE refresh."provider" = pruned."provider"
    AND refresh."providerPlaceId" = pruned."providerPlaceId"
)
SELECT "providerPlaceId" FROM pruned
''',
      parameters: QueryParameters.named({'cutoff': cutoff}),
      transaction: transaction,
    );
    await DiscoveryMetrics.recordRemovedPlaces(
      session,
      rows.length,
      transaction: transaction,
    );
    return rows.length;
  }
}
