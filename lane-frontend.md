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
other's. From 2026-09-15 Claude holds both lanes, by owner assignment, until
Codex returns. Back-end work is still logged in `lane-backend.md` on `main`,
and this log gets a short pointer for each back-end checkpoint.

Last updated: 2026-09-15

## Current state

- M9, "Got time" discovery, opened on 2026-09-13 and runs alongside M7.
  G1 landed in `017e17c`. M9-F is complete: its prework in `bb212d7`, and
  the configuration read and kept links on the back-end lane's contract
  commit `4014037`. G2, the results screen, landed on 2026-09-13, and G3,
  filters and categories, on 2026-09-14, followed that day by the area
  follow-up on the back-end lane's `eda8827` contract. M9-J's admin surfaces
  landed the same day on the back-end lane's `ebbdf5f` admin contracts, and
  G4, pins, selection and coverage, later that day on the same generated
  types, without merging `main` while Codex is paused. H, place detail, save,
  share and report, followed on the same generated types and fakes
  (`backend/discovery-contracts.md`). On `main`, `browse`,
  `facets` and `placeContext` run against the catalog (M9-C, `532d33d`), still
  dark behind `discoveryEnabled`. Shared details now answer in both modes, and
  catalog reports work behind the flag (M9-D, `a40ff76`). Harvesting,
  coverage and the M9-E admin reads are implemented too (M9-E,
  `7429e03`), harvesting behind the flag. This branch has not merged `main`
  since `3c042fc`. See the checkpoints below and
  `discovery_upgrade.md` §"Implementation plan".
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

### Back-end M9-E on `main` — pointer (2026-09-15)

Claude finished M9-E in the back-end lane as `7429e03`. The evidence
is in `lane-backend.md`, and the behavior it settled is in
`backend/discovery-contracts.md` §"Harvesting and coverage as implemented
(M9-E)" and §"Admin as implemented (M9-E)". The generated client did not
change. For this lane:

- G4's receipt handling fits the server:
  - a pending or running `job` means follow it;
  - no job and no `retryAfter` means fresh;
  - a finished job with `retryAfter` means cooling down.
- `rate_limited` comes only when a new harvest would start.
- Footprints are the square around the snapped cell centre, so wide views stay
  partly explored under G4's union check.
- `lastSuccessAt` moves only on a full success, so G4's "unfinished" rule
  holds as written.
- "Searches" in the exploring strip count Swipe compatibility queries too.
- J's manifest editor, job page, unmapped types and growth dashboard now have
  a real server. Requesters are pseudonymous (`user:` and a hash). The
  manifest's Arabic fallbacks still need a reviewer.
- Every back-end M9 slice is done. What remains is M9-K, the cross-mode
  verification and dark release.

### Back-end M9-D on `main` — pointer (2026-09-15)

Claude finished M9-D in the back-end lane as `a40ff76`. The evidence
is in `lane-backend.md`, and the behavior it settled is in
`backend/discovery-contracts.md` §"Details and reporting as implemented
(M9-D)". The generated client gained only a doc comment on `details`; no
signature or type changed. For this lane:

- `detailsAvailable` is now true whether or not Discover is enabled, so once
  the server is deployed H's Swipe sheet reads `place.details` too.
- A refresh takes at most 10 s, inside H's 15-second timeout.
- `refreshing`, `budgetExceeded` and `retryAfter` come in ordinary answers,
  never as errors. H does not poll, and needs no change for them.
- A stale answer hides rating, reviews, price, hours, status, phone and
  featured review. A Swipe sheet opened on a stale deck place therefore shows
  fewer facts once details load than its card did. Whether to keep the card's
  values under a stale notice is still to decide.
- The catalog report errors H already handles are the ones the server sends:
  `feature_disabled` and `not_found`. A report of a place already reported
  from Swipe, with the same type, returns that report's id.
- J's issue rows now carry `source` and `sessionId`, and
  `affectedSessionCount` can be 0 for Discover reports.
- Still to come from the back-end lane: coverage footprints and freshness
  (M9-E).

### Back-end M9-C on `main` — pointer (2026-09-15)

Claude finished M9-C in the back-end lane as `532d33d`. The evidence is in
`lane-backend.md`, and the query behavior it settled is in
`backend/discovery-contracts.md` §"Query behavior as implemented (M9-C)". The
generated client did not change, so nothing here needs regenerating. For this
lane's Discover work:

- G2's `rate_limited` handling also covers a statement timeout, which arrives
  with `retryAfterSeconds: 5`.
- G3's draft previews are counted under their own fingerprint, and `facets`
  spends its own budget, as G3 asked.
- G4's pin previews spend a separate `placeContext` budget, so the re-reads
  after each first page no longer draw on browse.
- H's rank names a category only when `populationCategoryId` is set, which the
  server does for a single selected category other than Other.
- Unknown category ids are a `bad_request`; kept links already strip them.
- Still to come from the back-end lane: coverage footprints and freshness
  (M9-E), and details and catalog reports (M9-D).

### M9-H place detail, save, share and report — built against contracts (2026-09-14)

The client half of requirement 10 and the sharing half of requirement 11. It
is built on the generated M9-C `placeContext` and M9-D `place.details` and
`place.reportCatalogIssue` contracts, all on this branch since `ebbdf5f`.
Every one still answers `feature_disabled`, so nothing here has met a real
server, and Discovery stays dark. `main` was not merged in while Codex is
paused.

**One sheet, two modes.** `PlaceDetailsSheet`
(`app/lib/core/widgets/place_details_sheet.dart`) now takes a
`PlaceDetailsMode`:

- `SessionPlaceDetails` is Swipe as it was. The existing constructor and
  `showPlaceDetails` build it, so both swipe call sites and the
  photo-decoding test compile unchanged, and route estimates stay
  session-only.
- `DiscoveryPlaceDetails` has no session. Its distance is a straight line
  from the permitted location and it never asks for a route estimate. It
  shows the hidden-gem and open-now badges over the photos, or as chips when
  there are none, a photo count, and the place's standing.

