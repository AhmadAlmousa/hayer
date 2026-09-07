# Hayer execution and progress tracker

Last updated: 2026-09-06

Status: audit remediation active; invited-beta release remains blocked

Current focus: M7-A — core session integrity for audit release 0.2.0+6

Product brief: [`overview.md`](overview.md)

Production-readiness audit and remediation rationale: [`astra-audit.md`](astra-audit.md)

Git remote: `git@github.com:AhmadAlmousa/hayer.git`

## How to use this tracker

- `[ ]` is not started, `[~]` is active, `[x]` is verified, and `[!]` is
  blocked.
- Keep exactly one milestone active.
- Update this file in the same change as completed work.
- Check an item only after its exit condition passes, and add the relevant
  command, build, migration, or manual test to the evidence log.
- `overview.md` remains the product brief. This file is authoritative for the
  implementation choices made during planning.

## Required completion workflow

- Do not report a development task as finished until a release APK has been
  built successfully with `scripts/build-release-apk.sh`.
- If release signing or compilation is unavailable, keep the task explicitly
  blocked and report the missing prerequisite instead of substituting a debug
  APK.
- At the end of every completed task, stage the task's changes and create a Git
  commit with a clear summary and an explanatory commit message when useful.
- Record material implementation or verification decisions in this tracker's
  evidence or change log before committing.

## Locked decisions

- Release an Android-first, release-signed APK to an invited beta of at most
  50 people. Support at most 12 participants in a multiplayer session.
- Use `0.2.0+6` for the safety-focused audit release. Deploy compatible server
  changes first while build 5 remains accepted; set minimum build 6 only after
  the signed build passes production verification. Begin post-safety product
  and administration improvements at `0.2.1+7`.
- Use Flutter and Dart across the client, admin dashboard, and backend.
- Use Serverpod 3.4.13 in monolith mode with PostgreSQL/PostGIS and no Redis.
- Self-host on Unraid through Docker Compose. Cloudflare Tunnel publishes
  `https://hayer.almou.sa` through LAN-bound gateway port `8432`; no WAN port
  forward may expose the origin.
- Use anonymous identities, 24-hour sessions, late joins, case-insensitive
  participant names, durable swipe replay, and an immutable ordered deck.
- Support Saudi Arabia as the certified beta region. UAE, Kuwait, Qatar,
  Bahrain, and Oman are best effort and carry a visible warning.
- Use logged-out Google Maps web extraction modelled on Vela's behavior. Do
  not copy its GPL Kotlin source, and do not add a fallback POI provider.
- Build a shared provider-derived POI catalog. Freshness is 72 hours, failed
  refresh fallback is 30 days, and unseen catalog retention is 365 days.
  These values, two extractor attempts, and concurrency limits are editable
  and audited from the admin dashboard.
- Refresh stale coverage before serving. After both refresh attempts fail,
  use eligible cached places and hide stale dynamic fields.
- The current beta baseline ranks by review count, rating, distance, and stable
  ID. Treat this as versioned implementation behavior, not a permanent product
  decision. Preserve exact eligibility and fair selected-category handling;
  test a balanced ranker only after trustworthy impression/outcome telemetry
  exists. Unknown price remains eligible.
- Exclude temporary and permanent closures. Current open state is
  informational. Search English first and Arabic only to fill shortages.
- Show source attribution on results and in full in the POI details sheet.
- Use a protected Flutter web admin suite with anonymous product analytics,
  place insights, versioned taxonomy, cache/catalog controls, maps, guarded
  management, versioned calibration, and audit history.
- Protect routine admin access with WebAuthn passkeys and server-issued JWTs.
  Serve admin only at LAN/Tailscale `https://hayer.vpn.almou.sa/` through its
  dedicated Compose gateway port.
  Every admin RPC requires the `admin` scope plus that exact production origin.
  Public `/admin` paths return 404 and enrollment is disabled by default.
  Keep nginx Basic Auth only as an offline-held break-glass path for initial
  passkey enrollment and recovery; never store its password in Hayer.
- Retain anonymous product events for at most 14 days and privacy-preserving
  hourly aggregates for 12 months. Reports use Asia/Riyadh time and Sunday–
  Saturday weeks. Funnel work may use a random decision-journey ID bounded by
  raw-event retention; analytics never store authenticated user IDs, server
  session IDs, codes, names, addresses, precise coordinates, or persistent
  installation identifiers.
- Resolve session cities through Nominatim with a coarse roughly 1 km,
  30-day cache and an eight-second ceiling. Attribution failure never blocks
  session creation and is reported under a country-specific Unknown bucket.
- Version categories, cuisines, and POI types as a bilingual published
  taxonomy. Published IDs and kinds are immutable, retirement replaces
  deletion, and validation requires structural checks plus admin-selected
  address/map live canaries before audited publish or rollback.
- Use Material 3 Expressive behind Hayer-owned components, teal `#0E9594`,
  amber `#F5A623`, bundled Nunito, light/dark themes, reduced motion, and
  RTL-ready layouts.
- Defer the consumer embedded map, app attestation, accounts, identifiable or
  user-level analytics, full galleries/reviews, popular times, iOS, and
  consumer web/PWA until their roadmap milestones.
- Provider canaries report optional source capability and may gate activation
  of a new calibration, but cannot prevent the core API, cached sessions, or
  administration from starting. Treat the current provider cache as
  source-restricted; durable commercial exports require explicit provenance,
  retention, and field-use permission.

## Target architecture

```text
app/                         Flutter Android-first consumer application
admin/                       Protected Flutter web administration suite
backend/
  hayer_server/              Serverpod endpoints, domain, data, web routes
  hayer_client/              Generated shared Serverpod client and models
  deploy/                    Compose, gateway, backups and environment docs
references/Vela/             Pinned external GPL reference checkout
```

The consumer app uses feature-first UI with Riverpod view models and
repository interfaces. Platform/API/database operations stay in services;
business rules live in domain services and use cases. Drift is the local
source of truth for the active session snapshot and pending swipe outbox.

The host-aware gateway routes public `/api/*`, join/download/release/App-Link/
media paths to Serverpod and rejects public `/admin*`. A separate private
listener serves `hayer.vpn.almou.sa` admin routes from `/`, passkey/JWT RPCs
from `/api/`, and the normally disabled Basic-Auth `/enroll` route. Compose
binds public `8432` and private `8433` only to `192.168.225.20`; PostgreSQL and
Insights stay internal.

The backend is a JIT Dart process in production mode supervised by a Dart
source watcher. Code generation, analysis, tests, and migrations are explicit
preflight operations. A failed preflight must leave the previous process
running. Every deployed revision has a Git tag that can be restored.

## Shared contracts

Public generated Serverpod endpoint groups:

