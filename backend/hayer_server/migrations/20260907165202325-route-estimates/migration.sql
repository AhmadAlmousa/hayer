BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "hayer_cache_settings" ADD COLUMN "routeEstimatesEnabled" boolean NOT NULL DEFAULT true;
ALTER TABLE "hayer_cache_settings" ADD COLUMN "allowParticipantLocation" boolean NOT NULL DEFAULT true;
ALTER TABLE "hayer_cache_settings" ADD COLUMN "defaultRouteOrigin" text NOT NULL DEFAULT 'sessionAnchor'::text;
ALTER TABLE "hayer_cache_settings" ADD COLUMN "routeEstimateCacheMinutes" bigint NOT NULL DEFAULT 10;
ALTER TABLE "hayer_cache_settings" ADD COLUMN "routeRequestsPerMinute" bigint NOT NULL DEFAULT 30;
ALTER TABLE "hayer_cache_settings" ADD COLUMN "routeBurst" bigint NOT NULL DEFAULT 6;

ALTER TABLE "hayer_cache_settings"
  DROP CONSTRAINT IF EXISTS "hayer_cache_policy_valid";
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
    AND "routeEstimateCacheMinutes" BETWEEN 1 AND 120
    AND "routeRequestsPerMinute" BETWEEN 1 AND 300
    AND "routeBurst" BETWEEN 1 AND 30
    AND "defaultRouteOrigin" IN ('sessionAnchor', 'participantLocation')
    AND ("allowParticipantLocation" OR "defaultRouteOrigin" = 'sessionAnchor')
  );

--
-- MIGRATION VERSION FOR hayer
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('hayer', '20260907165202325-route-estimates', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260907165202325-route-estimates', "timestamp" = now();

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
