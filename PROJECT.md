# Hayer execution and progress tracker

Last updated: 2026-09-16

Status: audit remediation active; invited-beta release remains blocked

Current focus: M7-C — source-outage readiness and truthful refresh outcomes
(F10/F21). F08/F09 provider/geocoder bounds are implemented and locally
verified; production deployment remains pending. M7-A/M7-E/M7-F device and
live safety acceptance remain open.

## Beta acceptance review — 2026-09-13

The owner confirmed that Start swiping works after the legacy-calibration
repair in `39ab02a`; that production incident is closed. This is owner-reported
journey evidence, not an independently rerun authenticated canary or complete
solo/multiplayer acceptance. Invited-beta closure remains blocked.

The latest recorded automated run passed 151 server, 184 app and 51 admin
tests, plus all 44 tests against dedicated remote PostGIS. The signed
`0.2.1+7` APK built, its v2 signature verified, and its SHA-256 is
`84d10c9ab9120fc42c15a881930b2cdd62e745c0c7dc740c7fa8969e4e23ef61`.
Both F17 halves are merged.
Those results supersede older statements below that PostGIS tests could not
run; they do not establish gateway, restore, device or CI acceptance.

| Remaining gate | Evidence required to close it |
| --- | --- |
| Core journeys — M7-A/M7-E/M7-G | Signed-APK solo create → force-stop → resume → results; two-device majority/unanimous, editable choices and late joins; final offline swipe, lost acknowledgement and reconnect converge without lost or duplicate votes. Complete the remaining failure/race matrix. |
| Provider and catalog — M7-C | Deploy the verified F08/F09 provider/geocoder bounds, implement F10/F21 cached operation during source outage and truthful refresh outcomes, and record representative spatial query plans and response-fixture coverage. |
| Security and governance — M7-B | Real-gateway quota/forged-header/direct-origin checks; connector trust decision; supervised private-host passkey/revocation checks; owner-reviewed bilingual privacy notice, contact, source inventory, retention and identity cleanup decisions. |
| Release and recovery — M7-D/M7-F | Locked native image and enforced green CI; current migrations and gateway policies; isolated data/secret restore and rollback; least-privilege roles, resource limits and tested operational alerts. |
| Device quality and analytics — M7-E | TalkBack/focus, large native text, RTL, reduced motion, denied/approximate location, background recovery and release-profile performance. Complete bounded analytics query/aggregation work (F22); F23's actual-match attribution regression already passes. |
| Final release — M7-F | Reconcile the planned safety build 6 with the current build 7 artifact; verify the chosen APK/checksum, previous-client compatibility and rollback through production, then deliberately update the minimum build and create the beta tag. |

Next backend implementation: F10/F21. Physical-device
acceptance can proceed alongside it. This review does not change the locked
release/build policy or waive any gate. Discovery expansion remains separate
from closure of the current swipe beta.

Live handoff (2026-09-09): G02 is complete in commit `2d4b81d`; P05 is complete
in commit `da8e7ca`; P06 is complete in commit `a17567b`. Pinned full preflight
passes generation/formatting, all fatal-info analyses, 101 server tests, 123
app tests, nine admin tests, shell checks, and diff checks. Signed build
`0.2.1+7` passes both manifests, package/version
inspection, and v2 signature verification. New P05/P06 real-PostGIS cases
compile but cannot run because this host has no `docker` command. Next M7 work
is the open M7-A/M7-E/M7-F physical-device and live safety acceptance. Claude's
F01 signup work is separate; its join limiter is implemented and live gateway
proof remains open. Existing unrelated working-tree changes are being
preserved.

Team lanes after P06 (2026-09-09): Codex owns backend work and logs it in
`lane-backend.md`. Claude owns frontend work from `worktree-claude-lane` and
logs it in [`lane-frontend.md`](lane-frontend.md). Both lanes' post-`4c9520a`
work is merged into `main`; the lane branch continues from there. No new
frontend work should start in the main worktree after P06.

P06 completed handoff (2026-09-09; commit `a17567b`): Codex implemented the
POI-report protocol/storage, consumer details-sheet reporting flow, admin
moderation inbox, generated Serverpod artifacts/migration, tests, and P06
documentation. The boundary is an authenticated, idempotent report validated
against room membership and its
immutable deck, with hourly/daily budgets and one active report per
reporter/place/type. Reporter identity remains server-only and salted.
Operators can claim, release, resolve, dismiss, and
reopen reports with source evidence and append-only audit entries; recurrence
and affected-room counts are exposed without reporter identity. Quarantine is
a separate explicit, reversible operator action and is never a report-submit
side effect.

P06 implementation checkpoint (2026-09-09): the structured consumer sheet is
wired from swipe/results place details in English and Arabic; transient retries
reuse one key and neither raw report data nor reporter identity enters product
analytics. `place.reportIssue` enforces membership/deck provenance,
idempotency, salted report/idempotency correlation, transaction-scoped
concurrent deduplication, and six-per-hour plus 20-per-day budgets without
touching catalog quarantine. Migration `20260909025500100-poi-issue-reports`
adds lifecycle constraints and indexed queue/dedupe paths while preserving the
current definition's custom PostGIS DDL. The admin inbox exposes outcome
counts, recurrence, affected-room counts, source snapshots, ownership,
evidenced resolve/dismiss, release/reopen, and a separately labelled quarantine
action. Current verification: 101 server unit tests, 123 app tests, and nine
admin tests pass; fatal-info analysis passes for all three packages. The new
concurrent submission/moderation/flood real-Postgres cases analyze, but
`scripts/test-server-integration.sh` still stops immediately because `docker`
is not installed on this host. Pinned full preflight passes. The signed
`0.2.1+7` APK is 104,876,403 bytes at SHA-256
`0ac17018b52c8685eaa783836bb2c79da44ff1fe9ba1af5e35cf6c0a7da7de0f`;
both manifests, package/version metadata, and APK Signature Scheme v2 verify.

Product brief: [`overview.md`](overview.md)

Production-readiness audit and remediation rationale: [`astra-audit.md`](astra-audit.md)

Git remote: `git@github.com:AhmadAlmousa/hayer.git`

## How to use this tracker

- `[ ]` is not started, `[~]` is active, `[x]` is verified, and `[!]` is
  blocked.
- Keep exactly one milestone active. Exception: M9 runs alongside M7 by owner
  decision on 2026-09-13; M7 remains the invited-beta gate.
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

## Agent worktrees and role split

Two agents develop this repository in parallel. They never share a working
directory. Each commits from its own Git worktree and integrates through
`main`.

Temporary assignment (2026-09-15): Codex is paused on its usage limit, so the
owner assigned the back-end lane to Claude as well until Codex returns. Claude
works the back end from the primary worktree on `main`, continuing
`lane-backend.md`, keeps the front end in `claude-lane`, and adds a pointer in
`lane-frontend.md` for each back-end checkpoint. The ownership rules below
resume as written when Codex is back.

- Codex works in the primary worktree `/mnt/unraid/places_swiper/hayer` on
  branch `main`. Claude works in `.claude/worktrees/claude-lane` on branch
  `worktree-claude-lane`, and rebases onto `main` to pick up Codex's commits.
- Codex owns the back end and delivery: `backend/`, generated Serverpod
  protocol and client artifacts, migrations, `scripts/`, deployment, and the
  M7 safety milestone (M7-A, M7-E, and M7-F acceptance).
- Claude owns the front ends: presentation and client-side behavior in `app/`
  and `admin/`, meaning screens, widgets, routing, state wiring, localization,
  and their widget and unit tests.
- The generated protocol under `backend/hayer_client/` is Codex's output.
  Claude consumes it read-only and rebases to pick up new endpoints rather
  than regenerating or hand-editing it. Claude does not edit `backend/`,
  migrations, or deployment scripts.
- A front-end change that needs a new or altered endpoint is a handoff to
  Codex, not a reason to cross the boundary. Record the request in the change
  log and keep the client work behind the existing contract until it lands.
- Uncommitted work is invisible across worktrees, so the split protects only
  committed state. Codex hands over pending front-end work by committing it;
  before editing a front-end file, confirm the handoff note above does not
  list it as in flight.
- Each lane keeps its own log, in its own worktree, and neither agent edits
  the other's: `lane-frontend.md` for Claude, `lane-backend.md` for Codex.
  Checkpoints, verification evidence, handoff requests, and lane-local
  implementation decisions go there.
- This tracker stays authoritative for everything shared: locked decisions,
  target architecture, contracts, the milestone checklist and its exit
  conditions, verification gates, and this role split. Check a milestone box
  here; explain how it was earned in your lane log. Keep additions here short
  enough that the two lanes rarely touch the same paragraph, and resolve any
  overlap as an ordinary merge rather than rewriting the other agent's text.
- A worktree materializes tracked files only. `build/` is ignored, so the
  pinned toolchain exists solely in the primary worktree. Build from a
  secondary worktree with `export FLUTTER_BIN=/mnt/unraid/places_swiper/hayer/build/toolchains/flutter-3.47.2/bin/flutter`,
  which `scripts/resolve-toolchain.sh` honors ahead of any `flutter` on `PATH`.

