BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "hayer_session" ADD COLUMN "visitAt" timestamp without time zone;

-- New sessions use three-character codes while existing six-character links
-- remain valid during the transition.
ALTER TABLE "hayer_session"
  DROP CONSTRAINT IF EXISTS "hayer_session_values_valid";
ALTER TABLE "hayer_session"
  ADD CONSTRAINT "hayer_session_values_valid"
  CHECK (
    "code" ~ '^[ABCDEFGHJKLMNPQRSTUVWXYZ23456789]{3}([ABCDEFGHJKLMNPQRSTUVWXYZ23456789]{3})?$'
    AND "anchorLatitude" BETWEEN -90 AND 90
    AND "anchorLongitude" BETWEEN -180 AND 180
    AND "radiusMeters" IN (500, 1000, 3000, 5000, 10000)
    AND "deckSizeRequested" IN (10, 20, 30, 40, 50)
    AND "deckSizeActual" BETWEEN 0 AND "deckSizeRequested"
    AND ("priceLevel" IS NULL OR "priceLevel" BETWEEN 1 AND 4)
  );

--
-- MIGRATION VERSION FOR hayer
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('hayer', '20260902143335499-visit-scheduling', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260902143335499-visit-scheduling', "timestamp" = now();

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
