import 'package:serverpod/serverpod.dart';

const nearbyCatalogByLocationSql = '''
SELECT "providerPlaceId"
FROM "hayer_poi_catalog"
WHERE "countryCode" = @country
  AND "quarantinedAt" IS NULL
  AND "sourceCheckedAt" >= @seenAfter
  AND ST_DWithin(
    "location",
    ST_SetSRID(ST_MakePoint(@longitude, @latitude), 4326)::geography,
    @radius
  )
LIMIT 500
''';

const nearbyCatalogByCoordinatesSql = '''
SELECT "providerPlaceId"
FROM "hayer_poi_catalog"
WHERE "countryCode" = @country
  AND "quarantinedAt" IS NULL
  AND "sourceCheckedAt" >= @seenAfter
  AND ST_DWithin(
    ST_SetSRID(ST_MakePoint("longitude", "latitude"), 4326)::geography,
    ST_SetSRID(ST_MakePoint(@longitude, @latitude), 4326)::geography,
    @radius
  )
LIMIT 500
''';

bool isMissingCatalogLocation(DatabaseQueryException error) =>
    error.code == '42703' &&
    (error.columnName == 'location' || error.message.contains('"location"'));