In flight at the split (2026-09-09): Codex holds uncommitted P06 front-end
files, namely `app/lib/features/report/`,
`app/lib/data/poi_issue_repository.dart`, `admin/lib/features/issues/`, and
edits to `place_details_sheet.dart`, `results_screen.dart`, `place_card.dart`,
`core/providers.dart`, the `l10n` ARB and generated localizations,
`admin_app.dart`, and `admin_operations.dart`. Claude leaves these to P06's
scoped commit. Claude's open F01 join-limiter item sits in
`backend/hayer_server/`, so it now belongs to Codex's lane.

## Locked decisions

- Release an Android-first, release-signed APK to an invited beta of at most
  50 people. Support at most 12 participants in a multiplayer session.
- Use `0.2.0+6` for the safety-focused audit release. Deploy compatible server
  changes first while build 5 remains accepted; set minimum build 6 only after
  the signed build passes production verification. Begin post-safety product
  and administration improvements at `0.2.1+7`.
- Owner exception (2026-09-08): implement P01/P03 ahead of safety release
  acceptance, staging an unpublished `0.2.1+7` APK. This does not authorize
  deployment or raising the minimum build. Multiplayer destination selection
  is one editable participant ballot, plurality wins, and the host's ballot
  breaks a leading tie only. No host override, confirmation dialog, or runoff.
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
- `place.routeEstimate(sessionId, placeId, originLatitude?, originLongitude?)`
  returns an approximate driving duration and distance for a session-deck
  place to members only. The origin defaults to the host search location;
  opted-in multiplayer guests may use their device location when admin policy
  permits it. The app falls back to straight-line distance from that origin.
- `sessions.create(request, idempotencyKey)` obtains POIs and transactionally
  persists the session, host, and complete ordered snapshot.
- `sessions.join(code, displayName, idempotencyKey)` is idempotent, enforces
  names case-insensitively, and permits late joins while active.
- `sessions.getBundle(sessionId)` returns the session, deck, participants,
  explicit authenticated participant/progress, and revision to members only.
- `sessions.progress(sessionId)` returns the mutable session, participant/self
  progress, vote tallies, and destination-choice state without retransmitting
  the immutable deck.
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
  search/directions endpoints, templates, and positional paths Hayer consumes,
  ignore irrelevant upstream changes, and auto-activate only after the Riyadh
  canary.
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
- [~] A generated Serverpod/PostGIS integration suite now covers concurrent
  create retries, immutable decks, late joins, private aggregate results,
  duplicate swipes, majority/unanimous convergence, and authoritative expiry.
  All 38 tests passed against dedicated remote PostGIS on 2026-09-13. Its
  isolated database runner is wired into CI; a green containerized CI run is
  still required before this gate is fully verified.

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

#### M7-A — Core session integrity `[ ]`

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

- [~] Fix F01 at the real Serverpod endpoint path with a gateway-overwritten,
  trusted client-IP signal plus server method/user budgets; prove forged
  forwarding headers and direct-origin access cannot bypass it.
  - [x] Move the strict signup limit onto `/api/anonymousIdp`, the path
    Serverpod actually posts to, and delete the dead `/api/hayerSession/join`
    rule and zone rather than leave edge config that never fires.
  - [x] Overwrite `X-Hayer-Client-Ip` in both server blocks and budget
    anonymous signups against it, replacing the framework's proxy-blind
    TCP-peer quota at the configured 30/hour ceiling. A request without the
    vouched header is budgeted against its own socket, so a bypass cannot
    spend a legitimate client's budget.
  - [x] Add the method-aware join budget: retain 30 requests/minute per
    authenticated anonymous user and add 120 requests/minute per gateway-
    resolved client address, with the same safe peer fallback as signup.
  - [ ] Prove 31 distinct clients, forged `CF-Connecting-IP`, and direct-origin
    access through the real gateway. Not yet run: no container runtime on the
    development host.
  - [ ] Decide whether CF trust is pinned to the connector source address.
    It currently rests on the public port plus the documented host firewall,
    because Docker NAT masks the connector address.
- [~] Fix F13/F14/F20/F30: require passkey UP/UV, revoke issued admin/enrollment
  sessions, make compare-and-swap mutations atomic with audit records, and
  stop emitting recovery credentials to logs.
  - [x] F13: validate the registration attestation and signed login
    authenticator data on the server; require the expected RP hash, the
    minimum authenticator structure, and both UP and UV while retaining the
    existing origin, challenge, credential, and signature checks. Zero
    signature counters remain valid for synced passkeys.
  - [x] F14: make issued admin sessions reject new HTTP requests after logout
    or administrative revocation, and prove enrollment credentials are
    single-use under replay/concurrency. The targeted stateful validator and
    atomic enrollment claim are implemented, and their Postgres integration
    cases now pass against real PostGIS via
    `scripts/test-integration-remote.sh`.
  - [x] F20: make compare-and-swap admin mutations and their audit records one
    atomic transaction. Taxonomy revision/status checks and cache-policy
    version checks now run under row locks, validation is rebound to the exact
    revision after live canaries, and every audited admin mutation writes its
    audit row in the same transaction. All five Postgres concurrency/rollback
    cases now pass; an audit diff no longer carries a model's `__className__`
    marker, which had made the stored diff deserialize back into `CachePolicy`.
    See [`lane-backend.md`](lane-backend.md).
  - [x] F30: require preprovisioned first-start recovery credentials and keep
    them out of normal runtime output.
- [~] Close F29/F35 with an in-product identity/location lifecycle explanation,
  a provider/source-use inventory, a named reviewer, and documented retention,
  attribution, outage, and commercial-use decisions. The in-product account and
  a device-data erase are done in `worktree-claude-lane`; see
  [`lane-frontend.md`](lane-frontend.md). The notice still carries no support
  or deletion contact because none exists to quote, its bilingual copy needs
  the owner's read before beta, and the inventory, reviewer, documented
  decisions, city-only geocoding precision, and anonymous-identity cleanup
  remain open.

Exit: onboarding cannot be exhausted through the shared proxy identity;
privileged ceremonies/revocation reject replay; mutations are atomic/audited;
privacy and provider assumptions have accountable acceptance evidence.

#### M7-C — Catalog and upstream correctness `[~]`

- [~] Fix F05/F06/F07 as one persistence/provenance contract: batch atomic
  upserts, retain query-specific category evidence, coalesce only equivalent
  searches, and apply each caller's exact radius/price/category policy before
  its deck is selected. Catalog, category-evidence, and coverage writes are now
  three ordered parameterized upserts in one transaction, preserving
  first-seen and quarantine state. Evidence is per observed query plus its
  validated parent and carries a calibration-scoped `hayer-v2` marker, so
  legacy contaminated evidence is ignored and rebuilt on refresh. Cached SQL
  applies current evidence, price, closure, radius, and deterministic ranking
  before `LIMIT 500`; final policy selection still rechecks the exact caller.
  Refresh sharing now requires an exact request key. The three PostGIS
  concurrency/provenance/dense-cache cases now pass. They exposed a real defect,
  since fixed: a refresh persisted only the caller's selected deck, so every
  place the provider returned beyond one caller's `deckSize` or price ceiling
  was dropped from the shared catalog instead of being remembered. See
  [`lane-backend.md`](lane-backend.md).
- [x] Fix F08/F09 with one process-wide Google admission pool, bounded
  operation/page/retry deadlines, HTTP cancellation, streamed byte ceilings,
  validated redirect hops and bounded calibration retention. Consumer, admin
  and city resolution now share one geocoder, one-second admission spacing,
  an eight-second queue-inclusive deadline and a 2,000-entry TTL/LRU cache.
  The endpoint is switchable via `HAYER_GEOCODER_ENDPOINT`. Focused deadline,
  overload, real-socket cancellation and geocoder regressions pass; the live
  Riyadh source canary returns 10 places and remote PostGIS passes 39 tests.
  Production rollout and release-load measurements remain pending; retain the
  single-replica constraint. See `lane-backend.md` and `backend/deploy/README.md`.
- [~] Fix F10/F21 by separating core readiness from optional source canaries
  and reporting refresh outcomes truthfully. The server no longer waits for
  the source canary, refresh workers atomically lease jobs, and only a complete
  live result succeeds. Partial live data, stale fallback, hard failure, and
  cancellation remain non-green with stable causes; cancellation also stops
  provider work owned by this process and preserves prior coverage invalidation
  until a complete live refresh clears it. Production-like blocked-source
  restart and gateway proof remain pending. See `lane-backend.md`.

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

The 2026-09-08 UI/UX implementation pass was prioritized at the owner's
request. This does not waive the earlier safety checkpoints or authorize a
production rollout.

- [x] Implement the F18 startup shell and initial-load retry/home states for
  lobby, swipe, and results; retain saved lobby/results content on refresh
  failure, announce errors, and guard setup/join callbacks after disposal.
  Startup operations are bounded and retain the existing bootstrap-outage
  resume policy and successful update-required check.
- [x] Implement F19's independent GPS selection/address enrichment and one
  authenticated location repository. Show loading, no-results, and retry
  states; invalidate late search/address responses after newer user input.
