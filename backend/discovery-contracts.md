# Discovery frontend handoff — contract v1

Delivered on 13 September 2026 for M9-B/C/D and the consumer part of M9-E;
amended on 14 September 2026 for the M9-G2 area handoff and M9-E's admin
contracts.
The generated `hayer_client` types are ready for frontend development with
`Fake implements Client` and endpoint doubles. The merged frontend prework is
on `main` (`d4b58b7`). Bring the frontend lane forward with
`git merge --ff-only main` before building on these contracts.

**Available now:** public `client.bootstrap.discoveryConfig()` returns a typed,
disabled configuration. Every other new RPC below returns
`ApiException(code: 'feature_disabled')` after its normal authentication or
admin authorization check. There is no discovery query, taxonomy seed, detail
refresh, catalog report write or harvest implementation yet. These are contract
deliveries, not completed M9-B/C/D/E checkpoints or permission to enable discovery.

The implementation requirements remain in [the plan](../discovery_upgrade.md).
Both modes must use the same Vela-derived non-API search adapter, cache-first
detail resolver and crowd-sourced backend POI catalog. Searches by more users
in new areas grow that shared catalog. Do not add a frontend scraper, official
Places API, per-mode cache or a dedicated Vela detail RPC: that RPC is not mapped.

## What Claude can build now

| Frontend checkpoint | Generated contract |
| --- | --- |
| M9-F config and retained disabled links | `bootstrap.discoveryConfig`, `DiscoveryConfig` |
| M9-G2 results and generations | `discover.browse`, `DiscoverQuery`, `DiscoverBrowsePage` |
| M9-G3 filter preview and category tree | `discover.facets`, `discover.taxonomy`, `DiscoverFacets`, `DiscoveryTaxonomyNode` |
| M9-G4 pins, unloaded selection, coverage | browse map payload, `placeContext`, `ensureArea`, `deepen`, `harvestStatus` |
| M9-H shared detail, context and reporting | `place.details`, `discover.placeContext`, `place.reportCatalogIssue` |
| M9-J admin surfaces | policy/tree/issue contracts plus the harvest manifest lifecycle, job inspection, unmapped types and growth metrics |

M9-E's admin contracts are now generated. Like the consumer coverage contracts,
their endpoint implementations remain dark until the storage and worker slice
lands.

## Configuration and disabled links

`DiscoveryConfig` contains `contractVersion`, `enabled`, `detailsAvailable`,
`policyRevision`, `taxonomyRevision`, `serverTime`, `expiresAt`,
`supportedCountries`, `scoring`, `limits`, `amenitiesAvailable` and
`reviewTextSearchAvailable`. It contains no operational harvest quotas.

The current response has contract version 1, revisions 0 and a five-minute
lifetime. Both availability flags are false. Its scoring values are provisional
display fixtures, not the selected launch policy: the Riyadh formula comparison
and Bayesian catalog mean still belong to implementation. Render explainers and
badges from the returned settings rather than hardcoding these values.

Fetch after startup, outside `_initialize`; cache for no longer than the
server-provided lifetime or five minutes. Revalidate on resume, foreground
expiry and before entering discovery. A missing endpoint on an older server,
an unsupported contract version, or an expired config that cannot be refreshed
means disabled. It must not slow or break Swipe startup.

Before redirecting a disabled discovery link to home, retain its validated,
canonical URL in local pending-link state. Preserve that state across restarts,
show the availability notice, and let Retry fetch fresh config and reopen the
saved URL only when enabled. A failed retry leaves the link available; clear it
after successful navigation or explicit dismissal. Apply the same rule if the
flag turns off while discovery is open. The backend has no client navigation
state and cannot recover a URL discarded by the router.

Public nginx now serves the Flutter entry document at both `/discover` and
`/app/discover`, retaining the query string and browser URL. The Flutter base
path remains `/app/`. This hosting change needs a rebuilt web/server image and
gateway recreation before live URLs work; it has not been deployed from this
checkout. Android App Links still require the existing certificate association.

## Query, paging and filters