- `bootstrap.get(clientBuild, platform)` returns minimum supported build,
  flags, supported countries, taxonomy version, and configuration version.
- `places.suggestLocations(request)` starts at three characters, is called
  after a 350 ms debounce, and returns at most eight suggestions with
  coordinates.
- `sessions.create(request, idempotencyKey)` obtains POIs and transactionally
  persists the session, host, and complete ordered snapshot.
- `sessions.join(code, displayName, idempotencyKey)` is idempotent, enforces
  names case-insensitively, and permits late joins while active.
- `sessions.getBundle(sessionId)` returns the session, deck, participants,
  explicit authenticated participant/progress, and revision to members only.
- `sessions.recordSwipe(command)` is idempotent by session/user/place.
- `sessions.getResults(sessionId)` returns aggregate results without named
  individual votes.
- `sessions.watch(sessionId)` emits refresh hints. Clients poll every five
  seconds when streaming is unavailable.
- `taxonomy.current()` exposes the active display-only bilingual taxonomy;
  the consumer uses its bundled taxonomy when that endpoint is unavailable.
- Admin endpoints expose live and historical product analytics, place vote
  rankings, taxonomy draft/validate/publish/rollback, location canaries,
  metrics, catalog/coverage/job/audit pages, refresh, quarantine/restore,
  invalidation, pruning, settings changes, and calibration rollout.
- `passkeyIdp.createChallenge/login` performs WebAuthn authentication;
  `adminEnrollment.begin` is reachable only through the Basic-Auth recovery
  route and issues enrollment scope only; `adminAuth.currentOperator/logout`
  validates or revokes the passkey-backed admin session.

Stable error codes are `invalid_request`, `invalid_code`, `name_taken`,
`session_full`, `session_expired`, `no_places`, `place_source_unavailable`,
`rate_limited`, `unauthorized`, and `update_required`.

Place snapshots include provider-neutral identity, all matched Hayer labels,
coordinates/distance, short and full address, rating/reviews, original and
derived price, structured weekly hours, open status, phone, validated website,
source map URL, up to three allowlisted photo URLs, optional editorial summary
and featured review, attribution, source check time, and stale status. Session
snapshots never change after creation.

## POI catalog and acquisition

Catalog and administration tables include `poi_catalog`, `poi_categories`,
`poi_coverage`, `poi_refresh_jobs`, `poi_calibrations`, `cache_settings`,
`admin_audit_log`, `taxonomy_versions`, the coarse city-resolution cache, and
hourly operational/product aggregates. Session tables are `hayer_sessions`,
`participants`, `session_places`, `swipes`, `idempotency_keys`, and
`rate_limits`.

- Store POI coordinates as `geography(Point,4326)` with a GiST index.
- Use composite/partial indexes for active/fresh lookups, index every foreign
  key, use atomic UPSERTs, and keep network work outside transactions.
- Snap anchors to a radius-relative coverage grid. Expand the provider
  viewport to cover the grid cell, then apply the user's exact PostGIS radius.
- A fresh, sufficient catalog/coverage hit skips extraction. Missing, stale,
  or underfilled coverage is refreshed before serving.
- Warm one logged-out cookie session, use browser-like headers, and issue the
  calibrated `tbm=map` request with `hl=en`, inferred `gl`, natural language
  query, and `pb` viewport.
- Fetch offset 0 first, and offsets 20/40 concurrently only when the page is
  nearly full and more candidates are needed. Run at most three selected
  queries concurrently and stop once the deck can be filled.
- Strip the XSSI prefix and safely traverse positional JSON through a
  versioned calibration document. Reject consent redirects, bot-degraded or
  oversized responses, invalid hosts, and parser drift.
- Check Vela's signed calibration feed at startup and hourly. Project only the
  search endpoint/template and positional paths Hayer consumes, ignore
  irrelevant upstream changes, and auto-activate only after the Riyadh canary.
- Require stable identity, name, latitude, and longitude. Deduplicate by
  feature ID, provider place ID, then normalized name and rounded coordinates.
- On successful extraction, batch-upsert normalized records and coverage.
  Coalesce concurrent work by coverage key.
- When two refresh attempts fail, use records seen within 30 days. Hide
  open-now/next-hours, rating, price, phone, and featured review when their
  dynamic freshness exceeds 72 hours. Show the host a freshness warning.
- Return a smaller strict deck if some candidates remain. Return `no_places`
  only after a successful zero-result search and `place_source_unavailable`
  when an outage plus insufficient cache caused zero.
- Prune catalog rows unseen for 365 days and not required by any immutable
  session snapshot. Dashboard removal quarantines first.

Default source budget is 30 HTTP requests/minute with burst six, two attempts,
three concurrent selected queries, a bounded response size, and a 30-second
session-creation deadline. Cache policy validation enforces
`freshness <= fallback age <= retention`.

## Milestone tracker

### M0 — Repository and foundation `[!]`

- [x] Study the product brief and pin all product/technical decisions.
- [x] Create this canonical `PROJECT.md` tracker.
- [x] Initialize Git on `main` and configure
  `git@github.com:AhmadAlmousa/hayer.git`.
- [x] Preserve Vela at commit `02f72339347f8a20875256abe29934463d8bc34a`
  as a submodule/reference boundary.
- [x] Scaffold the Flutter consumer, Flutter admin, Serverpod server/client,
  root Dart workspace, and deployment directories.
- [x] Pin Flutter 3.47.2, Dart 3.13.2, Serverpod 3.4.13, generated code,
  fatal-info analysis, ignores, secret templates, and CI.
- [x] Prove RPC and WSS gateway-prefix routing through the deployed Compose
  stack. The public API is healthy and `/api/websocket` returns a successful
  HTTP 101 upgrade through nginx and the external TLS proxy.
- [!] Run a fresh-clone bootstrap and a green full CI workflow. CI is
  manual-only, and the local development environment has no Docker runtime for
  its PostGIS integration job.

Exit: a fresh clone bootstraps, CI is green, and API plus streaming smoke tests
pass through the intended public gateway.

### M1 — Extractor and shared catalog `[!]`

- [x] Add PostGIS catalog, category evidence, coverage, calibration, policy,
  refresh-job, audit, and operational-metric migrations and indexes.
- [x] Implement the original Dart cookie session, calibrated `tbm=map`
  builder, safe positional parser, normalization, host/size checks, paging,
  deduplication, exact-radius/closure/price filters, ranking, and diversity.
- [~] Unit fixtures cover XSSI, list, focused, malformed/drift, price, hours,
  stale suppression, policy, taxonomy, and consensus. A full sanitized
  provider-response fixture corpus remains to be captured.
- [x] Implement PostGIS catalog-first lookup, process-level refresh
  coalescing, English/Arabic fallback, configurable attempts/concurrency,
  global token-bucket source limits, 30-second deadline, stale suppression,
  metrics, and scheduled retention.
