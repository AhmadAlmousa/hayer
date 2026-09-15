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
CREATE TABLE "hayer_poi_detail_refresh" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "provider" text NOT NULL,
    "providerPlaceId" text NOT NULL,
    "state" text NOT NULL,
    "leaseToken" text,
    "leaseExpiresAt" timestamp without time zone,
    "lastAttemptAt" timestamp without time zone,
    "lastCheckedAt" timestamp without time zone,
    "lastSuccessAt" timestamp without time zone,
    "retryAfter" timestamp without time zone,
    "lastFailureCode" text,
    "attemptCount" bigint NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "hayer_poi_detail_refresh_identity" ON "hayer_poi_detail_refresh" USING btree ("provider", "providerPlaceId");

--
-- ACTION ALTER TABLE
--
ALTER TABLE "hayer_poi_issue_report" ADD COLUMN "source" text NOT NULL DEFAULT 'session'::text;
ALTER TABLE "hayer_poi_issue_report" ALTER COLUMN "sessionId" DROP NOT NULL;

-- A report belongs to the swipe session it was filed from or, from Discover,
-- to no session. Existing rows take the session default.
ALTER TABLE "hayer_poi_issue_report"
  ADD CONSTRAINT "hayer_poi_issue_source_valid"
  CHECK (
    ("source" = 'session' AND "sessionId" IS NOT NULL)
    OR ("source" = 'discovery' AND "sessionId" IS NULL)
  );
-- Shared per-place refresh metadata. A lease is held exactly while its token
-- and expiry are both set, and only then is the state refreshing.
ALTER TABLE "hayer_poi_detail_refresh"
  ADD CONSTRAINT "hayer_poi_detail_refresh_values_valid"
  CHECK (
    char_length("provider") BETWEEN 1 AND 80
    AND char_length("providerPlaceId") BETWEEN 1 AND 500
    AND "state" IN (
      'refreshing',
      'succeeded',
      'noMatch',
      'failed',
      'budgetExceeded'
    )
    AND ("leaseToken" IS NULL) = ("leaseExpiresAt" IS NULL)
    AND ("leaseToken" IS NULL) = ("state" <> 'refreshing')
    AND ("leaseToken" IS NULL OR char_length("leaseToken") BETWEEN 1 AND 64)
    AND (
      "lastFailureCode" IS NULL
      OR char_length("lastFailureCode") BETWEEN 1 AND 64
    )
    AND "attemptCount" >= 0
  );

--
-- MIGRATION VERSION FOR hayer
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('hayer', '20260915070806721-shared-detail-reporting', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260915070806721-shared-detail-reporting', "timestamp" = now();

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
