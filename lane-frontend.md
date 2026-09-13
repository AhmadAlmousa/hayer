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

Last updated: 2026-09-13

## Current state

- M9, "Got time" discovery, opened on 2026-09-13 and runs alongside M7.
  G1 landed in `017e17c`. M9-F is complete: its prework in `bb212d7`, and
  the configuration read and kept links on the back-end lane's contract
  commit `4014037`. The M9-B/C/D and consumer M9-E contracts are on `main`
  (`backend/discovery-contracts.md`), so G2–G4, H and J can build against
  the generated types and fakes; every discovery data RPC still answers
  `feature_disabled`. See the checkpoints below and `discovery_upgrade.md`
  §"Implementation plan".
- Branch `worktree-claude-lane`, merged into `main` on 2026-09-10 together
  with the back-end lane's seven post-`4c9520a` commits.
- F17 is complete in this lane as of 2026-09-10: the client now refreshes
  through `sessions.progress`, and a blocked event stream no longer strands a
  room. See the checkpoint below.
- Every place photo now states the size it needs decoding at, as of
  2026-09-10. See the checkpoint below; confirming the effect on a real device
  belongs to M7-E's outstanding performance check.
- What is left of M7 here needs a physical device (M7-E acceptance, M7-G
  two-device reconnect), a container runtime (M7-B gateway proof, M7-G
  real-PostGIS regressions), protocol fields the back-end lane owns (M7-J
  sample counts, source type, version overlays), or the owner (F29's reviewer,
  contact, and documented decisions). The open handoffs are listed below.
- M7-E's remaining physical-device TalkBack/focus/contrast,
  largest-native-text, denied/approximate-location, background/reconnect, and
  performance checks need real hardware.
- M7-A's client half is in place and was re-read for this pass: a failed local
  durability write rolls the card back with a message rather than advancing,
  and a deck whose last swipe is still queued shows a pending-sync screen with
  a retry instead of results. What is left of that checkpoint is the
  crash/replay/concurrency proving, which needs a real server and two clients.
- The F01 join limiter is *not* in this lane. It lives in
  `backend/hayer_server/`, so it moved to the back-end lane at the split.

## Checkpoints

### M9-F configuration and kept links — landed (2026-09-13)

The second half of M9-F, built on the configuration contract in `4014037`.
The server still answers `enabled: false`, so discovery stays dark. What
changed is that the app now asks, and no longer loses a link it cannot open.

**The configuration read.** `DiscoveryConfigController`
(`app/lib/features/discover/discovery_config_controller.dart`) reads
`bootstrap.discoveryConfig` the first time home or `/discover` needs it,
never inside `_initialize`, so Swipe startup neither waits on it nor fails
with it. Its state is unknown, enabled or disabled, and
`discoveryEnabledProvider` now derives from it instead of being a constant.

- A configuration is trusted for `expiresAt - serverTime`, capped at five
  minutes and counted from receipt on the device. Neither end is compared
  with the device clock, so a phone set to the wrong time neither stretches
  nor shortens the lifetime.
- It is read again when it expires in the foreground, on resume once it has
  expired, and before `/discover` opens without a fresh one. Reads in flight
  are shared, and an expiry-driven refresh waits at least 30 seconds, so a
  configuration that arrives already expired cannot become a request loop.
- A failed read, an older server without the method, and a contract version
  other than 1 all mean disabled. A failed refresh keeps a configuration
  still within its lifetime; an expired one that cannot be refreshed becomes
  disabled, as the contract requires.

**Kept links.** This replaces the prework's `go('/')`, which dropped the link.

- `/discover` shows a progress indicator until the configuration has been
  revalidated, so "not known yet" is no longer treated as off.
- When discovery is off, or turns off while the screen is open, the link's
  canonical location is written to secure storage through
  `PendingDiscoveryLinkStore` before the screen returns home. A stored value
  is read back through the codec, and anything that is not a `/discover`
  link is ignored.
- Home shows a notice with Try again and Dismiss. Try again reads the
  configuration again whatever the cache says, and opens the link only if
  discovery is on; otherwise it says the link is still kept. The link
  survives restarts and is forgotten when `/discover` opens that same link,
  on Dismiss, or when the device's data is erased.
- English and Arabic strings for the notice and the progress label.

