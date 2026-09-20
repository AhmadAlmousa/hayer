BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "hayer_cache_settings" ADD COLUMN "photoFetchCount" bigint NOT NULL DEFAULT 6;
ALTER TABLE "hayer_cache_settings" ADD COLUMN "photoWidth" bigint NOT NULL DEFAULT 1200;
ALTER TABLE "hayer_cache_settings" ADD COLUMN "photoCacheCount" bigint NOT NULL DEFAULT 400;
ALTER TABLE "hayer_cache_settings" ADD COLUMN "photoCacheDays" bigint NOT NULL DEFAULT 14;

--
-- ACTION CUSTOM
--
-- The new columns belong under the same bounds check as the rest of the
-- policy, so the database refuses an out-of-range photo setting even if a
-- caller reaches it without going through DiscoveryPolicyService.validate.
-- A CHECK cannot be extended in place, so drop and recreate it; the defaults
-- above already satisfy the new predicates on every existing row.
ALTER TABLE "hayer_cache_settings"
  DROP CONSTRAINT IF EXISTS "hayer_discovery_policy_valid";
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
    AND "photoFetchCount" BETWEEN 1 AND 10
    AND "photoWidth" BETWEEN 400 AND 2400
    AND "photoCacheCount" BETWEEN 20 AND 2000
    AND "photoCacheDays" BETWEEN 1 AND 90
  );

--
-- MIGRATION VERSION FOR hayer
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('hayer', '20260918132049087-photo-policy', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260918132049087-photo-policy', "timestamp" = now();

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