Generated client calls (arguments shown as names, without the server's Session):

```dart
client.discover.taxonomy();
client.discover.browse(
  query: query, context: context, cursor: cursor,
  pageSize: 50, includeMap: true,
);
client.discover.facets(query: query, context: context);
client.discover.placeContext(identity: identity, query: query, context: context);
```

`pageSize` and `includeMap` are required by the generated Dart client even
though the server declares defaults. `context` and `cursor` are nullable for
browse; facets and placeContext require a context.

`DiscoverQuery` holds `viewport` (`south/west/north/east`), nullable
`countryCode`,
`sort`, `categoryIds`, `reviewBands`, nullable `exactPriceLevel` and
`minimumRating`, `hoursWindows`, `text` and `completeness`. Empty lists/text and
null scalar filters mean no restriction. Resolve the URL's optional viewport
to the app's area fallback before the call. Omit `countryCode`: the server
resolves it from the viewport and returns it in `DiscoverQueryContext`.
An older client may still send a country hint; the implementation must reject
a hint that does not match the resolved area with `unsupported_area`. It must
never infer the area country from the device's current location. Bounds must
be within supported coverage; the implementation will validate finite,
ordered coordinates and area limits.

Use the generated `DiscoverSort`, `DiscoverReviewBand`, `DiscoverHoursWindow`
and `DiscoverCompleteness` enums. They serialize **by name**. Their Dart names
match the frontend domain enum names, so map explicitly by `.name` using a
prefixed client import. URL spellings such as `top_rated`, `recent` and
`1000-plus` are a separate codec and must not be sent as wire enum values.
Map URL `priceLevel` to `exactPriceLevel` and the minimum-rating enum's numeric
value to `minimumRating`.

The first browse sends null context/cursor. Reuse its returned
`DiscoverQueryContext` (opaque `fingerprint`, resolved `countryCode`,
policy/taxonomy revisions and server `evaluatedAt`) for the matching facets,
later pages and place context.
It freezes hours evaluation for that generation, not the catalog contents.
Keep context and cursor out of share URLs. Reset from the first page on
`query_changed`, a changed revision, explicit Refresh or completed harvesting.
Deduplicate catalog ids across live pages and drop late responses from older
client generations.

For a filter-sheet draft, send the draft query to facets with the committed
context as the revision/evaluation-time base. Facets returns the draft query's
own fingerprint. Its implementation must accept a different query fingerprint
for this preview while rejecting stale policy/taxonomy revisions; pagination
and placeContext require the exact query context. Keep the preview separate
from committed results; applying the draft starts a fresh browse generation.
Budget `facets` separately from `browse`: a committed search makes one of each,
and an open filter sheet can make a facets request after each 400 ms editing
pause. An applied Open now filter also refreshes the first browse page once a
minute and whenever the app returns to the foreground.

Browse supplies `items`, `total`, `context`, `fetchedAt`, nullable `nextCursor`,
nullable `map` and `coverage`. Each `DiscoverPlace` includes the canonical
`catalogId`, provider, `PlaceSnapshot`, absolute one-based `ordinal`,
`firstSeenAt`, `hiddenGem` and nullable `openNow`. Use the browse total for the
page header and the facets total for the draft preview; separate calls may see
different live data. They are not a stored search snapshot.

Defaults are 50 rows, maximum 100, 50 category ids and 256 Unicode code points
of text, all available in config. Request the map initially; set
`includeMap: false` on ordinary pagination. A null map means omitted: retain
the generation's map. An explicit empty payload means clear it. Map mode is
`points` up to the configured 2,000 matches, otherwise `aggregates` with cell
bounds/counts. Only the matching mode's list is populated. Aggregate counts
sum to the browse total. Points have enough identity/location/rating fields
for markers; use placeContext for a selected point absent from loaded rows.

Filter semantics are OR within a group, AND across groups. Review bands are
`under50` = 1–49, `from50` = 50–99, `from100` = 100–249,
`from250` = 250–499, `from500` = 500–999 and `from1000` = 1,000+.
Unknown/zero reviews match no explicit band. Price is exact 1–4, not Swipe's
price ceiling. Unknown rating/price/hours remain unknown rather than zero.

Facets expose type counts, review-band counts, price counts, rating buckets,
minimum-rating counts and unknown-rating count. A group's distribution excludes
that group's selected filter while retaining other groups and sort eligibility,
as specified in plan §8. Rating buckets use `[minimumInclusive,
maximumExclusive)`; the final bucket must have an upper bound above 5 to
include five-star ratings. Use `minimumRatingCounts` for threshold-chip counts,
not approximations from buckets. Null price/type values represent unknowns.

The published taxonomy is a recursive bilingual tree with aliases on interior
nodes as well as leaves. `DiscoveryTypeCount.taxonomyNodeId` identifies the
node's own mapped count, not a pre-rolled branch total. Sum its own counts plus
descendants exactly once. Unmapped types use config's `otherCategoryId`.
Keep selected zero-count nodes and their ancestors visible. The existing Swipe
taxonomy endpoint, evidence categories and five-query limit are unchanged.
Publish must advance the taxonomy snapshot revision, configuration revision and
facets context revision together. `otherCategoryId` is a synthetic bucket and
must never equal a taxonomy node id. Empty roots mean unpublished; they do not
authorize clearing category ids retained from a shared link.

## Details, reporting and coverage

```dart
client.place.details(identity: identity, sessionId: optionalSessionId);
client.place.reportCatalogIssue(
  catalogId: catalogId, issueType: issueType, details: optionalDetails,
  idempotencyKey: stableRetryKey,
);
client.discover.ensureArea(viewport: viewport);
client.discover.deepen(
  viewport: viewport, idempotencyKey: stableRetryKey,
);
client.discover.harvestStatus(jobId: jobId);
```

`PoiIdentity` is the provider (currently `google-web`) plus `placeId` from the
snapshot. It is not a provider URL or free-form search. Render the existing
snapshot immediately while details loads. `PlaceDetailResult` returns the
snapshot, identity, stale flag, missing-field enums, refresh state, attempt/
success/retry timestamps and fetch time. During this contract rollout, retain
the existing Swipe detail presentation when the new method is unavailable.
Once implemented, `detailsAvailable` is independent of discovery's `enabled`:
turning discovery off must leave shared detail reads available to Swipe.

`DiscoverPlaceContext` supplies current eligibility, optional preview place,
optional one-based ordinal, total, nullable rating percentile, optional
population category id, distribution, context and fetch time. Percentiles are
0–100, based on other rated eligible places strictly below this rating; null
means no rating or no rated peers. Use a category label only when
`populationCategoryId` is supplied; otherwise say places. An ineligible result
has no rank/preview. This read never refreshes source details.

Catalog reporting returns the report id and accepts a server-issued catalog
id plus the existing `PoiIssueType`; keep the same idempotency key on retries.
It accepts no client snapshot and creates no synthetic Swipe session.
`AdminPoiIssue.source` and `sessionId` are additive nullable fields. A missing
source from an older response means session. Discovery-origin rows will have
source `discovery` and no session link when persistence is implemented.

Call `ensureArea` once per committed initial/shared-link area or Search this
area action, alongside browse. Do not call it for pagination/filter/sort
changes. Its eventual behavior is idempotent by canonical area and coverage.
Explicit Deepen uses an idempotency key. `DiscoveryAreaReceipt` returns
coverage, optional job/retry time and fetch time; coverage contains catalog
count, cell footprints, query-group completion and pending jobs. Poll the
returned job id; distinguish `succeeded`, `partial`, `failed` and `cancelled`.
Terminal success/partial results can refresh visible data without claiming the
area is complete. A job's observed-place count is not necessarily new inserts.

For the area bar, call `place.reverseGeocodeDetails` with the viewport centre.
It shares the existing reverse-geocoder cache, queue, rate limit and language
handling, and returns `formattedAddress`, nullable `locality`, `city`, `region`
and `countryCode`. Prefer locality, then city, for the short area label; do not
parse the formatted line by comma position. The existing string-returning
`place.reverseGeocode` remains available to older consumers.

## Admin and implementation boundaries

Admin methods are `discoveryTaxonomyDraft()`, `discoveryTaxonomyHistory()`,
`saveDiscoveryTaxonomyDraft(reason, version, revision, roots)`,
`validateDiscoveryTaxonomyDraft(reason, version, revision)`,
`publishDiscoveryTaxonomy(reason, version, revision)` and
`rollbackDiscoveryTaxonomy(reason, version, expectedActiveRevision)`.
Arguments in parentheses after the first two are named. Version/revision
values come from the server; retain them for optimistic concurrency.
Documents use the existing `TaxonomyStatus` enum (`draft`, `active`,
`superseded`), recursive roots and validation/audit timestamps.

The broad-query manifest has its own parallel lifecycle, separate from both
taxonomy editors:

```dart
client.admin.discoveryHarvestManifestDraft();
client.admin.discoveryHarvestManifestHistory();
client.admin.saveDiscoveryHarvestManifestDraft(
  reason: reason, version: version, revision: revision, entries: entries,
);
client.admin.validateDiscoveryHarvestManifestDraft(
  reason: reason, version: version, revision: revision,
);
client.admin.publishDiscoveryHarvestManifest(
  reason: reason, version: version, revision: revision,
);
client.admin.rollbackDiscoveryHarvestManifest(
  reason: reason, version: version,
  expectedActiveRevision: expectedActiveRevision,
);
```

`AdminDiscoveryHarvestManifestVersion` uses `DiscoveryManifestStatus` and holds
stable entries with an admin label, primary English query, reviewed Arabic
fallback, order and enabled state. Retain version/revision for optimistic
concurrency. All six lifecycle calls currently authorize and then return
`feature_disabled`; mocks can drive the editor until persistence lands.

The remaining reads are:

```dart
client.admin.discoveryHarvestJobs(
  page: page, pageSize: pageSize,
  query: query, state: state, requester: requester, trigger: trigger,
);
client.admin.discoveryUnmappedTypes(
  page: page, pageSize: pageSize, query: query, issue: issue,
);
client.admin.discoveryGrowthMetrics(from: from, to: to);
```

Harvest jobs distinguish `DiscoveryHarvestRequester.user` from
`.administrator` (Serverpod reserves `operator`), while trigger remains the
consumer event (`committedSearch` or `deepen`). Each row carries the actual
cell/footprint, radius, calibration and manifest revisions, the exact manifest
snapshot, attempted/completed totals, cooldown, and per-query broad versus
compatibility outcomes. Do not infer a successful full harvest from a terminal
job alone; use its state and query outcomes.

The unmapped-type page includes ambiguous aliases as a separate issue, since
both feed the synthetic Other count. Its direct map action should load the
existing Discover taxonomy draft and add the raw `primaryType` as an alias;
there is intentionally no second mapping mutation. Growth metrics report the
catalog row count at both window boundaries, additions, quarantine/removal,
cells, observations, cache hits/misses, detail refreshes and actual upstream
requests. Breakdowns use initiating `swipe`/`discovery` mode and
`browse`/`search`/`harvest`/`detailRefresh` operation. Derive cache-hit rate
from hits and misses rather than accepting an unscoped percentage.

`CachePolicy.discovery` contains `DiscoveryPolicy` (enabled, scoring, harvest
budgets/cooldown, user and read quotas, timeout and page/map caps).
`CachePolicy.detailRefresh` holds separate request/time/cooldown limits.
Both additions are nullable to preserve older clients' payloads. At this
stage, **any non-null new policy section is rejected with feature_disabled**,
before a write, rather than accepted and silently discarded. Existing policy
edits with null sections still work. Build the new controls with mocks until
the persisted policy implementation lands; then null means preserve settings.

No database schema changes accompany these contract commits. Persistent policy
fields, discovery taxonomy/manifest storage and seeds, generated catalog
columns, nullable `PoiIssueReportRow.sessionId` plus source backfill, refresh
metadata, unmapped-type aggregation, metrics, worker leases and harvest
coverage belong to their implementation migrations. Do not mark their
acceptance gates complete from DTO availability.

All new errors use the existing `ApiException` envelope and optional
`retryAfterSeconds`. Handle `feature_disabled` through the retained-link flow,
`query_changed` by restarting the generation, and `rate_limited` with a retry
wait. The implementation contract reserves `bad_request` for invalid filters,
`invalid_area` for invalid/oversized bounds, `unsupported_area` for unsupported
coverage and `not_found`/`forbidden` for identity/authorization failures.
Only `feature_disabled` and existing authentication/authorization failures
are currently exercised; the future query and provider behavior needs its own
PostGIS and cross-mode acceptance tests.
