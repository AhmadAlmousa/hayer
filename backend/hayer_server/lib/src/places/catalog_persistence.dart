const catalogEvidenceVersion = 'hayer-v2';

String catalogEvidencePrefix(String calibrationVersion) =>
    '$catalogEvidenceVersion:$calibrationVersion:';

const catalogBatchUpsertSql = '''
WITH input AS (
  SELECT *
  FROM json_to_recordset(CAST(@places AS json)) AS place(
    "providerPlaceId" text,
    "featureId" text,
    "normalizedName" text,
    "name" text,
    "countryCode" text,
    "latitude" double precision,
    "longitude" double precision,
    "categoryIds" json,
    "snapshot" json,
    "calibrationVersion" text,
    "sourceCheckedAt" timestamp without time zone,
    "seenAt" timestamp without time zone
  )
)
INSERT INTO "hayer_poi_catalog" AS catalog (
  "provider",
  "providerPlaceId",
  "featureId",
  "normalizedName",
  "name",
  "countryCode",
  "latitude",
  "longitude",
  "categoryIds",
  "snapshot",
  "calibrationVersion",
  "sourceCheckedAt",
  "firstSeenAt",
  "lastSeenAt"
)
SELECT
  'google-web',
  input."providerPlaceId",
  input."featureId",
  input."normalizedName",
  input."name",
  input."countryCode",
  input."latitude",
  input."longitude",
  input."categoryIds",
  input."snapshot",
  input."calibrationVersion",
  input."sourceCheckedAt",
  input."seenAt",
  input."seenAt"
FROM input
ORDER BY input."providerPlaceId"
ON CONFLICT ("provider", "providerPlaceId") DO UPDATE SET
  "featureId" = CASE
    WHEN EXCLUDED."sourceCheckedAt" >= catalog."sourceCheckedAt"
      THEN EXCLUDED."featureId"
    ELSE catalog."featureId"
  END,
  "normalizedName" = CASE
    WHEN EXCLUDED."sourceCheckedAt" >= catalog."sourceCheckedAt"
      THEN EXCLUDED."normalizedName"
    ELSE catalog."normalizedName"
  END,
  "name" = CASE
    WHEN EXCLUDED."sourceCheckedAt" >= catalog."sourceCheckedAt"
      THEN EXCLUDED."name"
    ELSE catalog."name"
  END,
  "countryCode" = CASE
    WHEN EXCLUDED."sourceCheckedAt" >= catalog."sourceCheckedAt"
      THEN EXCLUDED."countryCode"
    ELSE catalog."countryCode"
  END,
  "latitude" = CASE
    WHEN EXCLUDED."sourceCheckedAt" >= catalog."sourceCheckedAt"
      THEN EXCLUDED."latitude"
    ELSE catalog."latitude"
  END,
  "longitude" = CASE
    WHEN EXCLUDED."sourceCheckedAt" >= catalog."sourceCheckedAt"
      THEN EXCLUDED."longitude"
    ELSE catalog."longitude"
  END,
  "snapshot" = CASE
    WHEN EXCLUDED."sourceCheckedAt" >= catalog."sourceCheckedAt"
      THEN jsonb_set(
        EXCLUDED."snapshot"::jsonb,
        '{categoryIds}',
        catalog."categoryIds"::jsonb,
        true
      )::json
    ELSE catalog."snapshot"
  END,
  "calibrationVersion" = CASE
    WHEN EXCLUDED."sourceCheckedAt" >= catalog."sourceCheckedAt"
      THEN EXCLUDED."calibrationVersion"
    ELSE catalog."calibrationVersion"
  END,
  "sourceCheckedAt" = GREATEST(
    catalog."sourceCheckedAt",
    EXCLUDED."sourceCheckedAt"
  ),
  "lastSeenAt" = GREATEST(catalog."lastSeenAt", EXCLUDED."lastSeenAt")
''';

