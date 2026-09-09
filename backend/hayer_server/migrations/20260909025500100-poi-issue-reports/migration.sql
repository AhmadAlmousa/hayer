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
CREATE TABLE "hayer_poi_issue_report" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "reportId" text NOT NULL,
    "reporterHash" text NOT NULL,
    "activeDedupeKey" text,
    "sessionId" text NOT NULL,
    "placeId" text NOT NULL,
    "placeName" text NOT NULL,
    "reportedSnapshot" json NOT NULL,
    "issueType" text NOT NULL,
    "details" text,
    "status" text NOT NULL,
    "ownerName" text,
    "resolution" text,
    "sourceEvidence" text,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL,
    "resolvedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "hayer_poi_issue_report_id" ON "hayer_poi_issue_report" USING btree ("reportId");
CREATE UNIQUE INDEX "hayer_poi_issue_active_dedupe" ON "hayer_poi_issue_report" USING btree ("activeDedupeKey");
CREATE INDEX "hayer_poi_issue_status_created" ON "hayer_poi_issue_report" USING btree ("status", "createdAt");
CREATE INDEX "hayer_poi_issue_place_type_created" ON "hayer_poi_issue_report" USING btree ("placeId", "issueType", "createdAt");
CREATE INDEX "hayer_poi_issue_owner_status" ON "hayer_poi_issue_report" USING btree ("ownerName", "status");


ALTER TABLE "hayer_poi_issue_report"
  ADD CONSTRAINT "hayer_poi_issue_values_valid"
  CHECK (
    char_length("reportId") BETWEEN 1 AND 128
    AND char_length("reporterHash") = 64
    AND ("activeDedupeKey" IS NULL OR char_length("activeDedupeKey") = 64)
    AND char_length("sessionId") BETWEEN 1 AND 128
    AND char_length("placeId") BETWEEN 1 AND 256
    AND char_length("placeName") BETWEEN 1 AND 500
    AND "issueType" IN (
      'wrongCategory',
      'closed',
      'wrongLocation',
      'duplicate',
      'misleadingPhoto',
      'other'
    )
    AND "status" IN ('open', 'inReview', 'resolved', 'dismissed')
    AND ("details" IS NULL OR char_length("details") BETWEEN 4 AND 500)
    AND ("ownerName" IS NULL OR char_length("ownerName") BETWEEN 1 AND 64)
    AND ("resolution" IS NULL OR char_length("resolution") BETWEEN 4 AND 500)
    AND ("sourceEvidence" IS NULL OR char_length("sourceEvidence") BETWEEN 4 AND 500)
    AND "updatedAt" >= "createdAt"
    AND ("resolvedAt" IS NULL OR "resolvedAt" >= "createdAt")
    AND (
      (
        "status" = 'open'
        AND "ownerName" IS NULL
        AND "resolution" IS NULL
        AND "sourceEvidence" IS NULL
        AND "resolvedAt" IS NULL
        AND "activeDedupeKey" IS NOT NULL
      )
      OR (
        "status" = 'inReview'
        AND "ownerName" IS NOT NULL
        AND "resolution" IS NULL
        AND "sourceEvidence" IS NULL
        AND "resolvedAt" IS NULL
        AND "activeDedupeKey" IS NOT NULL
      )
      OR (
        "status" IN ('resolved', 'dismissed')
        AND "ownerName" IS NOT NULL
        AND "resolution" IS NOT NULL
        AND "sourceEvidence" IS NOT NULL
        AND "resolvedAt" IS NOT NULL
        AND "activeDedupeKey" IS NULL
      )
    )
  );



--
-- MIGRATION VERSION FOR hayer
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('hayer', '20260909025500100-poi-issue-reports', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260909025500100-poi-issue-reports', "timestamp" = now();

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
