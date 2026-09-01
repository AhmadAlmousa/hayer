BEGIN;

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

--
-- ACTION CREATE TABLE
--
CREATE TABLE "hayer_admin_audit" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "auditId" text NOT NULL,
    "operatorName" text NOT NULL,
    "ipHash" text NOT NULL,
    "action" text NOT NULL,
    "targetType" text NOT NULL,
    "targetId" text,
    "reason" text NOT NULL,
    "beforeData" json,
    "afterData" json,
    "occurredAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "hayer_admin_audit_id" ON "hayer_admin_audit" USING btree ("auditId");
CREATE INDEX "hayer_admin_audit_time" ON "hayer_admin_audit" USING btree ("occurredAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "hayer_cache_settings" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "settingsKey" text NOT NULL,
    "version" bigint NOT NULL,
    "freshHours" bigint NOT NULL,
    "staleFallbackDays" bigint NOT NULL,
    "retentionDays" bigint NOT NULL,
    "extractorAttempts" bigint NOT NULL,
    "perCreationConcurrency" bigint NOT NULL,
    "globalRequestsPerMinute" bigint NOT NULL,
    "globalBurst" bigint NOT NULL,
    "updatedBy" text NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "hayer_cache_settings_key" ON "hayer_cache_settings" USING btree ("settingsKey");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "hayer_calibration" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "version" text NOT NULL,
    "status" text NOT NULL,
    "document" json NOT NULL,
    "fixturePassed" boolean NOT NULL,
    "liveCanaryPassed" boolean NOT NULL,
    "validationErrors" json NOT NULL,
    "createdBy" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "validatedAt" timestamp without time zone,
    "activatedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "hayer_calibration_version" ON "hayer_calibration" USING btree ("version");
CREATE INDEX "hayer_calibration_status" ON "hayer_calibration" USING btree ("status");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "hayer_idempotency" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "scope" text NOT NULL,
    "userId" text NOT NULL,
    "idempotencyKey" text NOT NULL,
    "requestHash" text NOT NULL,
    "responseId" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "expiresAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "hayer_idempotency_unique" ON "hayer_idempotency" USING btree ("scope", "userId", "idempotencyKey");
CREATE INDEX "hayer_idempotency_expiry" ON "hayer_idempotency" USING btree ("expiresAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "hayer_participant" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "participantId" text NOT NULL,
    "sessionId" text NOT NULL,
    "userId" text NOT NULL,
    "displayName" text NOT NULL,
    "normalizedName" text NOT NULL,
    "isHost" boolean NOT NULL,
    "currentIndex" bigint NOT NULL,
    "hasCompleted" boolean NOT NULL,
    "lastSeenAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "hayer_participant_id" ON "hayer_participant" USING btree ("participantId");
CREATE UNIQUE INDEX "hayer_participant_session_user" ON "hayer_participant" USING btree ("sessionId", "userId");
CREATE UNIQUE INDEX "hayer_participant_session_name" ON "hayer_participant" USING btree ("sessionId", "normalizedName");
CREATE INDEX "hayer_participant_session" ON "hayer_participant" USING btree ("sessionId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "hayer_poi_catalog" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "provider" text NOT NULL,
    "providerPlaceId" text NOT NULL,
    "featureId" text,
    "normalizedName" text NOT NULL,
    "name" text NOT NULL,
    "countryCode" text NOT NULL,
    "latitude" double precision NOT NULL,
    "longitude" double precision NOT NULL,
    "categoryIds" json NOT NULL,
    "snapshot" json NOT NULL,
    "calibrationVersion" text NOT NULL,
    "sourceCheckedAt" timestamp without time zone NOT NULL,
    "firstSeenAt" timestamp without time zone NOT NULL,
    "lastSeenAt" timestamp without time zone NOT NULL,
    "quarantinedAt" timestamp without time zone,
    "quarantineReason" text
);

-- Indexes
CREATE UNIQUE INDEX "hayer_poi_provider_identity" ON "hayer_poi_catalog" USING btree ("provider", "providerPlaceId");
CREATE INDEX "hayer_poi_feature_id" ON "hayer_poi_catalog" USING btree ("featureId");
CREATE INDEX "hayer_poi_country_last_seen" ON "hayer_poi_catalog" USING btree ("countryCode", "lastSeenAt");
CREATE INDEX "hayer_poi_quarantine" ON "hayer_poi_catalog" USING btree ("quarantinedAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "hayer_poi_coverage" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "coverageKey" text NOT NULL,
    "queryKey" text NOT NULL,
    "language" text NOT NULL,
    "countryCode" text NOT NULL,
    "anchorLatitude" double precision NOT NULL,
    "anchorLongitude" double precision NOT NULL,
    "radiusMeters" bigint NOT NULL,
    "calibrationVersion" text NOT NULL,
    "resultCount" bigint NOT NULL,
    "refreshedAt" timestamp without time zone NOT NULL,
    "expiresAt" timestamp without time zone NOT NULL,
    "lastFailureCode" text,
    "invalidatedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "hayer_coverage_key" ON "hayer_poi_coverage" USING btree ("coverageKey");
CREATE INDEX "hayer_coverage_query_expiry" ON "hayer_poi_coverage" USING btree ("countryCode", "queryKey", "language", "expiresAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "hayer_rate_limit" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "counterKey" text NOT NULL,
    "attemptCount" bigint NOT NULL,
    "windowStartedAt" timestamp without time zone NOT NULL,
    "expiresAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "hayer_rate_limit_key" ON "hayer_rate_limit" USING btree ("counterKey");
CREATE INDEX "hayer_rate_limit_expiry" ON "hayer_rate_limit" USING btree ("expiresAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "hayer_refresh_job" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "jobId" text NOT NULL,
    "coverageKey" text NOT NULL,
    "status" text NOT NULL,
    "requestedBy" text NOT NULL,
    "reason" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "startedAt" timestamp without time zone,
    "completedAt" timestamp without time zone,
    "errorCode" text
);

-- Indexes
CREATE UNIQUE INDEX "hayer_refresh_job_id" ON "hayer_refresh_job" USING btree ("jobId");
CREATE INDEX "hayer_refresh_job_coverage_status" ON "hayer_refresh_job" USING btree ("coverageKey", "status");
CREATE INDEX "hayer_refresh_job_created" ON "hayer_refresh_job" USING btree ("createdAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "hayer_session" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "sessionId" text NOT NULL,
    "code" text NOT NULL,
    "hostUserId" text NOT NULL,
    "mode" text NOT NULL,
    "categoryId" text NOT NULL,
    "subcategoryIds" json NOT NULL,
    "priceLevel" bigint,
    "anchorLatitude" double precision NOT NULL,
    "anchorLongitude" double precision NOT NULL,
    "anchorAddress" text,
    "countryCode" text NOT NULL,
    "radiusMeters" bigint NOT NULL,
    "deckSizeRequested" bigint NOT NULL,
    "deckSizeActual" bigint NOT NULL,
    "consensusRule" text NOT NULL,
    "matchingTiming" text NOT NULL,
    "status" text NOT NULL,
    "matchedPlaceId" text,
    "revision" bigint NOT NULL,
    "freshnessWarning" text,
    "createdAt" timestamp without time zone NOT NULL,
    "expiresAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "hayer_session_session_id" ON "hayer_session" USING btree ("sessionId");
CREATE UNIQUE INDEX "hayer_session_code" ON "hayer_session" USING btree ("code");
CREATE INDEX "hayer_session_status_expires" ON "hayer_session" USING btree ("status", "expiresAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "hayer_session_place" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "sessionId" text NOT NULL,
    "placeId" text NOT NULL,
    "deckOrder" bigint NOT NULL,
    "snapshot" json NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "hayer_session_place_order" ON "hayer_session_place" USING btree ("sessionId", "deckOrder");
CREATE UNIQUE INDEX "hayer_session_place_identity" ON "hayer_session_place" USING btree ("sessionId", "placeId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "hayer_swipe" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "sessionId" text NOT NULL,
    "userId" text NOT NULL,
    "placeId" text NOT NULL,
    "liked" boolean NOT NULL,
    "swipeIndex" bigint NOT NULL,
    "clientSwipedAt" timestamp without time zone NOT NULL,
    "serverReceivedAt" timestamp without time zone NOT NULL,
    "idempotencyKey" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "hayer_swipe_identity" ON "hayer_swipe" USING btree ("sessionId", "userId", "placeId");
CREATE UNIQUE INDEX "hayer_swipe_idempotency" ON "hayer_swipe" USING btree ("userId", "idempotencyKey");
CREATE INDEX "hayer_swipe_session_place" ON "hayer_swipe" USING btree ("sessionId", "placeId");

-- Hayer spatial/catalog hardening. Serverpod models keep portable latitude and
-- longitude columns; PostGIS adds generated geography values for indexed
-- radius queries without duplicating application writes.
CREATE EXTENSION IF NOT EXISTS postgis;
CREATE EXTENSION IF NOT EXISTS pg_trgm;

ALTER TABLE "hayer_poi_catalog"
  ADD COLUMN "location" geography(Point, 4326)
  GENERATED ALWAYS AS (
    ST_SetSRID(ST_MakePoint("longitude", "latitude"), 4326)::geography
  ) STORED;
ALTER TABLE "hayer_poi_coverage"
  ADD COLUMN "location" geography(Point, 4326)
  GENERATED ALWAYS AS (
    ST_SetSRID(ST_MakePoint("anchorLongitude", "anchorLatitude"), 4326)::geography
  ) STORED;

CREATE INDEX "hayer_poi_location_gist"
  ON "hayer_poi_catalog" USING gist ("location")
  WHERE "quarantinedAt" IS NULL;
CREATE INDEX "hayer_coverage_location_gist"
  ON "hayer_poi_coverage" USING gist ("location")
  WHERE "invalidatedAt" IS NULL;
CREATE INDEX "hayer_poi_categories_gin"
  ON "hayer_poi_catalog" USING gin (("categoryIds"::jsonb));
CREATE INDEX "hayer_poi_name_trgm"
  ON "hayer_poi_catalog" USING gin ("normalizedName" gin_trgm_ops)
  WHERE "quarantinedAt" IS NULL;
CREATE INDEX "hayer_session_active_expiry"
  ON "hayer_session" ("expiresAt") WHERE "status" = 'active';
CREATE INDEX "hayer_refresh_pending_created"
  ON "hayer_refresh_job" ("createdAt") WHERE "status" = 'pending';

ALTER TABLE "hayer_participant"
  ADD CONSTRAINT "hayer_participant_session_fk"
  FOREIGN KEY ("sessionId") REFERENCES "hayer_session" ("sessionId")
  ON DELETE CASCADE;
ALTER TABLE "hayer_session_place"
  ADD CONSTRAINT "hayer_session_place_session_fk"
  FOREIGN KEY ("sessionId") REFERENCES "hayer_session" ("sessionId")
  ON DELETE CASCADE;
ALTER TABLE "hayer_swipe"
  ADD CONSTRAINT "hayer_swipe_session_fk"
  FOREIGN KEY ("sessionId") REFERENCES "hayer_session" ("sessionId")
  ON DELETE CASCADE;

ALTER TABLE "hayer_poi_catalog"
  ADD CONSTRAINT "hayer_poi_coordinates_valid"
  CHECK ("latitude" BETWEEN -90 AND 90 AND "longitude" BETWEEN -180 AND 180);
ALTER TABLE "hayer_poi_coverage"
  ADD CONSTRAINT "hayer_coverage_values_valid"
  CHECK (
    "anchorLatitude" BETWEEN -90 AND 90
    AND "anchorLongitude" BETWEEN -180 AND 180
    AND "radiusMeters" IN (500, 1000, 3000, 5000, 10000)
  );
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
ALTER TABLE "hayer_participant"
  ADD CONSTRAINT "hayer_participant_progress_valid"
  CHECK ("currentIndex" >= 0 AND length(trim("displayName")) BETWEEN 1 AND 40);
ALTER TABLE "hayer_swipe"
  ADD CONSTRAINT "hayer_swipe_index_valid" CHECK ("swipeIndex" >= 0);
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


--
-- MIGRATION VERSION FOR hayer
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('hayer', '20260831122748914-hayer-core', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260831122748914-hayer-core', "timestamp" = now();

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