- [x] Implement the F24–F27 presentation changes: honor system text scaling,
  adaptive home/setup/lobby/result controls, scrollable large-text swipe
  content, lazy variable-height results with bounded thumbnail decoding,
  focusable setup steps, reduced-motion celebration/swipe/step transitions,
  labeled directions, and shared localized fractional-distance formatting.
  The results thumbnail bound is corrected and extended to every other place
  photo in `worktree-claude-lane`; see [`lane-frontend.md`](lane-frontend.md).
- [x] Pass automated consumer checks: all 93 tests and fatal-info analysis;
  cover English/Arabic 200% text, 320 px portrait and short landscape results,
  setup/join with keyboard coverage, lobby/details, initialization retry,
  stale-data retention, GPS/address failure, and late address responses.
- [ ] Complete physical-device TalkBack/focus/contrast, largest native text,
  denied/approximate-location, background/reconnect, and performance checks.

- [~] Fix F17–F19 with coalesced lightweight progress refresh, dependable
  stream retry/poll convergence, prompt startup shell, recoverable screen
  states, and GPS success independent of reverse-geocoder failure. The F18
  startup shell and F19 location independence are checked above. F17's client
  half is now complete in `worktree-claude-lane`; see
  [`lane-frontend.md`](lane-frontend.md). Lobby, swipe and results refresh
  through the deck-free `sessions.progress` response, keeping the immutable
  deck they already hold; a server without that read falls back to the full
  load once and then stops asking. A blocked stream no longer strands a room:
  after two silent connection attempts the client polls that cheap read on a
  jittered, self-widening interval and says on screen that live updates are
  paused, with a manual refresh. What remains is two-device certification on
  real hardware and the server-side fold of `results` into one response, which
  belongs to M7-A.
- [x] Fix F22 by using bounded SQL aggregation/query paths. Reports group and
  rank in SQL on one connection each, under a statement timeout, with at most
  two at once. Aggregation drains in time-budgeted batches, records backlog
  and oldest-event metrics, and expires raw events at 14 days even when
  pending. Over a synthetic 2.77-million-row year no report run took over
  585 ms, and the drain ran at 12,921 events/s. Production rollout pending;
  see `lane-backend.md`.
- [x] Fix F23's last-swiped-place attribution: completion records the actual
  consensus-matched places and distinguishes no-match completion. The remote
  PostGIS regression likes only the first card, finishes on a different card,
  and verifies `place_matched` credits the first card. It passed on 2026-09-13;
  versioned analytics semantics were implemented with G02.
- [~] Certify the implemented F24–F27 adaptive presentation pass on physical
  devices using the acceptance matrix above. Automated presentation coverage
  is complete; device conformance remains open.

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

#### M7-G — Decision intelligence (`0.2.1+7`) `[~]`

- [x] Implement G02 with correctly named deck inclusions, measured/deduplicated
  card impressions, short-lived random journey linkage, explicit-choice and
  no-match outcomes, schema/version metadata, and no persistent installation
  identity.
- [x] Implement P01: a labeled Details action on swipe cards opens the shared
  result details sheet without casting a vote or advancing the card.
- [x] Implement the owner-revised P03 UI and tally: one editable My choice
  ballot per participant, per-place aggregate counts, an automatic plurality
  leader/group choice, and the host's ballot as a tie-break only. No extra
  screen or confirmation. A tie without a host ballot among the leaders stays
  unresolved. Choices open after group swiping (or an instant match); a late
  join pauses choices and retains prior ballots while results are provisional.
- [x] Add membership/expiry/candidate validation, per-participant choice
  revisions, no-op same-choice retries, transactional snapshots/mutations,
  bilingual controls, and old-server compatibility via an optional bundle
  field. Likes and deck completion remain separate from destination ballots.
- [x] Execute the real-PostGIS choice retry/edit, simultaneous group choice,
  membership/candidate/expiry and late-join regressions. They pass in the
  38-test remote suite recorded on 2026-09-13.
- [ ] Certify two-device choice/reconnect behavior and compatibility through
  the deployed gateway before accepting the decision flow for beta.
- P04 runoff/new-round recovery is explicitly deferred by the owner
  (2026-09-08): keep finding a place short and fun. Do not add it implicitly.

Exit: the product and dashboard distinguish inclusion, human impression,
preference, voting completion, declared choice, no-match, and technical failure.

#### M7-H — Return value and POI feedback `[x]`

- [x] Implement P05 as private local-first saved/favorite lists and reusable
  shortlists; preserve notes locally unless a user explicitly shares them.
  Want to try/Favorites, private 500-character notes, save/remove actions,
  device-loss/no-sync/export disclosure, 2–20-place selection, optional five-
  place fresh mix, and server-side catalog re-resolution are implemented.
  The API receives only ordered place IDs; saved snapshots and notes stay
  local. Reuse telemetry is emitted only after room creation, and compatibility
  deck buckets no longer create false underfill events. Pinned full preflight
  passes with 96 server, 119 app, and eight admin tests. Signed build 7 and both
  checksum manifests pass. The compiled real-PostGIS cases remain blocked by
  the absent Docker runtime.
- [x] Implement P06 as structured, rate-limited POI issue reporting with
  reversible moderation, source corroboration, ownership, resolution state,
  and an audit trail. Never convert one anonymous report directly into a
  closure or catalog fact. Active implementation uses six factual issue types,
  idempotent membership/deck validation, hourly and daily reporter budgets,
  salted server-only reporter correlation, and one active report per
  reporter/place/type. The admin queue exposes recurrence and affected-room
  counts, requires ownership plus source evidence for confirmed resolution,
  and audits claim/release/resolve/dismiss/reopen transitions. Catalog
  quarantine/restore remains an explicit separate moderation action.

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

- [~] Add decision health, host/guest funnels, POI quality/freshness, demand
  versus usable supply, and incident/extractor views with explicit periods,
  denominators, sample sizes, lag, source type, version overlays, and links to
  the next operator action. Explicit periods, the denominators and sample
  sizes the protocol already carries, small-cohort suppression, measured lag,
  correct metric polarity, and next-action links — including per-place links
  that carry their own filter into the catalog and the issue queue — are done
  in `worktree-claude-lane`; see [`lane-frontend.md`](lane-frontend.md). Sample counts on KPIs and trend
  points, source type, and version overlays need protocol fields that do not
  exist yet, and are an open handoff to the back-end lane.
  The POI catalog view now has a heat map, a list that can follow the map,
  cache times, sorting and filters, and a full info card per place (owner
  request, 2026-09-16); see both lane logs.
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

### M9 — "Got time" discovery `[~]`

Runs alongside M7 by owner decision on 2026-09-13, as an explicit exception to
the one-active-milestone rule. M7 remains the invited-beta gate, and discovery
ships dark behind `discoveryEnabled`. Scope, ownership, contracts and
dependencies are in [`discovery_upgrade.md`](discovery_upgrade.md)
§"Implementation plan"; each lane log holds its evidence.

- [x] M9-A — Shared source and observation writer (back end). Raw provider
  pages are evidence-neutral; Swipe adds its query evidence in its adapter,
  while the shared writer persists broad/detail observations independently.
- [x] M9-B — Flag, configuration and Discover taxonomy (back end). Typed
  policy storage, backward-compatible updates, public configuration, the
  shared flag guard, and the seeded/validated/audited tree lifecycle are live.
- [x] M9-C — Catalog columns and discovery query (back end). Generated catalog
  projections and the shared browse, facets and place-context SQL, with PostGIS
  acceptance, recorded query plans and a timed populated upgrade.
- [x] M9-D — Shared detail resolver and sessionless reporting (back end).
  One cache-first resolver serves both modes' details, refreshing a place once
  under a database lease and cooldown, and Discover reports share session
  reporting's validation, dedupe, quotas and moderation storage.
- [x] M9-E — Harvesting and coverage (back end, after F21). Committed searches
  and Deepen enqueue one bounded, deduplicated harvest per canonical cell
  through the shared source and writer, with honest coverage, a versioned
  broad-query manifest, admin job, unmapped-type and growth reads, and a
  measured admission load benchmark. Hosting deployment pending.
- [x] M9-F — Entry, configuration and links (front end). Prework in `bb212d7`;
  the configuration read and kept disabled links landed on 2026-09-13. Device
  App Link checks belong to M9-K.
- [x] M9-G — Discover surface (front end). G1, the shared map base, landed in
  `017e17c`; G2, the results screen, on 2026-09-13; G3, the filter sheet and
  category tree, on 2026-09-14, followed that day by the server-resolved
  area country and structured area label; G4, pins, selection and coverage,
  also on 2026-09-14 against generated contracts and mocks. The M9-C and M9-E
  implementations it waited on are merged (`060a472`), an Arabic 200% text
  pass covers its states, its handoffs are settled against the
  implementations, and device checks belong to M9-K.