Tests: `discovery_config_controller_test.dart` covers the lifetime cap, the
server-clock lifetime, expiry, resume, shared reads and each disabled cause.
`discover_route_test.dart` covers `/discover` with discovery off, missing,
on a newer contract and unknown, and `/app/discover` off and on; Retry while
still off and then on; Dismiss; and discovery turning off at foreground
expiry while the screen is open. `home_modes_test.dart` now drives home
through the configuration for on, off and unknown, each also in Arabic at
200% text on a 320x640 screen with a kept link showing.
`pending_discovery_link_store_test.dart` covers canonical read-back, and the
erase test now seeds a kept link. `widget_test.dart` and the setup and swipe
coverage in `consumer_ux_test.dart` are unmodified.

Verification: pinned full preflight passes generation, formatting, fatal-info
analyses, 151 server, 207 app (up from 184) and 51 admin tests, shell checks,
and diff checks. `scripts/build-release-apk.sh` produced signed `0.2.1+7` at
105,794,923 bytes with SHA-256
`4bb1f8986178a0e579baed9c899a6308b335035d03e713b6eaef0cf55461b2e4`. It
declares `sa.almou.hayer` versionCode 7 / versionName 0.2.1 with target SDK
36, verifies under APK Signature Scheme v2 with the same signing certificate
(`426f3bf4…77a6`) as previous releases, and its compiled manifest still
carries both discovery App Link paths.

Not verified here: App Link verification and cold and warm links on a
device, and direct `/discover` URLs on the web host. Both belong to M9-K and
to the back-end lane's pending gateway deployment.

### M9-G1 and M9-F prework — landed (2026-09-13, commits `017e17c`, `bb212d7`)

The first discovery work that needs no server contract. Discovery ships dark:
nothing here is reachable in production until M9-B's configuration read
replaces the local flag, so neither M9 box closes with this checkpoint.

**G1, the shared map base.** `HayerMap` (`app/lib/core/widgets/hayer_map.dart`)
now owns the MapLibre setup every map shares: the OpenFreeMap style, the 3–18
zoom range, north-up flat maps without compass or logo, and eager gesture
claiming. `SearchAreaMap` keeps its frame, overlay, annotations and drag
handling. `annotationOrder` is required, so the source-only Discover map can
pass an empty list, which MapLibre renders faster on Android.

`hayer_map_test.dart` pins the settings `SearchAreaMap` passed to MapLibre
before the move, for both the editable and read-only variants.
`search_area_map_test.dart` and the setup and lobby coverage in
`consumer_ux_test.dart` pass unmodified. The test's first version compared
`Factory.type`, which is the declared `OneSequenceGestureRecognizer` rather
than the recognizer it builds; it now builds the recognizer and checks that it
is an `EagerGestureRecognizer`.

**M9-F prework.**

- `DiscoveryUrlQuery` (`app/lib/domain/discovery_url_query.dart`) is the
  versioned `/discover` link codec. A link carries the committed viewport,
  sort, category selection and applied filters, and nothing about the device.
  Equivalent links canonicalize to one location: lists are deduplicated and
  ordered, text whitespace collapses, defaults are omitted, the viewport is
  rounded to five decimal places, and commas stay literal so shared links stay
  readable. Unusable values are dropped and reported as issues instead of
  silently changing the query. Limits mirror the planned server bounds (50
  category ids, 256 code points), and antimeridian-crossing boxes are rejected.
- `discoveryEnabledProvider` in `core/providers.dart` is false until the
  configuration read replaces it.
- `DiscoverScreen` sends a discovery link home with an availability notice
  while discovery is off. With the flag on it is an empty scaffold until G2.
- Android App Links accept the exact paths `/discover` and `/app/discover`;
  the router's existing `/app/` normalization keeps a mounted web link's query.
- With discovery on, home follows artboard 1a: a compact brand row, "How much
  time do you have?", and In a hurry and Got time as equal-width cards. With it
  off, `_singleSearch` keeps the original widgets verbatim, and the existing
  home, setup and swipe tests pass unmodified.
- English and Arabic strings. The Arabic uses the colloquial register home
  already uses: "كم عندك وقت؟", "مستعجل", "عندي وقت".