Both modes read `place.details` when the sheet opens. The snapshot shows
first and the answer replaces it; a failure or an unavailable read keeps the
snapshot. The read is made only while `placeDetailsAvailableProvider` is
true, which the app root answers from the discovery configuration's
`detailsAvailable`. That flag is independent of `enabled`, so Swipe keeps the
read with Discover off, and no sheet asks a server that has no such read.
Swipe identities use the provider `google-web`, as the contract names it;
Discover rows carry their own.

Save is handed to the sheet as a builder, because saving lives in
`features/saved` and `core` imports no feature. Both modes pass
`SavePlaceButton`, which gained a prominent style, over the unmodified
`SavedPlacesController`, and it saves the details last read. Directions now
comes first, then Save, then call and website. Save's snack bar appears once
the sheet closes, because a scaffold holds snack bars while another route
covers it; the button's label changes at once.

**Standing.** `DiscoveryPlaceStanding`
(`app/lib/features/discover/discovery_place_details.dart`) says where the
place stands in the whole filtered search, not in the loaded rows:

- the rank and total, "#2 of 31 places", naming a category only when the
  server gives `populationCategoryId`, and the sort the rank is under;
- "Where it sits in this view": the rating distribution as a strip with the
  place's own bucket highlighted, and the percentile sentence. Percentiles
  round down, to tenths below one percent. Zero reads as nothing rated lower,
  and no percentile means no sentence.

A selected row's Details asks `placeContext` in the query generation and
context the row was loaded in. A map preview already holds the answer, so its
Details asks nothing more. An ineligible answer says the place no longer
matches. `query_changed` says the results changed, with no retry, since the
results behind the sheet are already starting over. Any other failure offers
Try again.

**Catalog age, not venue age.** The sheet says "Added to Hayer in March 2025"
from `firstSeenAt`, in small type under the attribution. Nothing states or
implies when a place opened, and a test searches the whole screen for opening
words in both languages.

**Details from the list and the map.** A selected row shows a Details button
beneath it, and the map preview shows one under its row.

**Reporting.** `ReportPlaceIssueSheet.catalog` reports by catalog id through
`PoiIssueRepository.submitCatalog`, with no session and no snapshot. Sending
the same report again reuses its idempotency key, so a report whose answer
was lost is filed once; a changed reason or explanation takes a new key.
`feature_disabled` and `not_found` get their own messages. Discover's sheet
reports through it, and Worst rated rows carry a report button beside the
rating. The sheet closes itself with its own context, and Discover opens it
from the navigator's, so Report still works after the row or preview that
opened the details has gone, as it can when results refresh.

**Sharing.** The area bar's Share sends the committed search as
`https://hayer.almou.sa/discover?…` through SharePlus. The host now lives in
`app/lib/core/public_links.dart`, shared with join links. The link holds the
area, sort and filters and nothing about the device's location. After the
camera moves without Search this area, Share still sends the committed
search, whose results are the ones showing.

**Fixed on the way.**

- The report sheet imported `package:flutter/material.dart`. Its
  `ScaffoldMessenger` and `Theme` are different classes from `material_ui`'s,
  which the app runs on. After a report was sent, `ScaffoldMessenger.of` found
  no messenger, so the thanks never showed (an assertion in debug, a null
  check in release), and the sheet drew with the default theme instead of
  Hayer's. It now imports `material_ui`, and so does its test, whose app
  was a `flutter/material` one and hid the fault. This affected Swipe's
  reports too.
- G3 and G4 both defined `discoveryPreviewFailed`. The later definition won,
  so the filter sheet's failed count read "Couldn’t load this place." G4's
  string is now `discoveryPlaceLoadFailed`.

Not fixed here: `data_and_privacy_screen.dart` and
`route_origin_choice_sheet.dart` also import `flutter/material.dart`. The
first calls its `ScaffoldMessenger.of` and `showDialog`; both, and
`weekly_hours_calendar.dart`, read its `Theme.of`, which falls back to the
default theme in the app.

**Strings.** Everything new is in English and Arabic.

Tests:

- `place_details_sheet_test.dart`: the snapshot first and the details after;
  no read while unavailable; a failed read keeping the snapshot; a Discover
  sheet reading without a session, with badges, photo count and straight-line
  distance, no route estimate, and Save acting on the details last read.
- `discover_place_details_test.dart` drives the screen through the real
  router:
  - a selected row's standing and the request behind it; a category
    population under Worst rated with the lowest percentile; a rank without
    percentile or distribution; a preview's Details asking nothing more;
  - ineligible, changed and retried standings;
  - catalog age, and no venue-age wording, in English and Arabic;
  - Save through the controller into the store;
  - a report from the sheet with no session, retried under one key; a
    report opening after the preview that opened the details has gone; Worst
    rated rows reporting directly, and the unavailable message;
  - Share's public link;
  - Arabic at 200% on 320×640;
  - percentile rounding and bucket placement.
- `poi_issue_repository_test.dart`: a catalog report keeps the key it is
  given across the transient retry.
- The report-sheet tests pass with only their import changed. The swipe,
  results, photo-decoding and earlier Discover tests pass unmodified.

Verification: pinned full preflight passed generation, formatting, fatal-info
analyses, 159 server, 351 app (up from 329) and 72 admin
tests, shell checks, and diff checks. `scripts/build-release-apk.sh` produced
signed `0.2.1+7` at 106,926,159 bytes with SHA-256
`7a4bfa45ba154620f3187bccab7ac881a2455634a7ea8d2e6f28e2d88d0c4be8`. It
declares `sa.almou.hayer` versionCode 7 / versionName 0.2.1 with target SDK
36 and verifies under APK Signature Scheme v2 with the same signing
certificate (`426f3bf4…77a6`) as previous releases.

Not verified here: real detail refreshes, rank and percentile against
PostGIS, sessionless report storage, and the Android share sheet and shared
links opened cold and warm on a device (M9-K).