const catalogEvidenceBatchUpsertSql = '''
WITH input AS (
  SELECT *
  FROM json_to_recordset(CAST(@evidence AS json)) AS evidence(
    "providerPlaceId" text,
    "categoryId" text,
    "evidenceQuery" text,
    "seenAt" timestamp without time zone
  )
),
upserted AS (
  INSERT INTO "hayer_poi_category" AS evidence (
    "provider",
    "providerPlaceId",
    "categoryId",
    "evidenceQuery",
    "firstSeenAt",
    "lastSeenAt"
  )
  SELECT
    'google-web',
    input."providerPlaceId",
    input."categoryId",
    input."evidenceQuery",
    input."seenAt",
    input."seenAt"
  FROM input
  ORDER BY input."providerPlaceId", input."categoryId"
  ON CONFLICT ("provider", "providerPlaceId", "categoryId") DO UPDATE SET
    "evidenceQuery" = CASE
      WHEN EXCLUDED."lastSeenAt" >= evidence."lastSeenAt"
        THEN EXCLUDED."evidenceQuery"
      ELSE evidence."evidenceQuery"
    END,
    "lastSeenAt" = GREATEST(evidence."lastSeenAt", EXCLUDED."lastSeenAt")
  RETURNING "providerPlaceId"
),
affected AS (
  SELECT DISTINCT "providerPlaceId"
  FROM upserted
),
category_sets AS (
  SELECT
    affected."providerPlaceId",
    json_agg(categories."categoryId" ORDER BY categories."categoryId") AS ids
  FROM affected
  CROSS JOIN LATERAL (
    SELECT current."categoryId"
    FROM "hayer_poi_category" AS current
    WHERE current."provider" = 'google-web'
      AND current."providerPlaceId" = affected."providerPlaceId"
      AND left(current."evidenceQuery", length(@evidencePrefix)) =
          @evidencePrefix
    UNION
    SELECT input."categoryId"
    FROM input
    WHERE input."providerPlaceId" = affected."providerPlaceId"
  ) AS categories
  GROUP BY affected."providerPlaceId"
)
UPDATE "hayer_poi_catalog" AS catalog
SET
  "categoryIds" = category_sets.ids,
  "snapshot" = jsonb_set(
    catalog."snapshot"::jsonb,
    '{categoryIds}',
    category_sets.ids::jsonb,
    true
  )::json
FROM category_sets
WHERE catalog."provider" = 'google-web'
  AND catalog."providerPlaceId" = category_sets."providerPlaceId"
''';

const catalogCoverageUpsertSql = '''
INSERT INTO "hayer_poi_coverage" AS coverage (
  "coverageKey",
  "queryKey",
  "language",
  "countryCode",
  "anchorLatitude",
  "anchorLongitude",
  "radiusMeters",
  "calibrationVersion",
  "resultCount",
  "refreshedAt",
  "expiresAt",
  "lastFailureCode",
  "invalidatedAt"
)
VALUES (
  @coverageKey,
  @queryKey,
  'en',
  @countryCode,
  @latitude,
  @longitude,
  @radiusMeters,
  @calibrationVersion,
  @resultCount,
  @refreshedAt,
  @expiresAt,
  @lastFailureCode,
  @invalidatedAt
)
ON CONFLICT ("coverageKey") DO UPDATE SET
  "queryKey" = EXCLUDED."queryKey",
  "language" = EXCLUDED."language",
  "countryCode" = EXCLUDED."countryCode",
  "anchorLatitude" = EXCLUDED."anchorLatitude",
  "anchorLongitude" = EXCLUDED."anchorLongitude",
  "radiusMeters" = EXCLUDED."radiusMeters",
  "calibrationVersion" = EXCLUDED."calibrationVersion",
  "resultCount" = EXCLUDED."resultCount",
  "refreshedAt" = EXCLUDED."refreshedAt",
  "expiresAt" = EXCLUDED."expiresAt",
  "lastFailureCode" = EXCLUDED."lastFailureCode",
  "invalidatedAt" = EXCLUDED."invalidatedAt"
WHERE EXCLUDED."refreshedAt" >= coverage."refreshedAt"
''';