- [x] Run the Riyadh live canary against the migrated production PostGIS
  database.
- [!] Capture `EXPLAIN ANALYZE` spatial-index proof against a representative
  migrated PostGIS database.

Exit: a Riyadh request makes a deterministic deck, a covered repeat is local,
drift fails safely, and spatial queries use their indexes.

### M2 — Server-authoritative sessions `[!]`

- [x] Add anonymous JWT-backed identity, compatibility bootstrap,
  update-required gating, endpoint rate limits, and secure client token
  storage.
- [x] Implement transactional session/participant/immutable-deck/swipe and
  idempotency persistence with database constraints and a 12-member limit.
- [x] Implement create, idempotent join, member-only load, durable swipe,
  aggregate results, authoritative expiry, cleanup, per-place majority and
  unanimous consensus, instant match, and after-deck completion.
- [x] Add private streaming refresh hints, five-second polling fallback,
  revision updates, location suggestions, join App Links, and download/static
  routes.
- [ ] Add the authenticated consumer-web photo proxy before enabling consumer
  web; this is deferred to M8 and does not block the Android beta. Native
  Android currently loads only allowlisted HTTPS source photos.
- [!] A generated Serverpod/PostGIS integration suite now covers concurrent
  create retries, immutable decks, late joins, private aggregate results,
  duplicate swipes, majority/unanimous convergence, and authoritative expiry.
  Its isolated database runner is wired into CI; a green containerized run is
  still required before this gate is verified.

Exit: integration tests prove identical decks, private votes, correct
consensus, late joins, retry safety, and expiry.

### M3 — Consumer foundation and design system `[!]`

- [x] Configure Riverpod, repositories, GoRouter/App Links, Drift swipe
  outbox/replay, secure anonymous identity, active-session restoration, and
  compatibility bootstrap.
- [x] Implement Hayer-owned Material 3 themes/components, bundled Nunito,
  teal/amber tokens, light/dark themes, English/Arabic localization, and
  responsive/RTL-aware shells.
- [x] Add Android location/camera/network permissions, application ID
  `sa.almou.hayer`, minimum SDK 26, external release signing configuration,
  and `assetlinks.json` materialization.
- [~] Widget smoke tests exist and pass. Preview/golden matrices for dark,
  large-text, narrow/wide, RTL, and reduced motion remain a release gate.

Exit: the shell restores identity/session after termination, and previews
pass in light, dark, large-text, narrow/wide, and RTL harnesses.

### M4 — Solo vertical `[!]`

- [x] Build category/subcategory, GPS/typed location, radius/price/deck, and
  solo/multiplayer setup steps.
- [x] Connect setup to catalog-backed creation with supported GCC bounds,
  underfill, stale, no-place, and temporary-source messaging.
- [x] Build optimistic photo-led swiping with `flutter_card_swiper`, durable
  native/browser replay, termination resume, results filtering/sorting, full
  details sheet, attribution, and phone/site/external-navigation handoff.
- [!] Complete a signed APK create → forced restart → resume → results test
  against the deployed backend. Signed build `0.1.0+4` is served from the
  production domain; the physical-device proof remains outstanding.

Exit: a signed test build completes create, swipe, forced restart/resume, and
results against the backend.

### M5 — Multiplayer vertical `[!]`

- [x] Implement `ABC-124` display/share codes backed by 17,576,000 canonical
  values, automatic input formatting, historical-code compatibility, links,
  QR sharing, camera scanning, App-Link routing, and collision-bounded allocation.
- [x] Build lobby, participant progress, late join, live refresh/polling,
  swipe, completion, partial results, and result convergence flows.
- [!] Verify instant and after-deck majority/unanimous behavior with multiple
  physical clients, duplicate requests, disconnects, and newest/previous APKs.

Exit: two or more clients share the identical deck and converge on correct
results through duplicate requests and disconnects.

### M6 — Administration `[!]`

- [x] Protect dashboard assets and RPCs behind nginx Basic Auth plus a
  constant-time server secret; require named operators/reasons and append
  mutation audits. Credentials are memory-only in the web client.
- [x] Implement 24-hour KPI summaries, catalog paging/search, an OpenFreeMap
  context map, quarantine visibility/actions, and a bounded versioned policy
  editor whose values drive runtime extraction/cache behavior.
- [x] Implement coverage invalidation/refresh request creation, reversible
  quarantine/restore, calibration schema validation plus Riyadh live canary,
  signed hourly Vela synchronization, automatic activation, runtime version
  selection, and rollback.
- [x] Add dedicated coverage/job/audit inspector pages, refresh-job execution
  and cancellation, snapshot-safe manual prune controls, and KPI trend charts.
- [x] Verify that the deployed dashboard and admin RPC route reject
  unauthenticated requests with HTTP 401.
- [x] Add an explicit exact-origin/CSRF posture at the protected gateway.
- [x] Move the complete admin surface to the LAN/Tailscale-only hostname,
  bind WebAuthn to its RP, reject public admin paths, and make recovery
  enrollment fail closed unless explicitly enabled.
- [x] Publish the private admin on a separate Compose port and mount its
  browser routes at the private origin root, with legacy private redirects.
- [x] Expand the cache console into grouped, deep-linkable Overview, Usage,
  Places, Taxonomy, Operations, and Governance areas. Add 30-second live KPIs,
  five-minute hourly analytics rollups, daily/weekly interactive trends,
  Riyadh-time peak heatmaps, city/category/mode filters, completion/match/
  decision/swipe-depth insights, setup and cache-quality breakdowns, and
  vote-total/rate place rankings with a minimum-sample control.
- [x] Add privacy-bounded event capture, 12-month aggregates, retained-session
  backfill, coarse non-blocking city attribution, and versioned bilingual
  category/cuisine/POI-type controls with retirement, selected-location live
  validation, audited publish/rollback, and consumer runtime adoption with a
  bundled fallback.
- [!] Deploy and verify exact-origin enforcement, auditing, and reversible
  mutations through the production gateway.

Exit: unauthorized access fails, mutations are reversible/audited, and broken
calibration cannot activate.

### M7 — Reliability and invited beta `[~]`

- [x] Implement offline swipe replay, missing-photo fallback, stale/underfill/
  source/expiry states, active-session resume, update-required download gate,
  action-level anonymous-authentication recovery after startup outages,
  privacy-conscious diagnostics, and anonymous aggregate product analytics.
- [x] Add the Unraid Compose topology, nginx gateway, native AOT runtime,
  health checks, migrations-on-start, daily 03:00 backups, seven-day
  retention, guarded restore, named-volume runtime credential initialization,
  cached image-built Flutter web apps, and Compose-native source/public
  canaries. Routine startup never rebuilds or pulls the local server image.
