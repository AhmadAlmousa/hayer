BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "hayer_cache_settings" ADD COLUMN "discoveryEnabled" boolean NOT NULL DEFAULT false;
ALTER TABLE "hayer_cache_settings" ADD COLUMN "discoveryBestFormula" text NOT NULL DEFAULT 'popularityWeighted'::text;
ALTER TABLE "hayer_cache_settings" ADD COLUMN "discoveryGemMinimumRating" double precision NOT NULL DEFAULT 4.5;
ALTER TABLE "hayer_cache_settings" ADD COLUMN "discoveryGemMinimumReviews" bigint NOT NULL DEFAULT 1;
ALTER TABLE "hayer_cache_settings" ADD COLUMN "discoveryGemMaximumReviewsExclusive" bigint NOT NULL DEFAULT 500;
ALTER TABLE "hayer_cache_settings" ADD COLUMN "discoveryBayesianPriorReviews" bigint NOT NULL DEFAULT 100;
ALTER TABLE "hayer_cache_settings" ADD COLUMN "discoveryBayesianMeanRating" double precision NOT NULL DEFAULT 4.0;
ALTER TABLE "hayer_cache_settings" ADD COLUMN "discoveryBestMinimumReviews" bigint NOT NULL DEFAULT 1;
ALTER TABLE "hayer_cache_settings" ADD COLUMN "discoveryTopRatedMinimumReviews" bigint NOT NULL DEFAULT 0;
ALTER TABLE "hayer_cache_settings" ADD COLUMN "discoveryWorstRatedMinimumReviews" bigint NOT NULL DEFAULT 0;
ALTER TABLE "hayer_cache_settings" ADD COLUMN "discoveryRecentlyAddedDays" bigint NOT NULL DEFAULT 45;
ALTER TABLE "hayer_cache_settings" ADD COLUMN "discoveryHarvestMaximumRequests" bigint NOT NULL DEFAULT 24;
ALTER TABLE "hayer_cache_settings" ADD COLUMN "discoveryHarvestDesiredCandidatesPerQuery" bigint NOT NULL DEFAULT 50;
ALTER TABLE "hayer_cache_settings" ADD COLUMN "discoveryHarvestMaximumSeconds" bigint NOT NULL DEFAULT 300;
ALTER TABLE "hayer_cache_settings" ADD COLUMN "discoveryHarvestCooldownMinutes" bigint NOT NULL DEFAULT 60;
ALTER TABLE "hayer_cache_settings" ADD COLUMN "discoveryUserHarvestsPerHour" bigint NOT NULL DEFAULT 3;
ALTER TABLE "hayer_cache_settings" ADD COLUMN "discoveryBrowseRequestsPerMinute" bigint NOT NULL DEFAULT 30;
ALTER TABLE "hayer_cache_settings" ADD COLUMN "discoveryFacetRequestsPerMinute" bigint NOT NULL DEFAULT 60;
ALTER TABLE "hayer_cache_settings" ADD COLUMN "discoveryQueryTimeoutMilliseconds" bigint NOT NULL DEFAULT 2000;
ALTER TABLE "hayer_cache_settings" ADD COLUMN "discoveryMaximumPageSize" bigint NOT NULL DEFAULT 100;
ALTER TABLE "hayer_cache_settings" ADD COLUMN "discoveryMaximumMapPoints" bigint NOT NULL DEFAULT 2000;
ALTER TABLE "hayer_cache_settings" ADD COLUMN "detailRefreshMaximumRequests" bigint NOT NULL DEFAULT 3;
ALTER TABLE "hayer_cache_settings" ADD COLUMN "detailRefreshMaximumSeconds" bigint NOT NULL DEFAULT 20;
ALTER TABLE "hayer_cache_settings" ADD COLUMN "detailRefreshCooldownMinutes" bigint NOT NULL DEFAULT 60;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "hayer_discovery_taxonomy" (
    "id" bigserial PRIMARY KEY,
    "version" text NOT NULL,
    "revision" bigint NOT NULL,
    "status" text NOT NULL,
    "documentJson" text NOT NULL,
    "validationPassed" boolean NOT NULL,
    "validationErrors" json NOT NULL,
    "createdBy" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "validatedAt" timestamp without time zone,
    "publishedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "hayer_discovery_taxonomy_version_key" ON "hayer_discovery_taxonomy" USING btree ("version");
CREATE INDEX "hayer_discovery_taxonomy_status" ON "hayer_discovery_taxonomy" USING btree ("status", "publishedAt");
CREATE UNIQUE INDEX "hayer_discovery_taxonomy_one_active"
  ON "hayer_discovery_taxonomy" ((1)) WHERE "status" = 'active';
CREATE UNIQUE INDEX "hayer_discovery_taxonomy_one_draft"
  ON "hayer_discovery_taxonomy" ((1)) WHERE "status" = 'draft';

ALTER TABLE "hayer_cache_settings"
  ADD CONSTRAINT "hayer_discovery_policy_valid"
  CHECK (
    "discoveryBestFormula" IN ('popularityWeighted', 'bayesian')
    AND "discoveryGemMinimumRating" <> 'NaN'::double precision
    AND "discoveryGemMinimumRating" BETWEEN 0 AND 5
    AND "discoveryGemMinimumReviews" BETWEEN 1 AND 10000000
    AND "discoveryGemMaximumReviewsExclusive" BETWEEN 2 AND 10000000
    AND "discoveryGemMinimumReviews" < "discoveryGemMaximumReviewsExclusive"
    AND "discoveryBayesianPriorReviews" BETWEEN 1 AND 10000000
    AND "discoveryBayesianMeanRating" <> 'NaN'::double precision
    AND "discoveryBayesianMeanRating" BETWEEN 0 AND 5
    AND "discoveryBestMinimumReviews" BETWEEN 0 AND 10000000
    AND "discoveryTopRatedMinimumReviews" BETWEEN 0 AND 10000000
    AND "discoveryWorstRatedMinimumReviews" BETWEEN 0 AND 10000000
    AND "discoveryRecentlyAddedDays" BETWEEN 1 AND 3650
    AND "discoveryHarvestMaximumRequests" BETWEEN 1 AND 100
    AND "discoveryHarvestDesiredCandidatesPerQuery" BETWEEN 1 AND 500
    AND "discoveryHarvestMaximumSeconds" BETWEEN 1 AND 600
    AND "discoveryHarvestCooldownMinutes" BETWEEN 1 AND 10080
    AND "discoveryUserHarvestsPerHour" BETWEEN 1 AND 60
    AND "discoveryBrowseRequestsPerMinute" BETWEEN 1 AND 600
    AND "discoveryFacetRequestsPerMinute" BETWEEN 1 AND 600
    AND "discoveryQueryTimeoutMilliseconds" BETWEEN 100 AND 30000
    AND "discoveryMaximumPageSize" BETWEEN 1 AND 100
    AND "discoveryMaximumMapPoints" BETWEEN 1 AND 5000
    AND "detailRefreshMaximumRequests" BETWEEN 1 AND 20
    AND "detailRefreshMaximumSeconds" BETWEEN 1 AND 120
    AND "detailRefreshCooldownMinutes" BETWEEN 1 AND 10080
  );
ALTER TABLE "hayer_discovery_taxonomy"
  ADD CONSTRAINT "hayer_discovery_taxonomy_values_valid"
  CHECK (
    length(trim("version")) BETWEEN 1 AND 120
    AND "revision" >= 1
    AND "status" IN ('draft', 'active', 'superseded')
    AND length(trim("createdBy")) BETWEEN 2 AND 80
  );


--
-- MIGRATION VERSION FOR hayer
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('hayer', '20260914073223386-discovery-policy-taxonomy', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260914073223386-discovery-policy-taxonomy', "timestamp" = now();

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