Status (2026-09-15): the server side is now on `main`, rank and percentile in
M9-C and details and sessionless reports in M9-D. This branch has not merged
`main`, so H still has not met a real server.

### M9-G4 map pins, selection and coverage — landed (2026-09-14)

The last part of the Discover surface. It is built on the generated M9-C map
and place-context contracts and on M9-E's consumer coverage contracts
(`ensureArea`, `deepen`, `harvestStatus`), all on this branch since
`ebbdf5f`. Every one still answers `feature_disabled`, so nothing here has
met a real server, and Discovery stays dark. On the owner's instruction,
`main` was not merged in while Codex is paused.

**Pins.** `DiscoveryMap` (`app/lib/features/discover/discovery_map.dart`)
draws the first page's map payload on the G1 `HayerMap` with style sources
and layers rather than annotations:

- up to the configured point limit, every match is a pin in a clustered
  GeoJSON source, labelled with its rating, with hidden gems dark-filled;
- above the limit, the server's aggregate cells go in a separate,
  unclustered source, and the bar asks to "Zoom in to see places";
- the selected place is drawn above both from a third source.

The three sources and eight layers are added once per loaded style and then
only fed new data, so repeated filter changes add nothing to the map; a
replaced style gets them again. Tapping a pin selects its place, a cluster
zooms in two levels, and a cell fits the camera to its bounds, which stages
Search this area like any other move. The GeoJSON builders are pure
functions in `discovery_map_features.dart`.

Pin labels keep Western digits in Arabic. The map draws them with the tile
style's Noto Sans, which has no Arabic-Indic digits. The list still formats
ratings for the locale.

**Selection.** `DiscoverySelectionController` keeps pins and rows in step.

- A pin whose row is loaded selects that row. The sheet rises to half height
  if it was lowered, and the row scrolls into view.
- A pin beyond the loaded pages is previewed above the list through
  `placeContext`, in the shown generation's query and context. No pages are
  loaded or reordered, and a late preview for an earlier pin is dropped.
- Tapping a row selects it and highlights its pin; tapping it again clears
  the selection.
- When the results are replaced from the top, a selection still among the
  rows stays. One missing from a points payload is cleared with a notice.
  Otherwise, as always with aggregates, the place is asked about again and
  cleared with the notice once it no longer matches. `query_changed` reloads
  the results once.

`DiscoveryResults` gained a `generation` count, so the selection can tell a
new first page from a later one.

**Coverage.** `DiscoveryCoverageController` reports each committed area to
`ensureArea` once, whether it came from a link, the starting area or Search
this area. Sorting, filtering or paging the same area reports nothing.

- It follows any exploration the report starts, or that the results list as
  pending. It checks every 3 seconds, or at the job's `retryAfter` within 3 to
  30 seconds, and stops in the background until the app returns.
- A succeeded or partial exploration reloads the results from the top, with
  a notice.
- Deepen keeps its idempotency key across a failed attempt and takes a new
  one once the server accepts it.
- A `rate_limited` answer, or a job or footprint cooldown, disables Deepen
  until it passes and says when.

The strip (`discovery_coverage_strip.dart`) describes whichever of the
results and the latest area receipt is newer, through
`app/lib/domain/discovery_coverage.dart`:

- Not explored yet, with how many places are already known there;
- Partly explored, when complete footprints do not together cover the view,
  checked by cutting the view along every footprint edge;
- Explored, when they do, still saying there may be places not yet found;
- Exploring, with completed and total searches;
- when the area was last explored, and whether the last attempt finished.

An empty, unexplored view that is being explored says so in place of "We
haven't explored this area yet". Empty results under filters keep the strip
beside Clear filters. At large text sizes the details and Deepen fold under
the strip's title: at 200% on a 320-pixel phone the full strip was 370 pixels
tall and pushed every row off the screen.

**Strings.** Everything new is in English and Arabic.

Tests:

- `discovery_coverage_test.dart`: the four states, footprint unions over
  quarters and around a centre cell, unfinished attempts, waits that count
  only while ahead, and a finished job outranking stale coverage.
- `discovery_map_features_test.dart`: pin, cell and selected features and
  their labels.
- `discovery_map_test.dart` runs the real `DiscoveryMap` over a recording
  MapLibre platform that creates a controller. It covers sources and layers
  added once across five query changes and a switch to cells, and again for a
  new style; pin, cluster and cell taps; and disposal releasing taps.
- `discovery_selection_controller_test.dart`: loaded and unloaded pins, late
  previews, what a refresh keeps or clears, the aggregates re-check,
  `query_changed` reloading once, and a failed preview's retry.
- `discovery_coverage_controller_test.dart`: one report per area, following
  an exploration to success, partial and failure, pending jobs listed by the
  results, stopping for a new area, Deepen keys, the rate-limit wait, and the
  newer-coverage choice.
- `discover_map_view_test.dart` drives the screen through the real router:
  - pins kept across pages, a loaded pin revealed, and an unloaded pin
    previewed without touching the pages;
  - a row highlighting its pin, and a departed selection's notice;
  - aggregates and the zoom-in prompt;
  - a cold area going from not explored to exploring to reloaded, and a sort
    that reports nothing more;
  - Deepen, the rate-limit wait, an unfinished exploration, and coverage kept
    beside Clear filters;
  - Arabic at 200% on 320×640 with the strip unfolded and a preview.

The existing Discover tests pass unmodified.

Verification: pinned full preflight passed generation, formatting, fatal-info
analyses, 159 server, 329 app (up from 279) and 72 admin tests, shell checks,
and diff checks. `scripts/build-release-apk.sh` produced signed `0.2.1+7` at
107,483,215 bytes with SHA-256
`f2dfde148db26cd3f02bff462edb1561ab7c588eae9839996964c69ff0fee44d`. It
declares `sa.almou.hayer` versionCode 7 / versionName 0.2.1 with target SDK
36, verifies under APK Signature Scheme v2 with the same signing certificate
(`426f3bf4…77a6`) as previous releases, and its compiled manifest still
carries both discovery App Link paths.