- [x] M9-H — Place detail, save, share and report (front end). The shared
  sheet's Discover mode with standing and catalog age, Save, sessionless
  reports from the sheet and Worst rated rows, and Share landed on 2026-09-14
  against generated contracts and mocks. The M9-C and M9-D implementations
  it waited on are merged (`060a472`) and its handoffs are settled, stale
  details included; device link checks belong to M9-K.
- [x] M9-J — Admin (front end). Policy knobs, Discover tree editor, unmapped
  types, harvest manifest, harvest jobs, growth metrics and report sources
  landed on 2026-09-14 against generated contracts and mocks. The M9-B, M9-D
  and M9-E implementations requirement 16's acceptance waited on are merged
  (`060a472`), and refresh jobs now label user explorations.
- [~] M9-K — Cross-mode verification and dark release (both lanes). The
  back-end half (`c7ad9ee`), the lane merge (`060a472`), the Got time
  privacy copy and an Arabic 200% text pass are done. Physical-device and
  web-host checks and the owner's formula, budget and latency review remain;
  the flag stays off.

Frontend handoff: [`backend/discovery-contracts.md`](backend/discovery-contracts.md).
Frontend prework was merged into main in `d4b58b7`. No checkpoint above is
complete from contract availability alone. Discovery stays dark: data, harvest and
catalog-report RPCs answer `feature_disabled` while `discoveryEnabled` is
false. Shared place details answer in both modes whatever the flag, and the
M9-E admin reads answer authorized operators. Every back-end M9 slice is
implemented, and M9-K is in progress.

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
- Public anonymous signup is limited to 10 requests/minute/IP at the gateway
  and 30 accounts/hour/resolved-client in Serverpod; join is limited to 30
  requests/minute/authenticated anonymous user and 120 requests/minute/
  resolved-client in Serverpod. General API traffic is limited to
  30 requests/second/IP and public streaming to 50 connections/IP. Enrollment
  is limited to three gateway requests/minute and six Serverpod
  starts/hour/operator while explicitly enabled.
- Admin mutations never rewrite an existing session snapshot.
- Native Android may load allowlisted source photos directly. Consumer web
  must use the authenticated bounded media proxy.
- The release keystore, production passwords, Basic Auth recovery hash,
  IP-hash salt, database password, passkey private keys, and signing material
  never enter Git. Passkey private keys and biometrics remain in the user's
  authenticator.

## Evidence log

- 2026-09-13: implemented the F10/F21 source-outage and refresh-truthfulness
  boundary after fast-forwarding Claude's M9-F commit `5863f02`. The core
  server no longer depends on the optional source canary. Dashboard jobs use
  atomic skip-locked leases and lease-checked completion; only complete live
  source data succeeds, while partial, stale fallback, hard failure and
  cancellation retain distinct non-green outcomes. Active local provider work
  is cancelled, prior coverage invalidation survives cancellation, and partial
  observations persist without making coverage look fresh. Pinned full
  preflight passed generation, formatting, all analyses, 154 server tests,
  207 app tests and 51 admin tests. The guarded remote PostGIS suite passed all
  52 tests, including six refresh-job concurrency/outcome/cancellation cases.
  `scripts/build-release-apk.sh` produced signed `0.2.1+7` (105,794,923 bytes);
  APK Signature Scheme v2 and package `sa.almou.hayer`, version code 7, target
  SDK 36 verify, with SHA-256
  `684556bcac678aeae8991ea3a396d8e8373018ba768803476c435e229b6aad3b`.
  Docker is unavailable on this host, so Compose parsing and the required
  production-like blocked-source restart/gateway proof remain pending. No
  schema migration, generated protocol change, or catalog reset is introduced.
- 2026-09-13: implemented F08/F09 provider/geocoder limits. Google operations
  share bounded process-wide admission, a cancellable deadline across pages
  and retries, request/streamed-byte limits and validated redirect hops.
  Completed observations still persist to the shared catalog in an awaited
  transaction outside provider cancellation. Consumer/admin/city lookups share
  one bounded geocoder/cache and a configurable HTTPS endpoint. Active
  calibration retention is bounded and rollback reload is tested. Full pinned
  preflight passed generation, formatting, all analyses, 147 server tests,
  165 app tests and 51 admin tests. Final server analysis/tests also passed
  after the persistence-scope adjustment. All 39 remote PostGIS tests passed
  on the final isolated rerun; an intervening calibration-test timeout and
  cascading transaction errors under concurrent load are recorded in
  `lane-backend.md`. The live Riyadh source canary returned 10 places.
  `scripts/build-release-apk.sh` produced signed `0.2.1+7`; APK Signature
  Scheme v2 verifies, with SHA-256
  `ef731e258e34f3d57e4692113db04de2850cdbb73effaf69f4c2def0591dc140`.
  Deployment and release-load measurements remain pending on Unraid. No
  schema migration or POI catalog reset is introduced. Next work is F10/F21.
- 2026-09-13: opened M9 alongside M7 by owner decision. The front-end lane
  landed M9-G1, the shared `HayerMap` base, in `017e17c`, and M9-F's
  contract-free prework in `bb212d7`: the dark Got time entry, the
  `/discover` gate and App Links, the link codec and bilingual strings.
  Pinned full preflight passed 130 server, 184 app and 51 admin tests with
  clean analyses. Signed `0.2.1+7` built at SHA-256
  `4a15d6c0bb4b0b1371b643b75df8eadac8799f924f71139978ef9ddd74d8c97a` and
  verifies under APK Signature Scheme v2 with the existing signer.
  Discovery stays disabled, and M9-F and M9-G stay open. Details are in
  `lane-frontend.md`.
- 2026-09-13: closed M9-F in the front-end lane on the `4014037` contract.
  The app reads `bootstrap.discoveryConfig` after startup, caches it for the
  server's lifetime capped at five minutes, and treats errors, older servers,
  other contract versions and unrefreshable expired configurations as
  disabled. A discovery link that cannot open is kept on the device, with
  Try again and Dismiss on home. Pinned full preflight passed 151 server, 207
  app and 51 admin tests with clean analyses. Signed `0.2.1+7` built at
  SHA-256 `4bb1f8986178a0e579baed9c899a6308b335035d03e713b6eaef0cf55461b2e4`
  and verifies under APK Signature Scheme v2 with the existing signer.
  Discovery stays disabled. Details are in `lane-frontend.md`.
- 2026-09-13: landed M9-G2 in the front-end lane on the `discover.browse`
  contract: the Discover map, area bar, sort and results sheet, with query
  generations, kept results on failure, keyset paging and bilingual rows.
  `/discover` now sits under `/` so committed query changes keep one screen.
  Handoffs for the area's country and a structured area label are in the
  lane log. Pinned full preflight passed 154 server, 254 app and 51 admin
  tests with clean analyses. Signed `0.2.1+7` built at SHA-256
  `ba8e607d3351070189dd19812327204e5e220c0eca86db844015d0fc77b0ba00` and
  verifies under APK Signature Scheme v2 with the existing signer. Discovery
  stays disabled. Details are in `lane-frontend.md`.
- 2026-09-14: landed M9-G3 in the front-end lane on the `discover.facets` and
  `discover.taxonomy` contracts. It adds the filter sheet as a draft with a
  debounced facets preview, and the category tree counted from one facets
  answer and the published tree. It also adds removable category chips,
  correction of links naming removed categories, and the open-now minute
  check. Pinned full preflight passed 154 server, 281 app and
  51 admin tests with clean analyses. Signed `0.2.1+7` built at
  SHA-256 `a10ebfca4ba9ee7ac43bb8cafccfbe5e2a37be99f5d9084f453e0232b0fc7a5b` and verifies under APK Signature Scheme v2 with the
  existing signer. Discovery stays disabled. Details are in
  `lane-frontend.md`.
- 2026-09-14: moved the front-end lane onto the back-end lane's `eda8827`
  area contract. Discover requests no longer guess a country from rough
  boxes. The server resolves the country from the viewport, and the app reads
  it back from `DiscoverQueryContext`. An area the server rejects as
  `unsupported_area` is explained in place of kept rows. The area bar names
  the locality, then the city, from `place.reverseGeocodeDetails`. Pinned
  full preflight passed 156 server, 279 app and 51 admin tests
  with clean analyses. Signed `0.2.1+7` built at SHA-256 `fa7ee73e219d6b30d14fb3179ceb2dc26e4707d99070f4815c966cf4836c746c` and verifies
  under APK Signature Scheme v2 with the existing signer. Discovery stays
  disabled. Details are in `lane-frontend.md`.
- 2026-09-14: landed M9-G4 in the front-end lane on the generated map,
  place-context and coverage contracts, without merging `main` while Codex is
  paused. The Discover map draws clustered rating pins, or the server's area
  counts above the point limit, from sources added once per style. Pins and
  rows select each other, and a place beyond the loaded pages is previewed
  above the list. A coverage strip reports each committed area once, follows
  its exploration and offers Deepen. Pinned full preflight passed 159 server,
  329 app and 72 admin tests with clean analyses. Signed `0.2.1+7` built at
  SHA-256 `f2dfde148db26cd3f02bff462edb1561ab7c588eae9839996964c69ff0fee44d`
  and verifies under APK Signature Scheme v2 with the existing signer.
  Discovery stays disabled. Details are in `lane-frontend.md`.