- [x] Add external release-keystore configuration, APK/checksum build script,
  download artifact staging, and certificate-derived `assetlinks.json`.
- [x] Make place-session warm-up retryable, preserve successful category
  results during partial source outages, stop unnecessary query batches, log
  sanitized source failures, distinguish client transport failures from source
  outages, and gate deployment on live source plus public RPC canaries.
- [x] Pass fatal-info analysis, 66 backend unit tests, 66 consumer tests, seven
  admin widget tests, shell syntax, and production web compilation for both
  Flutter apps. The PostGIS integration suite remains a separate gate.
- [x] Android debug and release compilation pass under the constrained
  2 GB/two-worker Gradle profile. The signed release build is staged with its
  SHA-256 checksum under `backend/deploy/releases/`.
- [x] Deploy Compose to Unraid and verify public TLS/API health, the WSS
  gateway prefix, App Links metadata, APK/checksum download, Basic Auth
  rejection, live Riyadh extraction, and creation of daily backups.
- [x] Add public auth/join/API rate limits, per-IP connection caps, trusted
  proxy address handling, private admin throttles, immutable container-image
  pins, and LAN-only origin binding.
- [!] Run the current-HEAD containerized integration/CI gates; verify current
  migrations, Cloudflare/NPM host separation, two private-host passkeys,
  closed WAN origin, backup restore, signed solo and multiplayer physical-
  device flows, accessibility, and performance; then tag the invited beta.

The checked items above record what was implemented before the production
audit. They do not override a later audit finding. The checkpoints below are
the authoritative remaining M7 execution order; keep only the current
checkpoint active and record commands plus manual evidence as each closes.

#### M7-A — Core session integrity `[~]`

- [x] Set the audit release target to `0.2.0+6`, advertise build 6 as latest,
  and retain minimum build 5 for the compatibility rollout.
- [~] Resolve F02/F03/F04 together: make heartbeat/expiry writes concurrency
  safe, return the authenticated participant explicitly, persist swipe
  commands before sending, serialize replay, preserve per-session order, and
  prevent a failed session or terminal command from blocking another.
- [ ] Prove crash-before-send, response-loss-after-commit, foreground/reconnect
  replay, identity/session terminal failure, concurrent browser writes, final
  offline swipe, and read-versus-swipe/expiry races. Do not advance the UI if
  local durability fails or show final results while the last command remains
  unacknowledged.

Exit: no read can revert progress; clients resume their own exact position;
every visible accepted/queued/rejected state has a durable and recoverable
meaning across Android and web.

#### M7-B — Security and governance boundaries `[ ]`

- [ ] Fix F01 at the real Serverpod endpoint path with a gateway-overwritten,
  trusted client-IP signal plus server method/user budgets; prove forged
  forwarding headers and direct-origin access cannot bypass it.
- [ ] Fix F13/F14/F20/F30: require passkey UP/UV, revoke issued admin/enrollment
  sessions, make compare-and-swap mutations atomic with audit records, and
  stop emitting recovery credentials to logs.
- [ ] Close F29/F35 with an in-product identity/location lifecycle explanation,
  a provider/source-use inventory, a named reviewer, and documented retention,
  attribution, outage, and commercial-use decisions.

Exit: onboarding cannot be exhausted through the shared proxy identity;
privileged ceremonies/revocation reject replay; mutations are atomic/audited;
privacy and provider assumptions have accountable acceptance evidence.

#### M7-C — Catalog and upstream correctness `[ ]`

- [ ] Fix F05/F06/F07 as one persistence/provenance contract: batch atomic
  upserts, retain query-specific category evidence, coalesce only equivalent
  searches, and apply each caller's exact radius/price/category policy before
  its deck is selected.
- [ ] Fix F08/F09 with bounded cancellation-aware provider admission, request/
  byte/time/concurrency ceilings, and one shared geocoder cache/rate budget.
- [ ] Fix F10/F21 by separating core readiness from optional source canaries
  and reporting live refresh, stale fallback, partial, failed, and cancelled
  outcomes truthfully.

Exit: overlapping refreshes do not collide or mislabel POIs; cancelled work
does not continue unbounded; a provider outage leaves cached/core operations
available; dashboards distinguish fresh data from fallback.

#### M7-D — Reproducible release and recovery `[ ]`

- [ ] Fix F11/F16/F28: build the native server from the committed lockfile,
  run required CI on pull requests and protected-branch changes, and verify the
  repository-controlled browser security policy through both gateways.
- [ ] Fix F15 before F12: prove checksum-portable, failure-atomic, off-host
  backup and secret recovery in an isolated restore, then separate migration,
  runtime, and backup database roles with least privilege.
- [ ] Fix F31/F32 by narrowing container capabilities/secret mounts, setting
  measured resource/log ceilings, and adding tested alerts for journey/API,
  provider, pool, job, analytics-lag, backup-age, and readiness failures.

Exit: a fresh production-like stack is reproducible, least-privileged,
observable, restorable, and rollback-capable without undocumented host state.

#### M7-E — Client, realtime, accessibility, and analytics integrity `[ ]`

- [ ] Fix F17–F19 with coalesced lightweight progress refresh, dependable
  stream retry/poll convergence, prompt startup shell, recoverable screen
  states, and GPS success independent of reverse-geocoder failure.
- [ ] Fix F22/F23 by using bounded SQL aggregation/query paths and attributing
  matches to the actual matched place under versioned metric definitions.
- [ ] Fix F24–F27 as one adaptive presentation pass: support at least 200%
  text where required, semantics/reduced motion, lazy variable-height results,
  and localized distance language that does not invent travel-time precision.

Exit: two-device state converges after stream/network failures; setup remains
recoverable; core journeys work at large text/RTL/reduced motion; analytics
remain bounded and semantically correct.

#### M7-F — Safety release `0.2.0+6` `[ ]`

- [ ] Deploy additive server/database changes first while builds 5 and 6 are
  accepted. Verify old-client behavior before publishing the APK.
- [ ] Run full preflight, containerized PostGIS/gateway integration, isolated
  restore, signed solo and two-device offline/reconnect flows, current-device
  accessibility, and release-profile performance checks.
- [ ] Finalize truthful bilingual `0.2.0` release notes, build and stage the
  signed APK/checksum, verify it through the production domain, then raise
  `minimumBuild` to 6 in a separate reversible deployment and create the beta
  tag.

Exit: invited users can install build 6 and complete the core decision flow;
build 5 is rejected only after build 6 and rollback evidence are verified.

#### M7-G — Decision intelligence (`0.2.1+7`) `[ ]`

- [ ] Implement G02 with correctly named deck inclusions, measured/deduplicated
  card impressions, short-lived random journey linkage, explicit-choice and
  no-match outcomes, schema/version metadata, and no persistent installation
  identity.
