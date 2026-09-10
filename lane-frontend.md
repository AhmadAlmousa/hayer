# Front-end lane log

Working notes for the front-end lane: `app/` and `admin/` presentation and
client-side behavior. Claude works this lane from
`.claude/worktrees/claude-lane` on branch `worktree-claude-lane`.

This file exists so the two lanes stop appending to the same paragraphs of
[`PROJECT.md`](PROJECT.md). Checkpoints, verification evidence, handoff
requests, and lane-local decisions live here. `PROJECT.md` stays authoritative
for everything shared: locked decisions, architecture, contracts, the milestone
checklist and its exit conditions, verification gates, and the role split
itself. Check a milestone box in `PROJECT.md`; explain how it was earned here.

The back-end lane keeps its own equivalent file. Neither agent edits the
other's.

Last updated: 2026-09-10

## Current state

- Branch `worktree-claude-lane`, merged into `main` on 2026-09-10 together
  with the back-end lane's seven post-`4c9520a` commits.
- Nothing in M7 is startable in this lane any more. What is left of the
  milestone here needs a physical device (M7-E acceptance, M7-G two-device
  reconnect), a container runtime (M7-B gateway proof, M7-G real-PostGIS
  regressions), protocol fields the back-end lane owns (M7-J sample counts,
  source type, version overlays), or the owner (F29's reviewer, contact, and
  documented decisions). The open handoffs are listed below.
- M7-E's remaining physical-device TalkBack/focus/contrast,
  largest-native-text, denied/approximate-location, background/reconnect, and
  performance checks need real hardware. The F17 client half is complete, and
  its server half arrived in the merge as `sessions.progress` (`774edc7`), so
  wiring the client onto that response is startable in this lane again.
- M7-A's client half is in place and was re-read for this pass: a failed local
  durability write rolls the card back with a message rather than advancing,
  and a deck whose last swipe is still queued shows a pending-sync screen with
  a retry instead of results. What is left of that checkpoint is the
  crash/replay/concurrency proving, which needs a real server and two clients.
- The F01 join limiter is *not* in this lane. It lives in
  `backend/hayer_server/`, so it moved to the back-end lane at the split.

## Checkpoints

### F17 client convergence — complete (2026-09-09, commit `6277dcd`)

`SessionRealtimeListener` acknowledges a revision only after its refresh
completes, so a failed refresh is retried instead of being filtered out by the
`<=` revision guard. Previously the revision advanced the moment an event
arrived and the queued refresh swallowed its own failure, so one failed refresh
left the room stale until an unrelated higher revision or a reconnect arrived.
When the failed refresh was the room's last event, nothing recovered it. That
was the user-visible correctness defect in F17, as distinct from its
performance half.

An event burst now collapses to the highest pending revision. The previous
`_eventQueue.then(...)` chained rather than coalesced, so twelve people swiping
produced twelve sequential full loads of the same session and the queue drifted
behind real time.

Reconnects and failed refreshes share one exponential backoff capped at two
minutes and jittered across the upper half of each window. The former fixed
five-second retry brought a whole room back in lockstep after a single gateway
restart and hammered a server that stayed down.

`pause`/`resume` release the connection while a screen is not resumed, wired to
lifecycle in swipe, lobby, and results. A connection's first event is the
server's current revision, so resuming resyncs without any separate polling
path.

Lobby queued a concurrent refresh instead of dropping it — `if (_loading)
return` lost the event rather than deferring it. Lobby and results now
propagate refresh failures to the listener while still rendering their recovery
UI; both previously swallowed the error and returned normally, which would have
reported a failed refresh as a success.

Coalescing lives in the listener rather than in a third copy of the per-screen
`_loadInProgress`/`_reloadQueued` pattern, because acknowledging only
successful refreshes requires the listener to own revision state regardless.
Screens now only report whether their refresh failed.

Verification: pinned full preflight passes generation/formatting, all
fatal-info analyses, 101 server tests, 127 app tests, nine admin tests, shell
checks, and diff checks. The signed `0.2.1+7` APK is 104,892,787 bytes at
SHA-256 `d8d34935f840a3cf42710976986c3a9bee4ad97fdf44d4166d5ebb3cfeea2f45`,
declares `sa.almou.hayer` versionCode 7 / versionName 0.2.1, and verifies under
APK Signature Scheme v2 with the same signing certificate (`426f3bf4…77a6`) as
the previous release.

### F17 follow-up: deferred refreshes (2026-09-09)

