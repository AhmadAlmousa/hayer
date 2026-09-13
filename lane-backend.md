# Back-end lane log

Working notes for the back-end lane: `backend/`, deployment, server contracts,
generated clients, and repository release tooling. This lane is worked from the
primary worktree on `main`. Codex held it through 2026-09-10; Claude took it
over on 2026-09-11 and continues this log rather than starting a new one.

`PROJECT.md` remains authoritative for shared decisions, milestone state, and
acceptance gates. Detailed back-end checkpoints and front-end handoffs live
here so the two lanes do not repeatedly edit the same evidence paragraphs.

Last updated: 2026-09-13

## Current state

- M7-A's F02/F03/F04 implementation and a real-PostGIS read-versus-swipe
  regression are present. Docker and physical-device acceptance remain open.
- F01's signup and method-aware join protections are implemented. Real gateway
  proof and the Cloudflare connector trust decision remain open.
- F13 and F30 are complete. F14's session/enrollment revocation and F20's
  atomic admin-mutation implementations are complete and their Postgres
  concurrency/replay cases now execute and pass against real PostGIS.
- F05/F06/F07's batched persistence, calibration-scoped category provenance,
  exact refresh coalescing, and selective deterministic cache query are
  implemented, and their PostGIS concurrency/dense-cache cases now pass. The
  catalog-truncation defect the first real run exposed is fixed.
- The latest integration suite is fully green: 38/38 against real PostGIS,
  including the two legacy-calibration regressions added on 2026-09-13.
- Claude completed the F17 client convergence half in `6277dcd`, and the
  additive deck-free server progress contract is wired into the merged client.
  Two-device acceptance remains open.
- The owner confirmed the deployed Start swiping calibration repair works.
  The incident is closed; the remaining beta gates are summarized in
  `PROJECT.md` under the 2026-09-13 beta acceptance review. Next backend work
  is F08/F09 provider/geocoder bounds, followed by F10/F21 source resilience.

## Checkpoints

### Legacy calibration runtime repair — owner verified in production (2026-09-13)

The September 12 production logs identify the Start swiping failure as
`FormatException: Calibration field directionsEndpoint is missing` during
`PlaceServices.forSession`, before provider search starts. A persisted active
calibration predates the routing fields now required by the strict decoder.

`PlaceCalibration.fromStoredJson` supplies the bundled directions endpoint and
template only when both keys are absent. It preserves the active calibration's
search fields, version, parser paths and host allowlists, keeping the shared
crowd-sourced POI catalog and its calibration-scoped evidence intact. Modern
records retain their own directions settings; partial or explicitly malformed
settings remain errors. `PlaceServices` also evicts failed initialization
futures so an operator's repair of the same version can recover on the next
request. There is no database rewrite or cache reset.

Verification: the two new real-PostGIS cases reproduced the failures against
the original implementation and pass with the repair, including same-version
recovery and preservation of stored JSON. All 28 focused calibration/parser/
session tests passed. Pinned `scripts/preflight.sh` passed generation,
formatting, all analyses, 130 server tests, 165 app tests, 51 admin tests and
repository checks. `scripts/test-integration-remote.sh` passed all 38 tests on
the dedicated `hayer_test` database; existing custom-PostGIS schema metadata
warnings remain. `scripts/build-release-apk.sh` produced signed `0.2.1+7` and
its alias; APK Signature Scheme v2 verifies, with SHA-256
`ef731e258e34f3d57e4692113db04de2850cdbb73effaf69f4c2def0591dc140`.

Production follow-up: after the Unraid rebuild/recreate handoff, the owner
reported "resolved" on 2026-09-13. This closes the Start swiping incident in
`39ab02a` using the owner's successful retry. SSH authentication was unavailable
and the authenticated canary was not independently rerun. The existing APK
needs no reinstall for this backend repair. Full solo/offline/multiplayer,
gateway, recovery and release acceptance remain open in `PROJECT.md`.

### The first real run's four failures are closed (2026-09-11)

All four defects from the 2026-09-11 integration run are resolved and
`scripts/test-integration-remote.sh` is now 36/36, reproduced across two
consecutive runs. Only one was a product bug; the other three were a test
fixture, a test matcher, and an application serialization mistake. Two of the
three earlier diagnoses recorded in the checkpoint below turned out to be
wrong, so they are corrected here rather than edited in place.