- [ ] Implement P01/P03/P04: shared place details before voting, an authorized
  explicit final destination choice, truthful no-match causes, and a short
  immutable runoff/new-round recovery path that never silently relaxes hard
  constraints.

Exit: the product and dashboard distinguish inclusion, human impression,
preference, voting completion, declared choice, no-match, and technical failure.

#### M7-H — Return value and POI feedback `[ ]`

- [ ] Implement P05 as private local-first saved/favorite lists and reusable
  shortlists; preserve notes locally unless a user explicitly shares them.
- [ ] Implement P06 as structured, rate-limited POI issue reporting with
  reversible moderation, source corroboration, ownership, resolution state,
  and an audit trail. Never convert one anonymous report directly into a
  closure or catalog fact.

Exit: users can reuse prior candidates, and operators can resolve factual POI
problems without conflating a dislike with bad source data.

#### M7-I — POI and recommendation foundation `[ ]`

- [ ] Implement G01/G04 incrementally: retain permitted normalized discoveries
  separately from selected decks; add canonical Hayer identity, source mapping,
  field-group provenance/freshness, observation outcome, rights policy, and a
  rights-filtered export projection without turning raw cache payloads into an
  indefinite warehouse.
- [ ] Implement G03/P02 only after measured impressions/outcomes exist: preserve
  hard eligibility, add a versioned quality-confidence/distance/diversity
  ranker with stable room-level assignment, and compare it against the current
  baseline using declared-choice, no-match, latency, fairness, and exposure
  concentration guardrails.

Exit: the catalog can explain identity, source, freshness, permitted use, and
selection history; recommendation changes are measurable and reversible.

#### M7-J — Actionable administration `[ ]`

- [ ] Add decision health, host/guest funnels, POI quality/freshness, demand
  versus usable supply, and incident/extractor views with explicit periods,
  denominators, sample sizes, lag, source type, version overlays, and links to
  the next operator action.
- [ ] Add source/rights governance, moderation ownership, measurement-health,
  alert acknowledgement/resolution, and controlled aggregate export manifests.
  Suppress unsafe small cohorts; journey IDs never become a retention identity.

Exit: an operator can distinguish product friction, application failure,
extractor drift, weak usable supply, and POI data defects, then take an audited
action from the responsible view.

Exit: the safety release is proven in invited use, and the selected product,
administration, recommendation, and provenance foundations ship with defined
measurements and rollback paths.

### M8 — Post-beta roadmap `[ ]`

- [ ] Harden parser reliability and add app attestation.
- [ ] Certify each non-Saudi GCC calibration.
- [ ] Complete Arabic/RTL release certification, a signed iOS release, and
  consumer web/PWA releases. Core Arabic/RTL support and an unsigned iOS build
  workflow already exist.
- [ ] Add the authenticated web photo proxy, then evaluate a consumer map,
  typed visit-fit fields, link/list import, on-demand galleries/popular times,
  and limited finalist routing only through separate feasibility, rights,
  identity, cost, and measured-demand gates (P07–P10).
- [ ] Add Redis/horizontal Serverpod instances only when measurements require
  them.
- [ ] Perform only the targeted F33 ownership/module extractions justified by
  stabilized behavior; replace the framework landing page under F34 when the
  public-web product and metadata strategy is ready.

## Verification gates

- Parser fixtures cover every calibrated field, XSSI, focused/list/empty,
  degraded response, host validation, and drift.
- Catalog tests cover fresh hit, refresh success, two failures with fallback,
  expired fallback, underfill, Arabic supplementation, spatial boundaries,
  deduplication, price, closures, hours, ranking, and category diversity.
- Persistence tests cover constraints, concurrent UPSERT/coalescing,
  idempotency, consensus, expiry, and pruning.
- Flutter tests cover view models, outbox replay, routing, gestures, forms,
  light/dark, narrow/wide, large text, RTL, missing fields, and reduced motion.
- Admin tests cover authentication, CSRF, audit, quarantine/rollback, settings
  validation, and calibration activation.
- Deployment tests cover HTTPS, WSS, the `/api` prefix, hidden internal ports,
  App Links, APK checksum, backup, and restore.
- Target fresh catalog creation p95 is at most 750 ms. A spatial candidate
  query against one million synthetic records targets p95 at most 250 ms.
  Source-backed creation has a 30-second hard deadline.
- The server supports the newest and previous APK protocols. Changes remain
  additive unless bootstrap forces an update-required screen.
- Logs never contain cookie values, auth tokens, raw precise user coordinates,
  or complete typed queries.
- Product analytics never contain authenticated user IDs, server session IDs,
  join codes, participant names, typed addresses, precise coordinates, or a
  persistent installation identity. A random decision-journey ID may link raw
  funnel events only within their maximum 14-day retention; hourly aggregates
  expire after 12 months.

## Operational defaults

- Session cleanup: every 15 minutes; authoritative expiry is also checked on
  every read and write.
- Backup: daily at 03:00 Asia/Riyadh, seven copies, restore drill before beta.
- Dynamic cache freshness: 72 hours; stale deck fallback: 30 days; retention:
  365 days.
- Dashboard changes are versioned, bounded, reasoned, confirmed, and audited.
- Admin historical analytics refresh every five minutes; live session and
  participant KPIs refresh every 30 seconds. Reporting uses Asia/Riyadh and
  Sunday–Saturday weeks.
- Public anonymous login and join are each limited to 10 requests/minute/IP;
  general API traffic is limited to 30 requests/second/IP and public streaming
  to 50 connections/IP. Enrollment is limited to three gateway requests/minute
  and six Serverpod starts/hour/operator while explicitly enabled.
- Admin mutations never rewrite an existing session snapshot.
- Native Android may load allowlisted source photos directly. Consumer web
  must use the authenticated bounded media proxy.
- The release keystore, production passwords, Basic Auth recovery hash,
  IP-hash salt, database password, passkey private keys, and signing material
  never enter Git. Passkey private keys and biometrics remain in the user's
  authenticator.

## Evidence log

- 2026-08-31: Git is initialized on `main`, tracking `origin/main` at
  `git@github.com:AhmadAlmousa/hayer.git`; Vela is clean at
  `02f72339347f8a20875256abe29934463d8bc34a`.
- 2026-08-31: `serverpod_cli 3.4.13` generated the server protocol, client,
  endpoint dispatch, and integration test tools successfully.
- 2026-08-31: `dart analyze --fatal-infos` passed for `hayer_server` and
  `hayer_client`; `flutter analyze --fatal-infos` passed for `app` and
  `admin`.
- 2026-08-31: `dart test test/unit` passed 12 tests; `flutter test` passed the
  consumer and admin widget tests.
- 2026-08-31: consumer production web build passed with base `/app/`; admin
  production web build passed with base `/admin/cache/`.
