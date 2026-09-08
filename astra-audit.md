# Hayer production-readiness audit

Product decision update, 8 September 2026: the owner approved P01 shared
details before swiping and revised P03 to an inline multiplayer election.
Each participant gets one editable My choice ballot; every result shows its
choice count. The highest count wins, with the host's own ballot breaking a
leading tie only. If that ballot is absent or outside the tie, the leaders
remain tied. There is no host-only selection, confirmation dialog, or new
screen. Choices wait for group swiping (or an instant match); late joiners
keep results provisional without erasing prior choices. The owner deferred
P04 runoffs/new rounds to preserve Hayer's low-friction, playful premise.
These changes are implemented for unpublished build 7; the recommendations
below retain their original audit wording. Deployment and real-PostGIS /
two-device acceptance remain separate gates in PROJECT.md.

## 1. Executive Summary

Audit date: 7 September 2026. Repository baseline: commit 2429d51 and the existing working tree. Scope: consumer Flutter application, Flutter administration application, generated API contract, Serverpod backend, PostgreSQL/PostGIS schema and migrations, extraction/calibration pipeline, deployment, operational scripts, and tests.

Remediation update, 8 September 2026: the consumer implementation now addresses
the principal F18/F19/F24–F27 UX defects: immediate startup shell, retryable screen
loads and stale-data notices, GPS selection independent of address enrichment,
explicit location-search states with late-response guards, unrestricted system
text scaling, adaptive controls and swipe content, lazy variable-height results,
keyboard-accessible setup steps, reduced-motion transitions, labeled directions,
and localized fractional distances. All 93 consumer tests and fatal-info analysis
pass. The findings below retain their audit-baseline wording; this is not a new
production-readiness verdict. Physical-device accessibility, live location,
performance, realtime convergence, and the other release gates remain open.
See [`PROJECT.md`](PROJECT.md) for current acceptance status and build evidence.

**Verdict: suitable foundation for a controlled beta, but not ready for a large public rollout as-is.** The principal blockers are lost-update and offline-recovery defects in the main voting journey, a proxy/authentication rate-limit mismatch, and insufficiently reproducible and recoverable deployment. These are targeted engineering problems; neither a frontend rewrite nor a backend/database replacement is warranted.

| Area | Rating | Assessment |
| --- | --- | --- |
| Overall engineering quality | Fair | Strong typed contracts, immutable decks, domain policies, migrations, and useful tests; important cross-layer contracts and concurrency paths remain incorrect. |
| Overall security posture | Fair | Server-side membership and admin checks are substantial. Authentication abuse protection is miswired; passkey verification and admin revocation need tightening; runtime database privileges are excessive. No confirmed Critical vulnerability was established. |
| Overall performance | Fair | Spatial indexing, caching, bounded decks, and preloading are good foundations. Provider queues, repetitive full-session reads, catalog persistence, and analytics will constrain growth. No production latency or capacity claim is justified without measurements. |
| Overall maintainability | Fair | Logical packages and generated DTOs help. Oversized orchestration modules, repeated networking/state logic, and documentation drift make changes harder to reason about. |
| Overall UX quality | Fair | Clear create/join/swipe/results concept, bilingual support, and a coherent Material-based theme. Offline confidence, failure recovery, location setup, and large-text accessibility are weaker than the happy path. |
| Overall production readiness | Poor | Correctness defects affect the core journey. Cold startup depends on an external provider, release dependencies are not consistently locked, CI is manual, and recovery is not sufficiently verified. |

### Architecture and primary journeys

Hayer helps an individual or a group choose a nearby restaurant or other place. A host chooses category/subcategories, location, radius, price, visit timing, deck size, and decision rules. The server constructs and persists a deterministic, immutable deck. A group shares a six-character code, QR code, or join link; up to 12 participants vote on the same 10–50 cards. The application presents matches/results and opens directions or sharing. Administrators manage taxonomy, extraction calibration, cached places/coverage, refresh jobs, and analytics.

| Layer | Actual implementation |
| --- | --- |
| Consumer | Android-first Flutter; web build also shipped. Flutter 3.47.2/Dart 3.13.2 toolchain; Riverpod injection, GoRouter, StatefulWidget screen orchestration, Material UI/Material 3 Expressive wrappers, English/Arabic localization. |
| Administration | Separate Flutter web application, responsive dashboard/navigation, passkey login, protected recovery enrollment. |
| Backend/API | Serverpod 3.4.13 monolith. Generated typed RPC clients; HTTP RPC endpoint paths carry the method in the request body. WebSocket session revision notifications. Public bootstrap, authenticated session/place APIs, separately protected administration. |
| Database | PostgreSQL 16/PostGIS, Serverpod ORM and parameterized spatial SQL, schema migrations, unique constraints and spatial indexes. Production pool maximum 15 connections per server process. Database is not directly published by Compose. |
| Authentication/authorization | Anonymous consumer identities with JWT access/refresh tokens. Native secure token storage. Membership and host enforcement on the server. Admin scope plus trusted gateway-origin checks; passkeys; Basic-auth enrollment disabled by default. |
| Place integrations | Logged-out Google Maps web extraction, positional response parsing, host allowlists, configurable calibration; signed Vela calibration synchronization with validation/canaries. Nominatim reverse geocoding; OpenFreeMap maps; Google MLKit QR scanning on Android. No official Places API credential required by this design. |
| Persistence/storage | Immutable session place snapshots in PostgreSQL. Shared place catalog/coverage cache. Native Drift pending-swipe outbox; web secure-storage JSON outbox. Active session ID and display name stored locally. APKs served from a mounted releases directory. No product file-upload workflow found. |
| Background work | In-process scheduled maintenance every 15 minutes, refresh-job processing every 30 seconds, analytics aggregation every 5 minutes, signed calibration synchronization hourly; startup runs too. |
| Caching/retention | Default catalog freshness 72 hours, stale fallback 30 days, catalog retention 365 days. Session expiry 24 hours, deletion after a further seven-day recovery window. Analytics events nominally 14 days and hourly aggregates 365 days; backlog caveat in F22. No Redis. |
| Hosting/build | Docker Compose on one Unraid host. Public Cloudflare Tunnel and separate private LAN/Tailscale administration through Nginx Proxy Manager and repository nginx gateway. Digest-pinned base images and native multi-stage server compilation. Flutter web builds; separate signed Android release script. |
| Configuration | Workspace pubspec/lockfile, per-mode Serverpod YAML, bundled and database-active calibration/taxonomy, generated runtime secrets volumes, selected environment flags and client configuration. |
| Tests | Dart unit/domain/extractor tests, Flutter unit/widget tests, PostGIS-backed integration tests, generated Serverpod test tools, canary tools, and a manually triggered CI workflow. |
| Observability/analytics | Serverpod JSON console and persistent session logs, operational metrics, admin mutation audit records, anonymous product events/hourly reports. No end-to-end production alerting or client crash-reporting configuration established. |
| Payments, AI/LLMs, messaging | No payment, AI/LLM, email, SMS, or push-notification integration found. The calibration/extraction mechanism is not an LLM integration. These audit areas are not applicable to the current implementation. |

Architecture anchors: "app/lib/main.dart:15", "app/lib/core/providers.dart", "backend/hayer_server/lib/server.dart:20", "backend/hayer_server/lib/src/api/hayer_session_endpoint.dart", "backend/hayer_server/lib/src/places/catalog_place_service.dart", "backend/hayer_server/config/production.yaml", "backend/deploy/docker-compose.yml".

### Trust boundaries and data flows

    Untrusted consumer / shared join link
        -> public Cloudflare/nginx boundary
        -> Serverpod JWT + membership/host checks
        -> PostgreSQL session, participant, vote and immutable deck records
        -> private revision stream -> authorized client refresh

    Trusted operator device
        -> private LAN/Tailscale/NPM/nginx boundary
        -> origin gate + passkey/admin scope
        -> taxonomy/cache/calibration mutations + audit records

    Server-side place request with user-selected coordinates
        -> Google web / Nominatim (external, untrusted responses)
        -> validation / normalization / cache
        -> immutable session DTOs -> Flutter text/images/external links

    Signed remote calibration -> signature/schema/canary checks -> active config
    Database -> local backup files -> operator-controlled restore process

The gateway is a security boundary, not just a router: backend admin checks rely on headers it overwrites. Anonymous authentication does not make coordinates, display names, membership, or votes non-sensitive. A shared join code is an invitation capability; membership checks do not prevent someone who obtains a valid code from joining by design. The framework/database remains behind the API, so the absence of row-level security is not itself evidence of a BOLA vulnerability.

### Evidence and execution limits

- Reviewed application code, generated contracts/ORM behavior where necessary, schema/migrations, configuration, CI, scripts, test cases, and the relevant locally resolved authentication packages.
- Static analysis with fatal infos passed for the server, consumer, and admin.
- Consumer Flutter tests passed: 66 tests. Admin Flutter tests and server default Dart tests also passed.
- The separate "backend/hayer_server/integration_test" suites were inspected, not executed: Docker is unavailable in this environment. Passing default "dart test" is not evidence that the PostGIS suite passed.
- Reviewed the supplied reference screenshots as historical context only; they predate this commit. Visual conclusions below are grounded in current widget/layout code. No current-device screen-reader, keyboard, browser performance, or screenshot certification was performed.
- No load test, live penetration test, production database query, live canary mutation, deployment, migration, restore, or release build was performed. External firewall, TLS/edge policies, actual database roles, deployed versions, backups, and alert delivery remain unverified.
- No project-local skills were used. Installed PostgreSQL review guidance outside the repository informed the database review. Only this audit report was created; existing application and user changes were preserved.

Severity measures actual consequence; priority measures scheduling. P0 means a rollout blocker or urgent correctness/security fix, not automatically a Critical vulnerability. Confidence: Confirmed means visible implementation/behavior establishes the gap; High confidence means a concrete code path establishes a likely failure but its runtime occurrence was not reproduced; Needs verification means external evidence is required. Effort includes proportionate regression tests: Small = focused change, Medium = coordinated changes in a few modules, Large = cross-layer work and rollout validation.

## 2. Top 10 Issues

| Priority | Issue | Category | Severity | Impact | Effort | Location |
| --- | --- | --- | --- | --- | --- | --- |
| 1 · P0 | F01: Signup quota is shared behind the proxy; strict public RPC rate rules miss real requests | Security | High | Normal onboarding can hit a shared 30/hour ceiling; an attacker can consume it | Medium | nginx.conf:71; server.dart:33 |
| 2 · P0 | F02: Session reads can overwrite committed voting progress | Reliability | High | Repeated/skipped progress, inconsistent completion, stuck voting | Small | hayer_session_endpoint.dart:919 |
| 3 · P0 | F04: Offline commands can be lost, misclassified, or permanently blocked | Reliability | High | Votes appear saved but never synchronize; later sessions inherit a blocked queue | Large | session_repository.dart:82 |
| 4 · P1 | F03: Client guesses which participant is the caller | Reliability | High | Resumed users can start at another participant's card index | Medium | swipe_screen.dart:57; session_bundle.spy.yaml |
| 5 · P1 | F05: Concurrent catalog refreshes use non-atomic inserts | Reliability | High | Successful upstream searches fail under overlapping requests; excessive DB work | Medium | catalog_place_service.dart:277 |
| 6 · P1 | F10: External place canary gates the whole production startup | DevOps | High | Provider trouble prevents cached sessions and administration from coming online | Small | docker-compose.yml:46 |
| 7 · P1 | F08: Upstream work is queued without admission bounds or real cancellation | Performance | High | Load creates long queues and continuing requests after user timeouts | Medium | google_web_place_source.dart:184; catalog_place_service.dart:181 |
| 8 · P1 | F11: Production native dependencies are re-resolved without the committed lockfile | DevOps | High | Released server can differ from tested dependency graph and client build | Medium | Dockerfile.production:41 |
| 9 · P1 | F15: Backup recovery has path/atomicity gaps and only local protection | DevOps | High | Recovery can fail or partially restore when urgently needed | Medium | backup-loop.sh:21; restore-backup.sh:15 |
| 10 · P1 | F12: Runtime database connection uses the bootstrap superuser role | Security | High | A backend/credential compromise has database-administrator impact | Medium | docker-compose.yml:101; production.yaml:36 |

The remaining P1 items, particularly passkey verification, CI enforcement, screen failure recovery, and accessibility, are also pre-rollout work. Ranking is not permission to defer them indefinitely.

## 3. Detailed Findings

### F01 — Proxy identity and RPC routing invalidate the intended signup/join protection

Category: Security

Severity: High

Confidence: Confirmed

Location: "backend/deploy/nginx.conf:12", ":71", ":76"; "backend/hayer_server/lib/server.dart:33"; "backend/hayer_server/lib/src/auth/anonymous_idp_endpoint.dart".

What I found: The strict nginx locations target "/api/anonymousIdp/login" and "/api/hayerSession/join". Serverpod 3.4.13 sends HTTP RPCs to the endpoint path, such as "/api/anonymousIdp", with the method in the body. Normal calls hit the generic 30 requests/second rule instead. Separately, the anonymous provider's 30-account/hour quota uses the TCP peer IP, which is the shared gateway in this deployment.

Why it matters: Legitimate new users share a small signup budget. An unauthenticated actor can consume that budget and deny onboarding. The intended stricter public login/join rules do not apply to ordinary SDK traffic.

Evidence: Resolved serverpod_client 3.4.13 "lib/src/serverpod_client_shared.dart:558" builds the URL from host + endpoint. Resolved serverpod_auth_idp_server 3.4.13 "anonymous_idp_utils.dart:47" uses "session.remoteIpAddress"; "lib/src/utils/session_extension.dart:8" reads "request.connectionInfo.remote.address". The repository uses the unmodified anonymous endpoint. The generic edge rule and application per-user create/join/swipe limits do exist; this is not a finding of universally absent rate limiting.

Exploitability: Public, low complexity for quota exhaustion. Spoofing the edge's CF-Connecting-IP key additionally requires reaching an origin that accepts untrusted headers; actual firewall isolation was not verified.

Recommended fix: Rate-limit the actual anonymous endpoint path. Implement method-aware join limits on the server, retaining per-user limits and adding a trusted client-IP budget. Overwrite a canonical client-IP header at the gateway and accept it only from explicitly trusted ingress; never trust arbitrary forwarded headers. Fix the framework limiter integration or replace its proxy-blind quota with the verified equivalent, rather than simply increasing the shared ceiling. Test 31 distinct clients and repeated attempts from one client through the real gateway. Verify direct-origin access and forged CF headers cannot bypass controls.

Effort: Medium

Priority: P0

### F02 — A read-side heartbeat can overwrite committed swipe progress

Category: Reliability

Severity: High

Confidence: Confirmed

Location: "backend/hayer_server/lib/src/api/hayer_session_endpoint.dart:919", especially 931–939; swipe transaction at 545–682.

What I found: "_loadById" reads a participant, modifies lastSeenAt, then updates the entire row outside the voting transaction. A concurrent swipe can commit currentIndex/hasCompleted after that read but before the heartbeat update.

Why it matters: The heartbeat writes old progress over the newly committed values. A subsequent replay of the same vote can return without advancing progress, leaving the participant stuck. These reads occur during normal loading, results, and real-time refresh, not just unusual administration.

Evidence: "ParticipantRow.db.updateRow(session, participant)" at 939 supplies no column restriction. The resolved Serverpod PostgreSQL adapter, "database_connection.dart:250", defaults to all managed columns. Concrete interleaving: load reads index 4; swipe commits index 5; load updates lastSeenAt together with stale index 4. The expiry branch at 933–936 similarly writes a previously read session row.

Recommended fix: Update only lastSeenAt, preferably with a throttled conditional update. Make expiry a narrow conditional state transition so it cannot overwrite unrelated fields or revisions. Retain the existing voting row locks. Add a PostGIS regression that pauses a read after membership lookup, commits a swipe, then resumes the heartbeat and asserts monotonic progress.

Example implementation:

```dart
participant.lastSeenAt = now;
await ParticipantRow.db.updateRow(
  session,
  participant,
  columns: (table) => [table.lastSeenAt],
);
```

Handle expiry separately through a conditional update/transaction rather than a whole stale row. This example is a recommendation, not an applied application edit.

Effort: Small

Priority: P0

### F03 — Caller identity is inferred from presence timestamps

Category: Reliability

Severity: High

Confidence: Confirmed

Location: "app/lib/features/swipe/swipe_screen.dart:51"; "backend/hayer_server/lib/src/protocol/session_bundle.spy.yaml"; "backend/hayer_server/lib/src/protocol/participant_view.spy.yaml".

What I found: Swipe initialization chooses the participant with the newest lastSeenAt and uses that participant's currentIndex. The response contains participant IDs but does not identify which belongs to the authenticated caller. Initialization also retains an existing initialBundle after flushing pending commands.

Why it matters: Another participant's activity or a stale lobby bundle can select the wrong starting card/progress. Server-side membership prevents voting as that other person, so this is a correctness defect, not a demonstrated IDOR.

Evidence: "participants.reduce((a, b) => a.lastSeenAt.isAfter(b.lastSeenAt) ? a : b)" at 59–61; "_bundle ?? await ...load" at 53–55.

Recommended fix: Add a server-populated callerParticipantId or explicit myProgress to SessionBundle, derived from verified membership. Do not expose authentication user IDs. After replay, reconcile against a fresh authoritative snapshot even when navigation provided a bundle. Update generated protocol, both clients, compatibility policy, and resume tests together.

Effort: Medium

Priority: P1

### F04 — The offline outbox does not guarantee durable, ordered, recoverable voting