The first pass left one acknowledge-before-apply case open, and it sat on the
common path rather than in a rare race. Lobby and results both call `_load()`
from `initState` and then connect; the listener's first event therefore lands
while that initial load is usually still in flight. The deferred branch set
`_reloadQueued` and returned normally, which told the listener the refresh had
succeeded. If the absorbing pass then failed, the revision was already
acknowledged, so the listener never retried it and every later event at or
below that revision was filtered — the same defect class the first pass
removed, reached by a different route.

A deferred refresh now waits for the pass that absorbs it and reports that
pass's outcome, carrying the original stack trace through
`Error.throwWithStackTrace`. The completer is stored per load loop and settles
with a nullable `(Object, StackTrace)` record rather than an error, so a
deferred caller that does not care about failures cannot leave an unhandled
async error behind.

Verification: pinned full preflight passes with 101 server, 128 app, and nine
admin tests. The regression test drives the real shape — an initial load in
flight, an event deferred into it, and that pass failing — and fails against
the previous code. The signed `0.2.1+7` APK is 104,876,403 bytes at SHA-256
`87f0ce99f30919eb07228f52e2831774961f2348b79df34e4cb11b4a3fdec08a`, declares
`sa.almou.hayer` versionCode 7 / versionName 0.2.1, and verifies under APK
Signature Scheme v2 with the usual certificate (`426f3bf4…77a6`).

### M7-J number legibility, and admin English-only (2026-09-10)

The M7-J slice that needs no back-end change: make every figure on the
analytics pages say what it is drawn from.

`KpiTile` painted every increase teal with an up arrow, so a rising average
decision time read as an improvement. `AnalyticsKpi` carries no polarity, so
`metric_semantics.dart` supplies it per key: sessions, participants,
completion and match rate are higher-is-better; `decision_time` is
lower-is-better; `participants_per_session` is neutral, because group size is
a usage characteristic rather than a quality signal. An unknown key reads as
neutral, so a KPI added server-side is never given a verdict this dashboard
cannot justify. Direction and verdict are now separate: the arrow says which
way the metric moved, colour says whether that is good, and a `Semantics`
label spells out both rather than leaving colour to carry the meaning alone.

Rates now show their denominator where the response carries one, resolved from
the sibling KPI that holds it — `completion_rate` and
`participants_per_session` from `sessions`. `match_rate` deliberately shows
none: its denominator is completed decisions, which the overview does not
expose, and inventing one would be worse than omitting it.

Breakdown rows show `n` per row and withhold cohorts below five samples,
stating how many were withheld and how many rows were truncated. Previously
`sampleCount` was carried by the protocol and dropped by the UI entirely, so
50% of four looked like 50% of four thousand, and `take(8)` truncated
silently. The donut carries the same treatment and now draws from six
theme-derived fills paired with their own label colours; three hardcoded
colours meant a fourth slice reused the first, and white slice labels assumed
a contrast that the orange fill did not provide.

The Overview subtitle asserted that data "refreshes every 5 minutes" while
`generatedAt` sat unused in every response. Pages now measure lag from the
response itself and flag it past twenty minutes, so a stalled rollup is
visible rather than papered over by a static claim. Each page also states the
period its figures cover, and deltas name their comparison window instead of
saying only "vs previous".

Separately, the dashboard is now explicitly English-only per the owner's
decision. Five nav labels were hardcoded English while six went through 23 ARB
keys used at seven call sites — a half-finished effort that made every new page
guess which convention to follow. The keys are inlined, `admin/lib/l10n/` and
`admin/l10n.yaml` are gone, and `generate: true` is off. Removing the
localization delegates also removed what initialized `intl`'s locale data, so
date formatting no longer names a locale explicitly; that regression was caught
by the existing admin widget tests.

Verification: pinned full preflight passes with 101 server, 128 app, and 23
admin tests, up from nine. No release APK accompanies this work because
nothing under `app/` changed; the admin dashboard ships as Flutter web, and
`flutter build web --release` compiles clean. The signed `0.2.1+7` from the
previous commit still covers the consumer tree exactly.