**F05/F06/F07 — the catalog dropped places the provider actually returned.**
This was *not* a concurrency bug. `CatalogPlaceService._refresh`
(`catalog_place_service.dart:227`) persisted `live`, the value
`PlaceSearchService.buildDeck` returns, and that method returns `selected` —
the deck after `policy.select` applied the caller's price ceiling and truncated
to `deckSize` — while discarding the `candidates` list the source actually
produced. Every place the provider returned beyond one caller's deck size was
silently thrown away instead of entering the shared catalog.

The overlapping-refresh test only looked like a race because the second
`buildDeck()` asked for `deckSize: 1` against two candidates, so `sushi-only`
lost the ranking to `shared` (100 reviews versus 50) and never reached
`_persist`. A single sequential refresh with `deckSize: 1` reproduces it with no
concurrency at all — confirmed with a temporary probe before changing anything,
which printed `deck=[shared] catalog=[shared]`.

The fix adds `PlaceSearchService.buildDeckWithObservations`, which returns both
the caller's deck and every eligible place the search saw; `buildDeck` now
delegates to it so the canary, the refresh job, and the unit tests are
unaffected. `_refresh` persists `observed` and returns `deck`. The observation
set is built by re-running `policy.select` with the candidate count as the deck
size and no price ceiling, so dedupe, closure and radius filtering still apply
but neither one caller's budget nor its deck size decides what the shared
catalog is allowed to remember. Cache reads already re-apply price and policy
against the stored rows.

This also makes coverage `resultCount` reflect what was actually observed, and
it means the background refresh job populates the catalog properly. The cache
path is unaffected: `coverageIsFresh && cachedDeck.length >= deckSize` still
requires both conditions, so a wider catalog cannot serve a deck that fails the
caller's own filter.

**F20 — `CachePolicy` cast failure was ours, not Serverpod's.** The earlier note
guessed that the stringified map's key set coincidentally matched
`CachePolicy`'s fields and that Serverpod's dispatch was ambiguous. It is more
direct than that: `Protocol.deserialize` dispatches only on an explicit
`__className__` key (`protocol.dart:2982`), and `CachePolicy.toJson()` emits
`'__className__': 'CachePolicy'` (`cache_policy.dart:140`). `updatePolicy`
flattened the policy with `.toJson().map(...)` and copied that marker straight
into an `AdminAuditRow` field declared `Map<String, String>?`, so reading the
audit row back routed it into `CachePolicy.fromJson`, which cast the now-string
`version` to `int`.

The fix is a private `_policyAuditData` helper that drops `__className__`
before stringifying. The proposed key-prefixing workaround would have worked
only by accident and would have disfigured the audit data. The other two audit
writers (`vela_calibration_sync.dart:202`,
`poi_issue_moderation_service.dart:169`) build literal maps and never carried
the marker, so they needed no change.

**F20 — the stale-validation test never asserted what it claimed.** The
`recordValidation` revision check is correct; nothing in `TaxonomyService`
needed changing. The test passed a bare `isA<ApiException>()` to `expectLater`
instead of wrapping it in `throwsA`, so it compared the *Future object* against
the matcher, failed immediately, and abandoned the still-running transaction.
`tearDown` then truncated the taxonomy tables underneath that orphaned
transaction, so its `_draft` lookup found no row and threw `not_found`, which
surfaced asynchronously and was attributed to whichever test was running next.
That is the whole explanation for the "leaks into the next test" symptom. A
sweep of every `expectLater` in `test/` and `integration_test/` found no other
instance of this mistake.

**F14 — catalog pruning had nothing to prune.** Also a fixture gap, as
suspected. `_seedRestaurantCatalog` seeds exactly ten places and the request
asks for a ten-place deck, so every catalog row was referenced by an immutable
session and `CatalogPruner.prune`'s `NOT EXISTS` clause correctly matched
nothing and returned `0`. The pruner is right; the test could not tell a working
pruner from a broken one. It now inserts one unreferenced stale row after the
session is created and asserts `removed == 1`, that the unreferenced id is gone,
and that all ten deck rows survive — proving both halves of the claim in its own
name.

