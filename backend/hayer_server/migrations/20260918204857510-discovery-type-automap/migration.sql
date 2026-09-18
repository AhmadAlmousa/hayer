BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "hayer_cache_settings" ADD COLUMN "discoveryTypeAutoMapEnabled" boolean NOT NULL DEFAULT true;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "hayer_discovery_type_automap" (
    "id" bigserial PRIMARY KEY,
    "typeKey" text NOT NULL,
    "primaryType" text NOT NULL,
    "nodeId" text NOT NULL,
    "rule" text NOT NULL,
    "mappedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "hayer_discovery_type_automap_key" ON "hayer_discovery_type_automap" USING btree ("typeKey");
CREATE INDEX "hayer_discovery_type_automap_time" ON "hayer_discovery_type_automap" USING btree ("mappedAt");


--
-- MIGRATION VERSION FOR hayer
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('hayer', '20260918204857510-discovery-type-automap', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260918204857510-discovery-type-automap', "timestamp" = now();

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