Not verified here: MapLibre clustering, label glyphs, tap hit-testing, and
pan and pinch with several hundred pins, all on a device (M9-K). Real
coverage waits on the M9-C and M9-E implementations.

Status (2026-09-15): real coverage, harvests and polling are implemented on
`main` (M9-C and M9-E). This branch has not merged `main`, so G4 has not met
them yet.

Not in G4: the preview's details action and a row's details affordance are
M9-H.

### M9-J admin surfaces — built against contracts (2026-09-14)

The admin half of Discover, built on the back-end lane's contract commits:
M9-B's policy and tree, M9-D's report source, and M9-E's admin reads in
`ebbdf5f`, which fast-forwarded this branch from `main`. Every one of these
methods still answers `feature_disabled`, so each page explains that state
rather than showing an error. Nothing here is proven against a real server
yet. Admin stays English-only.

**System policy.** `DiscoveryPolicySection`
(`admin/lib/features/discovery/discovery_policy_fields.dart`) adds, under the
existing form, the Discover switch, the Best formula, the scoring and badge
thresholds, harvest budgets and read limits, and a separate place detail
refresh section. A section is sent only when something in it changed.
Otherwise it goes as null, which the contract defines as "preserve", so a
save that touches only route estimates is exactly what an older dashboard
sends. A server that reports no section gets a note instead of controls, and
a save leaves the section alone. A malformed value names its field, and
nothing is sent.

**Discover tree** (`/discover-tree`, `discover_taxonomy_page.dart`). It
mirrors the Swipe taxonomy page's lifecycle (save, validate, publish,
restore) over the recursive tree. An operator can add a top-level or child
node down to the eighth level, edit its labels, emoji and aliases, reorder
siblings, and remove a node after a warning that says what goes with it.
Publish stays off until a saved draft passes validation. A restore sends the
history's active revision as `expectedActiveRevision`. There is no live
canary: Discover reads the catalog it already has, and its queries live in
the manifest. Tree edits are pure functions in `discovery_tree.dart`,
addressed by path rather than id, because only validation makes ids unique.

**Unmapped types** (`/discover-types`). The page lists unmapped and ambiguous
types with their place and observation counts, filterable by issue. "Map into
tree" loads the current tree draft and lets the operator pick one node. It
then saves the draft with the raw `primaryType` added there and removed from
every other node, which is what resolves an ambiguous type. As the contract
asks, there is no mapping method of its own. A mapped type goes live through
the tree's validate and publish, which the confirmation links to. On screen,
aliases compare after trimming and lower-casing; the server's normalisation
decides. The page opens from the tree editor and keeps "Discover tree"
selected in the navigation; see the lane decision on navigation height.

**Harvest manifest** (`/harvest-manifest`, under Governance). The same
lifecycle, over entries with an admin label, English query, reviewed Arabic
fallback, order and an enabled switch. Entries are disabled rather than
deleted, since job outcomes refer to them by id.

**Refresh jobs.** A switch between the existing coverage refreshes, still the
default, and Discover harvests (`harvest_jobs_view.dart`). Each harvest shows:

- User-requested or Operator-requested, and its trigger;
- cell, footprint and radius;
- manifest and calibration revisions;
- attempted and completed queries, observed places and upstream requests;
- remaining cooldown;
- expandable per-query outcomes and the manifest snapshot.

Filters cover requester, state and trigger. A finished job that carries
failed or unattempted queries says "Incomplete", because the contract warns
against reading a terminal state as a whole harvest. Skipped compatibility
queries do not count against it.

**Catalog growth** (`/growth`, under Insights). For the last 24 hours, 7 days
or 30 days, the page shows:

- catalog size at both ends, with net change beside new, quarantined and
  removed places;
- cells explored, observations, detail refreshes and upstream requests;
- a table by initiating mode and operation.

Every hit rate is computed from hits and misses, and a row with neither says
"No lookups" rather than 0%.

**Reports.** Each report says whether it came from Discover or from a room.
A Discover report has no room line, and shows affected rooms only when some
share its problem. A room report adds its room id. Moderation is unchanged.

Tests: `discovery_tree_test.dart` covers path edits and both mapping cases.
`discovery_admin_test.dart` drives each surface through `AdminApp` with a
fake:

- policy sections sent only when edited, left alone on a server without
  them, and a malformed knob;
- tree add, save, validate and publish, the removal warning and the restore
  revision;
- mapping an unmapped and an ambiguous type, and the issue filter;
- harvest requester, shortfall, cooldown and outcomes, and the requester
  filter;
- manifest edit and restore;
- the growth hit rate;
- report sources;
- every page on a server that does not offer it, and each page at 200% text.

The existing admin tests pass unmodified.

Still open: requirement 16's acceptance needs the implementations. Seeing a
mapped type's places appear needs M9-B, M9-C and M9-E, audit rows for publish
and rollback are server-side, and user harvests need M9-E's worker.

Status (2026-09-15): the server side of all of these is implemented on `main`
through M9-E, and a PostGIS test maps a type and sees its place appear. This
branch has not merged `main`, so J has not met a real server yet.

Verification: pinned full preflight passed 159 server, 279 app and 72 admin
tests, up from 51 admin, with clean analyses and formatting, and
`flutter build web --release` compiles the dashboard. Nothing under `app/`
changed, but the branch now carries `ebbdf5f`'s regenerated client, so a
signed `0.2.1+7` was built at SHA-256
`7e134a7973412342cc2f004b408fe7dc504216315d0cb31d78f84c621df5603d`. It
verifies under APK Signature Scheme v2 with the same signing certificate
(`426f3bf4…77a6`) as previous releases.

### M9-G2 area follow-up — landed (2026-09-14)

The app now uses the back-end lane's `eda8827` area contract, merged into
this branch from `main`. That contract answers both M9-G2 handoffs below.
Discovery stays dark.