- 2026-09-14: landed M9-H in the front-end lane on the generated place-detail,
  place-context and catalog-report contracts, without merging `main` while
  Codex is paused. The shared details sheet has an explicit Discover mode
  beside the swipe session. Both modes read `place.details` over the
  snapshot. Discover's sheet shows where a place stands in the whole search,
  says only when Hayer added a place, saves through the unchanged saved-places
  controller, and reports catalog places without a session, as Worst rated
  rows now also do. Share sends the committed search as a public link. The
  report sheet's thanks, which never showed because the sheet used
  `flutter/material`'s messenger in a `material_ui` app, now shows. Pinned
  full preflight passed 159 server, 351 app and 72 admin
  tests with clean analyses. Signed `0.2.1+7` built at SHA-256
  `7a4bfa45ba154620f3187bccab7ac881a2455634a7ea8d2e6f28e2d88d0c4be8`
  and verifies under APK Signature Scheme v2 with the existing signer.
  Discovery stays disabled. Details are in `lane-frontend.md`.
- 2026-09-15: closed M9-C in the back-end lane, which the owner assigned to
  Claude while Codex is paused. Discover browse, facets and place context run
  on generated catalog projections through one SQL builder. On a 200,000-row
  catalog the slowest recorded statement fell from 17.2 s in the uncommitted
  draft to 0.65 s, and the populated upgrade takes 110.5 s, nearly all of it
  one table rewrite. The 31 new PostGIS cases pass within 86/86 on a
  disposable fresh-schema database, because the shared `hayer_test` still holds
  the draft schema and needs a reset. Pinned full preflight passed 176 server,
  279 app and 51 admin tests with clean analyses. Signed `0.2.1+7` built at
  SHA-256 `d5aaca0b71174fc3d93d64699b2706e62fcf83fdaaa23e5912de60a6967a14a5`
  and verifies under APK Signature Scheme v2 with the existing signer.
  Discovery stays disabled. Details are in `lane-backend.md`.
- 2026-09-15: closed M9-D in the back-end lane. `place.details` resolves both
  modes' detail reads from the shared catalog. It runs one focused
  Vela-derived search under a per-place database lease only when a record is
  stale or its missing fields are unchecked, with shared cooldowns, and it
  answers whether or not Discover is enabled. `place.reportCatalogIssue` files
  sessionless Discover reports through the session pipeline, sharing its
  dedupe and quotas, and admin issue rows carry their source. The migration
  makes a report's session nullable with a `source` backfill and adds refresh
  metadata. It also restores a report constraint that fresh definitions had
  lost. The 14 new PostGIS cases pass within 101/101 on a disposable
  fresh-schema database, and the upgraded and fresh schemas fingerprint
  identically. Pinned full preflight passed 181 server,
  279 app and 51 admin tests with clean analyses. Signed
  `0.2.1+7` built at SHA-256 `eeb18794c653d79ae4e9c48684d3a56799e34166310f7fda888dfb36aa077c6f` and verifies under APK Signature
  Scheme v2 with the existing signer. Discovery stays disabled. Details are in
  `lane-backend.md`.
- 2026-09-15: closed M9-E in the back-end lane. A committed Discover search or
  Deepen resolves to one canonical harvest cell. Under an advisory lock the
  request joins its active job, returns fresh coverage or a cooldown, or
  spends the user's quota to enqueue one bounded harvest. The existing worker
  runs it through the shared source and writer, with a heartbeat lease, flag
  and operator cancellation, and a scheduler that reaches every broad domain
  and Swipe compatibility query before continuation, retries and Arabic
  fallbacks. Compatibility results carry genuine Swipe evidence and coverage.
  Harvests yield to interactive requests inside the shared provider limiter.
  In a simulated-latency load benchmark, that brought Swipe search latency
  under a 24-page harvest from a 12.6 s p50 with first-come admission back to
  its 1.2 s baseline. Coverage footprints, the versioned broad-query manifest and the admin job,
  unmapped-type and growth reads are live behind the flag. The 14 new PostGIS
  cases pass within 115/115 on a disposable fresh-schema database, and the
  populated upgrade fingerprints identically to a fresh one. Pinned full
  preflight passed 199 server, 279 app and
  51 admin tests with clean analyses. Signed `0.2.1+7` built at
  SHA-256 `eeb18794c653d79ae4e9c48684d3a56799e34166310f7fda888dfb36aa077c6f`, unchanged from M9-D because the app did not
  change, and verifies under APK Signature Scheme v2 with the existing
  signer. Discovery stays disabled. Details are in `lane-backend.md`.
- 2026-09-15: advanced M9-K, with both lanes held by Claude. `main` was
  merged into the front-end branch as `060a472`. The back-end half
  (`c7ad9ee`) proves the cross-user, cross-mode catalog loop against PostGIS
  by upstream request counts, and stops live Swipe refreshes returning
  quarantined places. Data & Privacy now says Got time sends the map area
  searched rather than the device position, and keeps the last area and a
  kept link on the device; the Arabic wording awaits a native reviewer. A
  new suite shows every Discover empty, failure, coverage and report state
  in Arabic at 200% text on a small phone without an overflow. Pinned full
  preflight passed 199 server, 366 app and 72 admin
  tests with clean analyses, and the remote PostGIS suite passed
  118/118. Signed `0.2.1+7` built at SHA-256 `9a908507ad0cd86020b1f81f60e0a8a0651ebaa49cc16eacf3ffd277da126a20` and
  verifies under APK Signature Scheme v2. Device, web-host and owner review
  items remain open, and Discovery stays disabled. Details are in
  `lane-frontend.md` and `lane-backend.md`.
- 2026-09-15: accepted M9-G, M9-H and M9-J against the M9-B to M9-E
  implementations. Every front-end handoff was checked against the settled
  back-end behavior: explored footprints already expire with the freshness
  window, and unmapped types rank by observations, then places. A stale
  detail answer keeps changeable facts hidden under the cached-details note,
  now under test, and the refresh jobs page labels user explorations apart
  from operator jobs. Pinned full preflight passed 199 server,
  367 app and 73 admin tests with clean analyses. Signed
  `0.2.1+7` built at SHA-256 `9a908507ad0cd86020b1f81f60e0a8a0651ebaa49cc16eacf3ffd277da126a20`, unchanged from M9-K because only tests and admin changed, and verifies under APK
  Signature Scheme v2. Device checks remain with M9-K, and Discovery stays
  disabled. Details are in `lane-frontend.md`.
- 2026-09-13: the owner confirmed the deployed calibration repair resolved
  Start swiping. Closed that incident using owner-reported production
  evidence; no independent authenticated canary was rerun. Reviewed current
  acceptance against `astra-audit.md` and both lane logs, reconciled the
  PostGIS/choice-test status, confirmed F23's implemented actual-match
  attribution against source and its passing regression, and recorded the
  remaining beta gates above.
  The previous full preflight, 38-test PostGIS run and signed APK remain the
  validation baseline; this follow-up changes documentation only. Invited-
  beta acceptance, minimum-build changes and beta tagging remain open.
- 2026-09-13: fixed the Start swiping server failure reported on September 12.
  Older active database calibrations can omit both directions fields; runtime
  loading now inherits only that pair from the bundled calibration, retaining
  active search settings, version, allowlists and shared POI catalog evidence.
  Partial or malformed directions still fail strict validation. Failed loads
  are evicted so a repaired active record can be retried. Regression tests
  reproduced the production exception before the fix. Pinned full preflight
  passed generation, formatting, analysis and 130 server, 165 app and 51 admin
  tests; the dedicated remote PostGIS suite passed all 38 integration tests.
  `scripts/build-release-apk.sh` produced signed `0.2.1+7`, with v2 signature
  verification and SHA-256
  `ef731e258e34f3d57e4692113db04de2850cdbb73effaf69f4c2def0591dc140`.
  Deployment initially required an owner handoff because SSH authentication
  to Unraid was unavailable; the owner subsequently confirmed Start swiping
  was resolved. No database rewrite or catalog reset was required. Details
  are in `lane-backend.md`.
- 2026-09-10: aligned the toolchain resolver in `044617b`, closing the
  front-end lane's standing report. `hayer_resolve_dart` now prefers an explicit
  `DART_BIN`, then the resolved Flutter's sibling `dart`, then `PATH`, then the
  home fallback, so a pinned `FLUTTER_BIN` no longer silently pairs Flutter
  3.47.2 with system Dart 3.12.2 and a formatter that fails a clean tree. An
  invalid `DART_BIN` still fails closed with its reason. `scripts/test-resolve-
  toolchain.sh` covers all four precedence branches and the fail-closed case
  against temporary executables, and `scripts/preflight.sh` runs it before
  anything else. Verified independently from the primary worktree: with
  `DART_BIN` unset the resolver returns the pinned 3.13.2 Dart, and full
  preflight exits zero, formatting 245 files unchanged and passing 118 server,
  138 app, and 51 admin tests. No signed build was produced for this commit
  because it changes no shipped code; the merge artifact above still stands.