The two-mode home was also rendered with the real Nunito and Material icon
fonts in light and dark, and with discovery off, and compared against artboard
1a. That render was a throwaway and is not committed.

Verification: pinned full preflight passes generation, formatting, fatal-info
analyses, 130 server, 184 app (19 new) and 51 admin tests, shell checks, and
diff checks. `scripts/build-release-apk.sh` produced signed `0.2.1+7` at
105,286,907 bytes with SHA-256
`4a15d6c0bb4b0b1371b643b75df8eadac8799f924f71139978ef9ddd74d8c97a`. It declares
`sa.almou.hayer` versionCode 7 / versionName 0.2.1 with target SDK 36, verifies
under APK Signature Scheme v2 with the same signing certificate
(`426f3bf4…77a6`) as previous releases, and its compiled manifest carries both
discovery App Link paths.

Not verified here: App Link verification and cold/warm links on a device, and
web hosting of direct `/discover` URLs, which is M9-E deployment work in the
back-end lane. Still open in M9-F: the configuration provider once the M9-B
contract lands. Still open in M9-G: G2 to G4.

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

### F17 client integration onto `sessions.progress` (2026-09-10)

The client half of F17's performance argument is in place, and with it the
blocked-stream case the audit asked for. Lobby, swipe and results now refresh
through `SessionRepository.refresh`, which fetches only the half of a room that
can still change and merges it onto the bundle the screen already holds. A
refresh of a full twelve-person room drops from roughly 75-150 KB to 1-2 KB.
Presence survives the move: the back-end lane writes `lastSeenAt` on the
progress read too, throttled to thirty seconds, so leaving `load` behind did
not cost a room its presence signal.

Results was the worst offender and needed one more decision. It fetched
`results` and `load` in parallel on every event, so a single vote pulled two
copies of the same fifty place snapshots to move three integers per place.
`SessionResult.rank` is not read anywhere in the app — the screen sorts by the
reader's chosen order and numbers the rows it draws — so a refresh now rebuilds
its rows from the deck it holds plus `resultTallies`, and `applyResultTallies`
says in its doc comment that a caller who ever needs real server ranking must
read it from `sessions.results`. Opening the screen still fetches both, because
a cold screen has no deck to refresh onto.

Rollback is handled where it belongs. Build 6 has to work against a server
rolled back past this contract, which cannot answer the call at all. The first
failure that a full load then satisfies latches the repository off the
lightweight read for the rest of the process, so a rolled-back server costs one
wasted call rather than one per refresh. An `ApiException` is exempt: expiry,
lost membership and not-found are the server's real answers about this room,
and treating them as a missing endpoint would both hide the answer and disable
the read permanently.

The user-visible half is the blocked stream. Some networks refuse WebSockets
outright, and reconnecting alone never converges there: the room sat on
whatever it last loaded while people joined, swiped and matched, and said
nothing. After two consecutive attempts that deliver nothing — one dropped
stream is an ordinary reconnect and stays silent — the listener polls that
cheap read on a jittered six-to-twelve-second interval, widening to the
reconnect ceiling when the polls fail too, and stops the moment an event
arrives. `SessionSyncStatus` on lobby and results says which of the two states
the room is in, live-region announced, with a manual refresh. Swipe deliberately
has no banner: it shows your own deck, and the group state it actually needs is
the completion transition, which polling now delivers.

Two things were checked rather than assumed. Polling cannot inflate analytics,
because the server deduplicates a card impression per journey and place — the
integration suite asserts exactly that. And `_sleep` used `Future.delayed`,
which cannot be cancelled, so a disposed screen kept a live timer for the rest
of its backoff window; it is a cancellable `Timer` now.

One test-environment note for whoever extends this. Under `testWidgets`' fake
async a stream that errors or closes asynchronously never delivers, so the
listener makes no progress there. The blocked-stream widget test therefore uses
a `watch` that throws on connect, which is equally faithful to a blocked
WebSocket, and the error-stream path stays covered in real async by the
listener's own unit tests.

