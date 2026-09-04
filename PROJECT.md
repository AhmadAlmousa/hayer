# Hayer execution and progress tracker

Last updated: 2026-09-04

Status: beta implementation complete; environment and release verification in progress

Current focus: M7 — Docker/PostGIS deployment and multi-device beta proof

Product brief: [`overview.md`](overview.md)

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
- Use Flutter and Dart across the client, admin dashboard, and backend.
- Use Serverpod 3.4.13 in monolith mode with PostgreSQL/PostGIS and no Redis.
- Self-host on Unraid through Docker Compose. The existing external reverse
  proxy forwards `https://hayer.almou.sa` to gateway port `8432`.
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
- Rank by review count, then rating, then distance, then stable ID. Apply fair
  selected-category round robin, an exact radius, a maximum price cap, and no
  rating cutoff. Unknown price remains eligible.
- Exclude temporary and permanent closures. Current open state is
  informational. Search English first and Arabic only to fill shortages.
- Show source attribution on results and in full in the POI details sheet.
- Use a separate protected Flutter web cache dashboard with map, records,
  metrics, full guarded management, versioned calibration, and audit history.
- Use Material 3 Expressive behind Hayer-owned components, teal `#0E9594`,
  amber `#F5A623`, bundled Nunito, light/dark themes, reduced motion, and
  RTL-ready layouts.
- Defer the consumer embedded map, app attestation, accounts, behavioral
  analytics, full galleries/reviews, popular times, iOS, and consumer web/PWA
  until their roadmap milestones.

## Target architecture

```text
app/                         Flutter Android-first consumer application
admin/                       Protected Flutter web cache dashboard
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

The public gateway routes `/api/*` to the Serverpod API,
`/admin/cache/api/*` to the Basic-Auth-protected admin API,
`/admin/cache/*` to dashboard assets, and join/download/release/App-Link/media
paths to the Serverpod web service. Only port `8432` is exposed by Compose;
PostgreSQL and Insights stay internal.

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
  progress, and revision to members only.
- `sessions.recordSwipe(command)` is idempotent by session/user/place.
- `sessions.getResults(sessionId)` returns aggregate results without named
  individual votes.
- `sessions.watch(sessionId)` emits refresh hints. Clients poll every five
  seconds when streaming is unavailable.
- Admin endpoints expose metrics, catalog/coverage/job/audit pages, refresh,
  quarantine/restore, invalidation, pruning, settings changes, and calibration
  draft/validate/activate/rollback operations.

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

Catalog tables are `poi_catalog`, `poi_categories`, `poi_coverage`,
`poi_refresh_jobs`, `poi_calibrations`, `cache_settings`,
`admin_audit_log`, and hourly operational metric aggregates. Session tables
are `hayer_sessions`, `participants`, `session_places`, `swipes`,
`idempotency_keys`, and `rate_limits`.

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
- [x] Pin Flutter 3.44.2, Dart 3.12.2, Serverpod 3.4.13, generated code,
  fatal-info analysis, ignores, secret templates, and CI.
- [!] Prove RPC and WSS gateway-prefix routing on the Compose stack. Docker is
  unavailable in this development environment.

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
- [!] Run Saudi live canaries and `EXPLAIN ANALYZE` spatial-index proof against
  a migrated PostGIS database.

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
  web; native Android currently loads only allowlisted HTTPS source photos.
- [~] A generated Serverpod/PostGIS integration suite now covers concurrent
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
  against the deployed backend. Release signing works locally; the deployed
  runtime and physical-device proof remain outstanding.

Exit: a signed test build completes create, swipe, forced restart/resume, and
results against the backend.

### M5 — Multiplayer vertical `[!]`

- [x] Implement ambiguity-free six-character codes, links, QR sharing,
  camera scanning, App-Link join routing, and collision-bounded allocation.
- [x] Build lobby, participant progress, late join, live refresh/polling,
  swipe, completion, partial results, and result convergence flows.
- [!] Verify instant and after-deck majority/unanimous behavior with multiple
  physical clients, duplicate requests, disconnects, and newest/previous APKs.

Exit: two or more clients share the identical deck and converge on correct
results through duplicate requests and disconnects.

### M6 — Cache administration `[!]`

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
- [~] Add dedicated coverage/job/audit inspector pages, refresh-job execution
  and cancellation, manual prune controls, and KPI trend charts.
- [!] Verify nginx authentication, exact-origin/CSRF posture, auditing, and
  reversible mutations through the deployed gateway.

Exit: unauthorized access fails, mutations are reversible/audited, and broken
calibration cannot activate.

### M7 — Reliability and invited beta `[~]`

- [x] Implement offline swipe replay, missing-photo fallback, stale/underfill/
  source/expiry states, active-session resume, update-required download gate,
  action-level anonymous-authentication recovery after startup outages, and
  privacy-conscious diagnostics without behavioral analytics.
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
- [x] Pass fatal-info analysis, 28 backend unit tests, consumer/admin widget
  tests, shell syntax, and production web compilation for both Flutter apps.
- [x] Android debug and release compilation pass under the constrained
  2 GB/two-worker Gradle profile. The signed release build is staged with its
  SHA-256 checksum under `backend/deploy/releases/`.
- [!] Deploy Compose to Unraid; verify migrations, TLS/WSS/API prefixes, live
  extraction, App Links, backup restore, accessibility, performance, and
  newest/previous-build compatibility; then tag the invited beta.

Exit: an invited user installs from the Hayer domain and completes the full
solo and multiplayer flows without developer intervention.

### M8 — Post-beta roadmap `[ ]`

- [ ] Harden parser reliability and add app attestation.
- [ ] Certify each non-Saudi GCC calibration.
- [ ] Complete Arabic/RTL, iOS, and consumer web/PWA releases.
- [ ] Add the authenticated web photo proxy, then evaluate a consumer map and
  richer details from measured demand.
- [ ] Add Redis/horizontal Serverpod instances only when measurements require
  them.

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

## Operational defaults

- Session cleanup: every 15 minutes; authoritative expiry is also checked on
  every read and write.
- Backup: daily at 03:00 Asia/Riyadh, seven copies, restore drill before beta.
- Dynamic cache freshness: 72 hours; stale deck fallback: 30 days; retention:
  365 days.
- Dashboard changes are versioned, bounded, reasoned, confirmed, and audited.
- Admin mutations never rewrite an existing session snapshot.
- Native Android may load allowlisted source photos directly. Consumer web
  must use the authenticated bounded media proxy.
- The release keystore, production passwords, Basic Auth hash, IP-hash salt,
  database password, and signing material never enter Git.

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
  calibration rollout; job/audit inspector depth remains tracked in M6.
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
