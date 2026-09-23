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
-- Class AdminAuditRow as table hayer_admin_audit
--
CREATE TABLE "hayer_admin_audit" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "auditId" text NOT NULL,
    "operatorName" text NOT NULL,
    "ipHash" text NOT NULL,
    "action" text NOT NULL,
    "targetType" text NOT NULL,
    "targetId" text,
    "reason" text NOT NULL,
    "beforeData" json,
    "afterData" json,
    "occurredAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "hayer_admin_audit_id" ON "hayer_admin_audit" USING btree ("auditId");
CREATE INDEX "hayer_admin_audit_time" ON "hayer_admin_audit" USING btree ("occurredAt");

--
-- Class CacheSettingsRow as table hayer_cache_settings
--
CREATE TABLE "hayer_cache_settings" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "settingsKey" text NOT NULL,
    "version" bigint NOT NULL,
    "freshHours" bigint NOT NULL,
    "staleFallbackDays" bigint NOT NULL,
    "retentionDays" bigint NOT NULL,
    "extractorAttempts" bigint NOT NULL,
    "perCreationConcurrency" bigint NOT NULL,
    "globalRequestsPerMinute" bigint NOT NULL,
    "globalBurst" bigint NOT NULL,
    "routeEstimatesEnabled" boolean NOT NULL DEFAULT true,
    "allowParticipantLocation" boolean NOT NULL DEFAULT true,
    "defaultRouteOrigin" text NOT NULL DEFAULT 'sessionAnchor'::text,
    "routeEstimateCacheMinutes" bigint NOT NULL DEFAULT 10,
    "routeRequestsPerMinute" bigint NOT NULL DEFAULT 30,
    "routeBurst" bigint NOT NULL DEFAULT 6,
    "discoveryEnabled" boolean NOT NULL DEFAULT false,
    "discoveryBestFormula" text NOT NULL DEFAULT 'popularityWeighted'::text,
    "discoveryGemMinimumRating" double precision NOT NULL DEFAULT 4.5,
    "discoveryGemMinimumReviews" bigint NOT NULL DEFAULT 1,
    "discoveryGemMaximumReviewsExclusive" bigint NOT NULL DEFAULT 500,
    "discoveryBayesianPriorReviews" bigint NOT NULL DEFAULT 100,
    "discoveryBayesianMeanRating" double precision NOT NULL DEFAULT 4.0,
    "discoveryBestMinimumReviews" bigint NOT NULL DEFAULT 1,
    "discoveryTopRatedMinimumReviews" bigint NOT NULL DEFAULT 0,
    "discoveryWorstRatedMinimumReviews" bigint NOT NULL DEFAULT 0,
    "discoveryRecentlyAddedDays" bigint NOT NULL DEFAULT 45,
    "discoveryHarvestMaximumRequests" bigint NOT NULL DEFAULT 24,
    "discoveryHarvestDesiredCandidatesPerQuery" bigint NOT NULL DEFAULT 50,
    "discoveryHarvestMaximumSeconds" bigint NOT NULL DEFAULT 300,
    "discoveryHarvestCooldownMinutes" bigint NOT NULL DEFAULT 60,
    "discoveryUserHarvestsPerHour" bigint NOT NULL DEFAULT 12,
    "discoveryBrowseRequestsPerMinute" bigint NOT NULL DEFAULT 30,
    "discoveryFacetRequestsPerMinute" bigint NOT NULL DEFAULT 60,
    "discoveryQueryTimeoutMilliseconds" bigint NOT NULL DEFAULT 2000,
    "discoveryMaximumPageSize" bigint NOT NULL DEFAULT 100,
    "discoveryMaximumMapPoints" bigint NOT NULL DEFAULT 2000,
    "discoveryTypeAutoMapEnabled" boolean NOT NULL DEFAULT true,
    "detailRefreshMaximumRequests" bigint NOT NULL DEFAULT 3,
    "detailRefreshMaximumSeconds" bigint NOT NULL DEFAULT 20,
    "detailRefreshCooldownMinutes" bigint NOT NULL DEFAULT 60,
    "photoFetchCount" bigint NOT NULL DEFAULT 6,
    "photoWidth" bigint NOT NULL DEFAULT 1200,
    "photoCacheCount" bigint NOT NULL DEFAULT 400,
    "photoCacheDays" bigint NOT NULL DEFAULT 14,
    "updatedBy" text NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "hayer_cache_settings_key" ON "hayer_cache_settings" USING btree ("settingsKey");

--
-- Class CalibrationRow as table hayer_calibration
--
CREATE TABLE "hayer_calibration" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "version" text NOT NULL,
    "status" text NOT NULL,
    "document" json NOT NULL,
    "fixturePassed" boolean NOT NULL,
    "liveCanaryPassed" boolean NOT NULL,
    "validationErrors" json NOT NULL,
    "createdBy" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "validatedAt" timestamp without time zone,
    "activatedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "hayer_calibration_version" ON "hayer_calibration" USING btree ("version");
CREATE INDEX "hayer_calibration_status" ON "hayer_calibration" USING btree ("status");