Category: Reliability

Severity: High

Confidence: Confirmed

Location: "app/lib/data/session_repository.dart:82"; "app/lib/data/pending_swipe_store.dart"; "app/lib/data/local/app_database.dart"; "app/lib/features/swipe/swipe_screen.dart:237"; "backend/hayer_server/lib/src/api/hayer_session_endpoint.dart:555".

What I found: A vote is sent before being persisted. Every exception, including permanent API rejection, becomes an offline command. Replay stops at the first error across the whole queue and is only triggered by SwipeScreen initialization. Later live votes can bypass pending earlier positions. Only pending swipes, not the immutable deck/progress snapshot, are stored locally.

Why it matters: Process death can lose a vote; an expired-session command can block unrelated new-session commands forever; a user can finish visually without their decisions reaching the server. Relaunching without connectivity cannot reconstruct the session from the saved ID alone.

Evidence: Send first at 98–102, catch-all enqueue at 103–114, global replay/break at 118–136; the only application flushQueue call is swipe_screen.dart:52. Undo can decrement repeatedly at 237–241, whereas the server only permits changing the most recent vote at 600–605. The server checks active status before duplicate acknowledgement, so replay of a successful final vote after a lost response can be rejected once the room is completed. Web storage also uses a read/modify/write list without serialization.

Recommended fix: Persist before sending and use one ordered dispatcher per identity/session. Distinguish transport failures from terminal rejection; retry transient failures with jitter, reconcile conflicts, and quarantine/expire terminal records without blocking other sessions. Replay on reconnect/resume and while results are open. Persist the immutable deck and confirmed/pending progress if offline resume is promised. Bound queue size/age and prevent cross-identity replay. Make duplicate acknowledgement valid after completion where the exact previously accepted command is proven. Constrain undo to the backend contract and reconcile its revision. Use finally/error recovery when local storage fails; show pending versus confirmed status instead of reporting every rejection as offline success.

Example implementation: State sequence should be "persist command -> send oldest eligible command -> acknowledge/remove atomically -> advance confirmed progress", with pending UI progress explicitly separate.

Effort: Large

Priority: P0

### F05 — Catalog persistence races and performs hundreds of round trips

Category: Reliability

Severity: High

Confidence: High confidence

Location: "backend/hayer_server/lib/src/places/catalog_place_service.dart:277"; "backend/hayer_server/lib/src/storage/poi_catalog_row.spy.yaml"; "backend/hayer_server/lib/src/storage/poi_category_row.spy.yaml"; "backend/hayer_server/lib/src/storage/poi_coverage_row.spy.yaml".

What I found: "_persist" reads whether a place/category/coverage row exists, then inserts or updates it. Different request keys can concurrently refresh overlapping places. A transaction does not make a read-then-insert sequence an atomic upsert.

Why it matters: Both transactions can observe absence; one unique insert then fails, aborting an otherwise successful place refresh. Existing-row updates can also lose category merges. The same loop amplifies database latency and lock duration.

Evidence: Place SELECT/INSERT at 298/335; category SELECT/INSERT at 348/366; coverage SELECT/INSERT at 380/399. Unique identities exist in the schema. Refresh coalescing includes deck size, price, and anchor, so it does not serialize all overlapping identities. With 50 places and four category memberships, the loop can perform about 500 database operations before coverage work; this is a code-derived estimate, not a benchmark. The race was not reproduced against PostGIS during this audit.

Recommended fix: Use batched, parameterized INSERT ... ON CONFLICT operations with explicit merge semantics, preserving quarantine and first-seen fields. Order affected keys consistently to reduce deadlocks. Avoid one SELECT per place/category. Add concurrent live-refresh tests with different filters/deck sizes but overlapping provider IDs. Implement F06's provenance correction in the same persistence change, without changing existing immutable session decks.

Effort: Medium

Priority: P1

### F06 — Multi-category searches incorrectly label every returned place with every selected category

Category: Reliability

Severity: Medium

Confidence: Confirmed

Location: "backend/hayer_server/lib/src/places/catalog_place_service.dart:49", ":305", ":347", ":442".

What I found: All requested subcategory IDs are merged into every place and persisted as category evidence. The live source already records the particular evidence category, but persistence broadens it to the entire request. Rehydration chooses the first category as evidence rather than preserving provenance.

Why it matters: A place returned for one cuisine/type can later satisfy another unrelated cache filter. Cached decks can diverge from live category selection and balancing, undermining the main product promise.

Evidence: "persistedCategoryIds = {categoryId, ...subcategoryIds}"; every place merges "...categoryIds"; evidence rows are created "for (final category in categoryIds)". Cached candidates use "row.categoryIds.firstOrNull".

Recommended fix: Persist only per-place observed evidence and valid parent taxonomy relationships; keep the query's coverage categories separate. Reconstruct all relevant evidence for balanced selection. Version or invalidate contaminated catalog/category evidence and rebuild it gradually; do not rewrite past session snapshots. Test two disjoint cuisine queries, their union, and subsequent individual cached requests.

Effort: Medium

Priority: P1

### F07 — Shared search/cache selection can violate the caller's exact selection constraints

Category: Reliability

Severity: Medium

Confidence: Confirmed

Location: "backend/hayer_server/lib/src/places/catalog_place_service.dart:98", ":127"; "backend/hayer_server/lib/src/places/catalog_spatial_query.dart:3".

What I found: Coalescing rounds coordinates to three decimal places but returns the first caller's already-selected snapshots unchanged. Separately, the spatial candidate query applies LIMIT 500 without category/price filtering or deterministic ordering; those filters happen later in Dart.

Why it matters: Nearby simultaneous callers can receive distances and radius inclusion calculated for someone else's center. In a dense catalog, the first arbitrary 500 rows can exclude valid requested categories, causing unnecessary upstream work or undersized results even when relevant cached places exist.

Evidence: Rounded latitude/longitude are part of refreshKey, followed by "return live" without caller-specific policy selection. Both spatial SQL variants end with an unordered LIMIT 500.

Recommended fix: Coalesce reusable raw candidates, then apply exact center/distance/radius/price/category policy per caller; alternatively use exact request keys initially. Apply selective category/price predicates and a deterministic, product-appropriate bounded ordering before limiting database candidates. Validate with boundary-distance tests and a dense mixed-category PostGIS fixture; inspect EXPLAIN before adding indexes.

Effort: Medium

Priority: P2

### F08 — Provider throttling has unbounded waiting and deadlines do not cancel work

Category: Performance

Severity: High

Confidence: High confidence

Location: "backend/hayer_server/lib/src/places/google_web_place_source.dart:125", ":184"; "backend/hayer_server/lib/src/places/catalog_place_service.dart:181"; "backend/hayer_server/lib/src/places/google_web_session.dart:55"; "backend/hayer_server/lib/src/places/place_services.dart:18".

What I found: The request gate serializes an unlimited Future chain behind a default 30 requests/minute budget. A deck's 30-second timeout does not remove queued requests or cancel the search it wraps. HTTP GETs buffer complete bodies before size validation, and automatic redirects are not checked before each network hop. Each retained calibration instance owns its own source/gate/client.

