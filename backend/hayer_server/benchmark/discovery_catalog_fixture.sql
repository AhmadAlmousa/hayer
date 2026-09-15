-- Deterministic synthetic catalog for Discover query plans and migration
-- timing. It writes only columns that predate M9-C, so the same rows load into
-- the M9-B schema (upgrade timing) and the current schema (query plans).
--
-- Replace :rows with the row count, and run `SELECT setseed(0.42)` earlier in
-- the same session so every run produces identical rows.
--
-- Shape: 60% in a Riyadh city box, 20% in a Jeddah box and 20% spread across
-- Saudi Arabia; 12% unrated; heavy-tailed review counts; 45% unknown price;
-- 5% unknown type plus a few types the benchmark tree leaves unmapped; 70%
-- with weekly hours (day, overnight and 24-hour shapes); 10% stale; 2% closed;
-- 0.5% quarantined.
WITH draws AS MATERIALIZED (
  SELECT
    n,
    CASE
      WHEN n % 10 < 6 THEN 'riyadh'
      WHEN n % 10 < 8 THEN 'jeddah'
      ELSE 'country'
    END AS zone,
    random() AS r_lat,
    random() AS r_lon,
    random() AS r_rating,
    random() AS r_reviews,
    random() AS r_price,
    random() AS r_type,
    random() AS r_hours,
    random() AS r_stale,
    random() AS r_status,
    random() AS r_first,
    random() AS r_detail
  FROM generate_series(1, :rows) AS n
),
shaped AS MATERIALIZED (
  SELECT
    n,
    'bench-' || lpad(n::text, 7, '0') AS place_id,
    CASE zone
      WHEN 'riyadh' THEN 24.55 + r_lat * 0.40
      WHEN 'jeddah' THEN 21.40 + r_lat * 0.35
      ELSE 17.5 + r_lat * 11.5
    END AS latitude,
    CASE zone
      WHEN 'riyadh' THEN 46.50 + r_lon * 0.45
      WHEN 'jeddah' THEN 39.10 + r_lon * 0.20
      ELSE 38.0 + r_lon * 12.0
    END AS longitude,
    CASE WHEN r_rating < 0.12 THEN NULL
      ELSE round((2.8 + r_rating * 2.2)::numeric, 1)
    END AS rating,
    CASE WHEN r_rating < 0.12 THEN NULL
      ELSE floor(exp(r_reviews * r_reviews * 11.5))::bigint
    END AS reviews,
    CASE WHEN r_price < 0.45 THEN NULL
      ELSE 1 + floor((r_price - 0.45) / 0.55 * 4)::int
    END AS price_level,
    CASE WHEN r_type < 0.05 THEN NULL
      ELSE (ARRAY[
        'Coffee shop', 'Cafe', 'مقهى', 'Espresso bar', 'Tea house',
        'Bakery', 'Dessert shop', 'Restaurant', 'Fast food restaurant',
        'Pizza restaurant', 'Burger restaurant', 'Japanese restaurant',
        'Sushi restaurant', 'Indian restaurant', 'Lebanese restaurant',
        'Middle Eastern restaurant', 'مطعم', 'Steak house',
        'Seafood restaurant', 'Breakfast restaurant', 'Juice shop',
        'Ice cream shop', 'Park', 'City park', 'حديقة', 'Museum',
        'Art gallery', 'Shopping mall', 'Supermarket', 'Clothing store',
        'Electronics store', 'Gym', 'Spa', 'Hotel', 'Mosque', 'مسجد',
        'Tourist attraction', 'Amusement park', 'Bowling alley', 'Car wash'
      ])[1 + floor((r_type - 0.05) / 0.95 * 40)::int]
    END AS primary_type,
    r_hours,
    r_status,
    r_detail,
    (now() AT TIME ZONE 'UTC') - CASE
      WHEN r_stale < 0.10 THEN interval '100 hours'
      ELSE r_stale * interval '48 hours'
    END AS checked_at,
    (now() AT TIME ZONE 'UTC') - r_first * interval '365 days' AS first_seen_at
  FROM draws
)
INSERT INTO "hayer_poi_catalog" (
  "provider", "providerPlaceId", "featureId", "normalizedName", "name",
  "countryCode", "latitude", "longitude", "categoryIds", "snapshot",
  "calibrationVersion", "sourceCheckedAt", "firstSeenAt", "lastSeenAt",
  "quarantinedAt", "quarantineReason"
)
SELECT
  'google-web',
  place_id,
  NULL,
  lower(COALESCE(primary_type, 'Place') || ' ' || n),
  COALESCE(primary_type, 'Place') || ' ' || n,
  'SA',
  latitude,
  longitude,
  '[]'::json,
  jsonb_strip_nulls(jsonb_build_object(
    'placeId', place_id,
    'name', COALESCE(primary_type, 'Place') || ' ' || n,
    'primaryType', primary_type,
    'categoryIds', '[]'::jsonb,
    'rating', rating,
    'reviewCount', reviews,
    'priceLevel', price_level,
    'priceText', CASE WHEN price_level IS NOT NULL THEN repeat('$', price_level) END,
    'statusText', CASE
      WHEN r_status < 0.01 THEN 'Permanently closed'
      WHEN r_status < 0.02 THEN 'Temporarily closed'
    END,
    'hours', CASE
      WHEN r_hours < 0.55 THEN (
        SELECT jsonb_agg(jsonb_build_object(
          'day', day, 'openMinutes', 480, 'closeMinutes', 1380,
          'overnight', false) ORDER BY day)
        FROM generate_series(1, 7) AS day
      )
      WHEN r_hours < 0.65 THEN (
        SELECT jsonb_agg(jsonb_build_object(
          'day', day, 'openMinutes', 1020, 'closeMinutes', 180,
          'overnight', true) ORDER BY day)
        FROM generate_series(1, 7) AS day
      )
      WHEN r_hours < 0.70 THEN (
        SELECT jsonb_agg(jsonb_build_object(
          'day', day, 'openMinutes', 0, 'closeMinutes', 1440,
          'overnight', false) ORDER BY day)
        FROM generate_series(1, 7) AS day
      )
      ELSE '[]'::jsonb
    END,
    'distanceMeters', 0,
    'latitude', latitude,
    'longitude', longitude,
    'phoneNumber', CASE WHEN r_detail < 0.6 THEN '+966500000000' END,
    'websiteUrl', CASE WHEN r_detail < 0.4 THEN 'https://example.com/' || place_id END,
    'photoUrls', CASE
      WHEN r_detail < 0.8
      THEN jsonb_build_array('https://example.com/' || place_id || '.jpg')
      ELSE '[]'::jsonb
    END,
    'editorialSummary', CASE
      WHEN r_detail > 0.7 THEN 'Popular for coffee, desserts and a quiet terrace.'
    END,
    'attributions', jsonb_build_array('Benchmark'),
    'sourceCheckedAt', to_char(checked_at, 'YYYY-MM-DD"T"HH24:MI:SS.US"Z"'),
    'isStale', false
  ))::json,
  'benchmark',
  checked_at,
  first_seen_at,
  checked_at,
  CASE WHEN n % 200 = 0 THEN now() AT TIME ZONE 'UTC' END,
  CASE WHEN n % 200 = 0 THEN 'benchmark' END
FROM shaped;
