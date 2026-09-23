const nearbyCatalogByLocationSql = '''
WITH eligible AS (
  SELECT
    catalog."providerPlaceId",
    COALESCE(
      NULLIF(catalog."snapshot"->>'reviewCount', '')::bigint,
      -1
    ) AS review_count,
    COALESCE(
      NULLIF(catalog."snapshot"->>'rating', '')::double precision,
      -1
    ) AS rating,
    ST_Distance(
      catalog."location",
      ST_SetSRID(ST_MakePoint(@longitude, @latitude), 4326)::geography
    ) AS distance_meters
  FROM "hayer_poi_catalog" AS catalog
  WHERE catalog."provider" = 'google-web'
    AND catalog."countryCode" = @country
    AND catalog."quarantinedAt" IS NULL
    AND catalog."sourceCheckedAt" >= @seenAfter
    AND ST_DWithin(
      catalog."location",
      ST_SetSRID(ST_MakePoint(@longitude, @latitude), 4326)::geography,
      @radius
    )
    AND (
      @maximumPriceLevel < 0
      OR NULLIF(catalog."snapshot"->>'priceLevel', '') IS NULL
      OR NULLIF(catalog."snapshot"->>'priceLevel', '')::bigint <=
          @maximumPriceLevel
    )
    AND lower(COALESCE(catalog."snapshot"->>'statusText', '')) NOT LIKE
        '%temporarily closed%'
    AND lower(COALESCE(catalog."snapshot"->>'statusText', '')) NOT LIKE
        '%permanently closed%'
    AND EXISTS (
      SELECT 1
      FROM "hayer_poi_category" AS evidence
      WHERE evidence."provider" = catalog."provider"
        AND evidence."providerPlaceId" = catalog."providerPlaceId"
        AND evidence."categoryId" IN (
          SELECT json_array_elements_text(CAST(@categoryIds AS json))
        )
        AND evidence."lastSeenAt" >= @seenAfter
        AND left(evidence."evidenceQuery", length(@evidencePrefix)) =
            @evidencePrefix
    )
)
SELECT "providerPlaceId"
FROM eligible
ORDER BY
  review_count DESC,
  rating DESC,
  distance_meters,
  "providerPlaceId"
LIMIT 500
''';