- 2026-08-31: Bash/sh syntax checks passed for preflight, deploy, APK release,
  backup, and restore scripts.
- 2026-08-31: after two shared Gradle daemons were killed under host memory
  pressure, the project was constrained to a 2 GB heap, 768 MB metaspace, two
  workers, and a non-persistent daemon. The retry passed and produced a 192 MB
  debug APK with SHA-256
  `4d43428b3d2bd338c72eb019366f037c7dfdc1c642d023449994bb472091253e`.
- 2026-08-31: Docker is unavailable in this agent environment. Compose,
  PostGIS migrations/integration tests, nginx API/WSS routing, provider live
  search, App Links, backup restore, and signed installation remain external
  verification gates rather than claimed passes.
- 2026-09-01: `scripts/preflight.sh` passed after making Flutter, Dart, and
  Serverpod resolution independent of the caller's interactive `PATH`; fatal-
  info analysis, 19 backend unit tests, five consumer tests, and the admin
  widget test passed.
- 2026-09-01: the live Riyadh place-deck canary passed with 10 strict in-radius
  results on calibration `hayer-google-web-18`. Deployment now runs the same
  canary against the newly built server image before replacing the live
  container, then verifies the bootstrap RPC through public DNS, TLS, and the
  `/api/` gateway route.
- 2026-09-01: the Pangolin VPS initially served Traefik's self-signed default
  certificate for `hayer.almou.sa`. After its public TLS configuration was
  corrected, certificate verification succeeded and `/api/` returned the Hayer
  health response through Pangolin/Newt to Unraid.
- 2026-09-01: authenticated consumer actions now recover an anonymous session
  after a startup network/TLS outage instead of relying on the login controller
  that suppresses its error. Focused auth/error tests, full consumer tests,
  fatal-info analysis, and Android debug compilation passed.
- 2026-09-01: the first authenticated production deck request exposed migration
  drift: the latest clean-database definition omitted the custom PostGIS
  `hayer_poi_catalog.location` column used by the indexed radius query. Added an
  idempotent forward migration plus matching clean-database DDL for both POI
  spatial columns, GiST/GIN/trigram/partial indexes, foreign keys, and domain
  checks. All 28 backend unit tests and backend analysis passed; Unraid
  applied migration `20260901083702427-spatial-schema-repair` successfully.
  Serverpod 3.4 then reported the deliberately unmanaged PostGIS objects as
  absent from its generated target model, so deployment documentation now
  distinguishes that expected integrity warning from a failed migration. The
  catalog lookup also retains its indexed path while falling back to an exact
  coordinate-based PostGIS query if an older database lacks `location`.
- 2026-09-01: Unraid deployment was simplified to one Compose invocation. The
  image now builds both Flutter web bundles, Compose runs source and public RPC
  canaries, and the sole published gateway port remains 8432.
- 2026-09-01: a clean Chrome reproduction isolated web deck creation failing
  locally before `/api/hayerSession`: the native Drift outbox was constructed
  without Drift's required web database assets. Web now uses a browser-safe
  secure-storage outbox while Android retains Drift. The consumer also moved
  to `flutter_card_swiper` 7.2.0 and gained explicit selected/unselected chip
  contrast. All 14 consumer tests, the Chrome-specific provider test, fatal-
  info analysis, the `/app/` release build, and Android debug compilation
  passed. A clean-browser smoke test against `https://hayer.almou.sa/api/`
  received HTTP 200 for authentication and deck creation and rendered card 1
  of a 20-place deck.
- 2026-09-02: added an isolated PostGIS integration suite for the
  server-authoritative session lifecycle and made it a required CI step.
  Concurrent first-use rate limiting and create-session idempotency now use
  conflict-safe inserts so duplicate requests serialize without leaking a
  database uniqueness failure. The full repository preflight passes after
  exporting the resolved Dart SDK path for Serverpod's child process: generated
  code, formatting, fatal-info analysis, 28 backend unit tests, 14 consumer
  tests, the admin widget test, script syntax, and diff checks all pass. The
  integration runtime awaits Docker or CI because this development environment
  has no container runtime or test database listener.
- 2026-09-02: added startup-plus-hourly synchronization of Vela's signed
  calibration. The backend verifies the pinned P-256 signature, projects only
  Hayer's 23 consumed paths over bundled defaults, rejects version replays,
  ignores irrelevant upstream changes, and auto-activates only after its Riyadh
  canary. All 46 backend unit tests, fatal-info analysis, and native server
  compilation pass; the new PostGIS activation/fallback tests await CI because
  Docker remains unavailable locally.
- 2026-09-04: `scripts/build-release-apk.sh` produced the signed 113.0 MB
  `hayer-0.1.0-1.apk` and staged the current `hayer.apk`. SHA-256:
  `b9335bf0875607636897e88016a30d22471ffd3c436a9bd8a24764f529d48590`.
- 2026-09-05: `scripts/preflight.sh` passed on `d79ac35`: Serverpod generation
  and formatting were current; fatal-info analysis passed for the server,
  generated client, consumer, and admin; 50 backend unit tests, 63 consumer
  tests, and the admin widget test passed; operational-script syntax and Git
  diff checks also passed. The containerized PostGIS integration suite is not
  part of this local preflight and remains unverified on the current revision.
- 2026-09-05: live public checks returned HTTP 200 from `/api/`, HTTP 101 from
  `/api/websocket`, a certificate fingerprint for `sa.almou.hayer` from
  `/.well-known/assetlinks.json`, and HTTP 401 from both protected admin
  routes without credentials. `/download/` redirected to the current APK.
- 2026-09-05: signed Android build `0.1.0+4` is staged and served as
  `hayer.apk`; the public checksum matches the local SHA-256
  `f1310ca113ea30a945fb5cdb6d8154df96ab32a976a510c9bd2392d0b66984f6`.
  Daily backup artifacts exist through 2026-09-05, but a restore drill remains
  outstanding.
- 2026-09-05: completed the local cache-dashboard operations surface with
  responsive coverage, refresh-job, and audit inspectors; cancellable refresh
  execution; immutable-snapshot-safe pruning; hourly KPI trends; and exact
  production-origin enforcement in nginx. `scripts/preflight.sh` passed with
  clean fatal-info analysis, 54 backend tests, 63 consumer tests, and four
  dashboard tests. The production admin web build passed at
  `/admin/cache/`. The signed `0.1.0+4` APK was rebuilt and staged with SHA-256
  `04153904339a408b87c604d9984cf4cc66701f5ba112b5694ec6b16d4312b1d8`.
  Containerized PostGIS tests and deployed mutation/origin verification remain
  external gates.
