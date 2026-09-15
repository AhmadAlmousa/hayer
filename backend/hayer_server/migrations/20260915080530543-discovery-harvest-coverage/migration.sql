BEGIN;

--
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION ALTER TABLE
--
ALTER TABLE "hayer_refresh_job" ADD COLUMN "heartbeatAt" timestamp without time zone;

-- One active harvest per canonical key, across server processes: the job
-- queue and the harvest record each enforce it.
CREATE UNIQUE INDEX "hayer_refresh_job_active_harvest"
  ON "hayer_refresh_job" ("coverageKey")
  WHERE "planJson" IS NOT NULL AND "status" IN ('pending', 'running');
CREATE UNIQUE INDEX "hayer_discovery_harvest_one_active"
  ON "hayer_discovery_harvest" ("harvestKey")
  WHERE "state" IN ('pending', 'running');
CREATE UNIQUE INDEX "hayer_discovery_manifest_one_active"
  ON "hayer_discovery_harvest_manifest" ((1)) WHERE "status" = 'active';
CREATE UNIQUE INDEX "hayer_discovery_manifest_one_draft"
  ON "hayer_discovery_harvest_manifest" ((1)) WHERE "status" = 'draft';

ALTER TABLE "hayer_discovery_harvest_manifest"
  ADD CONSTRAINT "hayer_discovery_manifest_values_valid"
  CHECK (
    length(trim("version")) BETWEEN 1 AND 120
    AND "revision" >= 1
    AND "status" IN ('draft', 'active', 'superseded')
    AND length(trim("createdBy")) BETWEEN 2 AND 80
  );
ALTER TABLE "hayer_discovery_harvest"
  ADD CONSTRAINT "hayer_discovery_harvest_values_valid"
  CHECK (
    "state" IN (
      'pending',
      'running',
      'succeeded',
      'partial',
      'failed',
      'cancelled'
    )
    AND "requester" IN ('user', 'administrator')
    AND "trigger" IN ('committedSearch', 'deepen')
    AND "radiusMeters" IN (1000, 2000, 5000, 10000)
    AND "south" < "north"
    AND "west" < "east"
    AND "manifestRevision" >= 1
    AND "attemptedQueries" >= 0
    AND "completedQueries" BETWEEN 0 AND "totalQueries"
    AND "observedPlaces" >= 0
    AND "upstreamRequests" >= 0
    AND ("completedAt" IS NULL OR "state" NOT IN ('pending', 'running'))
  );
ALTER TABLE "hayer_discovery_coverage"
  ADD CONSTRAINT "hayer_discovery_coverage_values_valid"
  CHECK (
    "radiusMeters" IN (1000, 2000, 5000, 10000)
    AND "south" < "north"
    AND "west" < "east"
    AND "manifestRevision" >= 1
  );
ALTER TABLE "hayer_discovery_type_observation"
  ADD CONSTRAINT "hayer_discovery_type_observation_values_valid"
  CHECK (
    length("typeKey") BETWEEN 1 AND 200
    AND "observationCount" >= 0
    AND "firstObservedAt" <= "lastObservedAt"
  );

-- Existing catalog places seed the type counts, one observation per place
-- dated by its first and last sighting. Writers add to them from here on.
INSERT INTO "hayer_discovery_type_observation" (
  "typeKey", "primaryType", "observationCount", "firstObservedAt",
  "lastObservedAt"
)
SELECT
  primary_type_key, max(primary_type), COUNT(*), min("firstSeenAt"),
  max("lastSeenAt")
FROM "hayer_poi_catalog"
WHERE primary_type_key IS NOT NULL AND primary_type_key <> ''
GROUP BY primary_type_key;


--
-- MIGRATION VERSION FOR hayer
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('hayer', '20260915080530543-discovery-harvest-coverage', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260915080530543-discovery-harvest-coverage', "timestamp" = now();

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