**Country.** Requests no longer name a country. `DiscoverySearch`
(`app/lib/features/discover/discovery_search.dart`) leaves
`DiscoverQuery.countryCode` null. `discoveryCountryFor` and its rough
bounding boxes are gone from `app/lib/domain/discovery_area.dart`. The
server resolves the country from the viewport and returns it in
`DiscoverQueryContext.countryCode`. Rows and the filter sheet's price chips
now take their currency from the shown generation's context. The app does
not call `ensureArea` or `deepen` yet; that is G4.

- Every committed area is now sent to the server. Before, an area outside
  all six boxes was explained without a request. Now the server's
  `unsupported_area` answer shows "Got time covers the Gulf countries only".
  That notice replaces any rows kept from a covered area rather than dimming
  them, and Refresh stays off, as it did under the local check.
- The filter sheet counts whenever the committed generation has a context;
  it no longer waits for a country.

**Area label.** `DiscoveryAreaLabels` reads `place.reverseGeocodeDetails`
through the new `LocationRepository.reverseGeocodeDetails`. It sends the
same centre and language as before, with the same 8-second timeout and
per-area cache. The label is the `locality`, else the `city`. When the
lookup fails, or returns neither, the bar keeps "This area".
`discoveryAreaName` no longer picks a part of the formatted address by
position. Setup's GPS enrichment still uses the string `reverseGeocode`.

Tests: the view tests cover the locality label, the city fallback, blank
names, rows priced in the context's country, and a server-rejected area
replacing kept rows with no country in the request. The filter tests check
price chips in the context's country and a draft count sent without one. The
controller and facets tests now expect no country on the wire. The
country-pick tests went with the function.

Verification: pinned full preflight passed 156 server, 279 app and
51 admin tests with clean analyses. Signed `0.2.1+7` built at SHA-256
`fa7ee73e219d6b30d14fb3179ceb2dc26e4707d99070f4815c966cf4836c746c` and verifies under APK Signature Scheme v2 with the same signing certificate (`426f3bf4…77a6`) as previous releases.

### M9-G3 Discover filters and categories — landed (2026-09-14)

The filter sheet, the category tree and the controls that open them, built
on the `discover.facets` and `discover.taxonomy` contracts from `4014037`
with test doubles. Discovery stays dark: the server still answers
`enabled: false`, and every facets and taxonomy read `feature_disabled`.

**Counts.** `DiscoveryFacetsController`
(`app/lib/features/discover/discovery_facets_controller.dart`) follows the
results, not the link. Each first page the results controller applies
carries a new server context, and that search is counted once in that
context, so opening a view costs one browse and one facets call, and later
pages ask for no counts.

- An answer for an earlier generation is dropped. A failure keeps the
  earlier counts and offers a retry.
- `query_changed`, or counts made under another tree or policy revision,
  reload the results once and read the configuration again.
- The published tree (`discoveryTaxonomyProvider`) is read again whenever the
  configuration names a new revision. It is combined with counts only when
  both describe the same revision.

**The category tree.** `DiscoveryCategoryTree`
(`app/lib/domain/discovery_category_tree.dart`) is a pure function of the
published tree and one facets answer.

- A node's total is its own mapped count plus its children's totals.
  Unmapped types count under the configuration's Other id, beside the roots.
- Branches with nothing in view are hidden unless they hold a selection, and
  the footer counts each hidden branch once, at its top.
- Selecting a node drops its selected descendants and shows them as
  included. Search matches English or Arabic labels and mapped types,
  ignoring case and Arabic diacritics, and shows matches under their
  ancestors.
- The sheet follows artboard 2b and is a draft. Its counts leave the
  category selection out, so nothing is asked of the server until Show
  applies the selection as one search. Labels are `labelAr` in Arabic.

**The filter sheet.** A local draft over the committed query:

- text, labelled as searching names and descriptions;
- the six disjoint review bands as a histogram with counts;
- an exact price level in the area's currency, with counts;
- a minimum rating, counted from `minimumRatingCounts`;
- the four opening-hours windows;
- the four completeness requirements.

Each edit waits 400 ms, then counts the draft through facets in the committed
generation's context. The apply button shows a count only when it is for the
current draft. Show applies the whole draft as one history entry; Back or
dismissing discards it; Clear clears the sheet's filters and keeps the
categories; Reset returns to the applied filters. The five amenity chips are
visible, disabled, announced as unavailable, and explained.

**The bar and the link.**

- Sort, Filters and Categories sit in a horizontally scrolling bar over the
  map. Filters and Categories show how many values they apply.
- A removable chip with its count follows for each selected category.
  Removing one applies at once.
- Once the tree the configuration names is loaded, categories a link names
  that no longer exist are removed with a notice, and ones a selected parent
  already includes are removed silently. Either correction replaces the link
  rather than adding history.
- An empty result under filters now names the filters in play.

**Open now.** A committed search for places open now is checked again at
each minute boundary and on return to the foreground. The pages start over
only when the matching places or their count changed, so a scroll is not
thrown back every minute. Checks stop while the app is in the background.

**Large text.** At twice the text size the sheets' secondary header actions
move under their titles, and tree rows put the emoji and count under the
label. Before that, a 320-pixel phone squeezed the filter title to one letter
per line and a tree row to a word per line.

Tests:

- `discovery_category_tree_test.dart` proves every branch equals its own
  count plus its children's over a fixture tree. It also covers hiding and
  the hidden count, including a coffee-only view, kept selections, parent
  selection, link normalization, search in both languages, and counts from
  another revision.
- `discovery_facets_controller_test.dart` covers one count per first page in
  its context, dropped late answers, kept counts with retry, and the single
  reload for `query_changed` and revision mismatches.
- `discover_filters_test.dart` drives the screen through the real router:
  - one browse and one facets call on opening;
  - the draft preview and its single history entry, dismissal, and an
    out-of-order preview;
  - Clear keeping categories, disabled amenities, and no review-text claim;
  - exact price and counted ratings;
  - the tree's counts, hiding, inclusion and apply;
  - a zero-count selection kept removable, and immediate chip removal;
  - a removed link category with no extra history;
  - the empty state naming its filters;
  - Arabic at 200% on a 320×640 screen.