- 2026-09-05: expanded the console into the responsive Hayer admin suite with
  deep-linkable analytics, usage, place-insight, taxonomy, operations, and
  governance routes. Added anonymous event capture and five-minute hourly
  rollups, 12-month aggregate/14-day event retention, Riyadh daily and Sunday-
  weekly reporting, 30-second aggregate-only live usage, coarse non-blocking
  city attribution, vote-rate rankings, and bilingual versioned taxonomy with
  live location canaries, audited publish/rollback, and consumer fallback.
  `scripts/preflight.sh` passed Serverpod generation, formatting, fatal-info
  analysis, all 60 backend, 64 consumer, and four admin tests, script syntax,
  and Git diff checks. Production web builds passed at `/app/` and
  `/admin/cache/`. `scripts/build-release-apk.sh` produced and staged the signed
  100.1 MB `hayer-0.1.0-4.apk` with SHA-256
  `025f39828aaff09513f289a072c5636fbf756848c07ed1676d2e7e63818fd13f`.
  Applying the new PostGIS migration and validating populated production
  analytics through the protected gateway remain deployment gates.
- 2026-09-05: made `https://hayer.almou.sa/admin` the canonical protected
  admin entry point. nginx redirects `/admin` to the trailing-slash asset mount,
  serves RPCs at `/admin/api/`, and preserves `/admin/cache/...` bookmarks and
  request methods with 308 redirects. The Flutter bundle, Serverpod web route,
  runtime config, production image, CI, tests, and deployment documentation now
  share the `/admin/` base. A pre-deployment live check returned 404 at
  `/admin` and 401 at the old protected path, confirming that the new image is
  still required in production. `scripts/preflight.sh` passed all 60 backend,
  64 consumer, and four admin tests; the `/admin/` production web build and
  signed `hayer-0.1.0-4.apk` build passed. APK SHA-256:
  `025f39828aaff09513f289a072c5636fbf756848c07ed1676d2e7e63818fd13f`.
- 2026-09-05: replaced routine admin Basic Auth with a complete WebAuthn
  passkey flow. The Flutter admin now has guarded `/login` and `/enroll`
  routes, secure JWT restoration, operator identity, sign-out/revocation, and
  a self-hosted verified browser bridge. Serverpod registers
  `hayer.almou.sa` as the production relying party; all admin endpoints require
  `admin` scope and the nginx-set exact-origin marker. Hayer additionally
  validates WebAuthn client type/origin, rejects cross-origin ceremonies, and
  checks the authenticator RP hash. Basic Auth is confined to the separate
  enrollment page/API, which issues only `admin-enrollment` scope and revokes
  it after registration. Legacy empty credential/operator RPC parameters were
  removed from the generated contract.
- 2026-09-05: final `scripts/preflight.sh` passed Serverpod generation,
  formatting, fatal-info analysis, 63 backend tests, 64 consumer tests, six
  admin tests, script syntax, and diff checks. The `/admin/` Wasm production
  web build passed; its vendored passkey bridge passed `node --check` and
  matches upstream SHA-384
  `9495da6d52154e99599fc1aad2bafb1dc87129261a5657835db06a8850b0af9c09f5c4271d919dc7cf679d95fdc4771a`.
  `scripts/build-release-apk.sh` produced the signed 100.1 MB
  `hayer-0.1.0-4.apk` and stable `hayer.apk`, both with SHA-256
  `e4f8efd2a8e26a76378eba0215af69a132319c0f6d951596cde8df84f6302b93`.
  Building/deploying the new server image and completing the first live
  passkey ceremony remain production gates.
- 2026-09-05: `main` and `origin/main` both point to `d79ac35`. CI and the
  unsigned iOS build are manual-dispatch workflows, and no beta Git tag exists
  locally yet.
- 2026-09-06: verified public `hayer.almou.sa` resolves through Cloudflare and
  serves valid TLS/API traffic with Cloudflare edge headers. Verified private
  `hayer.vpn.almou.sa` resolves to NPM at `192.168.225.21`, terminates HTTPS,
  and reaches the current admin assets/API/enrollment routes. These checks
  prove both proxies are connected; the post-change 404/RP/rate/firewall
  behavior remains a deployment gate.
- 2026-09-06: upgraded the verified toolchain to Flutter 3.47.2/Dart 3.13.2.
  `scripts/preflight.sh` passed Serverpod generation, handwritten-source
  formatting, fatal-info analysis, all 66 backend, 66 consumer, and six admin
  tests, script syntax, and diff checks. Production Wasm builds passed at
  `/app/` and `/admin/`. `scripts/build-release-apk.sh` staged signed Android
  build `0.1.0+5` (100,907,926 bytes); `apksigner` verified its v2 signature
  and `aapt2` verified package `sa.almou.hayer`, version code 5, target SDK 36.
  APK SHA-256: `b1331f5005603c9d0fd9bad1e726033df37c1fc99d49f7750c4f9f9a89c65395`.
  Docker/nginx are unavailable in this development environment, so applying
  the new session-code migration and post-deployment gateway checks remain
  external gates.
- 2026-09-06: `scripts/preflight.sh` passed the split-port/root-mount revision:
  generated code, handwritten formatting, fatal-info analysis, 66 backend,
  66 consumer, and seven admin tests, script syntax, and diff checks all pass.
  The admin production Wasm build contains `<base href="/">` and the private
  root API URL. The required signed `0.1.0+5` APK rebuilt successfully at
  100,907,926 bytes; its v2 signature verifies and both stable/versioned files
  retain SHA-256
  `b1331f5005603c9d0fd9bad1e726033df37c1fc99d49f7750c4f9f9a89c65395`.
  nginx/Compose deployment and live `8432`/`8433` isolation remain external.
- 2026-09-06: live enrollment logs isolated a gateway redirect: the protected
  `adminEnrollment` RPC returned 200, then nginx redirected Serverpod's
  no-trailing-slash `POST /api/passkeyIdp` with 301 and Chrome followed it as a
  bodyless GET that returned 400. The private gateway now has an exact route
  that proxies that POST without redirecting, with regression coverage in the
  gateway access test. The full preflight passed 66 backend, 66 consumer, and
  seven admin tests. The required signed `0.1.0+5` APK rebuilt at 100.9 MB,
  verifies with APK Signature Scheme v2, and retains SHA-256
  `b1331f5005603c9d0fd9bad1e726033df37c1fc99d49f7750c4f9f9a89c65395`.
  Gateway recreation and a live passkey enrollment remain deployment checks.
