BEGIN;

-- Current sessions use three letters followed by three decimal digits. Keep
-- both historical three-character formats and ambiguity-free six-character
-- codes valid until their 24-hour sessions have expired.
ALTER TABLE "hayer_session"
  DROP CONSTRAINT IF EXISTS "hayer_session_values_valid";
ALTER TABLE "hayer_session"
  ADD CONSTRAINT "hayer_session_values_valid"
  CHECK (
    (
      "code" ~ '^[A-Z]{3}[0-9]{3}$'
      OR "code" ~ '^[A-HJ-NP-Z][0-9]{2}$'
      OR "code" ~ '^[ABCDEFGHJKLMNPQRSTUVWXYZ23456789]{3}([ABCDEFGHJKLMNPQRSTUVWXYZ23456789]{3})?$'
    )
    AND "anchorLatitude" BETWEEN -90 AND 90
    AND "anchorLongitude" BETWEEN -180 AND 180
    AND "radiusMeters" BETWEEN 500 AND 10000
    AND "deckSizeRequested" IN (10, 20, 30, 40, 50)
    AND "deckSizeActual" BETWEEN 0 AND "deckSizeRequested"
    AND ("priceLevel" IS NULL OR "priceLevel" BETWEEN 1 AND 4)
  );

--
-- MIGRATION VERSION FOR hayer
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('hayer', '20260906152448000-session-code-capacity', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260906152448000-session-code-capacity', "timestamp" = now();

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