- `discovery_results_controller_test.dart` gained the open-now minute check,
  and `discovery_url_query_test.dart` the query edits.
- The Discover widget harness moved to `discover_harness.dart`, shared by
  both screen test files.

Verification: pinned full preflight passes generation, formatting, fatal-info
analyses, 154 server, 281 app (up from 254) and 51 admin
tests, shell checks, and diff checks. `scripts/build-release-apk.sh` produced
signed `0.2.1+7` at 107,007,727 bytes with SHA-256 `a10ebfca4ba9ee7ac43bb8cafccfbe5e2a37be99f5d9084f453e0232b0fc7a5b`. It
declares `sa.almou.hayer` versionCode 7 / versionName 0.2.1, verifies under
APK Signature Scheme v2 with the same signing certificate (`426f3bf4…77a6`) as
previous releases, and its compiled manifest still carries both discovery App
Link paths.

Not verified here: sheet gestures, the keyboard over the filter sheet, and
screen-reader announcements on a device; and real counts, which the server
still refuses. The first three belong to M9-K; real counts wait on M9-C's
implementation.

Not in G3:

- Pins, selection, `ensureArea` and the coverage strip are G4.
- Facets carry no counts for hours windows or completeness, so those chips
  show none.
- `GccPriceLevel` announces price levels in English in either language; that
  shared widget predates Discover.

### M9-G2 Discover results — landed (2026-09-13)

The Discover screen itself: a full-bleed map, the area bar, the sort chip
and a draggable results sheet, built on the `discover.browse` contract from
`4014037` with test doubles. Discovery stays dark. The server still answers
`enabled: false` and every browse `feature_disabled`, so none of it is
reachable in production.

**The committed query.** The link stays the only source of truth.
`DiscoverView` (`app/lib/features/discover/discover_view.dart`) reads it on
every change and hands the resolved `DiscoverySearch` to the results
notifier; nothing mirrors it.

- `/discover` now sits under `/`, and Discover links are opened with `go`.
  Query changes keep the same page, map and notifier; home stays beneath for
  Back; the browser URL reflects each committed query.
- Each applied search or sort is one history entry. On Android the screen
  keeps those entries, so Back steps through earlier searches before it
  leaves; the web leaves them to the browser.
- A link without an area opens at the location already permitted, then the
  last area searched here (`DiscoveryAreaStore`, erased with device data),
  then central Riyadh. Browsing never asks for permission. The starting
  area and any respelling of a link replace it rather than adding an entry.
- The country for the request is picked from rough bounds of the six
  countries. An area outside all of them is explained without a request;
  see the handoff below. Superseded on 2026-09-14 by the server-resolved
  country; see the area follow-up.

**Results.** `DiscoveryResultsController` numbers a generation for every
first page and applies an answer only while its generation is current, so a
slow answer to an earlier search never lands. Earlier results stay, dimmed,
while a new generation loads and after it fails, which is what keeps a rate
limit from emptying the screen. Later pages reuse the generation's context
and cursor, ask for no map, and skip places already shown. `query_changed`
or a changed revision restarts from the top once, with a notice, then offers
a retry. A new scoring policy or category tree in the configuration reloads
the search. `feature_disabled` reads the configuration again, and the
existing kept-link flow takes over once it agrees.

**The sheet.** The count reads "N places in view", or "in the previous area"
once the camera has moved. The active sort's explainer sits under it, with
the gem and review thresholds taken from the scoring policy. Refresh and a
Full list / Show map toggle sit beside the count; at large text they wrap
beneath it.

- Rows follow artboard 1c: an emoji thumbnail from the swipe category, rank
  and name, type, straight-line distance and price, one tag, and the rating
  with a compact review count.
- The tag goes by priority: hidden gem, added to the catalog within the
  policy's days (on the server's clock), rated below 4.0, more than 20,000
  reviews, then open, closed or "Hours unavailable".
- Distance appears only with a location already permitted, and the footer
  says it is a straight line. The footer also carries the fetch time, the
  cached-details warning when a row is stale, and the Google Maps
  attribution.