Open from the design review, not built: next-action links from an insight to
the page that can act on it, keeping content during reload instead of blanking
the page, fixed-height grid tiles that overflow at large text, and giving the
wide `NavigationRail` the grouping that only the narrow drawer has (its group
boundaries are hardcoded index ranges over parallel label/icon lists, which
M7-J's new pages will trip over).

### Admin robustness: large text and reloads (2026-09-10)

Two of the design-review items left open, picked up because the first was a
risk the previous commit had just increased.

The analytics grids set a fixed `mainAxisExtent`, so a tile that outgrows its
cell overflows rather than scrolling. Adding the denominator line to `KpiTile`
made that cell tighter. Measured: the default scale still fits, but a KPI tile
overran its cell by 130 pixels at 200% text and by 84 at 1.6 with a long
label — a pre-existing defect, since the dashboard never had the F24–F27 pass
the consumer app got. Cell height now scales with the viewer's text scale.
Because a card's text scales linearly while its padding does not, scaling the
whole cell leaves headroom that grows with the factor, so the fix holds rather
than merely moving the breaking point; the tests sweep 1.0, 1.3, 1.6 and 2.0
against the worst case the overview can produce.

Each page also swapped its entire body for a spinner on every filter change,
and replaced good figures with an error panel when a reload failed — so an
operator lost the numbers they were comparing against at exactly the moment
they were comparing them. `AdminAsyncSection` keeps the last successful
response on screen, marks it refreshing while a new request is in flight, and
on failure keeps it behind a banner saying it is stale. It also ignores a
response for a filter the operator has already moved on from, which the plain
`FutureBuilder` did not guard.

Verification: pinned full preflight passes with 101 server, 128 app, and 33
admin tests, up from 23. No release APK: nothing under `app/` changed, and
`flutter build web --release` compiles the dashboard clean.

Still open from the review: next-action links, and the wide `NavigationRail`
grouping.

### M7-J next-action links (2026-09-10)

The last M7-J item in this lane that needs no protocol field: a figure now
names the view that can act on what it shows, and carries its subject there.

The analytics pages report and change nothing, so every finding ended in the
same manual detour — work out which of eleven destinations owns the problem,
open it, and search the place again by hand. `next_actions.dart` declares each
destination once as an `AdminNextAction` (label, what can be done there, route)
in the manner of `metric_semantics.dart`, and the pages attach them where a
figure has a genuine owner: the cache and source facts and the cache-quality
breakdown to refresh jobs and the catalog, popular cities to coverage, selected
categories to taxonomy, and each ranked place to the catalog and to its own
issue reports. A link states where the responsible controls are; it does not
assert the figure is a defect, because the dashboard cannot separate product
friction from weak supply on its own.

The setup-choice breakdowns on Usage — group size, radius, deck size, price,
visit timing — deliberately get no link. `CachePolicy` holds no defaults for
any of them, so every candidate destination would be a guess dressed as a
recommendation.

A place travels by name into the catalog, whose search is `name ILIKE` only,
and by id into the issue queue, whose search also matches `placeId` — two
places can share a name. `/catalog?q=` and `/reports?q=` seed the search each
page opens on. Both pages also apply a newly carried search in
`didUpdateWidget`: `go_router` reuses the same `State` for a second link to the
same route, so `initState` alone would have left an operator looking at the
previous place's rows under a new place's link.

Fixed alongside, because the same page had to be pumped to test the links: the
`Rank places by` field overflowed its own decoration by 111 pixels, and the
place table's action lives beside the name rather than in a trailing column,
which the table's horizontal scroll would have put off-screen at the width the
page opens on.

Verification: pinned full preflight passes with 101 server, 128 app, and 44
admin tests, up from 33. The new cases cover the encoded round trip of a place
name that looks like a query string, a place carried into its issue queue by
id, a second link replacing the first one's filter, the Places page at 200%
text, and a breakdown card's links at 1.0x and 2.0x plus its empty state. No
release APK: nothing under `app/` changed, and `flutter build web --release`
compiles the dashboard clean.

Not covered by a widget test: the catalog leg of the place menu. `_CatalogPage`
embeds a `MapLibreMap` whose `dispose` throws off a device — its method channel
is never initialized — and the interrupted unmount leaves a `RawTooltip`
pointer route registered, which then fails unrelated later tests in the same
file. The route and the seeding are the same code as the reports leg, which is
covered end to end; the catalog link's own location is unit-tested.

### Wide navigation grouping (2026-09-10)

The last item from the M7-J design review. The narrow drawer had shown
Insights / Content / Operations / Governance since that pass; the wide layout
showed eleven destinations as one column whose only hint of structure was a
tooltip on the rail's leading icon.

Material's `NavigationRail` takes a flat `List<NavigationRailDestination>` and
has nowhere to put a heading, so the wide layout renders the declared groups
itself. Labels moved beside their icons rather than under them: measured, four
headings plus stacked labels put the last destination at y≈920 in a 900-pixel
window — the height a 1080p screen leaves a browser — so Governance would have
been below the fold. The column still scrolls for scaled text or a later page,
and a test pins that today's set needs no scrolling at that height.

Route, label, icon, and group membership were three parallel lists plus
hardcoded index ranges — `for (var i = 5; i < 9; i++)` was what made a page
part of Operations — and `_adminRoutes` was a fourth list of the same routes in
the same order. They are one declaration now, read by the router and both
layouts, so a page added in the middle cannot change the heading of the pages
after it or shift the index another page resolves by.

A destination is also one merged semantics node announcing its name and whether
it is the current page; selection had been carried by colour alone. That is
verified against the navigation directly: in the assembled app neither this
navigation nor the `NavigationRail` it replaced contributes nodes to the test
semantics tree, which was checked against the previous commit before the change
was kept.

Verification: pinned full preflight passes with 101 server, 138 app, and 51
admin tests. No release APK for this commit: nothing under `app/` changed.

### F29 in-product data account and device erase (2026-09-10)

The front-end half of M7-B's F29 bullet. The audit found no in-product account
of the identity and location lifecycle and no deletion entry point: a user
could see "Address from OpenStreetMap" on a card, but nothing said their
coordinates reach the server, that the room sees their name and progress but
not their swipes, or that saved notes never leave the device.

`/data` — "Your data", reachable from home and from the setup step that asks
for a location, which is the file F29 names. Every claim was read out of the
path it describes rather than written from intent: no account
(`ensureAnonymousAuthentication`, no email/phone/password), the search anchor
and radius in `CreateSessionRequest`, the participant coordinates sent with a
route estimate, OpenStreetMap for addresses and Google Maps for place details,
`ParticipantView` (name, deck position, completion) and the aggregate-only
`DestinationChoiceState`/`SessionResult` counts for what a room sees, the four
device-local stores, and `ClientAnalyticsContext`'s per-room journey id with
app build, platform and language. Where the app cannot promise something it
says so: erasing this device does not remove what the server already recorded.

`DeviceDataRepository` erases saved places and notes, the remembered name, the
queued swipes, the resumable room pointer, and the anonymous sign-in. Two
stores only knew how to add, so `clear()` was added to both. Sign-out runs last,
so a partial failure never leaves data on the device under an identity it can
no longer reach, and the confirmation counts undelivered swipes first — they
are the one thing an erase destroys that the server has never seen.

Verification: pinned full preflight passes with 101 server, 138 app (up from
128), and 51 admin tests. The new cases cover each store being cleared, an
already-empty device, a queue that cannot be read, the sections rendering, the
question being asked before anything is destroyed, a failed erase reporting
itself, and the account at 200% text in English and Arabic at 320×640. The
signed `0.2.1+7` APK is 105,106,279 bytes at SHA-256
`d533a016423af6bb1cb1962432ae94198c2e1a164261d7b49918cf416a51152a`, declares
`sa.almou.hayer` versionCode 7 / versionName 0.2.1, and verifies under APK
Signature Scheme v2 with the usual certificate (`426f3bf4…77a6`).

Two gaps this lane cannot close, both owner-side: the notice carries no support
or deletion contact, because none exists to quote, and the bilingual copy makes
user-facing claims that should have the owner's read before beta. F29 also
wants a provider/source-use inventory, a named reviewer, and documented
retention, attribution, outage and commercial-use decisions; those are not
front-end work, and the server half — city-only geocoding precision and cleanup
of inactive anonymous identities — stays with the back-end lane.

### P06 independent re-verification (2026-09-09)

P06 was re-verified from this worktree before new work started, rather than
taken from the tracker. The 101/123/9 test counts, all three fatal-info
analyses, and the absent `docker` runtime reproduce exactly, and the staged
`0.2.1+7` APK matched its recorded size and SHA-256. The APK's build timestamp
precedes the P06 commit, but every P06 source file predates the build and all
three ABIs' `libapp.so` contain the P06 strings, so the signed build does cover
the committed code.

Two notes, neither a defect. The two `vela_calibration_feed_test.dart` cases
fail in a fresh worktree until `git submodule update --init` materializes
`references/Vela`. And `admin/lib/features/issues/poi_issue_page.dart` hardcodes
English, which matches the rest of the admin app — `AdminLocalizations` is used
only in `admin_app.dart`, seven call sites against 23 ARB keys — so it is a
pre-existing lane-wide gap rather than a P06 regression.

## Open handoffs to the back-end lane

### F17 server half — delivered 2026-09-10

The back-end lane landed this as `sessions.progress` in `774edc7`: a deck-free
response carrying the mutable session, participant/self progress, vote tallies,
and destination-choice state, with `SessionProgress` generated into
`backend/hayer_client/`. The client is not on it yet — `_loadById` is still the
only read this lane calls — so the work below is now an open task here rather
than a handoff, and the jittered polling fallback can land with it as intended.
The original request is kept for its sizing argument.

The client still fetches the whole immutable deck on every refresh, because
`_loadById` is the only read available, and that read is a locking write
transaction: it takes `LockMode.forUpdate` on the session row and updates
`lastSeenAt` before returning up to 50 `PlaceSnapshot`s.

A lightweight `sessionProgress` response — revision, participant progress,
match and choice counts, no deck — would cut a refresh from roughly 75–150 KB
to 1–2 KB. That is where the bulk of F17's amplification lives: a 12-person,
50-card room fans out about 7,200 refreshes, so the difference is roughly half
a gigabyte against roughly ten megabytes. Those are upper-bound estimates on a
full room, matching the audit's own framing, not measured traffic.

The audit's jittered polling fallback is deliberately not implemented yet.
Against today's full-deck `load` it would make a blocked-WebSocket client cost
more than it does now, so it should land with that endpoint rather than before
it.

Folding `results` and `load` into one response — `results_screen.dart` still
fires both in parallel — and decoupling the `lastSeenAt` write from every read
belong with F02/F03/F04 under M7-A, and are not started here.

### `scripts/resolve-toolchain.sh` mixes toolchains

`hayer_resolve_dart` resolves `dart` from `PATH` independently of the Flutter
it just resolved. On this host that silently pairs pinned Flutter 3.47.2 with
system Dart 3.12.2, and the 3.12 formatter reports 15 committed files as
unformatted, so `scripts/preflight.sh` fails at `--set-exit-if-changed` on a
clean tree. Exporting `DART_BIN` alongside `FLUTTER_BIN` is the workaround. The
resolved Flutter's own `dart` should take precedence over `PATH`. `scripts/` is
the back-end lane's, so this is reported rather than fixed here. Still
reproducing on 2026-09-10: the merge preflight failed this way twice before
both variables were exported, the second time reporting 18 files.

### Release keystore path is stale

`app/android/key.properties` points `storeFile` at
`/mnt/cache/coding/places_swiper/hayer/...`, which no longer exists, so
`scripts/build-release-apk.sh` fails at Gradle's `validateSigningRelease` after
a full build. The keystore itself is present at `app/android/hayer-release.jks`.
The file is gitignored and per-worktree, so only this lane's copy was
corrected. Resolved on 2026-09-10: the primary worktree's copy now points at
the same existing `app/android/hayer-release.jks`, so release builds work from
either worktree.

## Lane environment notes

A worktree materializes tracked files only, so a fresh one needs setup that the
primary worktree already has:

- `git submodule update --init --recursive` for `references/Vela`.
- `cp <primary>/app/android/key.properties app/android/`, then check its
  `storeFile` against the stale-path note above.
- `build/` is ignored, so the pinned toolchain exists only in the primary
  worktree. Export both variables, not just the first — `FLUTTER_BIN` alone
  still resolves system Dart:

```
export FLUTTER_BIN=/mnt/unraid/places_swiper/hayer/build/toolchains/flutter-3.47.2/bin/flutter
export DART_BIN=/mnt/unraid/places_swiper/hayer/build/toolchains/flutter-3.47.2/bin/dart
```

Release APKs and their `.sha256` files under `backend/deploy/releases/` are
gitignored, so a build never dirties a commit. There is no `docker` on this
host, so containerized PostGIS integration tests and live-gateway checks cannot
run from here.

## Lane decisions

- 2026-09-09: Fix F17 in two halves along the lane boundary rather than as one
  cross-lane change. The client half needs no protocol change and ships now,
  because the silent non-convergence it removes is a correctness defect, not a
  performance one. The server half is where the amplification actually lives,
  but it is a shared-lane change that reads better once M7-A's state contract
  lands.
- 2026-09-09: Put refresh coalescing in `SessionRealtimeListener` instead of
  copying the per-screen queue pattern a third time. Acknowledging only
  successful refreshes requires the listener to own revision state regardless,
  so the two concerns belong in one place.
