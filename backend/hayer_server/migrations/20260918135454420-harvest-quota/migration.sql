BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "hayer_cache_settings" ALTER COLUMN "discoveryUserHarvestsPerHour" SET DEFAULT 12;

--
-- ACTION CUSTOM
--
-- A new default does not reach the row that already exists, and there is only
-- ever one. Raise it for an operator who never changed it; leave a deliberate
-- setting alone.
UPDATE "hayer_cache_settings"
  SET "discoveryUserHarvestsPerHour" = 12
  WHERE "settingsKey" = 'default' AND "discoveryUserHarvestsPerHour" = 3;

--
-- MIGRATION VERSION FOR hayer
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('hayer', '20260918135454420-harvest-quota', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260918135454420-harvest-quota', "timestamp" = now();

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