**Verification.** Pinned full preflight passes: generation, formatting, all
fatal-info analyses, 118 server tests, 165 app tests, 51 admin tests, shell
syntax, and `git diff --check`. The real-PostGIS suite is 36/36 on two
consecutive runs.

The signed `0.2.1+7` APK and its alias are 105,253,887 bytes at SHA-256
`ef731e258e34f3d57e4692113db04de2850cdbb73effaf69f4c2def0591dc140`. It verifies
under APK Signature Scheme v2 with the expected signer, and reports
`sa.almou.hayer`, `versionCode 7`, `versionName 0.2.1`, `minSdk 26`,
`targetSdk 36`.

Note that this differs from the `34091e6b…` / 104,876,403-byte APK the
2026-09-10 entries below record. Nothing in this change touches `app/` or
`admin/`, so it cannot move the APK; the difference comes from client work
already merged into `main` since those builds, principally `c5b5360`. Treat
`ef731e25…` as the current build for `0.2.1+7`, and do not read the older hash
as still current.

**Toolchain correction.** Export only `FLUTTER_BIN`. `hayer_resolve_dart`
already prefers the `dart` beside the resolved Flutter, so `FLUTTER_BIN` alone
pairs 3.47.2 with Dart 3.13.2. Also exporting `DART_BIN` makes
`scripts/test-resolve-toolchain.sh` fail — it asserts Flutter's own Dart
precedes `PATH` — and that is preflight's first step, so preflight dies at once
with `Flutter's Dart should precede PATH`. Piping preflight through `tail` hides
this, because the pipeline reports `tail`'s status rather than preflight's.

### Integration suite ran against real PostGIS for the first time (2026-09-11)

`scripts/test-integration-remote.sh` (committed `d150038`) points the suite at
any reachable disposable Postgres instead of only the unavailable local Docker
Compose stack, closing the "await Docker" gap on the F05/F06/F07, F14, and F20
checkpoints above. Run twice against a throwaway `postgis/postgis:16-3.5-alpine`
container for reproducibility: 32/36 passing, four deterministic (non-flaky)
failures.

The `WARNING: The database does not match the target database` line every
`setUpAll` prints is not the cause of any of these — `psql \d hayer_poi_catalog`
against the same container after the run confirms `location`, the GIST/GIN/trgm
indexes, and the FK all exist exactly as the migrations define them. Whatever
comparison produces that warning is a false positive (a generated-column
comparison quirk is the likely cause) and can be ignored for now.

One failure was a test-config gap, not a product bug, and is already fixed:
`catalog_persistence_contract_test.dart` (F05/F06/F07's "overlapping refreshes"
case) races two real concurrent `buildDeck()` calls but, unlike
`admin_mutation_atomicity_test.dart`, `admin_auth_revocation_test.dart`, and
`hayer_session_endpoint_test.dart`, never set `rollbackDatabase:
RollbackDatabase.disabled` on `withServerpod`. The harness's single shared
rollback transaction can't run two sessions' queries concurrently, so it threw
`Concurrent database calls outside an already active transaction are not
supported...` instead of exercising the real race. Added the same
`rollbackDatabase: RollbackDatabase.disabled` the other three files use.

With that fixed, the test now runs the real race and fails on an actual
assertion instead: the `sushi-only` candidate never lands in
`hayer_poi_catalog` when two `buildDeck()` calls overlap
(`catalog_persistence_contract_test.dart:106`, expected
`['pizza-only', 'shared', 'sushi-only']`, got `['pizza-only', 'shared']`). This
is a genuine concurrency bug in the catalog upsert path this test exists to
catch — one candidate's insert is lost under overlap. Unstarted.

Three more failures, all reproduced identically across both runs:

- **F20** — `admin_mutation_atomicity_test.dart`, "editing invalidates an
  in-flight validation revision": `TaxonomyService.recordValidation`
  (`taxonomy_service.dart:184`) reads `_draft(session, version, transaction:
  transaction)` and compares `row.revision != revision`, which on inspection
  should throw `ApiException(code: 'conflict')` when the draft was edited to
  revision 2 after a stale revision-1 validation was in flight — but the call
  resolves without throwing, then an unrelated `ApiException(code: not_found,
  "Taxonomy draft not found.")` from `_draft` (`taxonomy_service.dart:342`)
  surfaces asynchronously, attributed by the reporter to the next test. Read
  through `recordValidation`/`_draft`/`saveTaxonomyDraft`
  (`admin_endpoint.dart:148`) without finding the defect — the conflict check
  looks correct in isolation, so the bug is likely in how the two transactions
  interleave (a visibility/isolation issue) rather than in the check itself.
  Needs someone who can step through it live.
- **F20** — `admin_mutation_atomicity_test.dart`, "two cache policy saves of
  one version commit exactly once": `type 'String' is not a subtype of type
  'int' in type cast` in generated `cache_policy.dart:57`
  (`CachePolicy.fromJson`), while `AdminAuditRow.fromJson` decodes its
  `afterData`/`beforeData` field. Root cause traced: `AdminEndpoint.updatePolicy`
  (`admin_endpoint.dart:873`) builds that audit snapshot as
  `_toPolicy(saved).toJson().map((key, value) => MapEntry(key, '$value'))` —
  correctly matching `AdminAuditRow`'s declared `Map<String, String>?` schema
  (`admin_audit_row.spy.yaml:13-14`). But because the stringified map's key set
  happens to exactly match `CachePolicy`'s field names, Serverpod's generated
  `Protocol.deserialize` on the read-back path routes it through
  `deserializeByClassName` into `CachePolicy.fromJson` instead of treating it
  as a plain string map, and the cast fails on the now-stringified `version`
  field. Looks like a Serverpod codegen/runtime ambiguity rather than an
  application bug — the app code matches its own declared schema. Workaround
  candidate: prefix the diff keys (e.g. `before_version`) so they no longer
  collide with a known model's field set, but haven't verified that actually
  avoids the dispatch.
- **F14** — `hayer_session_endpoint_test.dart`, "catalog pruning preserves
  places in immutable decks": `CatalogPruner.prune` returns `0` where the test
  expects `greaterThan(0)` (`hayer_session_endpoint_test.dart:567`). Not yet
  root-caused — most likely the test's `PlaceSource` fixture only returns
  exactly enough candidates to fill the deck, so there's no non-deck candidate
  left in `hayer_poi_catalog` for the prune's `NOT EXISTS` check to remove.
  Haven't confirmed against the fixture.

Claude ran this investigation from the front-end worktree at the user's
explicit request; the remaining three findings are real backend business-logic
bugs and are handed off here rather than fixed in place.

### F05/F06/F07 catalog contract — implemented (2026-09-10)

One live result batch now reaches the database through three ordered,
parameterized `INSERT ... ON CONFLICT` statements—catalog, category evidence,
and coverage—inside one transaction. There are no per-place or per-category
existence reads. Conflict merges preserve `firstSeenAt`, quarantine timestamp/
reason, and the newest dynamic snapshot/coverage values. Stable ordering of
provider/category keys reduces overlapping-refresh deadlock risk.

Each candidate carries all query categories that actually observed it. The
catalog stores those observations plus the validated parent category, while
coverage retains the full requested query set. Evidence is marked with both
the `hayer-v2` contract and active calibration version; legacy broadened rows
remain stored for auditability but no longer satisfy cache reads, and ordinary
refreshes progressively rebuild clean evidence. Immutable session snapshots
are unchanged.

Cache SQL now filters by current evidence, price, closure state, freshness, and
radius before a deterministic review/rating/distance/ID `LIMIT 500`. Dart then
reapplies the exact caller policy and balanced category selection. Shared live
refresh results require exact calibration, resolved query order, coordinates,
radius, price, and deck-size identity, eliminating rounded-anchor leakage.

Pinned full preflight passes 118 server tests, 123 app tests, nine admin tests,
generation/formatting, all fatal-info analyses, and repository checks. Three
real-PostGIS cases cover overlapping provider IDs, preservation of moderation/
first-seen metadata, disjoint and union cuisine cache behavior, and a dense
508-row category/price/radius fixture. They compile but cannot execute because
this host has no Docker command or local Postgres server. Representative
`EXPLAIN` evidence is also pending. The signed `0.2.1+7` APK and alias remain
104,876,403 bytes at SHA-256
`34091e6b6eac5a2663e9cd5b2c9b1ffbc5ae879966710afc29aa4a14ec9276d2`;
both manifests, package/version metadata, and APK Signature Scheme v2 verify.

### F20 atomic admin mutations — implemented (2026-09-10)

Taxonomy save, validation, publish, and rollback now hold the affected draft or
candidate row in a short transaction. Each revision/status check is repeated
under that lock, so a stale save conflicts, an edit invalidates in-flight
validation, and publish is bound to the exact validated document revision.
Cache-policy saves likewise lock the current version; concurrent first writes
use the unique settings key as a compare-and-swap boundary.

Every existing audited admin mutation now commits its audit row with its state
change: taxonomy operations, policy updates, pruning, refresh request/cancel,
coverage invalidation, calibration activation/rollback, and POI quarantine/
restore. Expensive taxonomy and calibration live canaries remain outside the
transaction, with their persisted state rechecked afterward. Calibration
candidate persistence also rechecks immutability under a row lock.

Five real-Postgres cases cover concurrent taxonomy saves, validation versus an
edit, publish versus an edit, concurrent policy saves, and injected audit-write
failure rollback. They compile with fatal-info analysis but cannot execute
because this host has no Docker command or listening test Postgres instance.
Pinned full preflight passes 111 server tests, 123 app tests, nine admin tests,
generation/formatting, all analyses, and repository checks. The signed
`0.2.1+7` APK and alias remain 104,876,403 bytes at SHA-256
`34091e6b6eac5a2663e9cd5b2c9b1ffbc5ae879966710afc29aa4a14ec9276d2`;
both manifests, package/version metadata, and APK Signature Scheme v2 verify.

### F14 privileged-session revocation — implemented (2026-09-10)

The JWT manager remains compatible with Serverpod's JWT refresh endpoint but
adds one targeted state lookup after signature/expiry validation whenever an
access token carries `admin` or `admin-enrollment`. The existing refresh-token
row is the session record: logout or any token-manager revocation deletes it,
so a copied privileged access JWT fails on its next authentication check.
Anonymous consumer JWTs deliberately keep the existing stateless validation
path.

Passkey registration atomically deletes-and-claims the enrollment refresh row
inside the same transaction that consumes the challenge and inserts the
credential. A failed ceremony rolls the claim back; concurrent ceremonies can
commit only one claim. Successful registration also broadcasts the existing
revocation notification after commit.

Five focused unit tests pass. Three real-Postgres cases cover copied admin-token
replay, the stateless anonymous path, claim rollback, and concurrent one-time
consumption. They compile with fatal-info analysis, but cannot execute because
this host has no Docker command. Pinned full preflight passes 111 server tests,
123 app tests, nine admin tests, generation/formatting, all analyses, and
repository checks. The signed `0.2.1+7` APK and alias remain 104,876,403 bytes
at SHA-256
`34091e6b6eac5a2663e9cd5b2c9b1ffbc5ae879966710afc29aa4a14ec9276d2`;
both manifests, package/version metadata, and APK Signature Scheme v2 verify.

### F13 passkey UP/UV enforcement — complete (2026-09-10)

The server now parses registration attestation authenticator data and validates
login authenticator data before delegating to Serverpod's existing ceremony.
Both paths require the configured RP hash, the 37-byte minimum authenticator
structure, signed user presence, and signed user verification. Existing
origin/type, challenge, key-ID, and signature checks remain in force. Signature
counter zero remains accepted for synced passkeys.

Targeted regressions cover malformed and wrong-RP data, each missing flag on
registration, and valid ES256 login signatures whose signed authenticator data
has UP=false or UV=false. The tests first prove the pinned dependency accepts
those inputs, then prove Hayer's policy rejects them.

Verification: pinned full preflight passes generation/formatting, all fatal-
info analyses, 106 server tests, 123 app tests, nine admin tests, and repository
checks. The required signed `0.2.1+7` APK and alias are 104,876,403 bytes at
SHA-256
`34091e6b6eac5a2663e9cd5b2c9b1ffbc5ae879966710afc29aa4a14ec9276d2`;
both manifests, package/version metadata, and APK Signature Scheme v2 verify.
A supervised real-authenticator registration/login ceremony remains a release
gate.

### F30 recovery credentials stay out of logs — complete (2026-09-09)

First-time runtime initialization now requires a preprovisioned
`HAYER_ADMIN_PASSWORD` and fails closed when it is absent. Once
`admin.htpasswd` exists in the persistent gateway secret volume, restarts no
longer require the environment value. The initializer result and command no
longer carry or print a generated recovery password.

Deployment guidance tells the operator to supply the initial value through the
protected Unraid configuration, store it offline, and remove it from the
runtime environment after initialization. Targeted tests cover first-start
failure, configured initialization, secret preservation, and the absence of
credential-printing code.

Verification: pinned full preflight passes generation/formatting, all fatal-
info analyses, 103 server tests, 123 app tests, nine admin tests, and repository
checks. The required signed `0.2.1+7` APK and alias are 104,876,403 bytes at
SHA-256
`34091e6b6eac5a2663e9cd5b2c9b1ffbc5ae879966710afc29aa4a14ec9276d2`;
both manifests, package/version metadata, and APK Signature Scheme v2 verify.

### F01 method-aware join budget — implemented (2026-09-09)

`hayerSession.join` retains its 30-request/minute authenticated-user budget and
now also applies a 120-request/minute budget to the client address vouched for
by the gateway. Requests without that header fall back to the direct peer, so
direct-origin access cannot spend a legitimate forwarded client's budget.

The per-client ceiling allows more than twice the entire 50-person beta to join
within one minute behind a carrier NAT while bounding attacks that rotate among
previously-created anonymous identities. The endpoint itself owns this check
because every Serverpod session RPC shares `/api/hayerSession` at the gateway.

The real-PostGIS regression uses distinct authenticated identities sharing the
test peer and proves the 121st join attempt is rejected by the client budget.
Live proof of forwarded addresses, forged headers, and direct-origin behavior
still requires the production-like gateway/container environment.

Verification: pinned full preflight passes generation/formatting, all fatal-
info analyses, 101 server tests, 123 app tests, nine admin tests, shell checks,
and diff checks. The new integration case compiles but cannot run because this
host has no Docker command. The required signed `0.2.1+7` APK and alias are
104,876,403 bytes at SHA-256
`0ac17018b52c8685eaa783836bb2c79da44ff1fe9ba1af5e35cf6c0a7da7de0f`;
both manifests and APK Signature Scheme v2 verify. The backend-only change
correctly leaves the APK bytes unchanged from the prior P06 build.

## Open handoffs to the front-end lane

### F17 lightweight progress contract — back-end complete (2026-09-09)

The additive `hayerSession.progress` method returns the mutable session view,
participants, explicit caller, per-place aggregate vote tallies, and destination
choice state. It carries place IDs but no `PlaceSnapshot`, precise location,
address, photos, or other immutable deck fields. Existing `load` remains intact
for initial/bootstrap reads and old clients.

The read holds a shared room lock so concurrent progress readers do not block
each other while all revision-changing mutations remain serialized. Expiry is
an authorized, parameterized conditional update of only status/revision.
Presence writes are narrow and throttled to once per 30 seconds on this path.
The watch handshake now reads this state instead of loading and discarding the
entire deck before emitting its initial revision.

The real-PostGIS case proves caller authorization, updated aggregate counts,
and that serialized progress omits a known deck place name. It compiles under
fatal-info analysis but cannot run without Docker. Pinned full preflight passes
101 server tests, 123 app tests, nine admin tests, all analyses, generation,
formatting, and repository checks. The required signed `0.2.1+7` APK and alias
are 104,876,403 bytes at SHA-256
`34091e6b6eac5a2663e9cd5b2c9b1ffbc5ae879966710afc29aa4a14ec9276d2`;
both manifests, package/version metadata, and APK Signature Scheme v2 verify.

Claude handoff: rebase this commit, use full `load` only to acquire the deck,
then merge `progress` by `placeId` during real-time refresh. Preserve a full-
load fallback for an older server/rollback until the server-first rollout is
accepted. `resultTallies` deliberately omit rank; re-sort the retained result
snapshots using the existing result ordering after merging counts.
