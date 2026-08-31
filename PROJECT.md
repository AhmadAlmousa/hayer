# Hayer execution and progress tracker

Last updated: 2026-08-31

Status: implementation in progress

Current focus: M0 — repository and foundation

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

The public gateway routes `/api/*` to the Serverpod API, `/admin-api/*` to
the Basic-Auth-protected admin API, `/admin/cache/*` to dashboard assets, and
join/download/release/App-Link/media paths to the Serverpod web service. Only
port `8432` is exposed by Compose; PostgreSQL and Insights stay internal.

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

### M0 — Repository and foundation `[~]`

- [x] Study the product brief and pin all product/technical decisions.
- [x] Create this canonical `PROJECT.md` tracker.
- [!] Initialize/push the Git root. The managed workspace exposes `.git` as
  read-only and GitHub SSH authentication currently returns `Permission
  denied (publickey)`.
- [ ] Preserve Vela as a pinned submodule/reference boundary.
- [ ] Scaffold the Flutter consumer, Flutter admin, Serverpod server/client,
  and deployment directories.
- [ ] Pin SDKs/dependencies, generated code, strict analysis, ignores, secret
  templates, and CI.
- [ ] Prove RPC and WSS gateway-prefix routing.

Exit: a fresh clone bootstraps, CI is green, and API plus streaming smoke tests
pass through the intended public gateway.

### M1 — Extractor and shared catalog `[ ]`

- [ ] Add PostGIS/catalog/coverage/calibration/settings/jobs migrations and
  indexes.
- [ ] Implement the Dart web session, calibrated request builder, safe
  positional parser, normalizer, filters, ranking, and diversity.
- [ ] Add sanitized list/focused/empty/degraded fixtures and opt-in Saudi live
  canaries.
- [ ] Implement catalog-first lookup, refresh coalescing, English/Arabic
  fallback, stale suppression, and scheduled retention.

Exit: a Riyadh request makes a deterministic deck, a covered repeat is local,
drift fails safely, and spatial queries use their indexes.

### M2 — Server-authoritative sessions `[ ]`

- [ ] Add anonymous identity, compatibility bootstrap, limits, and secure
  token handling.
- [ ] Implement session/participant/snapshot/swipe/idempotency persistence.
- [ ] Implement create, join, load, swipe, results, expiry, cleanup, majority,
  unanimous, instant, and after-deck matching.
- [ ] Add streaming refresh hints, polling revisions, location suggestions,
  and public join/download/media routes.

Exit: integration tests prove identical decks, private votes, correct
consensus, late joins, retry safety, and expiry.

### M3 — Consumer foundation and design system `[ ]`

- [ ] Configure Riverpod, repositories, routing/deep links, Drift outbox, and
  secure anonymous identity.
- [ ] Implement tokens/components, themes, Nunito, icon/wordmark, localization,
  reduced motion, and responsive/RTL primitives.
- [ ] Add widget previews/goldens and Android permissions/App Links/signing
  configuration.

Exit: the shell restores identity/session after termination, and previews
pass in light, dark, large-text, narrow/wide, and RTL harnesses.

### M4 — Solo vertical `[ ]`

- [ ] Build category, location, options, and mode setup steps.
- [ ] Connect GPS and typed location to catalog-backed creation and all
  underfill/stale/source states.
- [ ] Build durable photo-led swiping, result sorting, details, attribution,
  and external navigation.

Exit: a signed test build completes create, swipe, forced restart/resume, and
results against the backend.

### M5 — Multiplayer vertical `[ ]`

- [ ] Implement ambiguity-free six-character codes, links, QR sharing,
  scanning, and App-Link join routing.
- [ ] Build lobby/progress/late-join/countdown/live-results flows.
- [ ] Verify instant match and after-deck majority/unanimous behavior with
  multiple clients and supported APK versions.

Exit: two or more clients share the identical deck and converge on correct
results through duplicate requests and disconnects.

### M6 — Cache administration `[ ]`

- [ ] Protect both dashboard assets and RPCs with one named operator, CSRF,
  exact-origin validation, and append-only audits.
- [ ] Implement KPI trends, catalog/coverage map, filters, record/job/audit
  inspectors, and policy editor.
- [ ] Implement refresh, cancellation, quarantine/restore, invalidation,
  pruning, and validated calibration activation/rollback.

Exit: unauthorized access fails, mutations are reversible/audited, and broken
calibration cannot activate.

### M7 — Reliability and invited beta `[ ]`

- [ ] Complete offline, photo, expiry, source, diagnostics, and update-required
  states without behavioral analytics.
- [ ] Deploy Compose to Unraid, verify TLS/WSS, apply migrations, and restore a
  daily backup.
- [ ] Create an external release keystore; publish the signed APK, checksum,
  download page, and valid `assetlinks.json`.
- [ ] Pass accessibility, performance, security, and latest/previous build
  compatibility gates; tag the beta release.

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

- 2026-08-31: `serverpod_cli 3.4.13` installed successfully.
- 2026-08-31: GitHub SSH probe failed with `Permission denied (publickey)`;
  remote push remains blocked on host credentials.
- 2026-08-31: Docker and Serverpod were initially absent; Docker remains
  unavailable in this agent environment, so Compose runtime validation must
  occur on Unraid or another Docker host.

## Decision and change log

- 2026-08-31: Approved Serverpod-only backend instead of Supabase.
- 2026-08-31: Approved shared PostGIS POI catalog rather than a simple query
  response cache.
- 2026-08-31: Set 72-hour refresh, two attempts, 30-day guarded stale fallback,
  and 365-day retention, all dashboard-controllable.
- 2026-08-31: Added the protected, full-management Flutter web cache dashboard
  with map, audit, quarantine-first removal, and validated calibration rollout.
