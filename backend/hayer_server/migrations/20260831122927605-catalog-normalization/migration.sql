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
CREATE TABLE "hayer_operational_metric" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "bucketStartedAt" timestamp without time zone NOT NULL,
    "metricName" text NOT NULL,
    "dimensions" json NOT NULL,
    "metricValue" double precision NOT NULL,
    "sampleCount" bigint NOT NULL
);

-- Indexes
CREATE INDEX "hayer_metric_bucket_name" ON "hayer_operational_metric" USING btree ("bucketStartedAt", "metricName");
CREATE INDEX "hayer_metric_name_bucket" ON "hayer_operational_metric" USING btree ("metricName", "bucketStartedAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "hayer_poi_category" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "provider" text NOT NULL,
    "providerPlaceId" text NOT NULL,
    "categoryId" text NOT NULL,
    "evidenceQuery" text NOT NULL,
    "firstSeenAt" timestamp without time zone NOT NULL,
    "lastSeenAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "hayer_poi_category_identity" ON "hayer_poi_category" USING btree ("provider", "providerPlaceId", "categoryId");
CREATE INDEX "hayer_poi_category_lookup" ON "hayer_poi_category" USING btree ("categoryId", "lastSeenAt");

ALTER TABLE "hayer_poi_category"
  ADD CONSTRAINT "hayer_poi_category_catalog_fk"
  FOREIGN KEY ("provider", "providerPlaceId")
  REFERENCES "hayer_poi_catalog" ("provider", "providerPlaceId")
  ON DELETE CASCADE;


--
-- MIGRATION VERSION FOR hayer
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('hayer', '20260831122927605-catalog-normalization', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260831122927605-catalog-normalization', "timestamp" = now();

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
