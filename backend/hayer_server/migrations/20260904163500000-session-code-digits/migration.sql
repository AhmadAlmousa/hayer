BEGIN;

-- New codes are one letter followed by any two decimal digits. Keep legacy
-- three- and six-character codes valid so existing links continue to work.
ALTER TABLE "hayer_session"
  DROP CONSTRAINT IF EXISTS "hayer_session_values_valid";
ALTER TABLE "hayer_session"
  ADD CONSTRAINT "hayer_session_values_valid"
  CHECK (
    (
      "code" ~ '^[A-HJ-NP-Z][0-9]{2}$'
      OR "code" ~ '^[ABCDEFGHJKLMNPQRSTUVWXYZ23456789]{3}([ABCDEFGHJKLMNPQRSTUVWXYZ23456789]{3})?$'
    )
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
    VALUES ('hayer', '20260904163500000-session-code-digits', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260904163500000-session-code-digits', "timestamp" = now();

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
