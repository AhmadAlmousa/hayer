BEGIN;

--
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
    "processedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "hayer_analytics_event_id" ON "hayer_product_analytics_event" USING btree ("eventId");
CREATE INDEX "hayer_analytics_event_pending" ON "hayer_product_analytics_event" USING btree ("processedAt", "occurredAt");
CREATE INDEX "hayer_analytics_event_time" ON "hayer_product_analytics_event" USING btree ("occurredAt");
CREATE INDEX "hayer_analytics_event_unprocessed"
  ON "hayer_product_analytics_event" ("occurredAt")
  WHERE "processedAt" IS NULL;

--
-- ACTION CREATE TABLE
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
-- ACTION ALTER TABLE
--
ALTER TABLE "hayer_session" ADD COLUMN "cityKey" text;
ALTER TABLE "hayer_session" ADD COLUMN "cityName" text;
ALTER TABLE "hayer_session" ADD COLUMN "decisionAt" timestamp without time zone;
CREATE INDEX "hayer_session_created" ON "hayer_session" USING btree ("createdAt");
--
-- ACTION CREATE TABLE
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
CREATE UNIQUE INDEX "hayer_taxonomy_single_active"
  ON "hayer_taxonomy_version" ((1)) WHERE "status" = 'active';
CREATE UNIQUE INDEX "hayer_taxonomy_single_draft"
  ON "hayer_taxonomy_version" ((1)) WHERE "status" = 'draft';

-- Seed privacy-preserving hourly history from currently retained sessions.
-- Existing records predate city attribution, so they are deliberately grouped
-- into the Unknown city bucket instead of deriving or copying coordinates.
INSERT INTO "hayer_product_analytics_hour" (
  "aggregateKey", "bucketStartedAt", "metricName", "modeKey",
  "countryCode", "cityKey", "cityName", "categoryId", "taxonomyKind",
  "taxonomyId", "placeId", "placeName", "total", "sampleCount", "updatedAt"
)
SELECT
  md5(concat_ws(chr(31), 'backfill-session', date_trunc('hour', "createdAt")::text,
    "mode"::text, "countryCode", "categoryId")),
  date_trunc('hour', "createdAt"), 'session_created', "mode"::text,
  "countryCode", 'unknown', 'Unknown', "categoryId", '', '', '', '',
  count(*)::double precision, count(*)::bigint, now()
FROM "hayer_session"
GROUP BY date_trunc('hour', "createdAt"), "mode", "countryCode", "categoryId"
ON CONFLICT ("aggregateKey") DO NOTHING;

INSERT INTO "hayer_product_analytics_hour" (
  "aggregateKey", "bucketStartedAt", "metricName", "modeKey",
  "countryCode", "cityKey", "cityName", "categoryId", "taxonomyKind",
  "taxonomyId", "placeId", "placeName", "total", "sampleCount", "updatedAt"
)
SELECT
  md5(concat_ws(chr(31), 'backfill-exposure', date_trunc('hour', s."createdAt")::text,
    s."mode"::text, s."countryCode", s."categoryId", p."placeId",
    coalesce(p."snapshot"->>'name', ''))),
  date_trunc('hour', s."createdAt"), 'deck_exposure', s."mode"::text,
  s."countryCode", 'unknown', 'Unknown', s."categoryId", '', '', p."placeId",
  coalesce(p."snapshot"->>'name', ''), count(*)::double precision,
  count(*)::bigint, now()
FROM "hayer_session_place" p
JOIN "hayer_session" s ON s."sessionId" = p."sessionId"
GROUP BY date_trunc('hour', s."createdAt"), s."mode", s."countryCode",
  s."categoryId", p."placeId", coalesce(p."snapshot"->>'name', '')
ON CONFLICT ("aggregateKey") DO NOTHING;

INSERT INTO "hayer_product_analytics_hour" (
  "aggregateKey", "bucketStartedAt", "metricName", "modeKey",
  "countryCode", "cityKey", "cityName", "categoryId", "taxonomyKind",
  "taxonomyId", "placeId", "placeName", "total", "sampleCount", "updatedAt"
)
SELECT
  md5(concat_ws(chr(31), 'backfill-swipe', date_trunc('hour', w."serverReceivedAt")::text,
    CASE WHEN w."liked" THEN 'swipe_like' ELSE 'swipe_dislike' END,
    s."mode"::text, s."countryCode", s."categoryId", w."placeId",
    coalesce(p."snapshot"->>'name', ''))),
  date_trunc('hour', w."serverReceivedAt"),
  CASE WHEN w."liked" THEN 'swipe_like' ELSE 'swipe_dislike' END,
  s."mode"::text, s."countryCode", 'unknown', 'Unknown', s."categoryId", '', '',
  w."placeId", coalesce(p."snapshot"->>'name', ''), count(*)::double precision,
  count(*)::bigint, now()
FROM "hayer_swipe" w
JOIN "hayer_session" s ON s."sessionId" = w."sessionId"
LEFT JOIN "hayer_session_place" p
  ON p."sessionId" = w."sessionId" AND p."placeId" = w."placeId"
GROUP BY date_trunc('hour', w."serverReceivedAt"), w."liked", s."mode",
  s."countryCode", s."categoryId", w."placeId",
  coalesce(p."snapshot"->>'name', '')
ON CONFLICT ("aggregateKey") DO NOTHING;


--
-- MIGRATION VERSION FOR hayer
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('hayer', '20260905132740811-admin-analytics-taxonomy', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260905132740811-admin-analytics-taxonomy', "timestamp" = now();

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