- 2026-09-10: merged the front-end lane into `main`. Codex's seven post-
  `4c9520a` back-end commits and Claude's nine front-end commits converge with
  no source-file contention: fifty and forty-four files changed respectively,
  and `PROJECT.md` was the only file both lanes touched, which is what the
  `lane-backend.md`/`lane-frontend.md` split was for. Both tracker conflicts sat
  in the milestone checklist. The M7-B F13/F14/F20/F30 conflict was additive:
  Codex's sub-bullets and Claude's `[~]` on the following F29/F35 item both
  apply. The F17-F19 item needed a decision rather than a pick, because each
  lane had recorded the other's half as its own open handoff, so merging
  falsified both sentences; the item now records both halves merged and names
  what remains, namely wiring the client onto the deck-free `sessions.progress`
  response, its rollback fallback, and blocked-stream acceptance. Three
  statements the textual merge carried through silently were corrected for the
  same reason: the lane branch is no longer an unmerged rebase onto `4c9520a`,
  the F17 client half no longer waits on a server handoff, and the tracker date
  advances. Pinned full preflight passes generation, formatting of 245 files,
  all fatal-info analyses, 118 server tests, 138 app tests, 51 admin tests,
  shell checks, and diff checks; the app and admin counts rise from 123 and nine
  because the lane's tests came across. This run required `DART_BIN` exported
  alongside `FLUTTER_BIN`, because `scripts/resolve-toolchain.sh` then resolved
  `dart` from `PATH` independently of the Flutter it had just resolved; the
  resolver was corrected afterwards in `044617b`, recorded below. Signed
  `0.2.1+7` and its alias are 105,122,663 bytes at SHA-256
  `431f0d8500c48aa1cab37795beb7ad828f02f095bf64ce4ba7da7aefaaf4bd7b`,
  superseding the smaller pre-merge artifact; package `sa.almou.hayer`,
  versionCode 7 and versionName 0.2.1, and APK Signature Scheme v2 under the
  Hayer release certificate all verify. The admin dashboard is English-only by
  owner decision, so `admin/lib/l10n/` and `admin/l10n.yaml` are gone. Nothing
  was pushed or deployed, and the Docker-dependent PostGIS cases on both sides
  remain unrun on this host.
- 2026-09-10: implemented the F05/F06/F07 catalog contract. The former
  per-place/per-category read-then-write loop is replaced by ordered JSON batch
  `INSERT ... ON CONFLICT` operations for catalog rows, query evidence, and
  coverage inside one transaction. Conflict merges keep the earliest
  `firstSeenAt`, preserve quarantine fields, accept only newer dynamic
  snapshots, and prevent an older coverage refresh replacing a newer one.
  Search candidates retain every category query that actually observed them;
  persistence adds only those categories and validated parent relationships.
  Calibration-scoped `hayer-v2` evidence makes legacy broadened rows ineligible
  for cache selection until a normal refresh rebuilds them, without touching
  immutable session decks. Cached PostGIS queries now apply current evidence,
  price, closures, radius, and review/rating/distance/ID ordering before the
  500-row bound, then reapply the caller's exact policy in Dart. Refreshes
  coalesce only when calibration, resolved queries, exact coordinates, radius,
  price, and deck size all match. Focused regressions cover evidence union,
  round-robin deduplication, exact keys, and SQL/upsert structure. Three
  real-PostGIS cases cover overlapping refreshes with shared provider IDs,
  first-seen/quarantine preservation, disjoint/union/subsequent cached cuisine
  requests, and a dense 508-row category/price/radius fixture; they analyze but
  cannot execute because this host has no Docker command or local Postgres
  server. Pinned full preflight passes generation/formatting, fatal-info
  analysis, 118 server tests, 123 app tests, nine admin tests, and repository
  checks. Signed `0.2.1+7` and its alias are 104,876,403 bytes at SHA-256
  `34091e6b6eac5a2663e9cd5b2c9b1ffbc5ae879966710afc29aa4a14ec9276d2`;
  both manifests, package/version metadata, and APK Signature Scheme v2
  verify. A containerized PostGIS run plus representative `EXPLAIN` remains
  required before this checkpoint is marked verified.
- 2026-09-10: implemented F14's revocable privileged sessions without adding a
  second token table. After normal JWT signature/expiry validation, admin and
  enrollment access tokens must still reference their Serverpod refresh-token
  row; logout/revoke deletes that row, so a copied access JWT fails the next
  authentication check. The validator remains a `JwtTokenManager` subtype for
  refresh-endpoint compatibility and skips the database lookup for anonymous
  consumer JWTs. Passkey registration now deletes-and-claims the enrollment
  row in the same transaction as challenge consumption and credential insert;
  failure rolls everything back and concurrent attempts can commit only once.
  Five focused unit tests pass. Three real-Postgres regressions cover copied
  admin-token replay, the intentionally stateless consumer path, rollback, and
  concurrent enrollment claims; they compile under fatal-info analysis but
  cannot execute because this host has no Docker command. Pinned full preflight
  passes 111 server, 123 app, and nine admin tests plus all analyses/checks.
  Signed `0.2.1+7` and its alias remain 104,876,403 bytes at SHA-256
  `34091e6b6eac5a2663e9cd5b2c9b1ffbc5ae879966710afc29aa4a14ec9276d2`;
  both manifests, package/version metadata, and APK Signature Scheme v2
  verify. Containerized concurrency and fresh HTTP replay proof remain open.
- 2026-09-10: closed F13's server enforcement. Registration parses the CBOR
  attestation authenticator data before the existing Serverpod ceremony, and
  login validates the signed authenticator data before the existing challenge
  and signature verification. Both paths require a 37-byte minimum structure,
  the configured RP hash, UP, and UV; origin/type checks remain in place and
  zero counters are not rejected. Regressions prove malformed/wrong-RP data is
  rejected, prove the pinned dependency accepts otherwise-valid registration
  objects missing either flag, and use valid ES256 signatures to prove Hayer
  rejects login assertions with UP=false or UV=false. Pinned full preflight
  passes 106 server, 123 app, and nine admin tests plus all analyses/checks.
  Signed `0.2.1+7` and its alias are 104,876,403 bytes at SHA-256
  `34091e6b6eac5a2663e9cd5b2c9b1ffbc5ae879966710afc29aa4a14ec9276d2`;
  both manifests, package/version metadata, and APK Signature Scheme v2
  verify. A supervised real-authenticator ceremony remains a release gate.
- 2026-09-09: closed F30 by removing generated recovery passwords from the
  runtime initializer result and container output. A new secret volume must be
  initialized with a preprovisioned `HAYER_ADMIN_PASSWORD`; missing input fails
  closed, while an existing `admin.htpasswd` remains restart-compatible without
  that environment value. Deployment guidance requires offline storage and
  removal of the initial environment value after initialization. Targeted
  regressions cover first-start failure, configured creation, preservation,
  and the absence of credential-printing code. Pinned full preflight passes
  103 server, 123 app, and nine admin tests plus all analyses/checks. Signed
  `0.2.1+7` and its alias remain 104,876,403 bytes at SHA-256
  `34091e6b6eac5a2663e9cd5b2c9b1ffbc5ae879966710afc29aa4a14ec9276d2`;
  both manifests, package/version metadata, and APK Signature Scheme v2
  verify. No deployment or credential rotation was performed.
- 2026-09-09: implemented F17's additive back-end progress contract. Members
  can read mutable session/participant/self state, aggregate per-place vote
  tallies, and destination choices without retransmitting immutable place
  snapshots. Progress reads use a shared room lock, throttle narrow presence
  writes to 30 seconds, and perform expiry as an authorized parameterized
  status/revision update. The WebSocket handshake no longer loads and discards
  the deck before yielding its current revision. Existing full `load` remains
  compatible for initial reads and rollback. The real-PostGIS authorization,
  tally, and no-snapshot regression compiles but cannot run because Docker is
  absent. Pinned full preflight passes 101 server, 123 app, and nine admin
  tests plus all analyses/checks. Signed `0.2.1+7` and its alias are
  104,876,403 bytes at SHA-256
  `34091e6b6eac5a2663e9cd5b2c9b1ffbc5ae879966710afc29aa4a14ec9276d2`;
  both manifests, package/version metadata, and APK Signature Scheme v2
  verify. Claude's client branch must consume the generated contract and keep
  an old-server fallback before F17 is complete.
- 2026-09-09: implemented F01's remaining method-aware join budget. The join
  method retains 30 requests/minute per authenticated anonymous user and now
  also enforces 120 requests/minute per gateway-resolved client address, using
  the signup path's validated header and safe direct-peer fallback. This keeps
  normal session RPCs off a coarse `/api/hayerSession` edge rule while bounding
  identity rotation. A real-PostGIS regression uses distinct identities behind
  one peer and proves attempt 121 is rejected; it compiles but cannot execute
  on this host because Docker is absent. Pinned full preflight passes 101
  server, 123 app, and nine admin tests plus all analyses and checks. Required
  signed build `0.2.1+7` and its alias remain 104,876,403 bytes at SHA-256
  `0ac17018b52c8685eaa783836bb2c79da44ff1fe9ba1af5e35cf6c0a7da7de0f`;
  both manifests, package/version metadata, and APK Signature Scheme v2
  verify. Live gateway abuse/direct-origin proof remains open.
