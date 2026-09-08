BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "hayer_product_analytics_event" ADD COLUMN "receivedAt" timestamp without time zone;
ALTER TABLE "hayer_product_analytics_event" ADD COLUMN "eventSchemaVersion" bigint;
ALTER TABLE "hayer_product_analytics_event" ADD COLUMN "origin" text;
ALTER TABLE "hayer_product_analytics_event" ADD COLUMN "journeyId" text;
ALTER TABLE "hayer_product_analytics_event" ADD COLUMN "appBuild" bigint;
ALTER TABLE "hayer_product_analytics_event" ADD COLUMN "platform" text;
ALTER TABLE "hayer_product_analytics_event" ADD COLUMN "language" text;
ALTER TABLE "hayer_product_analytics_event" ADD COLUMN "outcomeCode" text;
ALTER TABLE "hayer_product_analytics_event" ADD COLUMN "deckPosition" bigint;
ALTER TABLE "hayer_product_analytics_event" ADD COLUMN "visibleMilliseconds" bigint;
CREATE INDEX "hayer_analytics_event_journey" ON "hayer_product_analytics_event" USING btree ("journeyId", "occurredAt");

--
-- MIGRATION VERSION FOR hayer
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('hayer', '20260908110049218-decision-analytics', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260908110049218-decision-analytics', "timestamp" = now();

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
