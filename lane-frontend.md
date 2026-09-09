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

Last updated: 2026-09-09

## Current state

- Branch `worktree-claude-lane`, rebased onto `main` at `4c9520a`.
- Open milestone work in this lane: M7-E. The F17 client half is complete; its
  server half is an open handoff (below). M7-E's remaining physical-device
  TalkBack/focus/contrast, largest-native-text, denied/approximate-location,
  background/reconnect, and performance checks need real hardware and are not
  startable here.
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

### F17 server half

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
the back-end lane's, so this is reported rather than fixed here.

### Release keystore path is stale

`app/android/key.properties` points `storeFile` at
`/mnt/cache/coding/places_swiper/hayer/...`, which no longer exists, so
`scripts/build-release-apk.sh` fails at Gradle's `validateSigningRelease` after
a full build. The keystore itself is present at `app/android/hayer-release.jks`.
The file is gitignored and per-worktree, so only this lane's copy was
corrected; the primary worktree's copy still needs the same change before the
next release build from there.

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