Why it matters: Concurrent cold searches and suggestions can create long queues, consume memory, and continue using upstream capacity after the client has already timed out. Post-buffer size checks do not bound peak response memory. Scale impact needs measurement, but the missing admission/cancellation bounds are visible in code. Dart explicitly documents that a timed-out Future can continue executing. [Dart timeout semantics](https://api.dart.dev/dart-async/Future/timeout.html).

Evidence: "_tail.then((_) => _acquireOne())" has no queue cap or cancellation; ".timeout(remaining)" only wraps buildDeck. The 5 MiB response limit is checked after "_client.get" completes. Initial HTTPS host allowlisting exists, so this is not evidence of arbitrary public URL SSRF.

Exploitability: Authenticated consumers can generate bounded-per-user but collectively excessive work; denial-of-service/resource exposure rather than demonstrated code execution. Redirect exploitation would additionally require an allowed upstream to redirect to an unsafe destination.

Recommended fix: Introduce a shared, bounded provider admission controller with queue length, deadline, cancellation, fair operation budgets, and observable overload rejection. Propagate remaining time through gate, fetch, and retry; abort network operations when supported. Stream with a byte limit and reject/validate every redirect before following it. Keep only needed calibration clients and close retired ones. Preserve stale-cache fallback and return a clear retryable busy state; do not just raise the provider request rate.

Effort: Medium

Priority: P1

### F09 — Reverse-geocoding limits and cache lifetime are not application-wide

Category: Performance

Severity: Medium

Confidence: Confirmed

Location: "backend/hayer_server/lib/src/places/reverse_geocoding_service.dart:20"; "backend/hayer_server/lib/src/api/place_endpoint.dart:13"; "backend/hayer_server/lib/src/admin/admin_endpoint.dart:27"; "backend/hayer_server/lib/src/places/city_resolution_service.dart:27".

What I found: Three independent geocoders each enforce one request/second and maintain separate queues/caches. Cached entries expire logically but are never evicted unless replaced at the same key; unique coordinates accumulate indefinitely. Queues have no admission limit.

Why it matters: Combined traffic can exceed the public Nominatim service's application-wide limit, leading to service restriction. Long-running process memory and wait time grow with distinct lookups. Nominatim's policy applies its maximum one request/second across the application, not per service instance. [Official usage policy](https://operations.osmfoundation.org/policies/nominatim/).

Evidence: Each listed caller creates "ReverseGeocodingService()". The service holds a Map at line 37; expiry is checked at 61 but no periodic/LRU eviction occurs. Separate request chains begin at 88. An identifying User-Agent and caching are already present.

Recommended fix: Inject one geocoder/egress budget across consumer, analytics, and admin use; use bounded TTL/LRU storage and shared in-flight deduplication. Apply F08's admission/deadline behavior. Make the endpoint operationally switchable. For traffic beyond the public service policy, validate a suitable geocoding service or self-hosted capacity before rollout; do not rely on more parallel instances.

Effort: Medium

Priority: P1

### F10 — A third-party place-source failure can prevent the entire stack starting

Category: DevOps

Severity: High

Confidence: Confirmed

Location: "backend/deploy/docker-compose.yml:46", ":64"; "backend/hayer_server/tool/place_source_canary.dart".

What I found: The server depends on successful completion of the external place canary; the gateway depends on a healthy server.

Why it matters: An upstream outage, response drift, or temporary network restriction during a cold deployment blocks existing cached rooms, results, and private administration as well as new deck creation. This defeats the isolation provided by immutable decks and stale fallback.

Evidence: "place-canary: condition: service_completed_successfully" is a mandatory dependency at 69–70. The canary calls the live place source.

Recommended fix: Keep the canary as a release preflight and ongoing capability check, not a mandatory process-start dependency. Boot database-backed functionality independently, expose degraded place-creation status, use available cache, and alert operators. Test restart with the provider blocked and verify existing rooms/admin remain usable. Do not remove parser validation or activate bad calibration to force startup success.

Effort: Small

Priority: P1

### F11 — The production native build does not consume the tested lockfile

Category: DevOps

Severity: High

Confidence: Confirmed

Location: "backend/hayer_server/Dockerfile.production:41"; "pubspec.lock"; "backend/deploy/docker-compose.yml:3".

What I found: The native build stage constructs a new two-package workspace and runs dart pub get without copying the committed lockfile. The Flutter web stage does copy it. Deployment uses the mutable local image tag hayer-server:local.

Why it matters: Transitive server dependencies can differ from those analyzed/tested and from the web client graph, despite pinning Serverpod itself. Rebuilding the same application commit may produce a different server. Replacing a single local tag also weakens rollback identification.

Evidence: Native COPY instructions at 43–44 include only pubspec files; the generated workspace and resolution occur at 45–54. Compare web-build COPY at 25.

Recommended fix: Preserve an authoritative locked server dependency graph compatible with the native workspace. Either resolve/build from the original workspace using the suitable toolchain or maintain and verify a deliberate native lockfile; do not blindly copy an incompatible Flutter workspace lock and assume enforcement. Fail the build if resolution changes the expected graph. Test/build the resulting production image, tag it by commit/digest, and retain the previous known-good image plus migration compatibility information.

Effort: Medium

Priority: P1

### F12 — Fresh deployments run the application as a database superuser

Category: Security

Severity: High

Confidence: Confirmed

Location: "backend/deploy/docker-compose.yml:101"; "backend/hayer_server/config/production.yaml:32"; "backend/hayer_server/Dockerfile.production:84".

What I found: Compose initializes PostgreSQL with POSTGRES_USER=hayer and the application connects as hayer. No separate migration and runtime roles are defined. The production command applies migrations on every startup.

Why it matters: A compromised application or database credential has substantially more authority than normal runtime CRUD requires, including destructive schema/role operations. The official image creates POSTGRES_USER with superuser power. [PostgreSQL image documentation](https://hub.docker.com/_/postgres).

Evidence: Both initialization and runtime configuration name the same role. This establishes the fresh-deployment default; existing deployed volumes could have manually changed roles and must be checked before remediation.

Exploitability: Requires an additional backend/credential/SQL compromise; this finding is not a claim that SQL injection was found. High impact reflects the resulting blast radius.

Recommended fix: Provision a restricted application login and explicit schema/table/sequence privileges; use a separate migrator/owner and bootstrap extension role. Run migrations as an explicit release job before switching compatible application versions. Give backups only required read privileges. Verify rol-superuser/create-role/create-db flags and exercise all Serverpod authentication, logging, and job tables with the restricted role. Do not abruptly revoke privileges on a running deployment without testing and a recovery account.

Effort: Medium

Priority: P1

### F13 — Admin passkey user verification is requested by the client but not checked by the server

Category: Security

Severity: Medium

Confidence: Confirmed

Location: "admin/lib/features/auth/admin_auth_repository.dart:54"; "backend/hayer_server/lib/src/auth/passkey_idp_endpoint.dart:74"; "backend/hayer_server/lib/src/auth/passkey_request_verifier.dart:33"; resolved passkeys_server 1.0.0 "lib/src/passkeys.dart:36", ":70".

What I found: The browser requests userVerification='required'. Repository verification checks client-data type/origin and RP hash, while the pinned passkey verification dependency checks challenge/signature but not user-presence/user-verification flags. Registration similarly does not enforce those flags.

Why it matters: A modified client can weaken the intended PIN/biometric policy without server rejection. Possession of a registered credential and a valid signature is still required; this is not a passkey-signature bypass or unauthenticated takeover.

Evidence: The repository verifier accepts a 32-byte RP hash prefix and never reads the authenticator flags. Pinned verifyLogin verifies the signature and challenge without UP/UV checks. WebAuthn requires server verification of presence and of UV when required. [WebAuthn assertion verification](https://www.w3.org/TR/webauthn-3/#sctn-verifying-assertion).

Exploitability: Requires access to a registered credential/authenticator capable of an assertion without the required verification, plus access to the private administration boundary.

Recommended fix: Enforce minimum authenticator-data structure and signed UP/UV bits for login, and corresponding registration flags. Use a vetted verifier or a small tested extension around the current library, retaining origin, RP ID, challenge, and signature verification. Test cryptographically valid assertions with UV=false and UP=false. Handle signature counters according to authenticator capabilities; do not reject all synced passkeys solely for a zero counter.

Example implementation: After parsing valid authenticator data, require "(flags & 0x01) != 0" and "(flags & 0x04) != 0" for this admin policy; flags validation does not replace signature verification.

Effort: Medium

Priority: P1

### F14 — Admin logout and enrollment revocation do not invalidate already-issued access JWTs

Category: Security

Severity: Medium

Confidence: Confirmed

Location: "backend/hayer_server/lib/src/auth/admin_auth_endpoint.dart:17"; "backend/hayer_server/lib/src/auth/passkey_idp_endpoint.dart:59"; "backend/hayer_server/lib/server.dart:30".

What I found: Both logout and supposedly single-use enrollment revoke the token through the JWT manager. In the pinned implementation this deletes refresh tokens and sends revocation notifications, but fresh HTTP authentication still accepts a correctly signed, unexpired access JWT without a revocation lookup.

Why it matters: A copied admin access token remains usable until expiry after logout. An enrollment access token can be reused for another registration while enrollment is still enabled, despite the single-use comment.

Evidence: Resolved serverpod_auth_core_server 3.4.13 "lib/src/common/integrations/adapters/jwt_token_manager.dart:125" deletes refresh tokens; validateToken at 148 delegates to "lib/src/jwt/business/jwt.dart:80", which verifies the JWT statelessly. Default access lifetime is 10 minutes and refresh lifetime 14 days in jwt_config.dart:174. No repository override or consumed-enrollment record closes that window.

Exploitability: Requires possession of a still-valid bearer token and the private admin gateway; enrollment reuse additionally requires the explicit enrollment flag to remain open. The window is bounded, not permanent.

Recommended fix: Make enrollment completion an atomic, server-recorded one-time operation. For administration, validate a revocable server session/denylist or token-version state on each privileged HTTP request, and test copied-token replay after logout. Keep refresh-token rotation/revocation. Prefer this targeted admin control over forcing stateful validation on every anonymous consumer request.

Effort: Medium

Priority: P1

### F15 — Backup generation and restore are not a verified recovery mechanism

Category: DevOps

Severity: High

Confidence: Confirmed

Location: "backend/deploy/backup-loop.sh:21"; "backend/deploy/restore-backup.sh:15"; "backend/deploy/docker-compose.yml:105", ":127".

What I found: The backup checksum records the absolute container path /backups/..., but restore checks that file path even when the operator supplies a dump elsewhere. Restore depends on the current Compose directory and runs --clean without single-transaction/exit-on-error protection. Backups are local to the same host as the database; no off-host copy or secrets recovery is configured here.

Why it matters: The documented absolute-path restore interface can fail checksum verification for a correctly copied backup. A mid-restore error can leave a partially modified database. Host loss can remove both primary data and local dumps. A dump alone does not recover runtime secrets or Android signing keys.

Evidence: `sha256sum "$target"` emits the /backups path; restore uses `sha256sum -c` without relocating that reference. `docker compose exec` supplies no explicit compose/project path. pg_dump writes directly to the final filename, and backup failure exits the scheduler without an alert mechanism in this repository.

Recommended fix: Write a temporary dump, validate it, then atomically publish dump and a portable checksum. Verify the actual supplied restore file. Select the Compose file/project explicitly. Restore to an isolated database first; use fail-fast transactional restore where supported, quiesce application writes for cutover, and retain the prior database/snapshot. Add encrypted off-host backups, age/failure alerts, separate secret/signing-key escrow, and scheduled restore drills with measured RPO/RTO. Do not test by overwriting production.

Effort: Medium

Priority: P1

### F16 — Existing verification is not an enforced release gate, and cross-layer regressions are missing

Category: Testing

Severity: High

Confidence: Confirmed

Location: ".github/workflows/ci.yml:3"; "backend/hayer_server/integration_test/hayer_session_endpoint_test.dart"; "app/test/data"; "admin/test/widget_test.dart".

What I found: CI only runs on workflow_dispatch. It has valuable generator-drift, analysis, domain/widget, PostGIS, web, and debug-APK checks, but no automatic pull-request/push trigger. No consumer/admin end-to-end integration_test flows were found. Existing backend integration cases do not cover the heartbeat race, real proxy routing/IP behavior, live overlapping catalog persistence, or complete passkey/revocation ceremonies.

Why it matters: A passing local/unit suite can coexist with the cross-layer defects above. A normal merge need not exercise even the substantial tests already available. Production native-image compilation/resolution is not the same build checked by the current workflow.

Evidence: CI lines 3–4 only declare workflow_dispatch; PostGIS tests are a distinct invocation at 82. Existing integration tests cover concurrent create, immutable decks, membership, matching, and expiry—those should be retained, not described as absent.

Recommended fix: Add automatic PR/main triggers and required checks; verify branch protection externally. Run the production-image dependency/build smoke from F11. Add the focused test matrix in section 9, especially gateway/auth, two-device voting/recovery, and controlled concurrency interleavings. Introduce dependency/secret scanning and scheduled advisory review, pin CI actions to reviewed revisions, and keep sensitive signing/deploy jobs separately permissioned. Do not substitute an arbitrary coverage target for behavioral tests.

Effort: Medium

Priority: P1

### F17 — Real-time refresh amplifies reads and can silently stop converging

Category: Performance

Severity: Medium

Confidence: Confirmed

Location: "app/lib/data/session_realtime_listener.dart:38"; "app/lib/features/swipe/swipe_screen.dart:83"; "app/lib/features/results/results_screen.dart:69"; "backend/hayer_server/lib/src/api/hayer_session_endpoint.dart:847", ":1134".

What I found: Each new revision queues a full refresh. The listener advances lastRevision before refresh succeeds, swallows failure, and does not retry that refresh while the stream stays connected. Reconnect attempts occur every five seconds, but there is no HTTP polling fallback. Results calls results and load in parallel even though results already loads the full bundle. Events are process-local.

Why it matters: One failed final refresh can leave a room stale until another event/reconnect. Frequent voting repeatedly transfers immutable decks and performs heartbeat writes. A 12-person, 50-card room can generate roughly 600 × 12 = 7,200 refresh hints if all participants remain subscribed; this is an upper scenario estimate, not measured traffic. A second server replica would not receive the other process's events.

Evidence: Listener lines 53–62 acknowledge revisions before callback success. Every relevant event calls load. Results endpoint itself invokes _loadById. "global: false" appears at server line 1148, and Redis is disabled. Subscriptions are disposed; this is not a blanket listener-leak claim.

Recommended fix: Fetch the immutable deck once; return lightweight caller/participant/result progress thereafter. Coalesce to the highest pending revision and acknowledge only successful refreshes. Retry failed refresh with bounded backoff; add jittered polling when streaming is unavailable and pause off-screen/lifecycle-inactive work. Return results plus needed session metadata in one response. Keep one server replica explicitly until shared events, job claims, and provider budgets are coordinated.

Effort: Medium

Priority: P1

### F18 — Startup and core screen failures lack dependable recovery states

Category: UX

Severity: Medium

Confidence: Confirmed

Location: "app/lib/main.dart:21"; "app/lib/features/swipe/swipe_screen.dart:38", ":244"; "app/lib/features/lobby/lobby_screen.dart:103"; "app/lib/features/results/results_screen.dart:139"; "app/lib/features/setup/setup_screen.dart:612".

What I found: Configuration, bootstrap, auth initialization, and anonymous login precede runApp. Some failures are caught but still delay the first UI; config/auth initialization is outside those catches. Swipe initialization is unawaited without a catch and can leave an indefinite spinner. A failed local enqueue can leave submitting=true. Lobby/results initial errors lack a direct retry action, and stale-data refresh errors are weakly surfaced. Some async catch blocks call setState without checking mounted.

Why it matters: Poor connectivity, expired membership, storage failure, or navigating away during a request can turn routine failures into a blank/startup wait, stuck controls, or a broken recovery journey. ErrorWidget.builder exists, but does not handle arbitrary asynchronous failures.

Evidence: runApp occurs at main.dart:43 after several awaits. Swipe initialization only reaches ready=true on success. _recordSwipe has no try/finally around repository work. Setup catch at 612–615 guards finally but not the error setState.

Recommended fix: Render an application shell immediately, with explicit initializing/offline/retry/update-required states. Bound startup operations without bypassing server authorization/version policy. Give each main screen initial/loading/ready/stale/error/expired states and a useful retry or return-home action. Preserve entered form data and existing results. Use mounted guards and finally for submission state; route uncaught asynchronous failures to redacted reporting. Share the error-state pattern rather than duplicating catches.

Effort: Medium

Priority: P1

### F19 — Location setup discards valid GPS results when address lookup fails

Category: UX

Severity: Medium

Confidence: Confirmed

Location: "app/lib/features/setup/setup_screen.dart:619", ":682", ":719".

What I found: The explicit use-location action waits for reverse geocoding before saving valid coordinates. If the address provider fails, successful GPS acquisition is discarded. The warmed-location path behaves differently and saves coordinates first. Suggestion failures are swallowed with no searching/error/empty distinction, and those direct client calls omit the repository's anonymous-auth recovery wrapper.

Why it matters: A user who granted permission and obtained a fix can still be blocked by a nonessential address label. Failed search looks like no matching places; after an initial authentication outage it may remain unhelpfully silent.

Evidence: Reverse lookup at 699 precedes coordinate assignment at 705; warmed assignment is at 722. Suggestion catch at 637 is empty. The 350 ms debounce is already a useful control and should be retained.

Recommended fix: Save/preview GPS coordinates immediately and enrich the label asynchronously, falling back to coordinates or a localized selected-location label. Use one authenticated location repository, explicit searching/no-results/service-error states, and a retry action. Preserve text and map center through errors, and test permission denial, approximate location, timeout, stale responses, and Arabic keyboard layouts. Unify manual and warmed-location behavior.

Effort: Small

Priority: P1

### F20 — Admin revision checks and audit writes are not atomic with their mutations

Category: Reliability

Severity: Medium

Confidence: High confidence

Location: "backend/hayer_server/lib/src/places/taxonomy_service.dart:119", ":160", ":184"; "backend/hayer_server/lib/src/admin/admin_endpoint.dart:143", ":591", ":620", ":986".

What I found: Draft/policy version checks read a revision and later update the row without a compare-and-swap predicate or lock covering the read. Publishing validates the draft before entering its transaction. Audit records are commonly written after the underlying mutation, in a separate operation.

Why it matters: Concurrent operators can overwrite each other's edits or publish an older validated document while a newer edit is being saved. If audit insertion fails, the mutation may already have succeeded although the UI receives an error and no matching audit record exists.

Evidence: saveDraft reads/checks at 126–127, updates at 157; recordValidation repeats that pattern. publish reads at 189 before transaction at 197. Cache policy checks at 595 and audit at 620 follow separate writes. The unique active-version constraint is present; this is not a claim that two active taxonomy rows can freely coexist.

Exploitability: Requires authenticated operator actions/concurrency or a partial database failure. The security consequence is incomplete attribution, not privilege escalation.

Recommended fix: Use revision/status compare-and-swap or row locking in one short transaction. Bind validation to the exact revision/document hash and re-check it inside publish. Write the audit entry in that mutation transaction, or use a durable transactional audit outbox. Return a conflict with preserved editor state. Test two concurrent saves, validation versus editing, publish versus editing, and injected audit failure.

Effort: Medium

Priority: P1

### F21 — Refresh jobs can report success without refreshing the source data

Category: Reliability

Severity: Medium

Confidence: Confirmed

Location: "backend/hayer_server/lib/src/admin/refresh_job_service.dart:83"; "backend/hayer_server/lib/src/places/catalog_place_service.dart:131".

What I found: The refresh job invalidates coverage and invokes buildDeck, which intentionally returns stale cached data on provider failure. Any returned deck leads to job status succeeded without verifying that a live refresh occurred.

Why it matters: Operators can see a green refresh job while the underlying source problem remains and freshness has not advanced. This undermines the dashboard's recovery workflow.

Evidence: buildDeck returns fallback at 146; job assigns succeeded at 111 with no result-origin/freshness check. Cancellation prevents final success assignment but is not propagated to already running upstream work. Job claims also use read-then-update; the local _running guard only makes that safe from another worker within the current process.

Recommended fix: Return structured source/freshness metadata or provide an explicit refresh-only operation that cannot succeed through stale fallback. Represent succeeded/degraded/failed accurately. Propagate cancellation where practical. Before adding workers, use atomic leased claims, such as a transaction with FOR UPDATE SKIP LOCKED, and recovery based on lease ownership. Add provider-outage and stale-fallback job tests.

Effort: Small

Priority: P2

### F22 — Analytics reads and aggregation throughput are bounded by code structure, not capacity policy

Category: Performance

Severity: Medium

Confidence: High confidence

Location: "backend/hayer_server/lib/src/analytics/analytics_query_service.dart:10", ":253"; "backend/hayer_server/lib/src/analytics/analytics_aggregation_service.dart:18", ":114"; "backend/hayer_server/lib/server.dart:119".

What I found: Live counts load all active session rows and their participants. Reports load all hourly dimension rows in a range, then aggregate/filter in Dart; ranges can span 366 days. The background run processes at most 8 × 500 events every five minutes. Old unprocessed events are not pruned.

Why it matters: Dashboard reads become expensive as usage and place dimensions grow, competing with consumer traffic. Sustained ingestion above roughly 13.3 events/second exceeds the nominal drain ceiling even before processing time, so backlog, reporting lag, and retained storage grow. Actual workload volume is unknown.

Evidence: Full find calls at query_service 14/21/256; range validation at 279 limits time, not rows. Aggregator batch caps at 18/43; prune only includes processedAt != null at 119. Existing skip-locked transactional aggregation is a good foundation.

Recommended fix: Compute counts/sums/grouped series in SQL with only required dimensions/metrics. Avoid loading unrelated place rows for overview KPIs and batch aggregate upserts. Drain within a measured time budget and reschedule promptly while backlog exists, with ingestion/backlog/oldest-event metrics and an explicit failed-event retention policy. Load-test a realistic year of dimensions; add indexes only after representative EXPLAIN evidence. Keep reporting work from exhausting the 15-connection consumer pool.

Effort: Medium

Priority: P2

### F23 — Match analytics can credit the final swiped place instead of the actual match

Category: Other

Severity: Medium

Confidence: Confirmed

Location: "backend/hayer_server/lib/src/api/hayer_session_endpoint.dart:817"; "backend/hayer_server/lib/src/analytics/analytics_query_service.dart".

What I found: A matchCompleted event attaches the place from the command that completed the decision whenever decisionHasMatch is true. In after-deck mode, that final card need not be one of the matched places.

Why it matters: Session-level match counts may be useful, but place-level success attribution becomes misleading and can drive wrong product/cache decisions.

Evidence: Event fields at 824–825 use the current "place.placeId" and "place.snapshot.name", not the computed match set. The application supports after-deck matching, so a match can be established on an earlier card.

Recommended fix: Define separate session-decision and place-match metrics. Emit the former without an arbitrary place ID; emit the latter for the actual matched place(s) according to a documented counting rule. Version the metric meaning and label or rebuild affected historical aggregates where possible. Test an earlier matched card followed by an unmatched final card.

Effort: Small

Priority: P2

### F24 — Global text scaling prevents users from obtaining sufficiently large text

Category: Accessibility

Severity: Medium

Confidence: Confirmed

Location: "app/lib/app/app.dart:63"; "app/lib/features/results/results_screen.dart:373".

What I found: The application clamps system text scaling to 1.0–1.4 for the entire consumer UI. Users requesting larger text do not receive it. Fixed-height result rows and truncated metadata make simply removing the clamp risky without layout work.

Why it matters: Low-vision users can be materially prevented from reading essential controls and place information. WCAG 1.4.4's 200% resizing criterion is a useful web benchmark and informs the native-app testing goal; this audit is not a complete conformance certification. [W3C resize-text guidance](https://www.w3.org/WAI/WCAG22/Understanding/resize-text.html).

Evidence: MediaQuery.withClampedTextScaling(maxScaleFactor: 1.4) wraps all app content at 68–71.

Recommended fix: Support the user's text scaling with adaptive row heights, wrapping, and scrolling; remove the global upper clamp after those constraints are repaired. Test create/join/lobby/swipe/results at 200% and larger native accessibility settings, 320 px width, Arabic/English, landscape, and keyboard-visible states. Any exceptional graphic-only scale constraint should be local and justified, not global.

Effort: Medium

Priority: P1

### F25 — Custom interactions and animation miss accessibility preferences and semantics

Category: Accessibility

Severity: Medium

Confidence: Confirmed

Location: "app/lib/features/setup/setup_timeline.dart:33", ":91", ":184"; "app/lib/core/widgets/fireworks_celebration.dart"; "app/lib/features/results/results_screen.dart:559"; "app/lib/features/swipe/swipe_screen.dart:152".

What I found: The setup timeline has a repeating glow and GestureDetector shortcuts without keyboard-focus/activation behavior. Fireworks and result reorder animations do not consult reduced-motion preferences. Several icon-only controls lack explicit accessible labels/tooltips, including result directions. Important async errors are ordinary text rather than deliberate live announcements.

Why it matters: Keyboard/screen-reader users may not discover shortcuts or understand icon actions; users requesting reduced motion still receive unnecessary animation. The infinite setup glow also consumes rendering work while idle.

Evidence: Timeline controller calls repeat(reverse: true); custom tap handlers are GestureDetectors rather than focusable button actions. The directions button contains only an icon and callback. Main like/dislike controls do have semantic labels and large targets, so the voting UI is not uniformly inaccessible.

Recommended fix: Use focusable Material/InkWell actions with keyboard activation, selected semantics and clear labels; add tooltips/semantic names to icon controls. Honor MediaQuery.disableAnimations, stop the idle glow, and offer an immediate nonanimated match transition. Announce validation/error/sync states without repeatedly interrupting screen readers. Verify focus order, dialog focus return, map alternatives, contrast, and touch targets on actual devices before claiming conformance.

Effort: Medium

Priority: P2

### F26 — Results eagerly construct every fixed-height card and image

Category: Performance

Severity: Medium

Confidence: Confirmed

Location: "app/lib/features/results/results_screen.dart:373", ":457", ":493".

What I found: Results uses a tall Stack with an AnimatedPositioned child for every result instead of a lazy list. Each card has a fixed 162 px extent and an image widget; 84 px thumbnails do not specify a decode-size bound. Place names are forced to one line.

Why it matters: At the supported maximum of 50 visible results, off-screen cards/images still create work and can increase decoded image memory. The fixed rows trade away readable names and flexible large-text layout to animate reordering. Exact memory/frame impact has not been profiled.

Evidence: The loop at 385 constructs all values; height equals values.length × _itemExtent. CachedNetworkImage at 457 sets fit but no decode dimensions. Existing image placeholders and errors are useful and should remain.

Recommended fix: Use a lazy ListView/SliverList with content-adaptive rows and stable keys; retain subtle reordering only if measurements justify its complexity. Request/display appropriately sized thumbnails and set native decode bounds based on logical size × device pixel ratio where supported. Give the place name more room, separate the primary decision information from secondary metadata, and preserve the detail view for full information. Implement alongside F24 to avoid two layout migrations.

Effort: Medium

Priority: P2

### F27 — Distance/ETA presentation overstates precision and bypasses localization

Category: UX

Severity: Medium

Confidence: Confirmed

Location: "app/lib/core/place_distance.dart:8"; "app/lib/features/setup/setup_screen.dart:860"; "app/lib/features/results/results_screen.dart:506".

What I found: Travel time is straight-line distance divided by an assumed 30 km/h, displayed as "N min away" without an estimate qualifier. Distance/time strings are hardcoded English. Setup radius formatting uses integer kilometers for distances above one kilometer, despite a continuously adjustable radius.

Why it matters: Users can mistake a rough estimate for routed travel time; rivers, road layout, traffic, and transport mode can make it substantially wrong. Arabic presentation is incomplete, and a 1.5 km radius can be summarized as 1 km.

Evidence: estimatedTravelMinutes computes ceil(distanceMeters / 500), while formatDistanceWithTravelTime emits literal English. Setup's kilometer formatter uses integer division.

Recommended fix: Prefer an accurately labeled distance with localized units; if the rough time remains, explicitly label it approximate and avoid implying navigation-grade accuracy. Use consistent decimal radius formatting and localized number/unit/plural rules. Directions can remain an external-map action; a paid routing integration is not necessary merely to repair misleading copy.

Effort: Small

Priority: P2

### F28 — Browser security policy is not explicitly controlled in repository deployment

Category: Security

Severity: Low

Confidence: Needs verification

Location: "backend/deploy/nginx.conf"; "app/web/index.html"; "admin/web/index.html".

What I found: No explicit CSP/frame-ancestors, clickjacking, nosniff, or referrer policy is configured in these gateway/web files. Cloudflare/NPM may supply some headers, but their deployed configuration was not available.

Why it matters: In particular, the admin browser's bearer credentials and privileged actions benefit from a tightly controlled script/embedding boundary. Missing CSP is defense-in-depth exposure, not proof of XSS. Consumer bearer authorization is not an ambient auth cookie, so generic cookie-CSRF findings would be misleading.

Evidence: Reviewed nginx contains routing/rate limits but no add_header policy; web entry documents contain no equivalent security policy. No concrete application-controlled unsafe HTML execution sink was established.

Exploitability: Depends on an additional injection issue or successful UI redress and on actual edge headers; not confirmed exploitable from this repository alone.

Recommended fix: Capture response headers from public, private, error, and static routes. Define an intentional policy in a version-controlled layer: frame-ancestors 'none' for admin, nosniff, suitable referrer policy, and a report-only CSP refined into enforcement. Account for Flutter Wasm, worker/assets, map/image hosts, and passkeys before tightening scripts/connect-src. Verify TLS/HSTS at ingress. Do not add restrictive headers blindly and break rendering or authentication.

Effort: Small

Priority: P2

### F29 — Location privacy and anonymous-identity lifecycle are not adequately explained or bounded

Category: Security

Severity: Medium

Confidence: Needs verification

Location: "app/lib/features/setup/setup_screen.dart"; "backend/hayer_server/lib/src/places/city_resolution_service.dart:51"; "backend/hayer_server/lib/src/places/reverse_geocoding_service.dart:115"; "backend/hayer_server/lib/src/storage/maintenance_service.dart:35".

What I found: No in-app privacy notice/deletion entry point was found. The city analytics resolver sends the original coordinates to a street-level reverse endpoint even though only coarse city metadata is needed. Session cleanup exists, but an explicit lifecycle for accumulated anonymous auth identities and local pending records is not defined here. An external privacy policy or operational deletion process may exist but was not supplied.

Why it matters: Users may not understand what is sent to Google/Nominatim or shared with a group, and anonymous identity is not equivalent to anonymous underlying activity. Unbounded identity/local-record retention increases storage and incident scope.

Evidence: CityResolutionService passes latitude/longitude unchanged; the reverse request uses zoom=18. Session records persist beyond visible 24-hour expiry for recovery. Analytics excludes direct user/session IDs, which is a positive control, but does not explain the whole data flow.

Exploitability: No separate remote exploit is established; the risk is avoidable disclosure/retention and inability to fulfill a clear lifecycle policy.

Recommended fix: Publish and link a concise, accurate bilingual notice covering purposes, external providers, group sharing, retention/backups, contact and deletion. Minimize city-only geocoding precision where it still produces reliable city attribution. Define safe cleanup for inactive anonymous identities, expired outbox data, and server records while preserving active references. Document backup deletion lag and verify actual log/backup contents. Obtain jurisdiction-specific privacy review separately; this is not a legal-compliance determination.

Effort: Medium

Priority: P1

### F30 — Generated admin recovery credentials are emitted to container logs

Category: Security

Severity: Medium

Confidence: Confirmed

Location: "backend/hayer_server/tool/init_runtime_config.dart:25"; "backend/deploy/docker-compose.yml:8".

What I found: When initialization generates an admin Basic-auth password, it prints the username/password to stdout. Those values can enter retained container logs or centralized log readers.

Why it matters: Logs become a second secret distribution channel outside the protected secret volume. Recovery enrollment is disabled by default and private-gateway protected, which materially reduces immediate exposure.

Evidence: The generatedAdminPassword branch ends with "password: $password" at line 29. This audit did not copy or disclose any actual credential; no committed production secret was established by the inspected tracked-file/configuration checks.

Exploitability: Requires log access and the ability to reach an enabled enrollment flow, or future misuse of a retained recovery password.

Recommended fix: Preprovision recovery credentials through a protected secret channel or support an explicit one-time, access-controlled retrieval mechanism instead of ordinary stdout. Rotate credentials if these logs have been shared, restrict/redact collectors, and keep enrollment time-limited with F14's one-use token semantics. Add a test that normal initializer output contains no secret values.

Effort: Small

Priority: P2

### F31 — Container privileges, secret mounts, and resource ceilings are broader than required

Category: Security

Severity: Medium

Confidence: Confirmed

Location: "backend/hayer_server/Dockerfile.production:67"; "backend/deploy/docker-compose.yml:71", ":105", ":127".

What I found: The runtime image has no non-root USER. PostgreSQL and backup mount the entire server-secrets volume, although they only need database credentials. Compose does not set application memory/PID limits, capability reduction, no-new-privileges, or a read-only application filesystem.

Why it matters: A compromise in one container can expose unrelated server secrets, and resource exhaustion can affect the single host's other services. Root in a container is not automatically host root, but unnecessarily enlarges the post-compromise surface.

Evidence: Runtime stage ends without USER; postgres mounts server-secrets at /run/hayer and backup mounts the same volume at /run/secrets. Native compilation and read-only mounted secret inputs are already good practices.

Exploitability: Requires a container/application compromise or excessive workload; no container escape was identified.

Recommended fix: Separate DB-only credentials from JWT/admin-sensitive material. Run the application as a dedicated UID, give the initializer only the privileges it needs, and stage writable runtime config in a narrow volume/tmpfs. Add tested capability/no-new-privileges/read-only controls, memory/PID budgets and log rotation. Size limits from load tests and retain headroom; do not apply arbitrary ceilings that create avoidable OOM restarts.

Effort: Medium

Priority: P2

### F32 — Health checks and monitoring do not establish that users can complete the journey

Category: DevOps

Severity: Medium

Confidence: Confirmed

Location: "backend/deploy/docker-compose.yml:39", ":76"; "backend/hayer_server/config/production.yaml:53"; "backend/hayer_server/lib/server.dart:105"; "app/lib/main.dart:20".

What I found: Gateway health is an unconditional 200; server health fetches the framework web root, not database-backed API readiness. Background failures are logged, but no external alert delivery, client crash capture, backup-age alarm, or end-to-end service-level monitoring is configured here.

Why it matters: Containers can appear healthy while login, database operations, refresh jobs, or place discovery fail. A failure may be visible only in a device console or in logs that nobody is watching.

Evidence: Server health URL is port 8082 "/"; gateway-health returns static "ok". Production JSON/persistent logs and admin metrics/audit records exist, so replacing them wholesale or claiming there is no logging would be inaccurate.

Recommended fix: Separate process liveness, DB/API readiness, and degraded provider capability. Add a read-only synthetic check plus tightly scoped scheduled end-to-end checks in a test tenant/environment. Emit/propagate request IDs into redacted client errors and server logs. Alert on API failures/latency, provider queue depth/failures, DB pool saturation, job age, analytics lag and backup age. Add FlutterError/PlatformDispatcher capture with a release ID and privacy filters. Route alerts to an owner and test their delivery; a dashboard alone is not monitoring.

Effort: Medium

Priority: P1

### F33 — Oversized orchestration modules and contradictory documentation increase change risk

Category: Architecture

Severity: Medium

Confidence: Confirmed

Location: "backend/hayer_server/lib/src/api/hayer_session_endpoint.dart"; "backend/hayer_server/lib/src/admin/admin_endpoint.dart"; "admin/lib/admin_app.dart"; "app/lib/features/setup/setup_screen.dart"; "PROJECT.md:105", ":115", ":138".

What I found: Session/admin endpoints combine validation, transactions, analytics, notification and DTO orchestration in thousand-line modules. The admin shell is roughly two thousand lines. Consumer screens mix direct RPC and repository access. Similar geocoding/auth/error/recovery patterns are independently implemented. PROJECT.md describes a production JIT watcher and five-second polling fallback, while the shipped Dockerfile is native and the client retries streaming rather than polling.

Why it matters: Engineers must reconstruct implicit contracts across large files, and stale instructions encourage incorrect implementation/operational assumptions. The duplicated heartbeat, recovery, and config patterns above demonstrate practical consequences rather than merely a file-length preference.

Evidence: _loadById, swipe, consensus/analytics recording and notification share one endpoint; taxonomy/cache/calibration administration shares another. F09 and F19 show inconsistent duplicate service paths. PROJECT.md's domain/service/local persistence description does not match all current behavior.

Recommended fix: After correctness tests, extract focused session command/query services, a catalog persistence boundary, and transactional admin operations. Centralize authenticated client calls and typed recoverable failures, and split admin feature pages from the shell. Update one authoritative architecture/deployment document, marking historical log entries as historical. Remove unused code only after call-site/build verification. These are signs of incremental implementation without complete consolidation; code alone cannot establish whether AI authored them.

Effort: Medium

Priority: P2

### F34 — The public root is still a framework landing page

Category: UX

Severity: Improvement

Confidence: Confirmed

Location: "backend/hayer_server/lib/server.dart:49"; "backend/hayer_server/lib/src/web/routes/root.dart"; "backend/hayer_server/web/templates/built_with_serverpod.html:5"; "backend/deploy/nginx.conf:123".

What I found: The public root routes to the Built with Serverpod template, showing framework links, run mode, and an Open Flutter app link. This is distinct from the Hayer-branded consumer web entry document and APK download route. Replacing it is optional product polish, not a broken route or core rollout blocker.

Why it matters: A first-time visitor to the shared product domain encounters implementation scaffolding rather than a clear explanation/install/open action. The root's title and content describe the framework, not Hayer; public discovery and user confidence suffer. Exposing run mode is minor information disclosure, not a major vulnerability.

Evidence: The template title is Built with Serverpod, and lines 16–17 display served/runmode fields. nginx proxies "/" to the Serverpod web server. Consumer web metadata already includes product title/description/social entries; do not claim those are entirely missing.

Recommended fix: Replace the root with a small accessible Hayer landing page or deliberate product redirect. Explain the existing purpose and offer Android install/open/join actions, bilingual content, accurate canonical/social metadata, and a privacy link. Add appropriate robots/sitemap behavior for public landing content; avoid indexing private session/admin URLs. Do not undertake SEO/SSR rewrites of private Flutter screens.

Effort: Small

Priority: P3

### F35 — The production place supply depends on an undocumented upstream interface

Category: Other

Severity: Medium

Confidence: High confidence

Location: "backend/hayer_server/lib/src/places/google_web_place_source.dart"; "backend/hayer_server/lib/src/places/search_parser.dart"; "backend/hayer_server/lib/src/places/vela_calibration_sync.dart"; "README.md:29".

What I found: The only place-supply path uses logged-out web extraction and positional response calibration, rather than an explicitly supported provider API. Signed updates, canaries, host validation and stale cache reduce failure risk but cannot guarantee the upstream interface, access policy, or content-reuse rights remain suitable for a large rollout.

Why it matters: Upstream anti-automation changes or schema changes can halt fresh supply across the product. Long-lived cached descriptions, reviews, images and attribution need a clear operational and rights policy. No conclusion that this implementation violates terms or GPL is justified from source inspection alone; the Vela checkout is identified as a reference and excluded from shipped Docker inputs.

Evidence: SearchParser decodes calibrated positional data; PlaceServices selects GoogleWebPlaceSource; README describes the reference/calibration arrangement. No provider service agreement or rights assessment was available.

Recommended fix: Assign an owner for upstream compatibility, content permissions/attribution, and sustainable traffic policy. Validate the actual intended deployment and data retention with the relevant provider terms/agreements and qualified review. Maintain representative sanitized fixtures, signature/canary regression tests, rapid calibration rollback and the degraded-cache path. Set a go/no-go threshold for fresh-supply failures. If the current source cannot support the required scale or permissions, evaluate a supported replacement deliberately; do not add an unreviewed fallback or rewrite the whole product preemptively.

Effort: Medium

Priority: P1

### Reviewed areas without an additional confirmed vulnerability

- Authorization: session membership and host checks are server-side, not merely hidden buttons. Admin RPCs require a server-recognized scope and gateway origin signal. Public gateway overwrites admin headers and blocks admin web paths. Integration tests include outsider rejection and private-vote protections. Expand negative tests as described in section 9; do not remove these controls during refactoring.
- Input/query safety: generated typed DTOs, explicit bounds, URL/host checks, parameterized spatial SQL and ORM filters provide meaningful defenses. No confirmed SQL/NoSQL/command/template injection, path traversal, unsafe deserialization, or user-controlled HTML execution was established in the inspected product flows. F08 remains relevant at the upstream HTTP boundary.
- Authentication: anonymous identity is a product choice, not inherently weak password handling. Consumer password reset, account enumeration by email, and MFA flows do not exist. Admin passkeys avoid a normal password login; recovery Basic auth is separately gated. Native secure storage is preferable to plaintext preferences; web storage still depends on origin security, covered by F28.
- Supply chain: root lockfile, matching Serverpod pins, image digests, and Flutter download checksum are positives. The published Serverpod ORM advisory lists 3.4.12 as the 3.x fix, and the resolved 3.4.13 implementation was inspected; it is not reported here as an unfixed SQL injection. Advisory range metadata alone would give a misleading conclusion. [Serverpod advisory and patch table](https://github.com/serverpod/serverpod/security/advisories/GHSA-868m-gf4j-xr8g). This was a targeted advisory/dependency review, not a complete SBOM/CVE or Git-history secret scan; close that limitation through F16's automated scanning and review triage.
- Database: spatial/unique indexes, migrations, immutable snapshots, transaction-protected voting and create idempotency are present. Fix narrow races instead of indiscriminately adding indexes or mandatory RLS to a server-only database.
- Browser/API: public bootstrap/download availability is intentional. Generic open-CORS findings are not justified without examining credential and authorization behavior. Verify actual deployed headers and origin access under F01/F28 rather than assuming edge settings.
- AI/LLM, payments, email/SMS/push and product uploads: no applicable implementation was found; there is no evidence warranting invented prompt-injection, payment-webhook, or upload findings. Re-review those boundaries if introduced.

## 4. Quick Wins

Prioritized by expected benefit relative to implementation size; recommendations still need regression checks.

1. Restrict the read heartbeat to lastSeenAt and make expiry field-scoped (F02). Very small change, direct protection of voting correctness.
2. Correct the anonymous RPC nginx location immediately, then complete the trusted-IP integration (F01). Do not treat the nginx-only fix as full resolution.
3. Remove live provider success from mandatory startup dependencies while retaining validation/preflight checks (F10).
4. Preserve valid GPS coordinates before reverse geocoding, and show a recoverable lookup state (F19).
5. Trigger existing CI automatically and make its checks required (F16). This activates safeguards already written.
6. Stop emitting generated recovery credentials into normal logs (F30).
7. Make refresh jobs distinguish live success from stale fallback (F21).
8. Localize and accurately label distance/radius estimates (F27).
9. Add explicit tooltips/labels and reduced-motion handling for the identified controls (F25); schedule full accessibility verification separately.
10. Replace the framework root page and correct authoritative runtime/polling documentation (F34/F33).

Do not present outbox reconstruction, role separation, or recovery drills as one-line quick fixes; their cross-layer dependencies matter.

## 5. Security Remediation Plan

### Fix immediately

- F01: Repair actual RPC routing and trusted client identity. Keep the admin origin boundary intact and test origin-header spoofing from public/direct access paths.
- Keep admin enrollment disabled except for a supervised short interval until F13/F14 are resolved. If initialization logs have left the trusted operator boundary, rotate the exposed recovery credential under F30.
- F02/F04 are correctness blockers rather than unauthenticated access vulnerabilities, but belong in the same immediate rollout hold because they can invalidate users' decisions.

### Fix before production expansion

- F12: Separate runtime/migration/backup database roles, then run restricted-role integration tests.
- F13/F14: Enforce server-side UP/UV and one-time enrollment; prove that revoked privileged sessions fail on new HTTP requests.
- F08/F09: Bound user-triggered egress and conform to the geocoder's application-wide traffic policy. Enforce streamed size/redirect boundaries.
- F11/F16: Produce a locked, scanned, tested release image; require CI and protect release credentials.
- F20: Make privileged mutation and attribution atomic.
- F29/F35: Verify data handling, user disclosure, upstream permissions and sustainable supply. These are verification gates, not unsupported claims of legal violation.
- F15: Recover both data and essential secrets from a failure outside the primary host.

### Harden later, without losing ownership

- F28/F31: Version-controlled browser policy, non-root runtime, narrow secret mounts, capability/resource restrictions. Header/ingress verification should occur before rollout even if advanced CSP tuning is staged.
- F30/F32: Secret-safe logging, correlation, alert validation and periodic admin credential recovery exercises.
- Revisit distributed authorization/session events and job leases before adding replicas (F17/F21). Preserve per-user API limits and scope checks throughout.

Acceptance evidence should include an automated abuse/auth regression run, externally verified private-origin isolation, a restricted-role release smoke, and a recorded recovery drill. No Critical exploit was confirmed; High-impact findings should not be downgraded merely because the app is currently small.

## 6. Performance Improvement Plan

| Order | Change | Expected real-user/operating effect | How to verify |
| --- | --- | --- | --- |
| 1 | Fix correctness and reduce heartbeat writes (F02), then lighten/coalesce progress refreshes (F17) | Lower DB traffic, transferred bytes, and time to consistent group results | Measure RPC/SQL counts and bytes per 12-person room; inject a failed final refresh |
| 2 | Bound/cancel provider work and consolidate geocoding (F08/F09) | Predictable creation/search wait, fewer wasted external requests, smaller queues and memory | Cold-search burst with provider 429/slow responses; assert deadline and no post-cancellation queue drain |
| 3 | Batch atomic catalog persistence and repair selection/provenance (F05–F07) | Fewer failed refreshes/DB round trips, higher correct cache hit rate, less extraction work | Overlapping refresh test; query-count tracing; dense-city EXPLAIN and cache/live equivalence |
| 4 | Render the shell before nonessential startup network work (F18) | Faster first usable frame and clearer slow/offline startup | Android cold starts and web first-load traces on throttled connections |
| 5 | Lazy adaptive results plus appropriately decoded thumbnails (F24/F26) | Less off-screen image work, lower memory, smoother scrolling and readable larger text | Profile 50-result rooms on a lower-end Android device; frame timing/image-cache memory |
| 6 | Aggregate analytics in SQL and drain backlog by time budget (F22) | Reports stop competing disproportionately with consumer API and storage stays predictable | Realistic month/year data set; p95 report latency, DB pool wait, oldest unprocessed event |

For consumer web, measure navigation-to-visible-content, LCP/INP/CLS where the Flutter renderer exposes meaningful browser metrics, transferred Wasm/JS/assets, and application first-frame/interaction timing. This is a client-rendered Flutter application, not a React hydration problem. No bundle-size, layout-shift, or Core Web Vitals numbers were measured here. Build/profile a release artifact before claiming a huge bundle or recommending rendering-stack changes. Check long-lived static caching and revalidation of index/config separately; cache immutable versioned assets aggressively only when deployment invalidation is reliable.

The highest cost opportunities are fewer extraction/geocoding calls, fewer full-deck refreshes and heartbeat writes, batched catalog writes, bounded analytics retention, and right-sized image decoding. No LLM token bill, payment processor cost, or cloud instance overprovisioning was found to optimize. Do not buy more infrastructure before measuring these paths; add pooling/replicas only after pool wait/capacity evidence and shared-state design.

## 7. Codebase Refactoring Plan

1. **Lock down contracts first.** Add targeted tests for caller identity, progress monotonicity, durable command order, category evidence, and accepted-command replay. Define explicit result types for source freshness and transport/terminal errors. This avoids carrying existing defects into new abstractions.
2. **Separate session commands and queries.** Extract narrow services from HayerSessionEndpoint: authorization/context, create/join/swipe transaction orchestration, read-only snapshots/progress, and notification/analytics scheduling. Keep consensus and immutable-deck policies; do not replace Serverpod or generated models.
3. **Repair the persistence boundary.** Give catalog upsert/evidence/coverage a single tested implementation. Share provider admission and geocoding instances. Keep parsing/calibration independent from persistence and user-specific selection.
4. **Make administration transactional.** Encapsulate taxonomy/policy/calibration mutations with revision checks and audit recording; split AdminEndpoint only along real domain operations. Keep irreversible operations confirmed and attributable.
5. **Consolidate client effects.** Move direct authenticated networking, outbox dispatch, recovery classification and resume reconciliation into repositories/controllers. Use one lifecycle-aware screen-state convention. Extract UI pieces from SetupScreen and admin_app only when doing so reduces coupling or enables meaningful tests.
6. **Align documentation and remove proven leftovers.** Document the native deployment, single-replica limitation, actual reconnect behavior, storage guarantees and backup process. Do not delete historical watcher/reference code merely because production no longer uses it; first confirm development/tooling consumers. Keep generated files generator-owned.

Avoid a blanket architecture migration, converting every StatefulWidget to a view model, or introducing generic repositories for already simple lookups. The benefit comes from owning transactions, state transitions and side effects, not adding layers for their own sake.

## 8. UI/UX Improvement Plan

| Journey/component | Current problem | Desired behavior and recommended change |
| --- | --- | --- |
| First launch / resume | Network work precedes the first app frame; incomplete failure recovery (F18) | Show the shell promptly; communicate connecting/offline/update states; preserve resumable state and offer retry without restarting the application |
| Setup location | A failed address lookup can discard GPS; suggestions fail silently (F19) | Keep selected coordinates, enrich labels progressively, distinguish searching/no results/error, preserve map/text and retry |
| Setup forms | Duplicated async failure paths and ambiguous selection feedback (F18/F25) | Preserve input after server failure, map stable error codes to localized inline feedback, expose selected state to assistive technology, disable only the active submission |
| Lobby / group progress | Refresh failures can leave stale data without a clear explanation (F17/F18) | Show reconnecting/stale status unobtrusively, reconcile automatically, and give a manual retry/home exit for terminal errors |
| Swipe / undo / offline | Pending votes look saved; undo permits unsupported history changes (F03/F04) | Show confirmed versus pending progress; allow only supported undo; reconcile rather than hiding conflicts; ensure the final vote is acknowledged before claiming synchronized completion |
| Results | Eager fixed rows truncate key information; sorting changes animate all cards (F24/F26) | Adaptive lazy rows, room for place name, secondary metadata grouped coherently, useful large-text behavior, motion reduced on request |
| Directions information | Estimated time reads like a routed ETA; mixed-language units (F27) | Localized, qualified estimate or distance-only display; clear labeled directions action |
| Admin editing / jobs | Stale edits and fallback refresh can misleadingly appear successful (F20/F21) | Conflict-aware editing with preserved draft, exact validated revision, honest fresh/degraded/failed job status and actionable recovery |
| Public landing | Framework-first content instead of product context (F34) | Brief bilingual product purpose, clear install/open/join choice, privacy/support information |

Visual direction: retain the existing restrained teal/coral Material language, typography family and reusable components. Do not introduce more cards, gradients or decorative shadows. The meaningful improvements are information hierarchy and readability: make the place name primary, agreement/status secondary, and ratings/reviews/distance supporting information; reduce competing weight and metadata truncation. Use shared spacing/type/status tokens while touching affected components, rather than a cosmetic restyle. Historical screenshots cannot establish current contrast failures; measure current light/dark, selected/disabled and error colors before changing them. Review 320 px/mobile, tablet/admin desktop, keyboard-visible layouts and Arabic RTL on the current build.

State acceptance matrix:

- Setup/join: initial defaults, validation, searching/loading, empty suggestions, denied location, slow provider, API rejection, successful navigation, and navigation-away during submit.
- Lobby/swipe: no room, expired/forbidden room, connecting, partial membership updates, temporarily offline, pending/failed outbox, last-card response loss, reconnect and successful completion.
- Results: still voting, no matches, partial matches, synchronized completion, stale data, API error, external-map launch failure and return navigation. Existing state presentations should be retained where they are correct, not replaced indiscriminately.
- Admin: signed out, canceled passkey dialog, denied origin/scope, expired/revoked session, empty tables, loading/error, stale-edit conflict, failed/degraded/cancelled refresh and post-mutation audit visibility.

These improve time-to-value, task completion and confidence within existing features. No additional engagement features are necessary to address the identified product gaps.

## 9. Testing Plan

Prioritize behavioral evidence, not a coverage percentage. Add regression tests with each fix rather than deferring all testing to a later roadmap phase.

| Order | Highest-value tests | Layer / failure assertion |
| --- | --- | --- |
| 1 | Heartbeat load overlaps committed swipe; expiry overlaps revision update (F02) | Real PostGIS, controlled barriers; progress/completion/revision never revert |
| 2 | Actual SDK RPCs through nginx, trusted/forged IP headers, 31 distinct users versus one abusive source (F01) | Container gateway + HTTP; correct limit bucket and private-origin isolation |
| 3 | Two participants with different progress and lastSeenAt order, stale initial bundle after replay (F03) | API DTO + Flutter screen; caller always resumes own exact card |
| 4 | Kill after local persist, lose response after commit/final vote, reconnect, expire one queued session, rotate identity, concurrent web writes, repeated undo (F04) | Repository/storage + two-device end-to-end; no lost/duplicate/misordered votes and no cross-session head-of-line blocking |
| 5 | Overlapping live catalog insert/update; disjoint cuisine queries; nearby coalesced anchors; >500 mixed candidates (F05–F07) | PostGIS + deterministic fake provider; atomic persistence and cache/live policy equivalence |
| 6 | Valid signed passkey with UP/UV false, wrong origin/RP/challenge, expired/replayed challenge, revoked admin token on new HTTP call, reused enrollment token (F13/F14) | Full auth integration with virtual authenticator/fixtures, not only verifier helper tests |
| 7 | Anonymous/outsider/user/host/admin authorization matrix for all relevant mutations, reads and streams | Extend existing membership tests; ensure no private vote leakage or privilege escalation through public routes |
| 8 | Provider delayed/429/malformed/oversized/redirected response; cancellation while queued; geocoder budget across call sites (F08/F09) | Fake HTTP servers and controllable clock; bounded memory/work/deadline, clear degraded result |
| 9 | Restart with provider down, locked production image, migration from previous release, rollback-compatible startup (F10–F12) | Disposable production-like stack; API readiness independent of provider and runtime role has only intended authority |
| 10 | Portable checksum, corrupt dump, failed restore, missing secrets, off-host recovery (F15) | Disposable database only; fail safely and demonstrate documented RPO/RTO |
| 11 | Failed last real-time refresh without any later event; event bursts; blocked WebSocket with working HTTP; background/foreground transitions (F17) | Listener/widget/integration; eventual convergence and coalesced work |
| 12 | Config/auth/local-storage failures; location permission denied; successful GPS plus failed geocoder; navigate away during request (F18/F19) | Widget/controller tests; usable retry state, input preservation, no unhandled async or disposed setState errors |
| 13 | Concurrent admin save/validate/publish and audit failure; refresh returning stale fallback (F20/F21) | PostGIS/admin integration; exact revision, atomic audit, honest outcome |
| 14 | Analytics ingestion above current drain cap, long range/high cardinality, earlier match with unmatched final card (F22/F23) | Query/performance + metric semantic tests; bounded lag and correct attribution |
| 15 | 200% text, 320 px, Arabic/RTL, dark/light, keyboard-only, screen-reader labels/live errors, reduced motion (F24–F27) | Flutter semantics/widget plus real Android TalkBack and current-browser manual checks |
| 16 | Consumer create -> join on second device -> vote -> reconnect -> results -> directions; admin login -> edit conflict -> refresh -> logout | Repeatable E2E smoke on release artifacts; integration_test dependencies alone do not provide these flows |

Keep existing domain/parser/calibration/consensus, immutable-deck, membership, concurrent-create, theme, QR and repository persistence tests. Add malformed and signed-but-invalid calibration fixtures without calling live services in routine unit tests. Live provider checks should be separately budgeted and monitored, not make all deterministic tests flaky. Perform automated SBOM/advisory and redacted history-secret scans; manually triage reachability and patched versions before calling a package vulnerable.

## 10. Production Readiness Checklist

Status refers to readiness for substantial real-user traffic, not a claim that every deployed setting has been inspected.

| Area | Status | Required resolution / evidence |
| --- | --- | --- |
| Security | ❌ Blocking problem | Repair public quota routing/identity (F01); complete privilege/auth/egress controls and regression checks |
| Authentication | ❌ Blocking problem | Onboarding quota correctness; server passkey UV/UP and revocable admin sessions (F01/F13/F14) |
| Authorization | ⚠️ Needs improvement | Core membership/host/admin checks present; add full negative gateway/stream matrix and verify private-origin firewall |
| Database | ❌ Blocking problem | Eliminate stale-row/collision defects and separate runtime role (F02/F05/F12) |
| Error handling | ❌ Blocking problem | Durable recoverable voting and explicit terminal/transient screen states (F04/F18/F19) |
| Performance | ⚠️ Needs improvement | Bound egress and reduce query/refresh amplification; measure representative load (F05/F08/F09/F17/F22/F26) |
| Accessibility | ⚠️ Needs improvement | Remove global scale ceiling safely; keyboard/semantics/reduced-motion and real-device validation (F24/F25) |
| Testing | ⚠️ Needs improvement | Analysis/unit/widget suites pass; run PostGIS and new cross-layer/E2E regressions and make checks mandatory (F16) |
| Logging | ⚠️ Needs improvement | JSON/persistent logs and audits exist; remove recovery secrets, make audit atomic and correlate errors (F20/F30/F32) |
| Monitoring | ❌ Blocking problem | Before large rollout, establish actionable readiness and failure/backup/job alerts with tested delivery (F32) |
| Backups | ❌ Blocking problem | Fix portable/atomic restore; verify off-host data/secret recovery in an isolated drill (F15) |
| CI/CD | ❌ Blocking problem | Automatic required checks, tested locked native image, immutable release/rollback reference (F11/F16) |
| Configuration | ⚠️ Needs improvement | Remove provider startup coupling, document actual native/single-process behavior, verify environment/edge settings (F10/F33) |
| Secrets | ⚠️ Needs improvement | No committed production secret established; remove log emission, narrow mounts and establish recovery/rotation (F15/F30/F31) |
| Rate limiting | ❌ Blocking problem | Correct actual RPC and trusted-IP limits; application-wide egress budgets (F01/F08/F09) |
| Deployment | ❌ Blocking problem | Independent readiness, reproducible release, migration-role separation and tested rollback/recovery (F10–F12/F15) |
| Scaling | ⚠️ Needs improvement | Explicitly single replica until shared events, atomic job leases and global egress are implemented (F17/F21); measure pool/capacity |
| Core foundations | ✅ Ready | Typed contracts, immutable deck design, server-side membership, bounded deck size, spatial schema, native release approach and bilingual foundation are worth preserving |
| TLS/firewall/live roles | ➖ Not applicable / unable to verify | Deployment owner must supply ingress rules, header captures and role inspection; verify before rollout |
| Payments/AI/messaging/uploads | ➖ Not applicable / unable to verify | No corresponding product integration found; re-audit if introduced |

## 11. Recommended Implementation Roadmap

### Phase A — Critical

Objective: make core decisions trustworthy and prevent a release/recovery incident. This phase contains High and Medium findings with rollout-critical consequences; it does not imply a confirmed Critical-severity exploit.

1. Add failing regressions for F01–F05 and fix trusted-IP routing, narrow heartbeat writes, and explicit caller progress.
2. Define the accepted/pending/rejected command contract and rebuild outbox ordering/replay around it (F04). Caller identity from F03 is a prerequisite for reliable reconciliation. Deploy compatible DTO changes before depending on them in clients; use the existing minimum-build mechanism only with a deliberate compatibility rollout.
3. Repair atomic catalog writes and category provenance together (F05/F06). Plan cache evidence invalidation separately from immutable historical session data.
4. Decouple startup from provider capability (F10), lock and validate native release dependencies (F11), and enable required CI now (F16).
5. Implement tested backup/secret recovery (F15) before privilege or migration changes. Then separate migration/runtime roles and use explicit migration release steps (F12).
6. Enforce passkey server verification and one-use/revocable admin sessions (F13/F14); keep enrollment closed outside supervised use. Remove logged recovery secrets where present (F30).
7. Install minimum actionable readiness/backup/API alerts (F32) and assign owners for privacy/provider rollout checks (F29/F35).

Exit evidence: no known progress-reversion or queue-poisoning path in the regression suite; real proxy signup behavior verified; production-like image builds from the intended locked graph; old and new clients handled deliberately; isolated restore demonstrated; privileged authentication replay rejected.

### Phase B — High ROI

Objective: predictable performance and reliable task completion under imperfect networks.

1. Add bounded cancellation-aware upstream admission and one geocoding budget (F08/F09), preserving F10's independent startup/degraded path.
2. Correct exact-anchor and candidate filtering semantics (F07), then measure cache hit rate and SQL/provider work with representative dense locations.
3. Replace full-deck event refresh with coalesced lightweight progress and dependable retry/poll fallback (F17). This depends on F02/F03/F04's corrected state contract.
4. Render the startup shell promptly and unify recoverable screen/form/location states (F18/F19).
5. Repair admin compare-and-swap/audit semantics and honest refresh outcomes (F20/F21).
6. Implement large-text-safe adaptive results and lazy images as one coordinated layout change (F24/F26), plus essential accessibility labels/reduced motion (F25).
7. Complete before-expansion privacy/provider/egress/security acceptance items from section 5; do not treat them as optional product polish.

Exit evidence: successful cold/warm/offline two-device journeys; bounded provider work after cancellation; eventual room convergence after failed refresh; large-text main journeys remain usable; no speculative capacity claim without a measured load profile.

### Phase C — Maintainability

Objective: make safe change and production diagnosis routine, without a rewrite.

1. Extract tested session/catalog/admin service boundaries and consolidate client effects (F33). Depend on stabilized Phase A/B behavior; retain generated contracts and existing domain policies.
2. Move analytics aggregation/query work to bounded SQL operations and correct match attribution (F22/F23). Version metric semantics before historical comparisons.
3. Extend observability, E2E tests, dependency scanning and operational runbooks (F16/F32), including documented event/job/provider/pool budgets.
4. Narrow container secrets/privileges and establish resource/log ceilings from measurements (F31); complete verified browser policies (F28).
5. Make the single-replica constraint explicit. Only if capacity requires additional replicas, implement shared notifications, atomic leased jobs, cross-process provider limits, and connection-budget allocation first (F17/F21). Redis or a separate queue is a conditional tool, not an automatic rewrite requirement.

Exit evidence: an engineer can explain ownership of each transaction, command queue and background job; CI guards those contracts; alerts identify failures with safe context; restore and release instructions work without undocumented local knowledge.

### Phase D — Polish

Objective: improve clarity and perceived professionalism within existing functionality.

1. Localize accurate distance/radius copy (F27); this small fix may be pulled forward independently.
2. Replace framework landing content, add intentional public metadata/privacy navigation, and verify private-route indexing policy (F34).
3. Apply consistent typography/spacing/status hierarchy to the components already being changed; prioritize readable names, clear selection and uncluttered metadata (F25/F26). Do not change colors/shadows solely for taste.
4. Complete real-device accessibility/RTL/keyboard and slow-network acceptance, then remove only proven unused wrappers/fallbacks and align historical documentation (F33).

### Unverified areas and how to close them

| Unverified area | Why it remains open | Required next evidence / resolution |
| --- | --- | --- |
| Deployed private/public exposure, TLS, CORS/security headers and proxy identity | Cloudflare/NPM/firewall settings are external; no live penetration test authorized/performed | Deployment-owner read-only config review, header captures and controlled ingress-negative tests (F01/F28) |
| Actual DB roles, indexes/plans, migrations under load and pool behavior | No live database inspection; Docker unavailable for local PostGIS execution | Disposable production-like PostGIS run, role query, representative EXPLAIN/lock/pool traces and migration rehearsal (F02/F05/F12/F16/F22) |
| Cryptographic passkey ceremony, logout/recovery on actual browser/authenticator | Helper and dependency code inspected, no live enrolled operator exercised | Virtual-authenticator regression plus supervised real-device smoke (F13/F14) |
| Current visual output, contrast, screen-reader/focus behavior and mobile keyboard obstruction | Reference screenshots are historical; widget code is not a current-device conformance test | Current release screenshots/goldens and TalkBack/browser keyboard tests in the matrix above (F24–F26) |
| Web/native load time, frame timing, bundle/image memory, sustained capacity and cost | No release-profile measurements or representative traffic/accounting data supplied | Release builds, low-end device profiling, throttled network traces and staged load test using section 6 metrics |
| Restore success, off-host backups, secret escrow, alert delivery and rollback | Repository describes only part of operations; no destructive/live action taken | Isolated restore drill, retention/backup-age evidence, protected signing-key recovery and tested alert/rollback runbook (F15/F32) |
| Graceful shutdown and in-flight work during deployment | Native server startup is inspected, but SIGTERM/draining behavior was not exercised | Rehearse shutdown during HTTP votes, WebSockets and refresh work in a disposable stack; verify committed commands reconcile, interrupted jobs recover, and the configured stop grace period is sufficient |
| Full dependency/CVE inventory and historical secret exposure | Targeted source/advisory checks are not an exhaustive artifact or history scan | Generate SBOMs for shipped images/APK/web; run advisory/container and redacted Git-history secret scans, triage actual reachability and rotate confirmed exposures (F16/F30) |
| Provider content rights, traffic agreements and privacy compliance | Contracts/policies and legal context were not provided | Documented owner review and applicable policy/qualified advice before scale expansion (F29/F35) |

Final review: the highest-severity findings were rechecked against their code paths and, for proxy IP, ORM whole-row updates, JWT revocation and passkey checks, the pinned dependency implementation. Related symptoms are consolidated under the owning state/persistence/egress contract. No unverified vulnerability was promoted to Critical, no current performance/visual benchmark was invented, and every identified gap above includes a resolution recommendation. **Do not deploy broadly as-is while F01/F02/F04 and the release/recovery gates remain unresolved.**

## 12. Product expansion, Vela reuse, and the POI intelligence roadmap

Added 7 September 2026 in response to the request for stronger consumer features, better results, richer administration, and a POI database suitable for future analysis/commercialization. This section adds proposals; it does not imply that the preceding audit fixes or any new features have been implemented. Existing findings F01–F35 retain their meaning and priority.

### 12.1 Strategic recommendation

**Make Hayer excellent at turning uncertainty into a confident group decision. Borrow Vela's place intelligence and progressive-detail patterns, not its entire navigation application.** Build the admin system around a second goal: explain why that decision did or did not happen, and distinguish weak supply, bad data, poor recommendations, and application failures.

My recommended first product release after the correctness blockers:

1. More balanced, explainable decks, instead of review-count-first ordering alone.
2. A useful place detail sheet reachable before swiping, using fields Hayer already has.
3. A final-choice action and a short runoff/recovery path when the group cannot decide.
4. Save a place/shortlist and start a new room from that shortlist.
5. Accurate card impressions and journey outcomes, surfaced in funnel and POI-quality dashboards.

In parallel, establish canonical POI identities, field provenance, permitted retention, and a rights-aware export boundary. **A large scrape cache is not automatically an accurate, comprehensive, or commercially reusable POI asset.** The strongest differentiated asset is a reliable, lawfully sourced place catalog plus appropriately governed first-party evidence of what Hayer users consider and choose.

#### Commercialization is a design gate, not a future paperwork task

Google's current Maps end-user terms restrict copying, mass downloading/bulk feeds, redistribution/sale, and specified uses in substitute mapping/business-listing datasets; its permissions guidance directs commercial integrations toward Maps Platform. These are material constraints on the proposed commercial database, not issues solved merely by adding attribution. Applicability, exceptions, and any separate agreement require qualified review before expanding collection or selling a dataset. [Maps terms](https://www.google.com/help/terms_maps/), [Google permissions guidance](https://about.google/brand-resource-center/products-and-services/geo-guidelines/).

Recommended resolution:

- Treat the present Google-derived cache as source-restricted until approved uses and retention are established. Do not assume buying an API subscription grants permanent warehousing/resale rights either; check the actual license.
- Evaluate a rights-cleared foundation for durable/commercial POI records: direct merchant submissions under suitable terms, independently verified first-party facts, licensed supplier data, or appropriately licensed open data. This is a proposed commercial-data workstream, not an unrequested replacement/fallback in the current live application.
- Overture Places is a particularly relevant candidate to evaluate by GCC coverage and field accuracy. Its current documentation distinguishes source-specific permissive licenses; preserve each record's source/license rather than applying one label to all Overture themes. [Overture Places guide](https://docs.overturemaps.org/guides/places/), [licensing and attribution](https://docs.overturemaps.org/attribution/).
- OSM is another option, but attribution and ODbL obligations must be assessed for the resulting database, especially after merging sources. Separate tables alone are not a legal workaround. [OSM copyright/license](https://www.openstreetmap.org/copyright).
- Do not market aggregate Hayer activity as representative city footfall or guaranteed merchant sales. It measures a self-selected decision-making audience, influenced by Hayer's coverage and ranking.

Vela code licensing is a separate boundary. Its GPLv3 license permits commercial distribution but imposes conditions on conveying covered/derived software; see "references/Vela/LICENSE:195", ":222", and ":245". Borrowing product ideas is different from copying Kotlin, JavaScript, or other implementation assets. Translating GPL code to Dart does not by itself remove license obligations. Preserve the repository's current independent-implementation approach, record provenance, and review any proposed direct reuse. Vela's license does not license Google's content to Hayer.

### 12.2 What can actually be borrowed from the checked-out Vela version?

Reference inspected: Vela commit 02f72339347f8a20875256abe29934463d8bc34a. This is the repository's pinned version, not a claim about the latest upstream release or live availability of every endpoint. Code/models and relevant fetch paths were checked, not just the feature list.

Important distinction: Vela describes a per-device client with no backend/telemetry ("references/Vela/README.md", Privacy section). Hayer centralizes extraction and stores shared data. Vela's traffic, privacy and operating assumptions therefore cannot be inherited unchanged.

| Capability | Verified Vela evidence | Hayer today | Recommendation / feasibility |
| --- | --- | --- | --- |
| Ratings, review counts, price, hours, contacts, descriptions and preview photos | "references/Vela/core/src/main/java/app/vela/core/model/Place.kt:8" | Already represented in PlaceSnapshot; results has a detail sheet/gallery, weekly hours, call/site/directions, attribution and checked-at time | Use these better before voting; do not propose basic detail/gallery support as entirely missing. Low incremental extraction cost. |
| Explicit permanent/temporary closure | Place.kt:30; "references/Vela/core/src/main/java/app/vela/core/data/google/parse/SearchParser.kt:169" | Hayer primarily carries status text/isOpen and filters closure strings | Add typed operating status with provenance; distinguish temporarily closed, permanently closed, unknown and ordinary closed-now. Validate GCC/localized fixtures. |
| Accessibility and About attributes | Vela SearchParser.kt:190; Place.kt:64/145 | No normalized accessibility/service-attribute fields in Hayer's snapshot | Start with verified wheelchair-entrance evidence. Broader parking, outdoor seating, dining/service attributes are detail-dependent and must be availability-tested; absence is unknown, not false. |
| Action links such as reserve/order/book | Place.kt:26 | Hayer has phone/site/directions but no typed action links | Useful later as an external handoff, not a booking engine. Validate actual extraction, destination schemes/hosts and source permissions; a click is not a completed reservation. |
| Rich gallery categories, photo dates, rating histogram | Place.kt:43; "references/Vela/app/src/main/java/app/vela/web/WebPhotoFetcher.kt:26" | Hayer stores preview URLs, not categorized full galleries/histograms | Pilot only on user-opened details. These depend on Vela's rendered-page path and are not guaranteed by Hayer's server-side HTTP search. Unknown dates must remain unknown. |
| Full/searchable reviews | "references/Vela/app/src/main/java/app/vela/web/WebReviewsFetcher.kt:27" | One featured snippet; no full review collection | Optional, high-cost enrichment. The pinned WebView path supersedes an older review RPC still present in core code. Do not treat the old method's existence as proof it works. Avoid warehousing review text/authors by default. |
| Typical popular times | Place.kt:86; "references/Vela/app/src/main/java/app/vela/web/WebPopularTimesFetcher.kt:29" | No histogram | Useful for choosing a visit time, subject to a feasibility/rights pilot. It is typical historical busyness, not live occupancy, a queue estimate, or available seating. |
| Related places | Place.kt:68/72; Vela SearchParser.kt:56 | No related-place relationship exposed | Useful to create a new alternatives round after a liked choice is unavailable. Require source identity, local eligibility and provenance; a related result is not automatically a suitable substitute. |
| Saved places, notes, lists and import | "references/Vela/core/src/main/java/app/vela/core/data/PlaceListStore.kt:12"; "references/Vela/core/src/main/java/app/vela/core/data/google/parse/EntityListParser.kt:28" | Active-session resume, but no dedicated user shortlist/list workflow found | High fit. Build Hayer-owned local lists first; add explicit, previewed public-link import later. Do not silently import another list owner's notes/identity into analytics or a commercial catalog. |
| Google Maps/geo link understanding | "references/Vela/core/src/main/java/app/vela/core/data/MapLinkParser.kt:1" | Hayer join/QR links, not a POI-list import workflow | Add paste/share-to-Hayer for a place, then a preview of a small public list. Verify identity before attaching to a room. |
| Traffic-aware route comparison | "references/Vela/core/src/main/java/app/vela/core/data/google/GoogleMapsDataSource.kt:449"; "references/Vela/app/src/main/java/app/vela/web/WebDirectionsFetcher.kt" | Straight-line estimate and external navigation | Consider only a late-stage, few-finalists travel comparison with a supported/approved source. Do not build turn-by-turn or route every candidate for every participant. |
| Signed repair, capability notices and graceful enrichment failure | "references/Vela/core/src/main/java/app/vela/core/config/CalibrationStore.kt"; WebPopularTimesFetcher.kt:41 | Hayer already verifies/projects signed search calibration, validates and supports rollback | Add per-capability health, field-completeness canaries and Hayer-authored service notices. Keep remote input declarative; do not import arbitrary remote JavaScript into the server. |
| Offline maps/routing, Street View, transit, Android Auto, fuel/parking history | Vela FEATURES.md and its separate navigation/offline modules | Outside Hayer's decision-making premise | Defer. These introduce large renderer/storage/provider/security surfaces with weak near-term benefit for choosing a venue. Borrow offline-state clarity and bounded caching, not the full feature set. |

Three pitfalls to avoid:

- **There is no turnkey Vela detail API to drop into Hayer.** "references/Vela/core/src/main/java/app/vela/core/data/google/GoogleMapsDataSource.kt:327" explicitly throws for its unmapped placeDetails RPC. Rich functionality is implemented elsewhere, including Android WebViews. Do not estimate the entire detail pipeline as a small parser extension.
- **Model fields do not prove reliable source coverage.** For example, popular times and full galleries can be absent from simple search responses. Establish availability, correctness and latency for the actual Saudi/GCC categories and deployment egress before making a feature promise. Do not copy Vela's false-default accessibility model; Hayer should preserve unknown.
- **Hayer's signed projector intentionally imports only consumed search paths.** "backend/hayer_server/lib/src/places/calibration.dart:29" and "backend/hayer_server/lib/src/places/vela_calibration_feed.dart:42" show that new fields/capabilities need deliberate model, parser, validation, calibration and test changes; an upstream config update will not implement them automatically.

### 12.3 Additional confirmed gaps relevant to the expanded goal

These are goal-specific observations, not a restatement of every earlier audit issue.

#### G01 — The catalog is a selected-deck cache, not a record of all discoveries

Category: Architecture

Severity: Medium

Confidence: Confirmed

Location: "backend/hayer_server/lib/src/places/place_search_service.dart:31", ":60", ":101"; "backend/hayer_server/lib/src/places/catalog_place_service.dart:187".

What I found: PlaceSearchService accumulates candidates, selects a bounded deck, then returns only selected snapshots. CatalogPlaceService persists that result. Other discovered candidates and the reasons they were excluded are lost at this interface. Coverage.resultCount consequently describes persisted selected results, not all businesses in an area.

Why it matters: A catalog built only from winning candidates reflects the current ranking and user-demand footprint. It cannot answer how many alternatives were rejected, how much supply was observed, or whether a neighborhood is comprehensively cataloged.

Evidence: buildDeck returns selected at 101; _refresh passes live into _persist at 200. CatalogPruner also intentionally removes old eligible records, so simply assuming the cache is a permanent warehouse is incorrect.

Recommended fix: Introduce a bounded SearchDiscoveryResult carrying validated candidates, selected IDs, dedup/exclusion counts, per-query evidence and completion/partial-failure status. Persist only the normalized observations allowed by each source's retention/use policy, independently of deck selection. Keep immutable session decks unchanged. Do not resolve this by mass-scanning Google or storing raw responses forever. Use licensed bulk sources if geographic completeness is a business requirement.

Effort: Medium

Priority: P1 for the proposed data initiative; not an additional current voting blocker.

#### G02 — Deck inclusion is labeled like exposure, and the current event model cannot reconstruct full journeys

Category: Other

Severity: Medium

Confidence: Confirmed

Location: "backend/hayer_server/lib/src/api/hayer_session_endpoint.dart:304"; "backend/hayer_server/lib/src/storage/product_analytics_event_row.spy.yaml"; "admin/lib/features/analytics/analytics_pages.dart:1124".

What I found: deck_exposure is emitted once per place at room creation, before anyone necessarily sees it. The admin table labels it Deck views. Events deliberately omit an actor/journey key; the metric list also lacks setup abandonment, actual impressions, detail opens, outbound actions and an explicit final choice.

Why it matters: One deck inclusion can later produce many participant views—or none. Inclusion is not a valid denominator for person-level click-through rates. Aggregated counts cannot reconstruct ordered setup funnels or returning-device cohorts, and a completed vote session is not proof the group selected or visited a venue.

Evidence: The event loop executes during creation, not viewport display. "backend/hayer_server/lib/src/analytics/product_analytics.dart:5" lists the present server-side metrics. Current analytics' omission of identity is a privacy-positive choice, not permission to silently introduce permanent tracking.

Recommended fix: Rename the current measure to deck inclusions/appearances and retain its historical meaning. Add the purpose-limited event contract in 12.6, with short-lived journey linkage for funnels and a separately disclosed, resettable optional identity only if retention measurement is justified. Capture a real final-choice action. Mark older reports as unavailable for these dimensions; do not invent retrospective impressions/users from aggregate rows.

Effort: Medium

Priority: P1 before drawing product/commercial conclusions from expanded analytics.

#### G03 — Review count is the first ranking key, which can limit discovery variety

Category: UX

Severity: Improvement

Confidence: Confirmed

Location: "backend/hayer_server/lib/src/places/place_search_policy.dart:79"; "app/lib/features/results/results_screen.dart:110".

What I found: Within evidence-category groups, a place with a higher review count always ranks before a lower-count place; rating and distance only break ties. Results then use their own user-selected rating/review/distance sort. The rule is deterministic and not inherently incorrect, but it strongly favors established high-volume listings.

Why it matters: Repeated sessions can show similar prominent venues, while a well-rated nearby independent venue may receive little exposure. That also biases the behavior database toward already favored places. A better ranking is a hypothesis to test, not a guaranteed uplift.

Evidence: _rank compares reviewCount, then rating, distance and ID, without a weighted relevance/uncertainty model. Round-robin category balancing already exists and should be preserved after F06's provenance repair.

Recommended fix: Add a versioned, transparent balanced ranker with eligible-place filtering, review-confidence adjustment, distance/price fit and bounded diversity. Offer a deliberate familiar/discover preference rather than hidden randomization. Keep one immutable shared deck/order per room. Evaluate against explicit choice rate, time to choice, no-match rate and distinct useful POI exposure—not swipe count alone.

Effort: Medium

Priority: P2, after F05–F07 and G02.

#### G04 — A mutable snapshot and one checked-at timestamp are insufficient for a durable multi-source asset

Category: Architecture

Severity: Medium

Confidence: Confirmed

Location: "backend/hayer_server/lib/src/storage/poi_catalog_row.spy.yaml:5"; "backend/hayer_server/lib/src/protocol/place_snapshot.spy.yaml:27"; "backend/hayer_server/lib/src/places/catalog_place_service.dart:310".

What I found: A provider-keyed catalog row stores a latest snapshot, calibration version, checked-at and first/last-seen times. There is no field-level rights/source history, independent cross-provider entity mapping, or dated observation history. Updating the whole snapshot cannot distinguish a field observed today from an older field merely retained during merging.

Why it matters: Rebrands, branch duplicates, conflicting hours, attribute disappearance and future exports become hard to explain. A catalog firstSeenAt is first seen by Hayer, not the business's opening date. One fresh timestamp can overstate the freshness of individual fields.

Evidence: PoiCatalogRow's UUID and provider identity are a useful starting point; the current model has one snapshot and one sourceCheckedAt, not the proposed entities below.

Recommended fix: Evolve the existing catalog into a canonical entity plus source observations/provenance, incrementally. Add field-group freshness and source-specific retention/use permissions, normalized branch/brand relationships, append-only permitted changes, and a rights-filtered export projection. Do not label all current rows commercially reusable or remove retention controls merely to grow the count.

Effort: Large, staged as described in 12.7.

Priority: P1 before expanding long-term collection/export.

### 12.4 Consumer feature backlog: improve decisions, not screen count

All P-series items below are proposed improvements. Benefit is a product hypothesis; effort includes backend contracts, tests and instrumentation. "Next" means after relevant audit blockers, not before them.

| ID / order | Feature and recommended behavior | Evidence / implementation seam | Effort, dependency and success measure |
| --- | --- | --- | --- |
| P01 · Next | **Inspect before deciding.** Tap a clear Details action on the swipe card without consuming a vote; show existing photos, full name, hours, price, description and contact actions. Return to the same card. Keep the primary swipe interface simple and accessible. | Results already implements _PlaceDetailsSheet at "app/lib/features/results/results_screen.dart:571"; swipe PlaceCard has a smaller presentation. Extract a shared detail component rather than duplicate it. | Medium; F03/F04/F24. Measure detail-open -> decision and time-to-choice; more time in a sheet is not automatically success. |
| P02 · Next | **A genuinely balanced deck.** Default to quality-with-confidence, local relevance and category variety; optional Discover something new mode with a small controlled exploration share. Show two truthful reasons such as within your radius / matches your cuisine / previously saved. | G03 and PlaceSearchPolicy; Vela's search/filter/related-place ideas are inspiration, not proof of a better Hayer score. | Medium; F05–F07/G02. Compare completed choices, no-match rate, repeated-venue rate and exposure concentration. |
| P03 · Next | **Choose the destination, not just finish swiping.** Add a clearly labeled Choose this place action on results. In groups, define who can finalize and communicate whether it is a host selection or group confirmation. Preserve the vote results and allow an explicit change with history. | HayerSessionEndpoint.results and current decision_completed event; no explicit selection endpoint/action found. | Medium; F02–F04/G02. Track explicit choices separately from completed decks, navigation taps and optional self-reported visits. |
| P04 · Next | **No-match recovery and a short final round.** Explain whether no match means disagreement, insufficient votes, insufficient eligible supply or a source error. Offer a 3-place runoff among near-matches, or a new room with one visibly changed constraint. Never silently relax budget/accessibility/radius. | Existing consensus and immutable room/deck design; related places are an optional future candidate source, not required for the first runoff. | Medium; P03 and reliable progress. Snapshot a new round/room with its own rule and shared deck; do not rewrite old votes. Measure recovery-to-choice and extra time/steps. |
| P05 · Next | **Saved places and reusable shortlists.** Private, local-first Want to try / Favorites lists; create a room from selected saved places, optionally with a small fresh-discovery mix. Keep notes private unless explicitly shared. Explain device-loss/export limits; cross-device sync can wait. | Vela PlaceListStore.kt:12; Hayer already has secure/local storage seams but no dedicated saved-place list workflow. | Medium; canonical identity and F04. Measure saves reused in later rooms and returning decision sessions, not raw save totals. |
| P06 · Next | **Report a bad recommendation.** Separate Wrong category / Closed / Wrong location / Duplicate / Misleading photo / Other data issue from a dislike. Optional tap after swiping, never a mandatory survey on every card. | Existing admin quarantine/audit actions and taxonomy/category evidence provide the moderation foundation. | Medium; source observations and moderation queue. Measure report resolution, confirmed issue rate and repeat exposure to known-bad records. Rate-limit reports; never auto-close a POI from one anonymous report. |
| P07 · Pilot | **Visit-fit filters with honest uncertainty.** Preserve existing visit-time and budget controls; add open through the intended visit duration, typed closure, and evidence-backed accessibility/service badges. Make required versus preferred constraints explicit. Offer a visible include-unknown option for soft preferences, never falsely guarantee suitability. | PlaceAvailability.isOpenAt already handles scheduled weekly hours and keeps unknown hours eligible; Vela About/accessibility/closure fields extend it. | Medium to Large; feature availability pilot. Measure field coverage, underfilled decks and user-confirmed bad-fit reports. Holiday/Ramadan exceptions and last-updated labels need explicit treatment; do not infer them from generic weekly schedules. |
| P08 · Pilot | **Share/paste a place or a small public list into Hayer.** Preview identities, deduplicate branches, let the user select entries, then create a shared immutable shortlist room. Begin with a single supported place link before full list import. | Vela MapLinkParser.kt and EntityListParser.kt; Hayer join links are a different capability. | Medium for single place, Large for robust lists; P05 and identity validation. Validate redirects/DNS/IP/host/scheme, size/item/time bounds and abuse limits; do not fetch arbitrary URLs or private lists with user cookies. Measure import-to-room success. |
| P09 · Pilot | **Better detail enrichment on demand.** Menu/Food/Vibe gallery tabs, structured About information, and typical quiet-time suggestions can reduce uncertainty. Load asynchronously only on opened places/finalists, with explicit unavailable/stale states. | Vela WebPhotoFetcher, WebPopularTimesFetcher and model fields; not currently proven on Hayer's HTTP extractor. | Large/conditional; rights and capability pilot plus F08/F09. Measure actual GCC availability, identity match, useful-action uplift, latency and incremental requests. Full reviews are lower priority than hours/accessibility/menu evidence. |
| P10 · Later | **Help the group meet fairly.** First let the host choose a meeting area manually. If validated demand warrants it, optionally compare travel effort to only 2–3 finalists for consenting participants; provide manual origin instead of GPS and do not reveal origins to the group. | Vela directions/route comparison is an architectural reference. Hayer does not currently possess a route matrix. | Large; suitable routing rights/budget and privacy design. Optimize a stated objective such as smallest maximum journey, not claim a geographic midpoint guarantees fairness. No 50-place × 12-person route fan-out. |

Additional low-cost retention improvement: offer a New round with these settings action after results, retaining the chosen filters and group rules while creating a new room/deck. Pass a typed setup seed from the existing session settings into SetupScreen; reuse visit-time and price-label helpers in "app/lib/features/setup/setup_preferences.dart". That file contains helpers, not a persisted settings store, so this proposal requires an explicit prefill contract rather than assuming persistence already exists. Exclude previously chosen places only with a clearly defined preference; recent rejection does not necessarily mean permanent dislike.

Do not prioritize a social feed, badges, mandatory registration, chat, turn-by-turn navigation, an LLM concierge or a full merchant marketplace yet. They expand the product and moderation burden before improving the current decision loop. Most recommendations above can be implemented with deterministic rules and existing data rather than AI calls.

#### Ranking and matching design guardrails

- Separate **eligibility** from **ranking**. Radius, explicit required constraints, valid coordinates and confirmed closure rules come first. Missing price/accessibility is unknown, not a guessed pass or a fabricated negative.
- A practical candidate-quality term can shrink a provider rating toward a local category prior: `(n * r + m * c) / (n + m)`, where r is rating, n review count, c a relevant prior and m a tuned confidence weight. This is an interpretable heuristic, not a calibrated probability of satisfaction; provider reviews are not independent random samples. Normalize other score components and version the weights. Do not mix currencies or price-level heuristics into exact spend claims.
- Add transparent distance/price fit and category diversity. Apply brand/branch diversity only when identity is reliable; do not deduplicate every restaurant sharing a common Arabic/English name.
- Use opt-in local saved/recent preferences initially. In a shared room, agree preferences before freezing the common deck. Per-user reordering mid-session breaks Hayer's index/consensus contract; personalized reasons can differ, but the shared card sequence must not.
- Keep a stable seeded exploration policy per room; if testing, randomize at the room level so participants see the same variant. Log ranking/taxonomy/calibration versions and actual position. Randomizing only the order of selected places does not fix candidate-selection bias; evaluate the candidate pool too.
- In results, separate unanimous/majority acceptance, partial-vote status and final selection. A place's Google rating should not silently override the group's expressed preference. Show how the list is sorted and allow explicit user choice.
- Never derive dietary safety, halal certification, allergy suitability, live crowding or reservation availability from a name, cuisine, rating, or review snippet. Use verified attributes with source/time and appropriate uncertainty; sensitive requirements need especially careful handling.

### 12.5 Admin dashboard: from charts to decisions

Keep existing capabilities: product Overview/Usage/Places, operational summary, POI catalog map, coverage, refresh jobs, cache settings, taxonomy/calibration management and audit inspection. These are visible in "admin/lib/admin_app.dart:65", ":328", ":444", ":659", ":947", and "admin/lib/features/analytics/analytics_pages.dart:11", ":207", ":328". Add drill-downs and better data definitions rather than replacing the dashboard.

Recommended navigation: **Product** (Overview, Funnels, Cohorts, Results quality), **POI intelligence** (Catalog, Coverage, Quality, Reports), **Operations** (Health, Jobs, Releases/calibration), **Governance** (Sources/rights, Exports, Audit). On mobile retain the current drawer pattern; desktop can keep grouped navigation. The overview should surface exceptions with links, not display every metric in a tile.

| Module | Questions it must answer | New information and practical operator action | Priority / effort |
| --- | --- | --- | --- |
| Decision health overview | Are people reaching useful decisions today? Is a change hurting them? | Explicit choice rate, time-to-choice p50/p95, no-match, source failure, queued-vote failure and measurement freshness. Separate solo/group and show denominators/comparison periods. Click a decline to its responsible segment/version. | First / Medium |
| Journey funnels | Where do hosts/guests stop, and is the cause UX or failure? | Separate host setup -> create -> first vote -> results -> choice from invite-open -> valid room -> join -> first vote. Show loading latency, validation/error codes, permission outcomes, app version/platform/language and drop-off step. Preserve unknown/lost telemetry. | First / Medium; G02 |
| POI quality and freshness | Which records make recommendations untrustworthy? | Filters for identity conflicts, wrong categories, suspected closure, broken photos, missing hours/price/accessibility, fresh-versus-stale fields and source disagreement. Drill into source observations and open/resolve a review task. | First / Medium; G04 |
| Demand versus usable supply | Where should catalog work be spent? | Coarse geographic cells × category/time: requested rooms, eligible candidates, underfill, unknown mandatory fields, repeated choices and source failures. Rank high-demand/low-usable-supply cells for authorized refresh/merchant outreach. A blank cell means unobserved, not zero businesses. | First / Medium; G01 |
| Recommendation lab | Why did this place appear, and which ranker helps? | Reconstruct a sampled room from policy/config versions, candidate/exclusion summary, deck positions and field freshness. Compare control/new rankers offline, then room-level experiments. Show category/brand concentration, repeat exposure and sample uncertainty. | Second / Medium |
| Retention/cohorts | Do installations return for another decision? | Optional consented/resettable installation cohorts, D1/D7/D28 activity and return-to-choice, segmented by acquisition category, language, version, solo/group and first successful decision. Label installations, not unique people; exclude immature cohorts. | Second / Medium; identity/privacy decision first |
| Incident and extractor console | Is low engagement actually a broken release/source? | API errors and latency, DB pool wait, cancellation/queue depth, parse yield, field completeness, identity mismatch, source 429s, stale fallback, job lag and backup age. Overlay app/server releases and taxonomy/calibration activations; jump to redacted correlated logs. | First / Medium; F08/F16/F32 |
| Feedback/moderation inbox | What did users report, and did we fix it? | POI issue type, source corroboration, affected rooms, report recurrence, owner, status and resolution time. Quarantine or correct source-aware data with reason/audit; preserve a reversible merge/split trail. | Second / Medium; P06/F20 |
| Source and rights registry | What may we store, show, retain and export? | Source/version/license/permission scope, field exclusions, expiry, attribution, restrictions and documented reviewer. Highlight unknown or expiring permissions. Preview export eligibility before any download. | First for data initiative / Medium |
| Controlled export / analysis | Can I analyze or commercialize this subset responsibly? | As-of/source/quality filters; approved CSV/GeoJSON first, columnar exports later when useful; manifest of schema/time/filter/source/license/row count. Aggregate-only behavior exports, small-cohort suppression and auditable authorization. | Second, after rights/data model / Medium |

Every chart should show the observation period, timezone, numerator/denominator, data lag, sample size and whether it is based on server facts, client reports, or inferred states. Each anomaly should have a suggested next investigation, owner, acknowledgement and resolved state. Do not add a global red alert because one low-volume city had one failure.

Examples of actionable alerts (initial rules to tune, not established SLOs):

- Search requests still succeed at HTTP level, but the share of parsed valid IDs or populated hours drops sharply for one calibration: inspect field-level canaries; pause the affected enrichment and roll back after confirmation.
- Create failures rise only in a new Android build while provider health is normal: inspect the setup/auth version segment, not the scraper.
- A popular neighborhood has repeated undersized decks despite a large observed catalog: inspect category provenance, eligibility counts and query candidate limits before fetching more records.
- Pending votes age while server acceptance is healthy: investigate the client outbox/reconciliation contract rather than interpreting the drop as user disinterest.
- Match completion rises but explicit choice rate falls: inspect ranking/runoff design and instrumentation changes; do not call the change successful from match counts alone.

### 12.6 Collect enough behavior data—but define it first

#### Event contract

Extend the existing recorder and aggregate machinery, not a collection of unrelated analytics SDKs. Separate transactional server facts from best-effort client telemetry. The following is a proposed schema and event dictionary, not existing functionality.

Common fields: event_id, event_name, event_schema_version, occurred_at, received_at, origin (server/client/derived), app_build/server_release, platform, language, bounded journey/room pseudonym where needed, operation/request correlation ID, ranking/taxonomy/calibration version, coarse geography, structured outcome/error code and an allowlisted small properties payload. POI events reference a canonical POI ID, snapshot/observation version and deck position. Derive membership/room/accepted-vote facts on the server; do not trust client-supplied identity or success claims.

| Event / family | When recorded | What it enables / what it does not prove |
| --- | --- | --- |
| journey_started, setup_step_viewed, setup_validation_failed | Foreground journey/meaningful step change, not every rebuild/keystroke | Setup funnel and friction; no need to collect raw entered names or addresses |
| location_permission_outcome, location_resolution_outcome | Permission/fix completed or failed, with coarse reason/duration | Separate permission denial, slow GPS, auth failure and geocoder failure without storing coordinates in telemetry |
| create_requested, create_succeeded, create_failed | Stable request lifecycle, success/failure authoritative on server | Attempts, conversion and latency; deduplicate transport retries by operation ID |
| invite_action, join_link_opened, join_requested, join_outcome | Share sheet invocation/link opening and validated join | Invite-to-join funnel; opening a share sheet does not prove the invite was sent or received |
| deck_included | Once per room/POI when the immutable deck is assigned | Current deck_exposure's real meaning; not a human impression |
| card_impression | Foreground card visibility under one documented rule, deduped by room/participant/card | Actual exposure and position bias. Define a short visibility threshold and handle fast swipes explicitly; do not silently mix inferred swipe exposure with measured visibility |
| place_details_opened, detail_enrichment_outcome | Explicit open, then independent fetch outcome | Whether richer data helps and whether empty details reflect source failure |
| swipe_accepted, swipe_revised, swipe_rejected | Backend outcome of idempotent vote command | Authoritative preferences/changes; existing signed adjustment events can feed final aggregates rather than double-counting retries |
| outbox_queued, sync_recovered, sync_terminal_failure | Local persistence/sync state transitions, reported later if offline | Technical friction; unsent/lost telemetry remains a measurement limitation |
| results_viewed, no_match_shown, recovery_started | Visible results and explicit new-round/runoff action | Where the decision loop stalls and whether recovery works |
| choice_confirmed, choice_changed | New P03 server-authorized action | A declared destination choice, not actual attendance |
| navigation_launch_attempted/succeeded/failed; call/site/reserve handoff | External action invocation and known OS/backend outcome | Intent and handoff reliability; not arrival, completed call, booking or revenue |
| place_saved, shortlist_used, place_issue_reported | Explicit product actions | Return value and data-quality signal; private notes/free text excluded from general analytics |
| visit_feedback_submitted | Optional explicit later user response, if introduced | Self-reported visit/satisfaction, labeled as such; do not infer it from background GPS |

Data-integrity controls: unique event IDs; bounded batches and payloads; rate limits; server-side allowlist/schema validation; maximum accepted clock skew; received-at retained for late arrivals; consent state and schema/version tracked; bots/canaries/test accounts marked; duplicate/rejected/late-event counters; a dead-letter process for invalid data. Never fail a vote because best-effort UI telemetry is unavailable. Preserve transactionality for the authoritative vote/choice event itself. Separate immutable event facts from corrected aggregates, with rebuild/version procedures.

#### Metric definitions that avoid misleading conclusions

| Metric | Proposed definition / caution |
| --- | --- |
| Eligible deck fill | Selected eligible places / requested deck size, segmented by explicit constraints and valid source outcome |
| Successful create rate | Distinct successful create operations / distinct requested create operations; report validation/auth/provider errors separately |
| Participant completion | Participants finishing their expected cards / eligible enrolled participants, with the room mode/early-match stopping rule stated |
| Declared choice rate | Mature eligible rooms with explicit choice_confirmed / mature eligible started rooms; also show create-to-choice separately so failed creation is not hidden |
| Time to choice | Foreground/elapsed variants from a clearly defined start to explicit choice; show percentiles and uncompleted/censored rooms, not just the fastest completers |
| True no-match rate | Rooms reaching the defined decision condition with no qualifying match / rooms reaching that condition; expired/incomplete/provider-failed rooms are separate |
| POI approval | Final accepted likes / final accepted likes plus dislikes for that POI; undo/revisions netted, distinct participants/rooms and time window reported |
| POI detail/open/choice rate | Numerator and denominator must be at the same unit: participant-impression for personal actions, room-exposure for group choice; do not divide many participants' clicks by one room inclusion |
| Repeat-use retention | Returning opted-in installations from an acquisition cohort / cohort installations old enough to observe that window; not unique humans or all users |
| Supply adequacy | Demand cells/categories with enough verified eligible candidates / demand cells/categories observed; not percent of all businesses in a city |
| Discovery value | Chosen POIs not previously chosen in the relevant consented/local history, plus concentration/novelty measures; never infer true newly opened businesses from firstSeenAt |

Statistical guardrails: show sample counts and uncertainty; avoid ranking a place with two votes above one with hundreds purely on raw percentages; separate locale/category/city/price/position effects. Use room-level experiment assignment and analysis because group votes are correlated. Predeclare a primary outcome and guardrails, show only mature windows, and do not automatically promote a variant after a noisy short-term lift. Historical aggregates cannot be backfilled into precise user journeys; start a clearly labeled measurement era.

#### Privacy, retention and commercial separation

- Keep essential reliability telemetry purpose-limited. Introduce optional behavioral/return-use tracking only with appropriate disclosure, lawful basis and user controls. Stable pseudonyms are still linkable data, not anonymous data.
- For funnels, use random short-lived journey identifiers. For D7/D28 retention, decide explicitly whether a resettable installation identifier with a bounded observation window is justified; rotating it daily cannot measure 28-day return. Do not fingerprint devices to reconnect identities after reset/opt-out.
- Keep anonymous auth IDs, exact room centers, display names and private lists/notes out of the analytics warehouse/export. A room pseudonym can still link a small group; restrict access and expiry. Coarse cells must become coarser or suppressed in low-volume areas; hashing an IP/coordinate does not anonymize it.
- Start with the current short raw-event retention where adequate; any extension for cohort measurement must be deliberate. For example, a separately approved 35-day purpose-limited cohort window can support D28 observation, then delete linkage and retain safe aggregates. Define allowed retention per data class rather than one indefinite setting.
- Proposed external-report floor: suppress small cohorts (for example fewer than 20 distinct contributing installations/rooms, selected for the report's unit), with complementary-cell suppression, restricted cross-filtering and repeated-query safeguards. This is a starting guardrail, not an anonymity guarantee; assess reidentification before external release.
- Exclude sensitive-category behavioral segmentation and identity/contact exports. Do not infer religion, health needs or other sensitive traits from POI choices. Make opt-out, reset and deletion work through raw data, derived linkages and backups according to the documented retention process.
- Do not enable screen/session replay, raw search-query archives, keystroke capture, exact location trails or background visit tracking merely to make the dashboard feel comprehensive. The aggregate funnels, failure codes and explicit feedback above answer most initial questions more safely.

### 12.7 Build a POI asset deliberately: source facts, identity, history, and rights

#### Recommended data model, introduced incrementally

Keep PostgreSQL/PostGIS and the current catalog as the fast serving projection initially. The existing PoiCatalogRow UUID is useful, but its current one-provider-row semantics should not silently become a cross-provider identity guarantee. Add explicit mapping before exposing stable Hayer POI IDs commercially.

| Entity / projection | Minimum useful fields | Purpose and retention boundary |
| --- | --- | --- |
| Canonical POI | Hayer ID, canonical/alternate names and languages, location, address components, country/city/area, branch/brand relation, operating status, entity revision | Stable entity identity derived from approved source evidence, not a copied provider row declared Hayer-owned. Preserve branch distinctions and aliases. |
| Source registry / policy | Source ID/version, access method, license/agreement evidence, permitted fields/purposes, display/cache/retention/export rules, attribution, reviewer and review/expiry dates | Default unknown permission to non-exportable; permits and privacy restrictions are independent. Policy is enforced, not just a note. |
| Source identity mapping | Source + provider place ID + feature ID -> Hayer POI ID, mapping confidence/evidence, observed interval, merge/split audit | Support provider ID changes, duplicate listings, renames and multiple providers without rewriting historical session IDs. |
| Source observation | POI/source ID, observed_at, received_at, field-group values/statuses, content hash, calibration/parser version, fetch outcome, permitted expiry | Append only meaningful permitted changes; unchanged observations can update last-observed metadata. Do not retain a full copied payload on every cache hit. |
| Attribute/category evidence | POI, normalized attribute/category ID, observed value/state, source observation, source label/language, confidence/reviewer, validity/freshness interval | Distinguish factual service/accessibility attributes from user preferences and taxonomy guesses. Correct F06 before trusting historical category evidence. |
| Discovery run + bounded candidate provenance | Coarse query cell/category/language, constraints, source/version, fetched/valid/deduped/eligible/selected counts, exclusion codes, request count/duration, complete/partial/failed status, allowed candidate references | Explain what was searched and why a deck underfilled; preserve permitted preselection observations via G01. No unbounded free-text query/coordinate logs. |
| Current serving projection | Approved latest field values with field-group freshness/source, search indexes, eligibility flags and Hayer ID | Fast reads and deck creation; rebuildable from permitted observations. Cache expiry is different from canonical-entity lifecycle. |
| Feedback / curation | Report type, POI/source reference, verification status, proposed correction, operator/reason, merge/split/quarantine history | User reports are claims pending verification, not automatically authoritative facts or merchant allegations. |
| Behavior aggregates | POI/coarse-area/category/time/variant, deck inclusions, measured impressions, net votes, explicit choices and outcomes, sample metadata | Separate access/retention from source data and identities. Export only approved aggregates; preserve metric definitions and limitations. |
| Export manifest | Export ID, as-of time, schema/source-policy versions, fields/filters, allowed-purpose, attribution/license notices, row count/checksum, actor and expiry | Reproducible, auditable exports; revoke or regenerate when upstream policy or source corrections require it. |

Use typed columns for identity, geometry, timestamps, frequently filtered status/categories and key numeric measures. Use constrained JSON for sparse optional source attributes, not an unbounded bag of arbitrary client properties. Batch upserts/observations, deduplicate unchanged content and enforce unique source identities. Begin with query-shaped indexes and keyset pagination; profile before adding a warehouse, broad JSON indexes or partitioning. Installed PostgreSQL guidance informed these bounded-write/index recommendations; no Supabase service migration is proposed.

#### Data worth prioritizing

1. **Identity and location:** source IDs, Hayer ID, feature ID, canonical/alternate Arabic and English names, address components, geography and branch/brand mapping. This unlocks almost everything else.
2. **Decision suitability:** category evidence, typed closure, weekly hours/timezone, exceptions where verified, source price text/currency/level, website/phone, accessibility/service attributes with unknown preserved.
3. **Confidence and freshness:** per-field/group observed time, extraction outcome, conflicting-source state, rights/expiry, parser/calibration version and report/curation state. These are at least as useful as adding another descriptive field.
4. **First-party outcomes:** seen/liked/rejected/selected/saved/reported in a specified context and period, aggregated with the controls above. Do not mix a user's dislike with a factual business defect.
5. **Conditional rich data:** photo categories, typical busy-time profiles, action URLs and rating distributions only where reliably available and permitted. Detailed review text, reviewer identities, copied media binaries and raw page archives are not default commercial-warehouse fields.

Model important uncertainty explicitly. For a boolean attribute use true / false / unknown, plus a separate observation outcome (present, absent from response, source unavailable, parse failure). A missing attribute in a degraded fetch must not overwrite a previously known value as false. Field-group freshness should not be refreshed merely because the place appeared again. Keep verification confidence separate from business popularity; firstSeenAt means first observed by Hayer, lastSeenAt does not prove still operating, and a missing search result does not prove permanent closure.

#### Proposed ingestion and serving flow

    Approved source request or licensed bulk release
        -> validate response identity, schema and source-policy permissions
        -> normalize and deduplicate permitted candidate observations
        -> retain field evidence / observed changes / collection-run counts
        -> update current catalog projection
        -> apply exact session eligibility + versioned ranking
        -> persist immutable session deck
        -> collect separately governed interactions and explicit outcomes

    Approved catalog + safe behavior aggregates
        -> rights/privacy/quality-filtered analysis or export
        -> versioned manifest + audit + retention enforcement

Two important invariants:

- Enrichment must match the canonical/source identity of the place being enriched; never accept a neighboring search hit's hours, busyness or reviews because the name looks similar. Vela itself includes identity-matched backfill safeguards in "references/Vela/core/src/main/java/app/vela/core/data/google/parse/PopularTimesParser.kt:40"; apply the stricter identity rule to all Hayer fields, including descriptive fields.
- New source observations may update current display metadata with an explicit checked-at label, but cannot quietly change the voted-on deck's membership, order or identity. Store the snapshot/version used for decisions and show material changes separately, such as a new closure warning on the selected destination.

#### How to grow coverage without an uncontrolled collection job

- Measure demand-covered cells by category and field quality; prioritize high-demand areas whose eligible supply is insufficient. Reuse permitted observations from real searches instead of repeating identical fetches.
- Treat source-search results as a ranked sample. Track marginal new valid entities per authorized request, duplicate yield and category balance, but do not claim saturation proves every business was found.
- For lawful comprehensive seeding, evaluate licensed bulk releases for selected GCC cities and categories; pin release versions, validate schema, sample manually and preserve source/license. This is a separate decision from changing the consumer's current provider.
- Refresh by field volatility and demand within source rules: near-term hours/closure verification for selected finalists, slower identity/address refresh, and lazy rich detail. Combine request, byte, time and concurrency budgets with canaries and a hard stop when limits/errors increase. Do not propose proxy rotation, account/cookie borrowing or bypassing upstream blocks to grow the database.
- Build a gold-standard manually reviewed test set across cities, Arabic/English names, malls with multiple branches, low-review venues, missing hours and known closures. Use precision/identity/attribute accuracy and useful coverage, not raw row count, as success criteria.
- Do not remove the existing cache pruner to preserve everything. Separate permissible durable identity/history from transient provider cache; expunge expired/restricted payloads and account for immutable snapshots, derived exports and backups in retention policy.

### 12.8 Vela-inspired enrichment architecture and feasibility gate

Before P07/P09, run a small explicitly budgeted feasibility study, for example 30–50 manually selected POIs across two target cities and several categories. That sample is a proposed engineering test, not a representative statistical validation or permission to scrape at scale. Record field availability, exact identity match, value accuracy, freshness, latency, response bytes, number of upstream requests and failure mode for the actual Hayer execution environment. Rights approval precedes collection/storage beyond current permitted use.

Start with an interface such as a typed PlaceEnrichmentService returning independently statused field groups. Store capability state by source/region/parser version: supported, degraded, temporarily unavailable or unverified. Make the UI omit unavailable optional sections without losing the base card. A 200 response with empty fields is not a healthy capability.

Preferred implementation sequence:

1. Extend Hayer's own bounded HTTP parser for fields demonstrably present in its approved search responses, such as typed closure and verified accessibility evidence. Add matching consumed calibration paths and fixtures.
2. Test approved focused-detail retrieval as an optional request after a user opens a place; prove identity matching and acceptable marginal cost. Do not eagerly enrich 50 cards during room creation.
3. If only a rendered-browser path can provide a feature, explicitly reassess the feature's benefit, provider permissions, maintenance and operating cost. Vela's on-device WebView is not a server-side free lunch. A supported detail source or external link may be the better decision.
4. If a browser-based enrichment worker is ultimately authorized, isolate it from the API/database credentials, bound concurrency/lifetime/downloads/network destinations, and treat all page/script output as untrusted data. Do not let signed upstream calibration execute arbitrary privileged code. Do not recruit user devices as a hidden distributed harvesting network or let client-submitted enrichment become trusted catalog truth.
5. Canary each optional capability by identity and field completeness, not just parser success. Keep a kill switch and graceful fallback. Separate source capability health from Hayer's core liveness, consistent with F10/F32.

### 12.9 Commercial opportunities that fit the product

These are options to validate, not evidence of present demand or rights clearance.

| Opportunity | Potential value | Prerequisites and boundaries |
| --- | --- | --- |
| Internal recommendation intelligence | Better decks, lower failure/underfill, more successful choices | First-party event quality and candidate provenance; highest immediate ROI, no new marketplace required |
| Aggregated area/category decision reports | Understand which types of outings Hayer's audience considers and where supply fails | Mature samples, privacy protections, source/derived-data rights review, selection-bias disclosure; never label as total market demand or real footfall |
| Merchant profile verification/correction | More accurate hours, contacts, branch identity and permitted attributes; potential later verified-profile service | Establish merchant authority, explicit data permissions, reversible moderation, dispute/abuse handling; verification must not secretly buy a better organic rank |
| Rights-cleared POI catalog/export/API | Reusable stable IDs, normalized attributes, permitted change history and useful quality indicators | Approved sources, entity accuracy, field-level export policy, refresh/support commitments, customer-use agreements and export audits |
| Venue action/referral partnerships | Better booking/order handoff from an actual Hayer choice | Explicit partner integration/attribution, user disclosure and verifiable conversion; a scraped action URL or navigation tap does not establish a payable referral |

Do not commercialize identifiable decision histories, precise-location traces, private lists, or raw Google review/photo collections as the default strategy. Aggregation is not an automatic exemption from source restrictions or privacy duties. If sponsored placements are ever introduced, label them, preserve hard constraints, separate them from organic ranking and report their impact on decision quality.

### 12.10 Recommended delivery sequence and acceptance gates

| Stage | Ship / investigate | Depends on | Evidence to proceed |
| --- | --- | --- | --- |
| 0 · Trustworthy baseline | Fix core audit blockers; rename Deck views; define explicit choice and metric dictionary; source-rights inventory | F01–F07/F11/F15/F16, G02/G04 | Voting/replay reliable, CI required, recovery proven, historical metric meanings documented |
| 1 · Better decisions + useful observability | P01/P03/P04; first funnel/incident/quality dashboard; P06 reporting if capacity allows | Stage 0, purpose-limited events, F18/F19/F24 | Two-device flows instrumented; distinguish partial/no-match/error; clear retry and final-choice states |
| 2 · Durable catalog foundation | G01/G04 normalized observations and source identity mapping; source/rights registry; demand/supply and data-quality views | Atomic/provenance-safe writes and permission/retention decisions | Selected versus discovered counts correct; no false freshness/identity merges; expired restricted fields excluded from export |
| 3 · Return value and better ranking | P05 saved shortlists; P02 balanced ranker; room-level experiment tooling; optional retention cohorts | Canonical identity, trustworthy impressions/outcomes, privacy choice | Improvement in declared choice or recovery without worse latency/fairness; useful repeat use, sufficient mature samples |
| 4 · Selective Vela enrichment | P07/P08/P09 feasibility gates, then one field group/capability at a time | Rights/availability pilot, bounded egress, capability canaries, known identity | Proven GCC availability and useful-outcome gain justify extra requests; graceful degradation remains intact |
| 5 · Commercial validation | One narrowly defined rights-cleared data/reporting product; possibly merchant verification | Stages 2–4 as relevant, legal/privacy/data-quality acceptance and actual customer demand | Auditable permitted export, defensible accuracy/coverage statement, minimum safe sample and support/update commitments |

The stages are dependency order, not calendar estimates. Stage 2 design can run alongside Stage 1 implementation; UI work need not wait for a fully built warehouse. P10 routing, full review ingestion, and broad geographic harvesting are not part of the recommended first releases.

### 12.11 Validation limits for this addendum

No application, telemetry, scraper, database, remote service or dashboard was changed; only this report was extended. Vela source was inspected at the pinned commit, but its rich-data routes were not executed against live Google responses, and GCC field coverage remains unverified. Current provider/license documentation was reviewed for planning constraints, not to issue a legal opinion. No commercial demand, actual retention baseline, market representativeness or performance uplift has been measured. Validate those through the stated pilots and acceptance gates before treating an idea as a committed capability.

**Bottom line:** the most valuable expansion is a better decision loop plus a provenance-aware POI and outcome database. Start by measuring what people really saw and chose; preserve useful, permitted discoveries independently of the selected deck; enrich only the places where extra detail helps a decision; and make the dashboard explain what action to take next.