- 2026-09-09: completed P06 structured POI issue reporting. Authenticated
  consumers can optionally report six factual issue types from swipe or result
  details in English and Arabic; dislikes remain separate. `place.reportIssue`
  validates room membership and immutable-deck provenance, reuses idempotency
  keys for transient retries, salts server-only reporter correlation, serializes
  active-report deduplication, and enforces six-per-hour plus 20-per-day budgets.
  The admin inbox exposes outcome counts, recurrence, affected-room counts,
  reported/current source snapshots, ownership, evidenced resolve/dismiss,
  release/reopen, and append-only transition audits without reporter/session
  identity. Catalog quarantine/restore is a separately labelled, reversible
  operator action and never occurs on report submission. Migration
  `20260909025500100-poi-issue-reports` adds lifecycle constraints and indexed
  queue/dedupe paths while retaining the custom PostGIS definition. The Flutter
  architecture, unit/widget-test, static-analysis, and Postgres-practice skills
  guided the boundary, validation, transaction, privacy, and regression work.
- 2026-09-09: pinned final `scripts/preflight.sh` passed Serverpod generation,
  formatting, fatal-info analysis of server/generated client/app/admin, 101
  server tests, 123 app tests, nine admin tests, shell syntax, and diff checks.
  New real-PostGIS cases cover concurrent different-key deduplication,
  same-key replay/conflict, authorization/provenance, immutable snapshots,
  ownership/evidence/auditing, reopen, and hourly flooding; they compile but
  `scripts/test-server-integration.sh` cannot execute because this host has no
  `docker` command. `scripts/build-release-apk.sh` produced signed unpublished
  `0.2.1+7`; `hayer-0.2.1-7.apk` and `hayer.apk` are each 104,876,403 bytes and
  both manifests verify at SHA-256
  `0ac17018b52c8685eaa783836bb2c79da44ff1fe9ba1af5e35cf6c0a7da7de0f`.
  `apksigner verify --verbose` confirms APK Signature Scheme v2 and `aapt2`
  confirms `sa.almou.hayer` version code 7/name 0.2.1, min SDK 26, target SDK
  36. No deployment, publish, minimum-build change, push, or tag was performed.
- 2026-09-08: completed P05 saved places and reusable shortlists. The consumer
  stores up to 100 local snapshots in secure storage, organized as Want to try
  or Favorites with optional 500-character private notes; save/remove actions
  are available from swipe and result cards. The bilingual saved screen states
  that data is not synced or exportable and may be lost with app data. Users
  can select 2–20 places within one supported search area and start solo or
  multiplayer rooms, optionally requesting up to five fresh ideas.
  `CreateSessionRequest` sends ordered IDs and a bounded fresh count only. The
  server re-resolves every identity from the eligible catalog, preserves the
  selected prefix, excludes duplicate discoveries, survives fresh-source
  failure with a saved-only room, and rejects missing/ineligible selections.
  The client fails closed if an older server does not preserve that prefix.
  Notes and cached snapshots are excluded from the API; raw save counts are not
  collected. `shortlist_used` is recorded only for a successfully created room.
  The architecture and unit/widget-test skills guided the local store,
  repository/controller/UI separation and privacy/serialization regressions.
- 2026-09-08: pinned final `scripts/preflight.sh` passed Serverpod generation,
  formatting, fatal-info analysis of server/generated client/app/admin, 96
  server tests, 119 app tests, eight admin tests, shell syntax, and diff checks.
  Three new real-PostGIS cases cover saved ordering/reuse analytics, bounded
  fresh deduplication, and malformed/unavailable IDs, but
  `scripts/test-server-integration.sh` cannot execute because this host has no
  `docker` command. `scripts/build-release-apk.sh` produced signed unpublished
  `0.2.1+7`; `hayer-0.2.1-7.apk` and `hayer.apk` are each 104,040,735 bytes and
  both manifests verify at SHA-256
  `cd87705bb266d2878e9f3122e9af1ab830ba9bc3ecfdc77679c7e81734954c18`.
  `apksigner verify --verbose` confirms APK Signature Scheme v2 and `aapt2`
  confirms `sa.almou.hayer` version code 7/name 0.2.1, min SDK 26, target SDK
  36. No deployment, publish, minimum-build change, push, or tag was performed.
- 2026-09-08: implemented audit G02 across the consumer, Serverpod, and admin
  dashboard. The event contract now separates deck inclusion from a measured
  500 ms foreground card impression, details/results views, destination choice
  confirmation/change, no-match completion, queue failure/recovery, room
  completion, and actual matched-place facts. Each client journey uses a random
  in-memory UUID with schema, build, platform, and language metadata; it is not
  written to secure/local storage and no installation identity was added.
  Client events are allowlisted, authenticated, membership/card validated,
  range bounded, rate limited, and best effort; the server owns authoritative
  swipe/choice/outcome facts and deduplicates impressions per member/card.
  Migration `20260908110049218-decision-analytics` is additive and preserves
  the custom PostGIS fresh-database definition. The admin place table now
  distinguishes deck inclusions from card impressions. Unit/widget-test skills
  guided repository, timer/detail, choice, migration, semantic-attribution,
  idempotency, and privacy regressions.
- 2026-09-08: pinned full preflight passed Serverpod generation, formatting,
  fatal-info analysis of server/generated client/app/admin, 96 server tests,
  105 app tests, 8 admin tests, shell syntax, and `git diff --check`. The signed
  `backend/deploy/releases/hayer-0.2.1-7.apk` and `hayer.apk` alias are
  103,286,395 bytes; both SHA-256 manifests verify at
  `43c27ddfdf54aeb051b8f8844170e91f39ab7822e2f1e91eb176b6d510548dbe`,
  and `apksigner verify --verbose` confirms APK Signature Scheme v2. Docker is
  unavailable, so the compiled real-PostGIS analytics/choice regressions and
  two-device reconnect acceptance remain open. No deployment, publish,
  minimum-build change, push, or tag was performed.
- 2026-09-08: closed the signup half of audit F01 (M7-B) in commit `2a4a20d`,
  taken because it was the only P0 whose files did not overlap the in-flight
  M7-G work. Both causes were confirmed against the pinned dependencies rather
  than assumed: `serverpod_client` 3.4.13 `serverpod_client_shared.dart:559`
  builds the RPC URL from host plus endpoint and carries the method in the
  body, so the exact-match `/api/anonymousIdp/login` rule never matched real
  traffic; `serverpod_auth_idp_server` 3.4.13 `session_extension.dart:8`
  resolves `remoteIpAddress` from the raw TCP peer, which behind the gateway is
  always the proxy, making the 30-accounts/hour quota one shared bucket for
  every client. Changed `backend/deploy/nginx.conf`, `server.dart`, new
  `lib/src/security/public_gateway_access.dart`, and `rate_limiter.dart`; the
  limiter gained an optional transaction because the IdP hook runs inside
  `runInTransactionOrSavepoint` and a second transaction there deadlocks
  against the caller's own `for update` locks. The ceiling stayed at 30/hour:
  the defect was the key, not the number, and lowering it would invalidate the
  31-distinct-clients proof and squeeze carrier-NAT users. Verification:
  93/93 `hayer_server` unit tests and `dart analyze --fatal-infos` passed, and
  `scripts/build-release-apk.sh` produced a signed `hayer-0.2.1-7.apk`.
  `nginx -t` could not run (no container runtime), so a unit test asserts the
  brace-bearing map regexes stay quoted, which otherwise fails nginx at startup.
  `anonymous_idp.dart:62` rethrows any hook failure as
  `AnonymousAccountBlockedException(denied)`, so the client sees `denied`
  rather than `rate_limited`/`retryAfterSeconds`; the refusal is correct and
  only the wording is coarse, and that messaging lives in files held by M7-G.
- 2026-09-08: prioritized the consumer-facing M7-E implementation from audit
  F18/F19/F24–F27. Reused the existing Material themes, taxonomy, routes, and
  session contracts. The responsive-layout skill guided content-based heights,
  wrapping/scrolling, and lazy results; widget-test and static-analysis skills
  guided verification. No new package dependencies or backend changes.
- 2026-09-08: pinned Flutter 3.47.2/Dart 3.13.2 verification passed:
  `build/toolchains/flutter-3.47.2/bin/dart analyze app --fatal-infos` and
  `cd app && ../build/toolchains/flutter-3.47.2/bin/flutter test --no-pub`
  (93 tests). `git diff --check` passed. Map platform rendering is substituted
  in widget tests; those tests verify application state/layout, not native map
  rendering or live geolocation/provider availability. Existing stream/outbox,
  routing, and theme tests remain green. Full device certification and F17's
  realtime convergence contract remain open.
- 2026-09-08: `graft` is unavailable on this environment's PATH. Used checked-in
  graph cards to locate source spans; graph regeneration remains pending in an
  environment with the CLI installed.