Verification: pinned full preflight passes with 118 server, 153 app (up from
138), and 51 admin tests, and all four fatal-info analyses are clean. The new
cases cover the deck being kept, the route policy surviving a refresh that
cannot carry it, a cold screen still fetching the deck, the old-server fallback
being used once and then dropped, an `ApiException` being reported instead of
retried, tallies moving the counts without a second `results` call, a place
outside the deck not being invented, polling starting only on the second silent
attempt and stopping when the stream returns, a failing poll being retried, and
the notice fitting 320x640 at 200% text in English and Arabic. The signed
`0.2.1+7` APK is 105,253,887 bytes at SHA-256
`431fb3e9dcddb6a3aaa5af41379f856bfe6376f69ca1b7a41b8510967a9c9420`, declares
`sa.almou.hayer` versionCode 7 / versionName 0.2.1, and verifies under APK
Signature Scheme v2 with the usual certificate (`426f3bf4…77a6`).

### Bounded place-photo decoding (2026-09-10)

The audit's remaining performance item in this lane. The extractor rewrites
every kept photo URL to `=w1600` before storing it
(`backend/hayer_server/lib/src/places/search_parser.dart:168-188`), so a photo
arrives 1600 logical pixels wide however small the box that draws it. Decoded,
that is roughly 6.8 MB of bitmap for a 48-pixel saved-list thumbnail, and
Flutter's image cache holds up to 100 MB of them — about fourteen photos — long
after the row that asked for one has scrolled away.

Four surfaces asked for the full bitmap: the swipe card in both its layouts,
the details-sheet gallery, and the saved-places thumbnail. Results was the one
that already bounded its decode, and it was doing it wrongly. `ResizeImage`
defaults to `ResizeImagePolicy.exact`, which resizes to exactly the width *and*
height it is given and ignores the source's aspect ratio, so the 84-pixel
square passed as both dimensions squashed every photo that was not already
square. `cached_network_image` hands `memCacheWidth`/`memCacheHeight` to
`ResizeImage.resizeIfNeeded` and offers no way to ask for the fitting policy,
so the fix is to pass one dimension only.

A width alone leaves the height to the photo's own aspect ratio, which the
client does not know, so the bound has to be wide enough that the resulting
height still covers the box — a 48x48 box needs about 85 pixels of width before
a landscape photo is 48 tall. `placePhotoDecodeWidth` takes the box and returns
`max(width, height x 16/9) x devicePixelRatio`, 16:9 being the widest ordinary
photograph. Nothing is upscaled by this: `ResizeImage` clamps to the source's
own width, so a box larger than the photo leaves it alone.

Two surfaces measure their box rather than assuming one. The swipe card already
had a `LayoutBuilder`, and the readable layout's strip is inset by the card's
own padding; the gallery gained one. The full-bleed swipe card is the honest
non-win: a card taller than a 1600-pixel photo can cover already needs every
pixel it has, so there the bound resolves above the source and changes nothing.
It is passed anyway so the site stays correct if a card is ever smaller than
the screen or a photo ever arrives larger.

The saved thumbnail is where this pays: 256 pixels decoded instead of 1600 at a
3x ratio, about 0.2 MB against 6.8 MB per row. Results drops to roughly 0.5 MB
and stops distorting. The strip in the readable card, which is the layout large
text and short screens fall back to, decodes under a quarter of the photo.

Not done, and deliberately: no prefetch of the next card's photo. `CardSwiper`
is configured with `numberOfCardsDisplayed: 3`
(`app/lib/features/swipe/place_deck_swiper.dart:76`), so the next two cards are
already built and already fetching. Adding a prefetch would duplicate work the
deck does for itself.

Verification: pinned full preflight passes with 118 server, 165 app (up from
153), and 51 admin tests, and four clean fatal-info analyses. The helper's
arithmetic is unit-tested for a square box, a wide box, pixel-ratio scaling, an
unmeasurable box, and the covering property across 1:1 through 16:9 at three
box shapes. Each surface has a case asserting it bounds the box it actually
renders — measured with `getSize` rather than against a hardcoded layout number
— and that no surface passes a second dimension. The signed `0.2.1+7` APK is
105,253,887 bytes at SHA-256
`5e8d37eaae0d60d31e0b59edb282b15a9ac8bf5b7c003f1cdae93b0152d4f98a`, declares
`sa.almou.hayer` versionCode 7 / versionName 0.2.1, and verifies under APK
Signature Scheme v2 with the usual certificate (`426f3bf4...77a6`).