--
-- Class CityResolutionRow as table hayer_city_resolution
--
CREATE TABLE "hayer_city_resolution" (
    "id" bigserial PRIMARY KEY,
    "cellKey" text NOT NULL,
    "countryCode" text NOT NULL,
    "cityKey" text NOT NULL,
    "cityName" text NOT NULL,
    "regionName" text,
    "resolvedAt" timestamp without time zone NOT NULL,
    "expiresAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "hayer_city_resolution_cell" ON "hayer_city_resolution" USING btree ("cellKey");
CREATE INDEX "hayer_city_resolution_expiry" ON "hayer_city_resolution" USING btree ("expiresAt");

--
-- Class DiscoveryCoverageRow as table hayer_discovery_coverage
--
CREATE TABLE "hayer_discovery_coverage" (
    "id" bigserial PRIMARY KEY,
    "countryCode" text NOT NULL,
    "cellId" text NOT NULL,
    "radiusMeters" bigint NOT NULL,
    "centerLatitude" double precision NOT NULL,
    "centerLongitude" double precision NOT NULL,
    "south" double precision NOT NULL,
    "west" double precision NOT NULL,
    "north" double precision NOT NULL,
    "east" double precision NOT NULL,
    "manifestRevision" bigint NOT NULL,
    "queryCompletedAt" json NOT NULL,
    "lastAttemptAt" timestamp without time zone,
    "lastSuccessAt" timestamp without time zone,
    "lastJobId" text,
    "lastFailureCode" text,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "hayer_discovery_coverage_cell" ON "hayer_discovery_coverage" USING btree ("countryCode", "cellId", "radiusMeters");
CREATE INDEX "hayer_discovery_coverage_bounds" ON "hayer_discovery_coverage" USING btree ("countryCode", "south", "north");

--
-- Class DiscoveryHarvestRow as table hayer_discovery_harvest
--
CREATE TABLE "hayer_discovery_harvest" (
    "id" bigserial PRIMARY KEY,
    "jobId" text NOT NULL,
    "harvestKey" text NOT NULL,
    "requester" text NOT NULL,
    "requestedBy" text NOT NULL,
    "trigger" text NOT NULL,
    "countryCode" text NOT NULL,
    "cellId" text NOT NULL,
    "radiusMeters" bigint NOT NULL,
    "centerLatitude" double precision NOT NULL,
    "centerLongitude" double precision NOT NULL,
    "south" double precision NOT NULL,
    "west" double precision NOT NULL,
    "north" double precision NOT NULL,
    "east" double precision NOT NULL,
    "manifestVersion" text NOT NULL,
    "manifestRevision" bigint NOT NULL,
    "calibrationVersion" text NOT NULL,
    "state" text NOT NULL,
    "queryOutcomes" json NOT NULL,
    "attemptedQueries" bigint NOT NULL,
    "completedQueries" bigint NOT NULL,
    "totalQueries" bigint NOT NULL,
    "observedPlaces" bigint NOT NULL,
    "upstreamRequests" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "startedAt" timestamp without time zone,
    "completedAt" timestamp without time zone,
    "failureCode" text
);

-- Indexes
CREATE UNIQUE INDEX "hayer_discovery_harvest_job" ON "hayer_discovery_harvest" USING btree ("jobId");
CREATE INDEX "hayer_discovery_harvest_key_state" ON "hayer_discovery_harvest" USING btree ("harvestKey", "state");
CREATE INDEX "hayer_discovery_harvest_cell_completed" ON "hayer_discovery_harvest" USING btree ("countryCode", "cellId", "radiusMeters", "completedAt");
CREATE INDEX "hayer_discovery_harvest_state_created" ON "hayer_discovery_harvest" USING btree ("state", "createdAt");
CREATE INDEX "hayer_discovery_harvest_created" ON "hayer_discovery_harvest" USING btree ("createdAt");

--
-- Class DiscoveryHarvestManifestRow as table hayer_discovery_harvest_manifest
--
CREATE TABLE "hayer_discovery_harvest_manifest" (
    "id" bigserial PRIMARY KEY,
    "version" text NOT NULL,
    "revision" bigint NOT NULL,
    "status" text NOT NULL,
    "entries" json NOT NULL,
    "validationPassed" boolean NOT NULL,
    "validationErrors" json NOT NULL,
    "createdBy" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "validatedAt" timestamp without time zone,
    "publishedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "hayer_discovery_manifest_version_key" ON "hayer_discovery_harvest_manifest" USING btree ("version");
CREATE INDEX "hayer_discovery_manifest_status" ON "hayer_discovery_harvest_manifest" USING btree ("status", "publishedAt");

--
-- Class DiscoveryTaxonomyVersionRow as table hayer_discovery_taxonomy
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

--
-- Class DiscoveryTypeAutoMapRow as table hayer_discovery_type_automap
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
-- Class DiscoveryTypeObservationRow as table hayer_discovery_type_observation
--
CREATE TABLE "hayer_discovery_type_observation" (
    "id" bigserial PRIMARY KEY,
    "typeKey" text NOT NULL,
    "primaryType" text NOT NULL,
    "observationCount" bigint NOT NULL,
    "firstObservedAt" timestamp without time zone NOT NULL,
    "lastObservedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "hayer_discovery_type_observation_key" ON "hayer_discovery_type_observation" USING btree ("typeKey");

--
-- Class IdempotencyRow as table hayer_idempotency
--
CREATE TABLE "hayer_idempotency" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "scope" text NOT NULL,
    "userId" text NOT NULL,
    "idempotencyKey" text NOT NULL,
    "requestHash" text NOT NULL,
    "responseId" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "expiresAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "hayer_idempotency_unique" ON "hayer_idempotency" USING btree ("scope", "userId", "idempotencyKey");
CREATE INDEX "hayer_idempotency_expiry" ON "hayer_idempotency" USING btree ("expiresAt");

--
-- Class OperationalMetricRow as table hayer_operational_metric
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
-- Class ParticipantRow as table hayer_participant
--
CREATE TABLE "hayer_participant" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "participantId" text NOT NULL,
    "sessionId" text NOT NULL,
    "userId" text NOT NULL,
    "displayName" text NOT NULL,
    "normalizedName" text NOT NULL,
    "isHost" boolean NOT NULL,
    "currentIndex" bigint NOT NULL,
    "hasCompleted" boolean NOT NULL,
    "lastSeenAt" timestamp without time zone NOT NULL,
    "destinationPlaceId" text,
    "destinationChoiceRevision" bigint NOT NULL DEFAULT 0
);

-- Indexes
CREATE UNIQUE INDEX "hayer_participant_id" ON "hayer_participant" USING btree ("participantId");
CREATE UNIQUE INDEX "hayer_participant_session_user" ON "hayer_participant" USING btree ("sessionId", "userId");
CREATE UNIQUE INDEX "hayer_participant_session_name" ON "hayer_participant" USING btree ("sessionId", "normalizedName");
CREATE INDEX "hayer_participant_session" ON "hayer_participant" USING btree ("sessionId");

--
-- Class PoiCatalogRow as table hayer_poi_catalog
--
CREATE TABLE "hayer_poi_catalog" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "provider" text NOT NULL,
    "providerPlaceId" text NOT NULL,
    "featureId" text,
    "normalizedName" text NOT NULL,
    "name" text NOT NULL,
    "countryCode" text NOT NULL,
    "latitude" double precision NOT NULL,
    "longitude" double precision NOT NULL,
    "categoryIds" json NOT NULL,
    "snapshot" json NOT NULL,
    "calibrationVersion" text NOT NULL,
    "sourceCheckedAt" timestamp without time zone NOT NULL,
    "firstSeenAt" timestamp without time zone NOT NULL,
    "lastSeenAt" timestamp without time zone NOT NULL,
    "quarantinedAt" timestamp without time zone,
    "quarantineReason" text
);

-- Indexes
CREATE UNIQUE INDEX "hayer_poi_provider_identity" ON "hayer_poi_catalog" USING btree ("provider", "providerPlaceId");
CREATE INDEX "hayer_poi_feature_id" ON "hayer_poi_catalog" USING btree ("featureId");
CREATE INDEX "hayer_poi_country_last_seen" ON "hayer_poi_catalog" USING btree ("countryCode", "lastSeenAt");
CREATE INDEX "hayer_poi_quarantine" ON "hayer_poi_catalog" USING btree ("quarantinedAt");

--
-- Class PoiCategoryRow as table hayer_poi_category
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

--
-- Class PoiCoverageRow as table hayer_poi_coverage
--
CREATE TABLE "hayer_poi_coverage" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "coverageKey" text NOT NULL,
    "queryKey" text NOT NULL,
    "language" text NOT NULL,
    "countryCode" text NOT NULL,
    "anchorLatitude" double precision NOT NULL,
    "anchorLongitude" double precision NOT NULL,
    "radiusMeters" bigint NOT NULL,
    "calibrationVersion" text NOT NULL,
    "resultCount" bigint NOT NULL,
    "refreshedAt" timestamp without time zone NOT NULL,
    "expiresAt" timestamp without time zone NOT NULL,
    "lastFailureCode" text,
    "invalidatedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "hayer_coverage_key" ON "hayer_poi_coverage" USING btree ("coverageKey");
CREATE INDEX "hayer_coverage_query_expiry" ON "hayer_poi_coverage" USING btree ("countryCode", "queryKey", "language", "expiresAt");

--
-- Class PoiDetailRefreshRow as table hayer_poi_detail_refresh
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
-- Class PoiIssueReportRow as table hayer_poi_issue_report
--
CREATE TABLE "hayer_poi_issue_report" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "reportId" text NOT NULL,
    "reporterHash" text NOT NULL,
    "activeDedupeKey" text,
    "sessionId" text,
    "source" text NOT NULL DEFAULT 'session'::text,
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

--
-- Class ProductAnalyticsEventRow as table hayer_product_analytics_event
--
CREATE TABLE "hayer_product_analytics_event" (
    "id" bigserial PRIMARY KEY,
    "eventId" text NOT NULL,
    "occurredAt" timestamp without time zone NOT NULL,
    "metricName" text NOT NULL,
    "modeKey" text NOT NULL,
    "countryCode" text NOT NULL,
    "cityKey" text NOT NULL,
    "cityName" text NOT NULL,
    "categoryId" text NOT NULL,
    "taxonomyKind" text NOT NULL,
    "taxonomyId" text NOT NULL,
    "placeId" text NOT NULL,
    "placeName" text NOT NULL,
    "value" double precision NOT NULL,
    "sampleCount" bigint NOT NULL,
    "receivedAt" timestamp without time zone,
    "eventSchemaVersion" bigint,
    "origin" text,
    "journeyId" text,
    "appBuild" bigint,
    "platform" text,
    "language" text,
    "outcomeCode" text,
    "deckPosition" bigint,
    "visibleMilliseconds" bigint,
    "processedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "hayer_analytics_event_id" ON "hayer_product_analytics_event" USING btree ("eventId");
CREATE INDEX "hayer_analytics_event_pending" ON "hayer_product_analytics_event" USING btree ("processedAt", "occurredAt");
CREATE INDEX "hayer_analytics_event_time" ON "hayer_product_analytics_event" USING btree ("occurredAt");
CREATE INDEX "hayer_analytics_event_journey" ON "hayer_product_analytics_event" USING btree ("journeyId", "occurredAt");

--
-- Class ProductAnalyticsHourRow as table hayer_product_analytics_hour
--
CREATE TABLE "hayer_product_analytics_hour" (
    "id" bigserial PRIMARY KEY,
    "aggregateKey" text NOT NULL,
    "bucketStartedAt" timestamp without time zone NOT NULL,
    "metricName" text NOT NULL,
    "modeKey" text NOT NULL,
    "countryCode" text NOT NULL,
    "cityKey" text NOT NULL,
    "cityName" text NOT NULL,
    "categoryId" text NOT NULL,
    "taxonomyKind" text NOT NULL,
    "taxonomyId" text NOT NULL,
    "placeId" text NOT NULL,
    "placeName" text NOT NULL,
    "total" double precision NOT NULL,
    "sampleCount" bigint NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "hayer_analytics_hour_key" ON "hayer_product_analytics_hour" USING btree ("aggregateKey");
CREATE INDEX "hayer_analytics_hour_metric_time" ON "hayer_product_analytics_hour" USING btree ("metricName", "bucketStartedAt");
CREATE INDEX "hayer_analytics_hour_city_time" ON "hayer_product_analytics_hour" USING btree ("cityKey", "metricName", "bucketStartedAt");
CREATE INDEX "hayer_analytics_hour_taxonomy_time" ON "hayer_product_analytics_hour" USING btree ("taxonomyKind", "metricName", "bucketStartedAt");
CREATE INDEX "hayer_analytics_hour_place_time" ON "hayer_product_analytics_hour" USING btree ("placeId", "metricName", "bucketStartedAt");

--
-- Class RateLimitRow as table hayer_rate_limit
--
CREATE TABLE "hayer_rate_limit" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "counterKey" text NOT NULL,
    "attemptCount" bigint NOT NULL,
    "windowStartedAt" timestamp without time zone NOT NULL,
    "expiresAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "hayer_rate_limit_key" ON "hayer_rate_limit" USING btree ("counterKey");
CREATE INDEX "hayer_rate_limit_expiry" ON "hayer_rate_limit" USING btree ("expiresAt");

--
-- Class RefreshJobRow as table hayer_refresh_job
--
CREATE TABLE "hayer_refresh_job" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "jobId" text NOT NULL,
    "coverageKey" text NOT NULL,
    "status" text NOT NULL,
    "requestedBy" text NOT NULL,
    "reason" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "startedAt" timestamp without time zone,
    "completedAt" timestamp without time zone,
    "errorCode" text,
    "planJson" text,
    "heartbeatAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "hayer_refresh_job_id" ON "hayer_refresh_job" USING btree ("jobId");
CREATE INDEX "hayer_refresh_job_coverage_status" ON "hayer_refresh_job" USING btree ("coverageKey", "status");
CREATE INDEX "hayer_refresh_job_created" ON "hayer_refresh_job" USING btree ("createdAt");

--
-- Class HayerSessionRow as table hayer_session
--
CREATE TABLE "hayer_session" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "sessionId" text NOT NULL,
    "code" text NOT NULL,
    "hostUserId" text NOT NULL,
    "mode" text NOT NULL,
    "categoryId" text NOT NULL,
    "subcategoryIds" json NOT NULL,
    "priceLevel" bigint,
    "anchorLatitude" double precision NOT NULL,
    "anchorLongitude" double precision NOT NULL,
    "anchorAddress" text,
    "cityKey" text,
    "cityName" text,
    "visitAt" timestamp without time zone,
    "countryCode" text NOT NULL,
    "radiusMeters" bigint NOT NULL,
    "deckSizeRequested" bigint NOT NULL,
    "deckSizeActual" bigint NOT NULL,
    "consensusRule" text NOT NULL,
    "matchingTiming" text NOT NULL,
    "status" text NOT NULL,
    "matchedPlaceId" text,
    "decisionAt" timestamp without time zone,
    "revision" bigint NOT NULL,
    "freshnessWarning" text,
    "intent" json,
    "intentBatchCount" bigint DEFAULT 1,
    "createdAt" timestamp without time zone NOT NULL,
    "expiresAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "hayer_session_session_id" ON "hayer_session" USING btree ("sessionId");
CREATE UNIQUE INDEX "hayer_session_code" ON "hayer_session" USING btree ("code");
CREATE INDEX "hayer_session_status_expires" ON "hayer_session" USING btree ("status", "expiresAt");
CREATE INDEX "hayer_session_created" ON "hayer_session" USING btree ("createdAt");

--
-- Class SessionPlaceRow as table hayer_session_place
--
CREATE TABLE "hayer_session_place" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "sessionId" text NOT NULL,
    "placeId" text NOT NULL,
    "deckOrder" bigint NOT NULL,
    "snapshot" json NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "hayer_session_place_order" ON "hayer_session_place" USING btree ("sessionId", "deckOrder");
CREATE UNIQUE INDEX "hayer_session_place_identity" ON "hayer_session_place" USING btree ("sessionId", "placeId");

--
-- Class SwipeRow as table hayer_swipe
--
CREATE TABLE "hayer_swipe" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "sessionId" text NOT NULL,
    "userId" text NOT NULL,
    "placeId" text NOT NULL,
    "liked" boolean NOT NULL,
    "swipeIndex" bigint NOT NULL,
    "clientSwipedAt" timestamp without time zone NOT NULL,
    "serverReceivedAt" timestamp without time zone NOT NULL,
    "idempotencyKey" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "hayer_swipe_identity" ON "hayer_swipe" USING btree ("sessionId", "userId", "placeId");
CREATE UNIQUE INDEX "hayer_swipe_idempotency" ON "hayer_swipe" USING btree ("userId", "idempotencyKey");
CREATE INDEX "hayer_swipe_session_place" ON "hayer_swipe" USING btree ("sessionId", "placeId");

--
-- Class TaxonomyVersionRow as table hayer_taxonomy_version
--
CREATE TABLE "hayer_taxonomy_version" (
    "id" bigserial PRIMARY KEY,
    "version" text NOT NULL,
    "revision" bigint NOT NULL,
    "status" text NOT NULL,
    "documentJson" text NOT NULL,
    "validationPassed" boolean NOT NULL,
    "validationErrors" json NOT NULL,
    "validationLocationJson" text,
    "validationRadiusMeters" bigint,
    "createdBy" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "validatedAt" timestamp without time zone,
    "publishedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "hayer_taxonomy_version_key" ON "hayer_taxonomy_version" USING btree ("version");
CREATE INDEX "hayer_taxonomy_status" ON "hayer_taxonomy_version" USING btree ("status", "publishedAt");

--
-- Class CloudStorageEntry as table serverpod_cloud_storage
--
CREATE TABLE "serverpod_cloud_storage" (
    "id" bigserial PRIMARY KEY,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "addedTime" timestamp without time zone NOT NULL,
    "expiration" timestamp without time zone,
    "byteData" bytea NOT NULL,
    "verified" boolean NOT NULL,
    "contentType" text,
    "cacheControl" text,
    "contentDisposition" text,
    "contentEncoding" text,
    "customMetadata" text
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_cloud_storage_path_idx" ON "serverpod_cloud_storage" USING btree ("storageId", "path");
CREATE INDEX "serverpod_cloud_storage_expiration" ON "serverpod_cloud_storage" USING btree ("expiration");

--
-- Class CloudStorageDirectDownloadEntry as table serverpod_cloud_storage_direct_download
--
CREATE TABLE "serverpod_cloud_storage_direct_download" (
    "id" bigserial PRIMARY KEY,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "expiration" timestamp without time zone NOT NULL,
    "authKey" text NOT NULL,
    "downloadFileName" text,
    "contentType" text
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_cloud_storage_direct_download_auth_key" ON "serverpod_cloud_storage_direct_download" USING btree ("authKey");
CREATE INDEX "serverpod_cloud_storage_direct_download_expiration" ON "serverpod_cloud_storage_direct_download" USING btree ("expiration");

--
-- Class CloudStorageDirectUploadEntry as table serverpod_cloud_storage_direct_upload
--
CREATE TABLE "serverpod_cloud_storage_direct_upload" (
    "id" bigserial PRIMARY KEY,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "expiration" timestamp without time zone NOT NULL,
    "authKey" text NOT NULL,
    "maxFileSize" bigint NOT NULL DEFAULT 10485760,
    "contentLength" bigint,
    "preventOverwrite" boolean NOT NULL DEFAULT false,
    "contentType" text,
    "cacheControl" text,
    "contentDisposition" text,
    "contentEncoding" text,
    "customMetadata" text
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_cloud_storage_direct_upload_storage_path" ON "serverpod_cloud_storage_direct_upload" USING btree ("storageId", "path");

--
-- Class FutureCallEntry as table serverpod_future_call
--
CREATE TABLE "serverpod_future_call" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "serializedObject" text,
    "serverId" text NOT NULL,
    "identifier" text,
    "scheduling" json
);

-- Indexes
CREATE INDEX "serverpod_future_call_time_idx" ON "serverpod_future_call" USING btree ("time");
CREATE INDEX "serverpod_future_call_serverId_idx" ON "serverpod_future_call" USING btree ("serverId");
CREATE INDEX "serverpod_future_call_identifier_idx" ON "serverpod_future_call" USING btree ("identifier");

--
-- Class FutureCallClaimEntry as table serverpod_future_call_claim
--
CREATE TABLE "serverpod_future_call_claim" (
    "id" bigserial PRIMARY KEY,
    "futureCallId" bigint,
    "lastHeartbeatTime" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "future_call_unique_idx" ON "serverpod_future_call_claim" USING btree ("futureCallId");

--
-- Class ServerHealthConnectionInfo as table serverpod_health_connection_info
--
CREATE TABLE "serverpod_health_connection_info" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "active" bigint NOT NULL,
    "closing" bigint NOT NULL,
    "idle" bigint NOT NULL,
    "granularity" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_health_connection_info_timestamp_idx" ON "serverpod_health_connection_info" USING btree ("timestamp", "serverId", "granularity");

--
-- Class ServerHealthMetric as table serverpod_health_metric
--
CREATE TABLE "serverpod_health_metric" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "serverId" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "isHealthy" boolean NOT NULL,
    "value" double precision NOT NULL,
    "granularity" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_health_metric_timestamp_idx" ON "serverpod_health_metric" USING btree ("timestamp", "serverId", "name", "granularity");

--
-- Class LogEntry as table serverpod_log
--
CREATE TABLE "serverpod_log" (
    "id" bigserial PRIMARY KEY,
    "sessionLogId" bigint NOT NULL,
    "messageId" bigint,
    "reference" text,
    "serverId" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "logLevel" bigint NOT NULL,
    "message" text NOT NULL,
    "error" text,
    "stackTrace" text,
    "order" bigint NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_log_sessionLogId_idx" ON "serverpod_log" USING btree ("sessionLogId", "order");

--
-- Class MessageLogEntry as table serverpod_message_log
--
CREATE TABLE "serverpod_message_log" (
    "id" bigserial PRIMARY KEY,
    "sessionLogId" bigint NOT NULL,
    "serverId" text NOT NULL,
    "messageId" bigint NOT NULL,
    "endpoint" text NOT NULL,
    "messageName" text NOT NULL,
    "duration" double precision NOT NULL,
    "error" text,
    "stackTrace" text,
    "slow" boolean NOT NULL,
    "order" bigint NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_message_log_sessionLogId_idx" ON "serverpod_message_log" USING btree ("sessionLogId", "order");

--
-- Class MethodInfo as table serverpod_method
--
CREATE TABLE "serverpod_method" (
    "id" bigserial PRIMARY KEY,
    "endpoint" text NOT NULL,
    "method" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_method_endpoint_method_idx" ON "serverpod_method" USING btree ("endpoint", "method");

--
-- Class DatabaseMigrationVersion as table serverpod_migrations
--
CREATE TABLE "serverpod_migrations" (
    "id" bigserial PRIMARY KEY,
    "module" text NOT NULL,
    "version" text NOT NULL,
    "timestamp" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_migrations_ids" ON "serverpod_migrations" USING btree ("module");

--
-- Class QueryLogEntry as table serverpod_query_log
--
CREATE TABLE "serverpod_query_log" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "sessionLogId" bigint NOT NULL,
    "messageId" bigint,
    "query" text NOT NULL,
    "duration" double precision NOT NULL,
    "numRows" bigint,
    "error" text,
    "stackTrace" text,
    "slow" boolean NOT NULL,
    "order" bigint NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_query_log_sessionLogId_idx" ON "serverpod_query_log" USING btree ("sessionLogId", "order");

--
-- Class ReadWriteTestEntry as table serverpod_readwrite_test
--
CREATE TABLE "serverpod_readwrite_test" (
    "id" bigserial PRIMARY KEY,
    "number" bigint NOT NULL
);

--
-- Class RuntimeSettings as table serverpod_runtime_settings
--
CREATE TABLE "serverpod_runtime_settings" (
    "id" bigserial PRIMARY KEY,
    "logSettings" json NOT NULL,
    "logSettingsOverrides" json NOT NULL,
    "logServiceCalls" boolean NOT NULL,
    "logMalformedCalls" boolean NOT NULL
);

--
-- Class SessionLogEntry as table serverpod_session_log
--
CREATE TABLE "serverpod_session_log" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "module" text,
    "endpoint" text,
    "method" text,
    "duration" double precision,
    "numQueries" bigint,
    "slow" boolean,
    "error" text,
    "stackTrace" text,
    "authenticatedUserId" bigint,
    "userId" text,
    "isOpen" boolean,
    "touched" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_session_log_serverid_idx" ON "serverpod_session_log" USING btree ("serverId");
CREATE INDEX "serverpod_session_log_time_idx" ON "serverpod_session_log" USING btree ("time");
CREATE INDEX "serverpod_session_log_touched_idx" ON "serverpod_session_log" USING btree ("touched");
CREATE INDEX "serverpod_session_log_isopen_idx" ON "serverpod_session_log" USING btree ("isOpen");

--
-- Class AnonymousAccount as table serverpod_auth_idp_anonymous_account
--
CREATE TABLE "serverpod_auth_idp_anonymous_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- Class AppleAccount as table serverpod_auth_idp_apple_account
--
CREATE TABLE "serverpod_auth_idp_apple_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "userIdentifier" text NOT NULL,
    "refreshToken" text NOT NULL,
    "refreshTokenRequestedWithBundleIdentifier" boolean NOT NULL,
    "lastRefreshedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "email" text,
    "isEmailVerified" boolean,
    "isPrivateEmail" boolean,
    "firstName" text,
    "lastName" text
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_apple_account_identifier" ON "serverpod_auth_idp_apple_account" USING btree ("userIdentifier");

--
-- Class EmailAccount as table serverpod_auth_idp_email_account
--
CREATE TABLE "serverpod_auth_idp_email_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "email" text NOT NULL,
    "passwordHash" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_idp_email_account_email" ON "serverpod_auth_idp_email_account" USING btree ("email");

--
-- Class EmailAccountPasswordResetRequest as table serverpod_auth_idp_email_account_password_reset_request
--
CREATE TABLE "serverpod_auth_idp_email_account_password_reset_request" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "emailAccountId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "challengeId" uuid NOT NULL,
    "setPasswordChallengeId" uuid
);

--
-- Class EmailAccountRequest as table serverpod_auth_idp_email_account_request
--
CREATE TABLE "serverpod_auth_idp_email_account_request" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "email" text NOT NULL,
    "challengeId" uuid NOT NULL,
    "createAccountChallengeId" uuid
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_idp_email_account_request_email" ON "serverpod_auth_idp_email_account_request" USING btree ("email");

--
-- Class FacebookAccount as table serverpod_auth_idp_facebook_account
--
CREATE TABLE "serverpod_auth_idp_facebook_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "userIdentifier" text NOT NULL,
    "email" text,
    "fullName" text,
    "firstName" text,
    "lastName" text
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_facebook_account_user_identifier" ON "serverpod_auth_idp_facebook_account" USING btree ("userIdentifier");

--
-- Class FirebaseAccount as table serverpod_auth_idp_firebase_account
--
CREATE TABLE "serverpod_auth_idp_firebase_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "created" timestamp without time zone NOT NULL,
    "email" text,
    "phone" text,
    "userIdentifier" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_firebase_account_user_identifier" ON "serverpod_auth_idp_firebase_account" USING btree ("userIdentifier");

--
-- Class GitHubAccount as table serverpod_auth_idp_github_account
--
CREATE TABLE "serverpod_auth_idp_github_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "userIdentifier" text NOT NULL,
    "email" text,
    "created" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_github_account_user_identifier" ON "serverpod_auth_idp_github_account" USING btree ("userIdentifier");

--
-- Class GoogleAccount as table serverpod_auth_idp_google_account
--
CREATE TABLE "serverpod_auth_idp_google_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "created" timestamp without time zone NOT NULL,
    "email" text NOT NULL,
    "userIdentifier" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_google_account_user_identifier" ON "serverpod_auth_idp_google_account" USING btree ("userIdentifier");

--
-- Class MicrosoftAccount as table serverpod_auth_idp_microsoft_account
--
CREATE TABLE "serverpod_auth_idp_microsoft_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "userIdentifier" text NOT NULL,
    "email" text,
    "created" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_microsoft_account_user_identifier" ON "serverpod_auth_idp_microsoft_account" USING btree ("userIdentifier");

--
-- Class PasskeyAccount as table serverpod_auth_idp_passkey_account
--
CREATE TABLE "serverpod_auth_idp_passkey_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "keyId" bytea NOT NULL,
    "keyIdBase64" text NOT NULL,
    "clientDataJSON" bytea NOT NULL,
    "attestationObject" bytea NOT NULL,
    "originalChallenge" bytea NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_idp_passkey_account_key_id_base64" ON "serverpod_auth_idp_passkey_account" USING btree ("keyIdBase64");

--
-- Class PasskeyChallenge as table serverpod_auth_idp_passkey_challenge
--
CREATE TABLE "serverpod_auth_idp_passkey_challenge" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "createdAt" timestamp without time zone NOT NULL,
    "challenge" bytea NOT NULL
);

--
-- Class RateLimitedRequestAttempt as table serverpod_auth_idp_rate_limited_request_attempt
--
CREATE TABLE "serverpod_auth_idp_rate_limited_request_attempt" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "domain" text NOT NULL,
    "source" text NOT NULL,
    "key" text NOT NULL,
    "ipAddress" text,
    "attemptedAt" timestamp without time zone NOT NULL,
    "extraData" json
);

-- Indexes
CREATE INDEX "serverpod_auth_idp_rate_limited_request_attempt_composite" ON "serverpod_auth_idp_rate_limited_request_attempt" USING btree ("domain", "source", "key", "attemptedAt");

--
-- Class SecretChallenge as table serverpod_auth_idp_secret_challenge
--
CREATE TABLE "serverpod_auth_idp_secret_challenge" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "challengeCodeHash" text NOT NULL
);

--
-- Class RefreshToken as table serverpod_auth_core_jwt_refresh_token
--
CREATE TABLE "serverpod_auth_core_jwt_refresh_token" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "scopeNames" json NOT NULL,
    "extraClaims" text,
    "method" text NOT NULL,
    "fixedSecret" bytea NOT NULL,
    "rotatingSecretHash" text NOT NULL,
    "lastUpdatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "serverpod_auth_core_jwt_refresh_token_last_updated_at" ON "serverpod_auth_core_jwt_refresh_token" USING btree ("lastUpdatedAt");

--
-- Class UserProfile as table serverpod_auth_core_profile
--
CREATE TABLE "serverpod_auth_core_profile" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "userName" text,
    "fullName" text,
    "email" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "imageId" uuid
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_profile_user_profile_email_auth_user_id" ON "serverpod_auth_core_profile" USING btree ("authUserId");

--
-- Class UserProfileImage as table serverpod_auth_core_profile_image
--
CREATE TABLE "serverpod_auth_core_profile_image" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "userProfileId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "url" text NOT NULL
);

--
-- Class ServerSideSession as table serverpod_auth_core_session
--
CREATE TABLE "serverpod_auth_core_session" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "scopeNames" json NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "lastUsedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expiresAt" timestamp without time zone,
    "expireAfterUnusedFor" bigint,
    "sessionKeyHash" bytea NOT NULL,
    "sessionKeySalt" bytea NOT NULL,
    "method" text NOT NULL
);

--
-- Class AuthUser as table serverpod_auth_core_user
--
CREATE TABLE "serverpod_auth_core_user" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "createdAt" timestamp without time zone NOT NULL,
    "scopeNames" json NOT NULL,
    "blocked" boolean NOT NULL
);

--
-- Foreign relations for "serverpod_future_call_claim" table
--
ALTER TABLE ONLY "serverpod_future_call_claim"
    ADD CONSTRAINT "serverpod_future_call_claim_fk_0"
    FOREIGN KEY("futureCallId")
    REFERENCES "serverpod_future_call"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_log" table
--
ALTER TABLE ONLY "serverpod_log"
    ADD CONSTRAINT "serverpod_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_message_log" table
--
ALTER TABLE ONLY "serverpod_message_log"
    ADD CONSTRAINT "serverpod_message_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_query_log" table
--
ALTER TABLE ONLY "serverpod_query_log"
    ADD CONSTRAINT "serverpod_query_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_anonymous_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_anonymous_account"
    ADD CONSTRAINT "serverpod_auth_idp_anonymous_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_apple_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_apple_account"
    ADD CONSTRAINT "serverpod_auth_idp_apple_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_email_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_email_account"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_email_account_password_reset_request" table
--
ALTER TABLE ONLY "serverpod_auth_idp_email_account_password_reset_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_password_reset_request_fk_0"
    FOREIGN KEY("emailAccountId")
    REFERENCES "serverpod_auth_idp_email_account"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "serverpod_auth_idp_email_account_password_reset_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_password_reset_request_fk_1"
    FOREIGN KEY("challengeId")
    REFERENCES "serverpod_auth_idp_secret_challenge"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "serverpod_auth_idp_email_account_password_reset_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_password_reset_request_fk_2"
    FOREIGN KEY("setPasswordChallengeId")
    REFERENCES "serverpod_auth_idp_secret_challenge"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_email_account_request" table
--
ALTER TABLE ONLY "serverpod_auth_idp_email_account_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_request_fk_0"
    FOREIGN KEY("challengeId")
    REFERENCES "serverpod_auth_idp_secret_challenge"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "serverpod_auth_idp_email_account_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_request_fk_1"
    FOREIGN KEY("createAccountChallengeId")
    REFERENCES "serverpod_auth_idp_secret_challenge"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_facebook_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_facebook_account"
    ADD CONSTRAINT "serverpod_auth_idp_facebook_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_firebase_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_firebase_account"
    ADD CONSTRAINT "serverpod_auth_idp_firebase_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_github_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_github_account"
    ADD CONSTRAINT "serverpod_auth_idp_github_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_google_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_google_account"
    ADD CONSTRAINT "serverpod_auth_idp_google_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_microsoft_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_microsoft_account"
    ADD CONSTRAINT "serverpod_auth_idp_microsoft_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_passkey_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_passkey_account"
    ADD CONSTRAINT "serverpod_auth_idp_passkey_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_core_jwt_refresh_token" table
--
ALTER TABLE ONLY "serverpod_auth_core_jwt_refresh_token"
    ADD CONSTRAINT "serverpod_auth_core_jwt_refresh_token_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_core_profile" table
--
ALTER TABLE ONLY "serverpod_auth_core_profile"
    ADD CONSTRAINT "serverpod_auth_core_profile_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "serverpod_auth_core_profile"
    ADD CONSTRAINT "serverpod_auth_core_profile_fk_1"
    FOREIGN KEY("imageId")
    REFERENCES "serverpod_auth_core_profile_image"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_core_profile_image" table
--
ALTER TABLE ONLY "serverpod_auth_core_profile_image"
    ADD CONSTRAINT "serverpod_auth_core_profile_image_fk_0"
    FOREIGN KEY("userProfileId")
    REFERENCES "serverpod_auth_core_profile"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_core_session" table
--
ALTER TABLE ONLY "serverpod_auth_core_session"
    ADD CONSTRAINT "serverpod_auth_core_session_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR hayer
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('hayer', '20260920164441959-upgrade-4-0', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260920164441959-upgrade-4-0', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260824182259319', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182259319', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260910193913364-string-rate-limit-keys', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260910193913364-string-rate-limit-keys', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260824182354731', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182354731', "timestamp" = now();


COMMIT;
-- Hayer schema additions that Serverpod's portable model definition cannot
-- represent. Keep this block in the latest definition for fresh databases.
CREATE EXTENSION IF NOT EXISTS postgis;
CREATE EXTENSION IF NOT EXISTS pg_trgm;

CREATE OR REPLACE FUNCTION hayer_discovery_rating(value jsonb)
RETURNS double precision
LANGUAGE plpgsql
IMMUTABLE STRICT PARALLEL SAFE
AS $$
DECLARE
  parsed numeric;
BEGIN
  IF jsonb_typeof(value) <> 'number' THEN
    RETURN NULL;
  END IF;
  parsed := (value #>> '{}')::numeric;
  IF parsed < 0 OR parsed > 5 THEN
    RETURN NULL;
  END IF;
  RETURN parsed::double precision;
END;
$$;

CREATE OR REPLACE FUNCTION hayer_discovery_review_count(value jsonb)
RETURNS bigint
LANGUAGE plpgsql
IMMUTABLE STRICT PARALLEL SAFE
AS $$
DECLARE
  parsed numeric;
BEGIN
  IF jsonb_typeof(value) <> 'number' THEN
    RETURN NULL;
  END IF;
  parsed := (value #>> '{}')::numeric;
  IF parsed < 0 OR parsed > 9223372036854775807 OR trunc(parsed) <> parsed THEN
    RETURN NULL;
  END IF;
  RETURN parsed::bigint;
END;
$$;

CREATE OR REPLACE FUNCTION hayer_discovery_price_level(value jsonb)
RETURNS smallint
LANGUAGE plpgsql
IMMUTABLE STRICT PARALLEL SAFE
AS $$
DECLARE
  parsed numeric;
BEGIN
  IF jsonb_typeof(value) <> 'number' THEN
    RETURN NULL;
  END IF;
  parsed := (value #>> '{}')::numeric;
  IF parsed < 1 OR parsed > 4 OR trunc(parsed) <> parsed THEN
    RETURN NULL;
  END IF;
  RETURN parsed::smallint;
END;
$$;

-- Mirrors DiscoveryTaxonomyService.normalizeAlias, for Discover type keys and
-- search text: Dart's String.trim, then
-- toLowerCase, then collapsing RegExp(r'\s+') to one space. The classes are
-- spelled out because PostgreSQL's \s and btrim depend on the C library and
-- skip no-break spaces; U+0085 is trimmed at the ends but kept inside, as in
-- Dart.
CREATE OR REPLACE FUNCTION hayer_discovery_normalize(value text)
RETURNS text
LANGUAGE sql
IMMUTABLE STRICT PARALLEL SAFE
AS $$
  SELECT regexp_replace(
    lower(regexp_replace(
      value,
      '^[\u0009-\u000d\u0020\u0085\u00a0\u1680\u2000-\u200a\u2028\u2029\u202f\u205f\u3000\ufeff]+|[\u0009-\u000d\u0020\u0085\u00a0\u1680\u2000-\u200a\u2028\u2029\u202f\u205f\u3000\ufeff]+$',
      '',
      'g'
    )),
    '[\u0009-\u000d\u0020\u00a0\u1680\u2000-\u200a\u2028\u2029\u202f\u205f\u3000\ufeff]+',
    ' ',
    'g'
  )
$$;

-- Folds validated weekly opening periods into week minutes, where Monday
-- 00:00 is 0 and the week has 10,080, using PlaceAvailability.isOpenDuring's
-- overnight rule and its Sunday-to-Monday spill. Null means no valid period:
-- an hours filter fails and Open now is unknown.
CREATE OR REPLACE FUNCTION hayer_discovery_opening_hours(hours jsonb)
RETURNS int4multirange
LANGUAGE plpgsql
IMMUTABLE STRICT PARALLEL SAFE
AS $$
DECLARE
  period jsonb;
  day_number numeric;
  open_minute numeric;
  close_minute numeric;
  day_start integer;
  ranges int4range[] := ARRAY[]::int4range[];
BEGIN
  IF jsonb_typeof(hours) <> 'array' THEN
    RETURN NULL;
  END IF;
  FOR period IN SELECT value FROM jsonb_array_elements(hours) LOOP
    CONTINUE WHEN jsonb_typeof(period) <> 'object'
      OR jsonb_typeof(period -> 'day') IS DISTINCT FROM 'number'
      OR jsonb_typeof(period -> 'openMinutes') IS DISTINCT FROM 'number'
      OR jsonb_typeof(period -> 'closeMinutes') IS DISTINCT FROM 'number'
      OR jsonb_typeof(period -> 'overnight') IS DISTINCT FROM 'boolean';
    day_number := (period ->> 'day')::numeric;
    open_minute := (period ->> 'openMinutes')::numeric;
    close_minute := (period ->> 'closeMinutes')::numeric;
    CONTINUE WHEN day_number < 1 OR day_number > 7
      OR trunc(day_number) <> day_number
      OR open_minute < 0 OR open_minute > 1439
      OR trunc(open_minute) <> open_minute
      OR close_minute < 0 OR close_minute > 1440
      OR trunc(close_minute) <> close_minute;
    day_start := (day_number::integer - 1) * 1440;
    IF (period ->> 'overnight')::boolean
      OR (close_minute <= open_minute AND close_minute <> 1440) THEN
      ranges := ranges || int4range(day_start + open_minute::integer, day_start + 1440);
      ranges := ranges || CASE
        WHEN day_number = 7 THEN int4range(0, close_minute::integer)
        ELSE int4range(day_start + 1440, day_start + 1440 + close_minute::integer)
      END;
    ELSE
      ranges := ranges || int4range(
        day_start + open_minute::integer,
        day_start + close_minute::integer
      );
    END IF;
  END LOOP;
  IF cardinality(ranges) = 0 THEN
    RETURN NULL;
  END IF;
  RETURN int4multirange(VARIADIC ranges);
END;
$$;

ALTER TABLE "hayer_poi_catalog"
  ADD COLUMN IF NOT EXISTS "location" geography(Point, 4326)
  GENERATED ALWAYS AS (
    ST_SetSRID(ST_MakePoint("longitude", "latitude"), 4326)::geography
  ) STORED,
  ADD COLUMN IF NOT EXISTS "catalogId" bigint GENERATED BY DEFAULT AS IDENTITY,
  ADD COLUMN IF NOT EXISTS "rating" double precision GENERATED ALWAYS AS (
    hayer_discovery_rating("snapshot"::jsonb -> 'rating')
  ) STORED,
  ADD COLUMN IF NOT EXISTS "review_count" bigint GENERATED ALWAYS AS (
    hayer_discovery_review_count("snapshot"::jsonb -> 'reviewCount')
  ) STORED,
  ADD COLUMN IF NOT EXISTS "price_level" smallint GENERATED ALWAYS AS (
    hayer_discovery_price_level("snapshot"::jsonb -> 'priceLevel')
  ) STORED,
  ADD COLUMN IF NOT EXISTS "primary_type" text GENERATED ALWAYS AS (
    CASE
      WHEN jsonb_typeof("snapshot"::jsonb -> 'primaryType') = 'string'
        AND length(btrim("snapshot"::jsonb ->> 'primaryType')) BETWEEN 1 AND 200
      THEN btrim("snapshot"::jsonb ->> 'primaryType')
      ELSE NULL
    END
  ) STORED,
  ADD COLUMN IF NOT EXISTS "primary_type_key" text GENERATED ALWAYS AS (
    CASE
      WHEN jsonb_typeof("snapshot"::jsonb -> 'primaryType') = 'string'
        AND length(btrim("snapshot"::jsonb ->> 'primaryType')) BETWEEN 1 AND 200
      THEN hayer_discovery_normalize("snapshot"::jsonb ->> 'primaryType')
      ELSE NULL
    END
  ) STORED,
  ADD COLUMN IF NOT EXISTS "opening_hours" int4multirange GENERATED ALWAYS AS (
    hayer_discovery_opening_hours("snapshot"::jsonb -> 'hours')
  ) STORED,
  ADD COLUMN IF NOT EXISTS "lifecycle_status" text GENERATED ALWAYS AS (
    CASE
      WHEN lower(regexp_replace(btrim(COALESCE("snapshot"::jsonb ->> 'statusText', '')), '\s+', ' ', 'g')) LIKE '%permanently closed%'
        OR lower(regexp_replace(btrim(COALESCE("snapshot"::jsonb ->> 'statusText', '')), '\s+', ' ', 'g')) LIKE '%مغلق نهائي%'
        OR lower(regexp_replace(btrim(COALESCE("snapshot"::jsonb ->> 'statusText', '')), '\s+', ' ', 'g')) LIKE '%مغلق دائم%'
      THEN 'permanently_closed'
      WHEN lower(regexp_replace(btrim(COALESCE("snapshot"::jsonb ->> 'statusText', '')), '\s+', ' ', 'g')) LIKE '%temporarily closed%'
        OR lower(regexp_replace(btrim(COALESCE("snapshot"::jsonb ->> 'statusText', '')), '\s+', ' ', 'g')) LIKE '%مغلق مؤقت%'
      THEN 'temporarily_closed'
      ELSE 'unknown'
    END
  ) STORED,
  ADD COLUMN IF NOT EXISTS "completeness_mask" smallint GENERATED ALWAYS AS (
    (CASE WHEN jsonb_typeof("snapshot"::jsonb -> 'photoUrls') = 'array'
      AND jsonb_array_length("snapshot"::jsonb -> 'photoUrls') > 0 THEN 1 ELSE 0 END)
    + (CASE WHEN hayer_discovery_opening_hours("snapshot"::jsonb -> 'hours') IS NOT NULL
      THEN 2 ELSE 0 END)
    + (CASE WHEN jsonb_typeof("snapshot"::jsonb -> 'phoneNumber') = 'string'
      AND length(btrim("snapshot"::jsonb ->> 'phoneNumber')) > 0 THEN 4 ELSE 0 END)
    + (CASE WHEN jsonb_typeof("snapshot"::jsonb -> 'websiteUrl') = 'string'
      AND length(btrim("snapshot"::jsonb ->> 'websiteUrl')) > 0 THEN 8 ELSE 0 END)
    + (CASE WHEN hayer_discovery_price_level("snapshot"::jsonb -> 'priceLevel') IS NOT NULL
      THEN 16 ELSE 0 END)
    + (CASE WHEN jsonb_typeof("snapshot"::jsonb -> 'editorialSummary') = 'string'
      AND length(btrim("snapshot"::jsonb ->> 'editorialSummary')) > 0 THEN 32 ELSE 0 END)
  ) STORED,
  ADD COLUMN IF NOT EXISTS "search_text" text GENERATED ALWAYS AS (
    hayer_discovery_normalize("normalizedName" || ' ' || CASE
      WHEN jsonb_typeof("snapshot"::jsonb -> 'editorialSummary') = 'string'
      THEN "snapshot"::jsonb ->> 'editorialSummary' ELSE '' END)
  ) STORED;

ALTER TABLE "hayer_poi_coverage"
  ADD COLUMN IF NOT EXISTS "location" geography(Point, 4326)
  GENERATED ALWAYS AS (
    ST_SetSRID(ST_MakePoint("anchorLongitude", "anchorLatitude"), 4326)::geography
  ) STORED;

CREATE INDEX IF NOT EXISTS "hayer_poi_location_gist"
  ON "hayer_poi_catalog" USING gist ("location")
  WHERE "quarantinedAt" IS NULL;
CREATE INDEX IF NOT EXISTS "hayer_coverage_location_gist"
  ON "hayer_poi_coverage" USING gist ("location")
  WHERE "invalidatedAt" IS NULL;
CREATE INDEX IF NOT EXISTS "hayer_poi_categories_gin"
  ON "hayer_poi_catalog" USING gin (("categoryIds"::jsonb));
CREATE INDEX IF NOT EXISTS "hayer_poi_name_trgm"
  ON "hayer_poi_catalog" USING gin ("normalizedName" gin_trgm_ops)
  WHERE "quarantinedAt" IS NULL;
CREATE UNIQUE INDEX IF NOT EXISTS "hayer_poi_catalog_id"
  ON "hayer_poi_catalog" ("catalogId");
-- The recorded Discover plans never used single-column btrees on rating, review
-- count, price, type or first-seen time: every sort ranks the whole eligible
-- viewport. Those candidates are omitted to keep catalog upserts cheap; the
-- GiST location index and the trigram search index remain.
CREATE INDEX IF NOT EXISTS "hayer_discovery_search_trgm"
  ON "hayer_poi_catalog" USING gin ("search_text" gin_trgm_ops)
  WHERE "quarantinedAt" IS NULL;
CREATE INDEX IF NOT EXISTS "hayer_session_active_expiry"
  ON "hayer_session" ("expiresAt") WHERE "status" = 'active';
CREATE INDEX IF NOT EXISTS "hayer_refresh_pending_created"
  ON "hayer_refresh_job" ("createdAt") WHERE "status" = 'pending';
CREATE INDEX IF NOT EXISTS "hayer_analytics_event_unprocessed"
  ON "hayer_product_analytics_event" ("occurredAt")
  WHERE "processedAt" IS NULL;
CREATE UNIQUE INDEX IF NOT EXISTS "hayer_taxonomy_single_active"
  ON "hayer_taxonomy_version" ((1)) WHERE "status" = 'active';
CREATE UNIQUE INDEX IF NOT EXISTS "hayer_taxonomy_single_draft"
  ON "hayer_taxonomy_version" ((1)) WHERE "status" = 'draft';

ALTER TABLE "hayer_participant"
  ADD CONSTRAINT "hayer_participant_session_fk"
  FOREIGN KEY ("sessionId") REFERENCES "hayer_session" ("sessionId")
  ON DELETE CASCADE;
ALTER TABLE "hayer_session_place"
  ADD CONSTRAINT "hayer_session_place_session_fk"
  FOREIGN KEY ("sessionId") REFERENCES "hayer_session" ("sessionId")
  ON DELETE CASCADE;
ALTER TABLE "hayer_swipe"
  ADD CONSTRAINT "hayer_swipe_session_fk"
  FOREIGN KEY ("sessionId") REFERENCES "hayer_session" ("sessionId")
  ON DELETE CASCADE;