- 2026-09-08: the final startup retry-state regression test and fatal-info
  analysis passed after the full 93-test run. The required
  `FLUTTER_BIN=$PWD/build/toolchains/flutter-3.47.2/bin/flutter bash scripts/build-release-apk.sh`
  succeeded for the final sources and staged the 103.1 MB signed
  `backend/deploy/releases/hayer-0.2.0-6.apk` plus the `hayer.apk` alias. Both
  SHA-256 manifests verify; artifact SHA-256 is
  `d9990a4605bc8bab06e989b68a7a88c90d455093318c7a0114ab22ca4aaf8862`.
  Android `apksigner verify --verbose` passes with APK Signature Scheme v2.
  Build warnings about existing Kotlin plugin migration and missing Cupertino
  icon fonts remain follow-up work. No production deployment, minimum-build
  change, or beta tag was performed.

- 2026-09-08: implemented the owner-revised P01/P03 pass. Swipe cards reuse
  the result details sheet without advancing or voting. Results expose one
  editable My choice action, live aggregate counts, a provisional leader or
  complete group choice, host-ballot tie-breaking, and direct directions.
  Sharing includes the current leader/choice and per-place choice counts.
  P04 runoffs/new rounds are deferred by explicit owner decision.
- 2026-09-08: generated the additive `DestinationChoiceState` protocol and
  `chooseDestination` RPC with Serverpod 3.4.13. Migration
  `20260908061228738-destination-choices` adds nullable destination ID and
  default-zero choice revision to participant rows; the fresh definition
  retains custom PostGIS, indexes, constraints, and foreign keys. Each change
  locks the room before membership/ballots, validates expiry and matched
  candidates, and updates only choice columns and the room revision.
  Same-choice retries are no-ops; stale different choices conflict. Anonymous
  caller identity is resolved server-side; payloads expose aggregate counts
  and only the caller's own ballot. No analytics event is relabeled as a
  destination choice, and no attendance or confirmed visit is inferred.
- 2026-09-08: verification with pinned Flutter 3.47.2/Dart 3.13.2 passed:
  consumer full suite (101 tests), final result/accessibility suite (24),
  final choice suite including editable ballots and lost responses (8),
  backend full unit suite (88), admin suite (8), fatal-info analysis of app,
  admin, server and generated client, formatting, and `git diff --check`.
  Four new real-PostGIS integration cases compile but were not executed:
  Docker/server binaries and a listening local test database are unavailable.
  They cover concurrent/retried changes, heartbeat overlap, tie-breaking,
  membership/candidate/expiry validation, and late joins. These are not a
  substitute for two-device or production acceptance.
- 2026-09-08: the unit/widget-test and static-analysis skills guided tally,
  retry, RTL and large-text verification. Postgres concurrency guidance
  informed short transactions and consistent lock ordering. The widget-preview
  skill added an isolated choice-control preview; its initial generated
  scaffold lacked dependencies. Recreating it allowed web compilation, but
  the watcher repeatedly reloaded without a browser connected; it was stopped,
  and no visual/device certification is claimed. Graft graph cards and tgrep
  guided navigation; `graft build` could not run because the CLI is absent.
- 2026-09-08: `scripts/build-release-apk.sh` succeeded for unpublished
  `0.2.1+7` using the pinned Flutter toolchain. Staged
  `backend/deploy/releases/hayer-0.2.1-7.apk` and the local `hayer.apk` alias
  (103,106,171 bytes); both SHA-256 manifests verify. Artifact SHA-256:
  `bb28c7ecf070c119eb480a4d5b2d64f7a2390cad4739256686e27a5c3ef65120`.
  APK Signature Scheme v2 verifies with `apksigner`. Existing Kotlin plugin
  migration and Cupertino icon-font warnings remain follow-ups.
  Do not publish until safety gates and live choice acceptance pass; deploy
  the additive migration/server before the client. An old server omits
  `destinationChoices`, so build 7 keeps legacy results without unsupported
  actions. No deployment, minimum-build change, push, or beta tag was performed.
- 2026-09-08: synchronized the repository overview, consumer/server/client
  READMEs, generated-client endpoint guide, server/client changelogs, and
  deployment runbook with P01 and the owner-revised P03 contract. The docs now
  distinguish swipe likes from destination ballots, specify editable
  single-choice plurality and host-ballot tie behavior, cover late joins and
  stale/lost-response reconciliation, and require server/migration verification
  before replacing the served build-7 APK.

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
- 2026-09-08: replaced invented straight-line travel times with a simple
  Google Directions traffic estimate. Hayer requests the alternatives once,
  selects the shortest traffic-aware duration (or normal duration when traffic
  is absent), caches it briefly, rate-limits source traffic, and silently falls
  back to localized straight-line distance. Multiplayer guests are prompted to
  keep the host search location or use their current location for only their
  own labels; the choice is device-local and precise guest coordinates are not
  stored in the session or analytics. The expanded admin System policy controls
  enablement, guest-location availability/default, cache duration, and request
  rate/burst. Migration `20260907165202325-route-estimates` adds bounded policy
  fields while preserving the custom PostGIS clean-database definition. A live
  fixed-coordinate Riyadh canary returned HTTP 200 and parsed a traffic-aware
  13,287 m / 1,009 s route. `scripts/preflight.sh` passed generated code,
  formatting, fatal-info analysis, 75 backend tests, 73 consumer tests, and
  eight admin tests; the connected Dart/Flutter MCP analyzer also reported no
  errors. Regression checks cover personal-distance fallback and clearing the
  previous card's route while its replacement loads. The signed `0.2.0+6` APK
  is 102,286,703 bytes, targets SDK 36, and verifies with APK Signature Scheme
  v2. Both release aliases have SHA-256
  `5e755b2ca02e946dfe7addb76c31fd3e94f7d406dac531d3f7f5d5e17f4b6ae3`.
  Applying the migration and exercising the choice on two physical devices
  remain deployment/manual gates.

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
- 2026-09-07: Keep route estimates intentionally lightweight: scrape one
  Google driving-directions response per origin/place pair, prefer the fastest
  returned traffic duration, prefix the user-facing value with `~`, and use
  straight-line distance as the non-blocking fallback. A guest may opt into
  using their current location for personal labels, but this never changes the
  host-anchored deck, votes, result ordering, session data, or analytics. Keep
  the feature and its operational limits adjustable in the protected admin
  System policy.
- 2026-09-09: Split parallel agent development by worktree and role rather
  than by coordination. Codex keeps the primary worktree on `main` and owns
  the back end, generated protocol, migrations, delivery scripts, and the M7
  safety milestone. Claude works from `.claude/worktrees/claude-lane` on
  `worktree-claude-lane` and owns the consumer app and admin dashboard front
  ends. Isolation is filesystem-level, so the two never contend for a working
  directory and meet only as ordinary merges on `main`. Because the split
  protects committed state only, pending front-end work is handed over by
  committing it, and the F01 join limiter moves to Codex's lane with the rest
  of `backend/hayer_server/`.
- 2026-09-09: Give each lane its own log file in its own worktree rather than
  appending both lanes' narrative to this tracker. Checkpoints, evidence,
  handoffs, and lane-local decisions were the only sections both agents grew,
  and they are exactly the sections that carry no cross-lane meaning; moving
  them to `lane-frontend.md` and `lane-backend.md` removes the merge surface
  without splitting the single source of truth for milestones, decisions, and
  contracts. The milestone checklist stays here so one file still answers what
  is done, and a lane log answers how.
- 2026-09-10: Bound a place photo's decode by width alone rather than by the
  box it is drawn in. `ResizeImage` defaults to `ResizeImagePolicy.exact`,
  which resizes to exactly the width *and* height it is given and ignores the
  source's aspect ratio, and `cached_network_image` gives no way to ask for
  the fitting policy instead. A single width leaves the height to the photo,
  so the bound has to be wide enough that the resulting height still covers
  the box; the client assumes photos are no wider than 16:9, which holds for
  everything the extractor's `=w1600` request returns.

- 2026-09-11: A live refresh now persists every place the provider returned,
  not the deck the caller selected. Persisting `policy.select`'s output meant
  the shared catalog inherited one caller's `deckSize` and price ceiling, so
  candidates the extractor had already paid to fetch were discarded and the
  next request re-fetched them. `PlaceSearchService` returns the deck and the
  observation set separately; the deck still honours the caller's filter while
  the catalog keeps everything eligible for the area, and cache reads re-apply
  price and policy against the stored rows.
- 2026-09-11: Audit diffs must not carry Serverpod's `__className__` marker.
  Flattening a model with `toJson()` into `AdminAuditRow`'s free-form
  `Map<String, String>` copied the marker, and `Protocol.deserialize`
  dispatches on exactly that key, so reading the row back tried to rebuild the
  model from stringified fields and threw. Audit payloads are built as plain
  maps, not as serialized models.
- 2026-09-11: Backend lane ownership moved from Codex to Claude while Codex is
  at its usage limit. The worktree split in "Agent worktrees and role split" no
  longer separates the two agents; backend work continues on `main` in the
  primary worktree and keeps logging to `lane-backend.md`.
