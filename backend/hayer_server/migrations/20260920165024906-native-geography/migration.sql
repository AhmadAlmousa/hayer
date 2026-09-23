BEGIN;

--
-- CREATE POSTGIS EXTENSION IF AVAILABLE
--
DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM pg_available_extensions WHERE name = 'postgis') THEN
    EXECUTE 'CREATE EXTENSION IF NOT EXISTS postgis';
  ELSE
    RAISE EXCEPTION 'Required extension "postgis" is not available on this instance. Please install PostGIS. For instructions, see https://docs.serverpod.dev/upgrading/upgrade-to-postgis.';
  END IF;
END
$$;

--
-- Function: gen_random_uuid_v7()
-- Source: https://gist.github.com/kjmph/5bd772b2c2df145aa645b837da7eca74
-- License: MIT (copyright notice included on the generator source code).
--
create or replace function gen_random_uuid_v7()
returns uuid
as $$
begin
  -- use random v4 uuid as starting point (which has the same variant we need)
  -- then overlay timestamp
  -- then set version 7 by flipping the 2 and 1 bit in the version 4 string
  return encode(
    set_bit(
      set_bit(
        overlay(uuid_send(gen_random_uuid())
                placing substring(int8send(floor(extract(epoch from clock_timestamp()) * 1000)::bigint) from 3)
                from 1 for 6
        ),
        52, 1
      ),
      53, 1
    ),
    'hex')::uuid;
end
$$
language plpgsql
volatile;

-- The existing location columns are generated and already contain the correct
-- geography values. Serverpod 4 manages them as ordinary GeographyPoint
-- fields, so retain the data while removing only the generated expression.
ALTER TABLE "hayer_poi_catalog"
  ALTER COLUMN "location" DROP EXPRESSION;

ALTER TABLE "hayer_poi_coverage"
  ALTER COLUMN "location" DROP EXPRESSION;

UPDATE "hayer_poi_catalog"
SET "location" = ST_SetSRID(
  ST_MakePoint("longitude", "latitude"),
  4326
)::geography
WHERE "location" IS NULL;

UPDATE "hayer_poi_coverage"
SET "location" = ST_SetSRID(
  ST_MakePoint("anchorLongitude", "anchorLatitude"),
  4326
)::geography
WHERE "location" IS NULL;

ALTER TABLE "hayer_poi_catalog"
  ALTER COLUMN "location" SET NOT NULL;

ALTER TABLE "hayer_poi_coverage"
  ALTER COLUMN "location" SET NOT NULL;

CREATE OR REPLACE FUNCTION hayer_sync_poi_catalog_location()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
  NEW."location" := ST_SetSRID(
    ST_MakePoint(NEW."longitude", NEW."latitude"),
    4326
  )::geography;
  RETURN NEW;
END;
$$;

CREATE OR REPLACE FUNCTION hayer_sync_poi_coverage_location()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
  NEW."location" := ST_SetSRID(
    ST_MakePoint(NEW."anchorLongitude", NEW."anchorLatitude"),
    4326
  )::geography;
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS hayer_sync_poi_catalog_location
  ON "hayer_poi_catalog";
CREATE TRIGGER hayer_sync_poi_catalog_location
  BEFORE INSERT OR UPDATE OF "latitude", "longitude"
  ON "hayer_poi_catalog"
  FOR EACH ROW
  EXECUTE FUNCTION hayer_sync_poi_catalog_location();

DROP TRIGGER IF EXISTS hayer_sync_poi_coverage_location
  ON "hayer_poi_coverage";
CREATE TRIGGER hayer_sync_poi_coverage_location
  BEFORE INSERT OR UPDATE OF "anchorLatitude", "anchorLongitude"
  ON "hayer_poi_coverage"
  FOR EACH ROW
  EXECUTE FUNCTION hayer_sync_poi_coverage_location();


--
-- MIGRATION VERSION FOR hayer
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('hayer', '20260920165024906-native-geography', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260920165024906-native-geography', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260824182259319', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182259319', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260910193913364-string-rate-limit-keys', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260910193913364-string-rate-limit-keys', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260824182354731', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182354731', "timestamp" = now();


COMMIT;