Unmeasured: the memory figures above are computed from the source width and
four bytes per pixel, not read from a running profile. Confirming the frame and
image-cache effect on a lower-end Android device is part of M7-E's outstanding
physical-device performance check.

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

### F17 server half — delivered 2026-09-10, client wired 2026-09-10

The back-end lane landed this as `sessions.progress` in `774edc7`: a deck-free
response carrying the mutable session, participant/self progress, vote tallies,
and destination-choice state, with `SessionProgress` generated into
`backend/hayer_client/`. The client now uses it; see the checkpoint above. The
original request is kept below for its sizing argument.

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
clean tree. Exporting `DART_BIN` alongside `FLUTTER_BIN` was the workaround. The
resolved Flutter's own `dart` should take precedence over `PATH`. `scripts/` is
the back-end lane's, so this was reported rather than fixed here. It reproduced
twice during the 2026-09-10 merge preflight, the second time reporting 18 files.

Resolved by the back-end lane on 2026-09-10 in `044617b`: the Flutter sibling
now precedes `PATH`, with explicit-override, fallback, and invalid-override
regression cases wired into preflight. Re-verified from this lane with `DART_BIN`
unset — the resolver returns the pinned 3.13.2 Dart and preflight exits zero, so
`FLUTTER_BIN` alone is now sufficient.

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
  worktree. Since `044617b` this one variable is enough, because the resolver
  takes `dart` from the Flutter it resolved:

```
export FLUTTER_BIN=/mnt/unraid/places_swiper/hayer/build/toolchains/flutter-3.47.2/bin/flutter
```

Release APKs and their `.sha256` files under `backend/deploy/releases/` are
gitignored, so a build never dirties a commit. There is no `docker` on this
host, so containerized PostGIS integration tests and live-gateway checks cannot
run from here.

## Lane decisions

- 2026-09-13: Count a discovery configuration's lifetime as the server's
  `expiresAt - serverTime` from the moment it arrives, rather than comparing
  `expiresAt` with the device clock. A phone set a few minutes wrong would
  otherwise see every configuration as already expired, or trust one far
  longer than five minutes.
- 2026-09-13: Revalidate on resume only once the configuration has expired.
  The five-minute cap already bounds staleness, and resumes also follow
  permission dialogs and the share sheet, so a read on every resume would
  add requests without a fresher answer.
- 2026-09-13: Keep one link, the most recent. A second link that cannot open
  replaces the first, because the newer one is what the user just asked for.
- 2026-09-13: Retry pushes the kept link over home, as the Got time hero
  already does. go_router does not reflect a push in the browser URL by
  default, so on the web the address bar stays at `/` after either. G2
  derives its committed query from the router and has to settle URL
  reflection there.
- 2026-09-13: Gate discovery on a local `discoveryEnabledProvider` that is
  always false instead of waiting for M9-B. The entry, route and links can
  land and be tested now through an override, and the configuration
  provider has one place to replace.
- 2026-09-13: While discovery is off, `/discover` goes home with a notice
  through `go('/')`, which drops the link. Requirement 15 asks to keep the
  URL for a later retry when discovery is disabled live; that belongs with
  the configuration provider, which can tell "not known yet" from "off".
  Done with that provider; see "M9-F configuration and kept links".
- 2026-09-13: Keep the link codec in `domain/` as pure Dart with its own
  validation mirroring the planned server limits. The server stays
  authoritative; the codec exists for canonical, readable links and an
  honest notice when part of a link is dropped. Category ids are checked
  only for shape, because the Discover tree's id format is the back-end
  lane's to define.
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
- 2026-09-10: Let the results screen rebuild its rows from the deck and the
  tallies rather than keep calling `sessions.results` on every refresh. The
  alternative — reproducing the server's ranking rule in the client — would
  duplicate a contract this lane does not own. Rebuilding is safe only because
  nothing in the app reads `SessionResult.rank`; that condition is written into
  `applyResultTallies`, so a future caller that needs ranking has to go back to
  the server for it.
- 2026-09-10: Poll on the same cheap read the stream refresh uses, and gate
  polling on the listener's own connection health rather than a screen-level
  timer. One dropped connection is deliberately not enough to start it: an
  ordinary reconnect takes a few seconds, and a room that announced degradation
  every time would train people to ignore the notice.