- Empty results say which case they are: filters excluding everything
  (with Clear filters), an area nothing is known about ("We haven't explored
  this area yet"), or a sort nothing qualifies for (with Show Best).
- Failures name rate limits with their wait, invalid and unsupported
  areas, and unusable queries, and offer a retry only where one can help.
  More pages load as the list nears its end.

**The map and the pending area.** `DiscoveryMap` is the G1 `HayerMap` with
no annotations yet. It fits the camera to the committed viewport and reports
the whole visible area each time the camera settles. The camera counts as
moved once that area no longer contains the committed viewport while filling
one axis. Then "Search this area" appears and the bar reads "Previous area".
The location button asks for permission on use and only recentres, and the
area bar names the area through the geocoder, falling back to "This area".

**Strings.** Every new string is in English and Arabic: sorts and
explainers, tags, empty and error states, the sheet and the area bar.

**Not in G2.** The Filters chip, category chips and filter sheet are G3.
Pins, pin and row selection, `ensureArea` and the coverage strip are G4. The
details affordance on a row is M9-H. The Data & Privacy copy does not yet
mention the kept link from M9-F or the last area searched; both belong with
the M9-K release pass, together with the note that Discover sends the map
area, not the device location.

Tests: `discovery_area_test.dart` covers camera and viewport arithmetic, the
moved-camera test, straight-line distance and the country pick.
`discovery_results_controller_test.dart` covers first and later pages,
duplicate ids, out-of-order answers, kept results while loading and after a
rate limit, restarts, revision changes, retries, refresh and the error map.
`discover_view_test.dart` drives the screen through the real router: the
three starting areas, rows and tags, distance with and without location, the
area label, Search this area with Back, sorts explained from policy, each
empty state, a failed first load, the unsupported area, paging, the restart
cap, and Arabic at 200% on a 320×640 screen. `discovery_url_query_test.dart`
gained the query changes; the route tests now supply an area, since an
opened link otherwise gains the starting area; and the erase test seeds the
last area.

The screen was also rendered with the real Nunito and Material icon fonts, in
English at both sheet heights and in Arabic at 200%, and compared against
artboard 1c. That render was a throwaway and is not committed; it is what
found the squeezed header and the oversized sort chip.

Verification: pinned full preflight passes generation, formatting, fatal-info
analyses, 154 server, 254 app (up from 207) and 51 admin tests, shell checks,
and diff checks. `scripts/build-release-apk.sh` produced signed `0.2.1+7` at
106,630,595 bytes with SHA-256
`ba8e607d3351070189dd19812327204e5e220c0eca86db844015d0fc77b0ba00`. It
declares `sa.almou.hayer` versionCode 7 / versionName 0.2.1 with target SDK
36, verifies under APK Signature Scheme v2 with the same signing certificate
(`426f3bf4…77a6`) as previous releases, and its compiled manifest still
carries both discovery App Link paths.

Not verified here: the MapLibre camera and visible-region reports, sheet
gestures and the location prompt on a device; browser Back and forward
through committed queries on the web host; and any real browse, which the
server still refuses. The first two belong to M9-K; real results wait on
M9-C's implementation.

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

### Discover details, standing and catalog reports — noted 2026-09-14 (M9-H)

Status 2026-09-15: `populationCategoryId` is implemented in M9-C (`532d33d`).
Details, refresh states and catalog reports wait for M9-D.

H reads `place.details`, `placeContext` and `place.reportCatalogIssue` in
ways the M9-C and M9-D implementations need to allow.

- **Swipe identity.** A swipe sheet sends `PoiIdentity(provider:
  'google-web', placeId:)` with its session id, because `PlaceSnapshot`
  carries no provider. A second provider reaching sessions would need one on
  the snapshot.
- **Refreshes in progress.** `PlaceDetailResult.refreshState` can be
  `refreshing`, but only another read says when a refresh ends. The sheet
  reads once per opening. Asked: finish within the read's deadline where
  possible, or set `retryAfter` when a second read is worth making.
- **Population.** The rank names a category only from
  `populationCategoryId`, looked up in the published tree; an id the tree
  lacks reads as places.
- **Report errors.** The catalog report sheet maps `rate_limited`,
  `feature_disabled` and `not_found`. Anything else, `bad_request` included,
  reads as a failed send; the sheet checks an explanation's length as the
  session sheet does.

### Discover coverage freshness and request rates — noted 2026-09-14 (M9-G4)

Status 2026-09-15: `placeContext` has its own budget since M9-C (`532d33d`).
Freshness, exploration checks and area reports wait for M9-E.

G4's strip and selection read `browse`, `ensureArea`, `harvestStatus` and
`placeContext` in ways the M9-C and M9-E implementations need to allow.

- **Freshness.** Requirement 13 expires "recently explored" after the
  policy's freshness hours, but the consumer configuration carries no
  freshness, so the app cannot age a footprint. Asked: return only fresh
  footprints in `DiscoveryCoverage`, flag each one as fresh, or add the hours
  to `DiscoveryClientLimits`. Until then the strip says Explored for any
  complete footprint union, and always shows when the area was last explored.
- **Exploration checks.** A followed job is checked every 3 seconds, or at
  its `retryAfter` when that is later, capped at 30 seconds, and not at all in
  the background. Setting `retryAfter` on `harvestStatus` slows clients down.
- **Area reports.** `ensureArea` goes out once per committed viewport: a
  link, the starting area, Search this area, and Back or Forward to an
  earlier area. Repeats of the same area need to stay idempotent.
- **Place context.** `placeContext` is read for a tapped pin outside the
  loaded rows. It is read again after each new first page while such a place
  stays selected and the points cannot decide, which is always the case in
  aggregates mode.

### Discover admin contracts — requested 2026-09-14, delivered and wired 2026-09-14 (M9-J)

The back-end lane delivered the manifest, harvest job, unmapped-type and
growth contracts in `ebbdf5f`, and every M9-J page now uses them; see "M9-J
admin surfaces". What those pages expect of the implementations:

- **Unmapped types ranked on the server.** The report is paged, so the page
  can only show types in the order it receives them. Requirement 16 asks for
  frequency order: sort by `catalogPlaceCount`, then `observationCount`,
  descending.
- **Policy responses carry the stored sections.** The dashboard sends
  `discovery` and `detailRefresh` only when edited. It shows their controls
  only when `policy` returns them, and takes `updatePolicy`'s response as the
  new baseline, so both should return the persisted sections once they
  exist.
- **Tree saves conflict on revision.** A type is mapped by saving the draft
  at the revision the unmapped-types page just loaded. That page and an open
  tree editor, or two operators, must get a revision conflict rather than
  overwrite each other.
- **An opaque user requester.** Operators see a user harvest's `requestedBy`
  as-is, so it should be a stable pseudonymous id, not an account email or a
  device identifier.

Originally asked: the M9-E admin contract commit ahead of its implementation,
as was done for the consumer contracts.

### Discover counts, tree and request budgets — noted 2026-09-14 (M9-G3)

Status 2026-09-15: draft previews and the separate facets budget are
implemented in M9-C (`532d33d`), and the tree revisions have advanced together
since M9-B. Hours-window and completeness counts are not added.

G3 reads `facets` and `taxonomy` in ways the M9-B and M9-C implementations
need to allow.

- **Draft previews.** The filter sheet sends an unapplied draft query to
  `facets` with the committed generation's `DiscoverQueryContext`, as the
  contract describes. The implementation must count a query whose
  fingerprint differs from the context's, while still rejecting stale policy
  or taxonomy revisions. Otherwise the sheet cannot count any edit.
- **Request rates, per client:**
  - one `browse` and one `facets` for each committed search;
  - one `facets` after each 400 ms pause while the filter sheet is edited;
  - while Open now is applied, one first-page `browse` a minute and one on
    each return to the foreground, as requirement 7 asks.

  Budgeting `facets` apart from `browse` would keep a busy filter sheet from
  rate-limiting the results.
- **The tree.** The app combines a taxonomy snapshot with counts only when
  the snapshot's `revision`, the configuration's `taxonomyRevision` and the
  counts' context revision all agree, so a publish has to advance all three
  together. `limits.otherCategoryId` must never equal a node id. While `roots`
  is empty the app treats the tree as unpublished and leaves link category
  ids alone.
- **Optional.** `facets` has no counts for hours windows or completeness
  requirements, so those chips show none. Requirement 8 does not ask for
  them; add them only if they come cheaply from the same statement.

### Discover area country — requested 2026-09-13, delivered and wired 2026-09-14 (M9-G2)

The back-end lane delivered this in `eda8827`. The country is now optional
on `DiscoverQuery`, `ensureArea` and `deepen`. The server resolves it from
the viewport and returns it in `DiscoverQueryContext.countryCode`, and a
hint that disagrees is to be rejected as `unsupported_area`. The client now
sends no country; see the area follow-up checkpoint. The original request is
kept below.

`DiscoverQuery.countryCode`, `ensureArea` and `deepen` each take a country
for the committed area, and the contract says it describes the area rather
than the device. The app has no country geometry, so G2 picks one from rough
bounding boxes of the six countries (`discoveryCountryFor` in
`app/lib/domain/discovery_area.dart`), smallest first, and explains an area
outside all of them without a request. Near a border that guess can name the
neighbour. Asked: derive the country from the viewport on the server, or
accept a null country and return the resolved one in `DiscoverQueryContext`,
and keep rejecting a mismatch with `unsupported_area` as planned.

### Discover area label — requested 2026-09-13, delivered and wired 2026-09-14 (M9-G2)

Delivered in `eda8827` as `place.reverseGeocodeDetails`. It returns the
formatted address with nullable locality, city, region and country code, on
the same F09 budget and cache as `place.reverseGeocode`. The client now
labels the area by locality, then city; see the area follow-up checkpoint.
The original request is kept below.

The area header uses `place.reverseGeocode`, as requirement 2 asks, but that
read returns one formatted line: street, district, city, region, country,
with whichever parts are known. `discoveryAreaName` takes the district part
by position, which names a street when the geocoder has no district. Asked:
a structured locality and city on a consumer reverse-geocoding read (the
server already has them in `ResolvedLocation`), or an area label on `browse`.
F09's shared budget is in place, so the label is enabled now.

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

- 2026-09-14: Gate the shared detail read on a `core` provider that the app
  root overrides from the discovery configuration, instead of reading the
  configuration in the sheet. `core` imports no feature, the sheet serves
  Swipe with Discover off, and a scope without the override, which is every
  existing swipe test, asks for nothing.
- 2026-09-14: Keep the source's status line for when a place closes rather
  than derive the design's "Closes 23:00" chip. The app has no time zone for
  a place, and a closing time worked out on the device would be wrong exactly
  where it matters. The "3 photos" chip ships, in Discover's mode.
- 2026-09-14: Offer Details under a selected row, not on every row or on a
  second tap. A second tap already clears the selection, and a button on
  every row would crowd the ranked list.
- 2026-09-14: Share the committed search from the area bar, even after the
  camera moves. The results showing are the committed search's, and a link to
  an unsearched view would open results nobody saw.
- 2026-09-14: Open Unmapped types from the Discover tree instead of giving it
  a navigation entry. With four new entries, the last destination ended at
  935 pixels in the test font. That is past the 900-pixel window
  `widget_test.dart` holds the navigation to. With three it ends at 883.
  Destinations now carry `subroutes`, which keep their entry selected.
- 2026-09-14: Send each new policy section only when it was edited. The
  contract makes null mean "preserve", and until persistence lands it rejects
  any non-null section. Sending unedited sections would break every existing
  policy save now, and would resend another operator's settings later.
- 2026-09-14: Map a type by saving the draft the unmapped-types page loads,
  not by editing an open tree editor's in-memory draft. The contract has no
  mapping method, and one draft revision guards both paths. Publishing stays
  in the tree editor, behind validation.
- 2026-09-14: Show harvests on the refresh jobs page behind a view switch
  that defaults to coverage refreshes. They are different records from
  different methods, and requirement 16 asks for them on that page.
- 2026-09-13: Register `/discover` under `/` and navigate to Discover links
  with `go`. Every committed query change then matches the same page key,
  so one screen, one map and one results notifier survive a change of
  query, home stays beneath for Back, and the browser URL reflects every
  committed query. This supersedes pushing the link over home.
- 2026-09-13: Keep Android Back history for Discover inside the screen, one
  entry per applied search, sort or filter change, and leave it to the
  browser on the web, where browser Back never reaches `PopScope`. A
  starting area and a canonical respelling replace the link through
  `Router.neglect` instead of adding an entry.
- 2026-09-13: Hold Discover results in one auto-disposed notifier with
  numbered generations, not a provider family keyed by query. A family
  would drop the previous results the moment a new query starts; the plan
  wants them kept while the next generation loads, and kept after a rate
  limit.
- 2026-09-13: Decide whether the camera has moved by geometry alone: the map
  still shows the committed viewport while it contains it and fills one
  axis within 5%. The camera fitted to a shared link's box passes; a pan, a
  zoom in or a clear zoom out fails. Nothing has to remember which camera
  moves the app made itself.
- 2026-09-13: Restart a scroll from the top at most once in a row after
  `query_changed` or a revision change, then offer a retry. A server that
  keeps rejecting the fresh cursor would otherwise reload the list forever.
  A later page that adds nothing and returns the cursor it was given also
  ends paging, for the same reason.
- 2026-09-13: Colour row tags with the scheme's primary and error colours
  rather than the design's green and coral, which fall under text contrast
  at 11.5 px on a light surface.
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
  reflection there. Superseded in G2: both now `go` to the nested route.
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
