import 'package:serverpod/serverpod.dart';

/// Removes catalog records that are outside retention and are not referenced
/// by an immutable session snapshot.
abstract final class CatalogPruner {
  static Future<int> eligibleCount(
    Session session, {
    required DateTime cutoff,
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
    );
    if (rows.isEmpty) return 0;
    return (rows.first.toColumnMap()['count'] as num?)?.toInt() ?? 0;
  }

  static Future<int> prune(
    Session session, {
    required DateTime cutoff,
  }) async {
    final rows = await session.db.unsafeQuery(
      '''
DELETE FROM "hayer_poi_catalog" AS catalog
WHERE catalog."lastSeenAt" < @cutoff
  AND catalog."quarantinedAt" IS NULL
  AND NOT EXISTS (
    SELECT 1
    FROM "hayer_session_place" AS session_place
    WHERE session_place."placeId" = catalog."providerPlaceId"
  )
RETURNING "providerPlaceId"
''',
      parameters: QueryParameters.named({'cutoff': cutoff}),
    );
    return rows.length;
  }
}