- 2026-09-06: replaced the error-prone manual enrollment environment toggle
  with `scripts/admin-enrollment.sh reenroll`. The command applies one
  process-scoped value while recreating and verifying both Serverpod and the
  gateway, waits for the browser ceremonies, and closes enrollment on Enter or
  process exit. Explicit enable/disable/status actions remain available for
  troubleshooting, and both Compose defaults remain fail-closed.
  Full preflight passed 68 backend, 66 consumer, and seven admin tests,
  including an executed fake-Compose lifecycle test for the synchronized
  command, plus all static analysis and shell syntax checks. The signed
  `0.1.0+5` APK rebuilt, verifies
  with APK Signature Scheme v2, and retains SHA-256
  `b1331f5005603c9d0fd9bad1e726033df37c1fc99d49f7750c4f9f9a89c65395`.
  Running the new command against the production Docker host remains the live
  deployment check.
- 2026-09-07: adopted the generated question-pin/card logo as the consumer
  branding source and regenerated launcher assets with
  `flutter_launcher_icons` 0.14.4. Android now has legacy-density icons plus a
  white-backed adaptive foreground, and the complete iPhone/iPad AppIcon set
  is RGB with alpha removed on white. Existing configured web, Windows, and
  macOS icons were refreshed from the same canonical artwork. The generator's
  unintended rewrite of two unrelated iOS asset-symbol build settings was
  reverted before verification. The repository preflight passed (68 backend,
  66 consumer-app, and 7 admin tests, with clean analysis), and the signed
  Android `0.1.0+5` release targeting SDK 36 passed APK Signature Scheme v2
  verification. Both release aliases are 101,565,643 bytes with SHA-256
  `d45a18ecdc1f93b591cd31e26aa9a4948a9bac1e0044b08c5ab5ebf390039f44`.
- 2026-09-07: began M7-A on audit release `0.2.0+6`. Session reads now update
  only the presence column, expiration uses a locked column-scoped update, and
  every bundle identifies the authenticated participant explicitly. Swipe
  submission now persists before transport, serializes submission/replay,
  reuses the same idempotency key after uncertain delivery, isolates blocked
  sessions, records terminal rejection, migrates the Drift outbox to schema 2,
  and keeps an unacknowledged final swipe on a retryable sync screen. The full
  browser secure-storage read/modify/write behavior has regression coverage for
  concurrent writes and terminal-state recovery. The full preflight passed
  generated-code/format checks, fatal-info analysis, 68 backend tests, 72
  consumer tests, and seven admin tests. The new PostGIS concurrency
  test is present but remains unexecuted locally because Docker is unavailable;
  physical foreground/offline replay also remains an M7-A gate. The signed
  `0.2.0+6` APK is 101,598,575 bytes, targets SDK 36, and verifies with APK
  Signature Scheme v2. SHA-256:
  `d31ef2d5f3e1b2f15a25a9c33347ab8d7dacc45b601ebcf8e64e0dc1075df7e6`.

## Decision and change log

- 2026-08-31: Approved Serverpod-only backend instead of Supabase.
- 2026-08-31: Approved shared PostGIS POI catalog rather than a simple query
  response cache.
- 2026-09-01: Keep Drift for the Android swipe outbox and use secure browser
  storage for the web outbox; full web SQLite/Wasm adds deployment weight
  without improving this small sequential replay queue.
- 2026-08-31: Set 72-hour refresh, two attempts, 30-day guarded stale fallback,
  and 365-day retention, all dashboard-controllable.
- 2026-08-31: Added the protected Flutter web cache dashboard with map,
  audited quarantine-first management, bounded policy editing, and validated
  calibration rollout. Coverage/job/audit inspectors, refresh execution and
  cancellation, safe manual pruning, and KPI trends were completed on
  2026-09-05.
- 2026-08-31: Wired policy values into extraction retries/concurrency/global
  traffic limits, added identical-refresh coalescing and scheduled cleanup,
  and required a Riyadh live canary before calibration activation or rollback.
- 2026-09-02: Automatically adopt relevant signed Vela calibration changes
  after validation, checking at startup and once per hour; keep manual rollback
  and the last working calibration as the failure path.
- 2026-08-31: Added secure active-session restoration, bootstrap build gating,
  QR scanning, and full provider-neutral result details/navigation to the
  consumer app.
- 2026-09-04: Every completed development task must finish with a successful
  signed release APK build, a material verification/change-log entry when
  applicable, and a descriptive Git commit.
- 2026-09-05: Product analytics are anonymous by construction: no user/session
  identifiers or precise locations, bounded raw retention, and aggregate-only
  live counts. Categories, cuisines, and POI types share one bilingual,
  versioned taxonomy; clients adopt published versions at runtime and retain a
  bundled fallback. Admin areas use path-based routes so views are bookmarkable.
  Their original public `/admin/` mount was superseded on 2026-09-06 by the
  private `hayer.vpn.almou.sa` root; old private `/admin/*` paths redirect for
  compatibility.
- 2026-09-05: Replaced routine admin Basic Auth with discoverable WebAuthn
  passkeys verified by Serverpod. Admin data remains server-protected by JWT
  `admin` scope and exact-origin checks; the public `/admin/` shell contains no
  data. Basic Auth is retained only on private `/enroll` and `/enroll-api/`
  as break-glass enrollment/recovery. Its token carries
  enrollment scope only and is revoked after successful registration. This is
  server authentication rather than `local_auth`, which cannot authenticate a
  web administrator or prove identity to the backend.
- 2026-09-06: Adopt `ABC-124` session codes (canonical `ABC124`) with all
  letters/digits and a forced build-5 update, while accepting historical codes.
  Move WebAuthn and all admin routes to private `hayer.vpn.almou.sa`, keep
  enrollment off by default, and replace public reverse-proxy exposure with
  an outbound Cloudflare Tunnel plus LAN/Tailscale NPM split. Upgrade only the
  verified Flutter 3.47.2/Dart 3.13.2 and nginx 1.30.4 patch line; retain
  Serverpod/database/package majors. Container privilege/network separation
  remains a deliberately separate hardening change.
- 2026-09-06: Split the gateway by exposure: cloudflared retains LAN-bound
  `8432`, while NPM uses LAN-bound `8433`. Mount the admin at the private
  origin root with `/api/` RPCs and `/enroll` recovery; keep its Serverpod web
  files internally namespaced and redirect older private `/admin/*` bookmarks.
- 2026-09-06: Keep enrollment disabled in committed Compose defaults and use
  one interactive operator command for the complete re-enrollment window. The
  toggle is process-scoped, self-verifying, closes on exit, and leaves no global
  enrollment variable behind.
- 2026-09-07: Adopt the production audit as the M7 remediation baseline. Keep
  one active milestone with ordered M7-A through M7-J checkpoints. Target
  safety release `0.2.0+6`, retain build 5 during a server-first compatibility
  rollout, and raise the minimum only after signed build-6 production proof.
  Begin high-ROI decision/admin work at `0.2.1+7`. Funnel linkage is limited to
  a short-lived random journey ID; persistent installation cohorts remain
  deferred. Provider-derived cache records are not presumed commercially
  reusable without enforceable provenance and source-use permission.
