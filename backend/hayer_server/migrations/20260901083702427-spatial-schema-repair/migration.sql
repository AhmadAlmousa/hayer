BEGIN;

-- The original hardening SQL was added to an already-created migration and
-- was absent from the latest clean-database definition. Repair both upgraded
-- installations and databases initialized from that definition.
CREATE EXTENSION IF NOT EXISTS postgis;
CREATE EXTENSION IF NOT EXISTS pg_trgm;

ALTER TABLE "hayer_poi_catalog"
  ADD COLUMN IF NOT EXISTS "location" geography(Point, 4326)
  GENERATED ALWAYS AS (
    ST_SetSRID(ST_MakePoint("longitude", "latitude"), 4326)::geography
  ) STORED;
ALTER TABLE "hayer_poi_coverage"
  ADD COLUMN IF NOT EXISTS "location" geography(Point, 4326)
  GENERATED ALWAYS AS (
    ST_SetSRID(ST_MakePoint("anchorLongitude", "anchorLatitude"), 4326)::geography
  ) STORED;

CREATE INDEX IF NOT EXISTS "hayer_poi_location_gist"
  ON "hayer_poi_catalog" USING gist ("location")
  WHERE "quarantinedAt" IS NULL;
CREATE INDEX IF NOT EXISTS "hayer_coverage_location_gist"
  ON "hayer_poi_coverage" USING gist ("location")
  WHERE "invalidatedAt" IS NULL;
CREATE INDEX IF NOT EXISTS "hayer_poi_categories_gin"
  ON "hayer_poi_catalog" USING gin (("categoryIds"::jsonb));
CREATE INDEX IF NOT EXISTS "hayer_poi_name_trgm"
  ON "hayer_poi_catalog" USING gin ("normalizedName" gin_trgm_ops)
  WHERE "quarantinedAt" IS NULL;
CREATE INDEX IF NOT EXISTS "hayer_session_active_expiry"
  ON "hayer_session" ("expiresAt") WHERE "status" = 'active';
CREATE INDEX IF NOT EXISTS "hayer_refresh_pending_created"
  ON "hayer_refresh_job" ("createdAt") WHERE "status" = 'pending';

DO $hayer$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'hayer_participant_session_fk'
      AND conrelid = 'hayer_participant'::regclass
  ) THEN
    ALTER TABLE "hayer_participant"
      ADD CONSTRAINT "hayer_participant_session_fk"
      FOREIGN KEY ("sessionId") REFERENCES "hayer_session" ("sessionId")
      ON DELETE CASCADE;
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'hayer_session_place_session_fk'
      AND conrelid = 'hayer_session_place'::regclass
  ) THEN
    ALTER TABLE "hayer_session_place"
      ADD CONSTRAINT "hayer_session_place_session_fk"
      FOREIGN KEY ("sessionId") REFERENCES "hayer_session" ("sessionId")
      ON DELETE CASCADE;
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'hayer_swipe_session_fk'
      AND conrelid = 'hayer_swipe'::regclass
  ) THEN
    ALTER TABLE "hayer_swipe"
      ADD CONSTRAINT "hayer_swipe_session_fk"
      FOREIGN KEY ("sessionId") REFERENCES "hayer_session" ("sessionId")
      ON DELETE CASCADE;
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'hayer_poi_coordinates_valid'
      AND conrelid = 'hayer_poi_catalog'::regclass
  ) THEN
    ALTER TABLE "hayer_poi_catalog"
      ADD CONSTRAINT "hayer_poi_coordinates_valid"
      CHECK ("latitude" BETWEEN -90 AND 90 AND "longitude" BETWEEN -180 AND 180);
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'hayer_coverage_values_valid'
      AND conrelid = 'hayer_poi_coverage'::regclass
  ) THEN
    ALTER TABLE "hayer_poi_coverage"
      ADD CONSTRAINT "hayer_coverage_values_valid"
      CHECK (
        "anchorLatitude" BETWEEN -90 AND 90
        AND "anchorLongitude" BETWEEN -180 AND 180
        AND "radiusMeters" IN (500, 1000, 3000, 5000, 10000)
      );
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'hayer_session_values_valid'
      AND conrelid = 'hayer_session'::regclass
  ) THEN
    ALTER TABLE "hayer_session"
      ADD CONSTRAINT "hayer_session_values_valid"
      CHECK (
        "code" ~ '^[ABCDEFGHJKLMNPQRSTUVWXYZ23456789]{6}$'
        AND "anchorLatitude" BETWEEN -90 AND 90
        AND "anchorLongitude" BETWEEN -180 AND 180
        AND "radiusMeters" IN (500, 1000, 3000, 5000, 10000)
        AND "deckSizeRequested" IN (10, 20, 30, 40, 50)
        AND "deckSizeActual" BETWEEN 0 AND "deckSizeRequested"
        AND ("priceLevel" IS NULL OR "priceLevel" BETWEEN 1 AND 4)
      );
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'hayer_participant_progress_valid'
      AND conrelid = 'hayer_participant'::regclass
  ) THEN
    ALTER TABLE "hayer_participant"
      ADD CONSTRAINT "hayer_participant_progress_valid"
      CHECK ("currentIndex" >= 0 AND length(trim("displayName")) BETWEEN 1 AND 40);
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'hayer_swipe_index_valid'
      AND conrelid = 'hayer_swipe'::regclass
  ) THEN
    ALTER TABLE "hayer_swipe"
      ADD CONSTRAINT "hayer_swipe_index_valid" CHECK ("swipeIndex" >= 0);
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'hayer_cache_policy_valid'
      AND conrelid = 'hayer_cache_settings'::regclass
  ) THEN
    ALTER TABLE "hayer_cache_settings"
      ADD CONSTRAINT "hayer_cache_policy_valid"
      CHECK (
        "freshHours" BETWEEN 1 AND 720
        AND "staleFallbackDays" BETWEEN 1 AND 180
        AND "retentionDays" BETWEEN 30 AND 730
        AND "freshHours" <= "staleFallbackDays" * 24
        AND "staleFallbackDays" <= "retentionDays"
        AND "extractorAttempts" BETWEEN 1 AND 3
        AND "perCreationConcurrency" BETWEEN 1 AND 5
        AND "globalRequestsPerMinute" BETWEEN 1 AND 300
        AND "globalBurst" BETWEEN 1 AND 30
      );
  END IF;
END
$hayer$;

--
-- MIGRATION VERSION FOR hayer
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('hayer', '20260901083702427-spatial-schema-repair', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260901083702427-spatial-schema-repair', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260129180959368', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129180959368', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260213194423028', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260213194423028', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260129181112269', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129181112269', "timestamp" = now();

COMMIT;
