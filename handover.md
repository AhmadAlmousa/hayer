# Hayer handover for Claude

This is an operational handover for continuing from the current `main` state.
Read [`PROJECT.md`](PROJECT.md) first; it is authoritative for product scope,
milestones, release gates, and shared decisions.

## Current snapshot — 2026-09-11

- Primary branch/worktree: `main` at `52d6537` (`Fix a test-config gap masking
  the overlapping-refresh race, log the first real run`). Remote:
  `git@github.com:AhmadAlmousa/hayer.git`.
- The consumer is `0.2.1+7`; a signed APK is staged in ignored deployment
  output. It is not necessarily announced or deployed: check bootstrap and the
  release checklist before changing availability or minimum-build policy.
- M7 beta/safety readiness is active. Passing code tests or building an APK is
  not enough: real PostGIS, gateway, physical-device accessibility/performance,
  two-device, passkey, and restore evidence remain distinct release gates.
- `scripts/test-integration-remote.sh` (commit `d150038`) runs the PostGIS
  suite against a disposable remote database. Its first real run had 32/36
  passing; active deterministic failures are below and in `lane-backend.md`.
- This worktree contains unrelated/untracked local edits. Start with
  `git status --short` and never stage or discard files outside your task.

## Repository map

```text
app/                    Flutter consumer app; Android-first, Riverpod + Drift
  lib/                  app/core/data/domain/features/screens/l10n
  test/                 widget and unit tests
  android/              Android project; signing config is ignored
admin/                  Flutter web operations/admin dashboard
  lib/features/         analytics, auth/passkeys, issues, navigation, taxonomy
  test/                 widget and unit tests
backend/
  hayer_server/         Serverpod monolith
    lib/src/api/        endpoints; lib/src/* holds domain/data/security/etc.
    migrations/         Serverpod migrations plus custom PostGIS DDL
    test/               unit/extractor tests
    integration_test/   real PostGIS/concurrency/replay tests
    config/             passwords are local and gitignored
    web/                built consumer/admin assets and server pages
  hayer_client/         generated shared Serverpod protocol/client; do not edit
  deploy/               Unraid Compose, nginx, backup/restore, release assets
scripts/                validation, toolchain, build, and operator helpers
PROJECT.md              authoritative project tracker and acceptance conditions
lane-backend.md         backend investigations and checkpoints
lane-frontend.md        frontend investigations and checkpoints
README.md               setup/deploy overview
graft/                  checked-in repository context graph (not source of truth)
references/Vela/        GPL reference only; never copy/link its source
```

The root workspace contains `app`, `admin`, `backend/hayer_server`, and
`backend/hayer_client`. It requires Dart `^3.13.0`; intended tooling is Flutter
**3.47.2**, Dart **3.13.2**, Serverpod CLI **4.0.0**, and PostgreSQL 16 with
PostGIS. The backend is a Serverpod monolith; Redis is intentionally absent.

## Ownership and collaboration

- Backend/delivery owns `backend/`, generated protocol/client output,
  migrations, `scripts/`, deployment, and M7 acceptance.
- Frontend owns client behavior in `app/` and `admin/`: widgets, routing,
  state, localization, and client tests.
- New/changed endpoint or protocol requirements are backend handoffs. Never
  hand-edit `backend/hayer_client/lib/src/protocol/`; generate it from the
  server contract and commit generated files with their source change.
- Keep detailed evidence in the corresponding `lane-*.md`. Record material
  shared decisions and earned acceptance evidence in `PROJECT.md` without
  rewriting another lane's notes.

The historic Claude worktree is `.claude/worktrees/claude-lane` on
`worktree-claude-lane`; the primary worktree is `main`. Ignored `build/` does
not appear in the secondary worktree. There, set this before Flutter commands:

```bash
export FLUTTER_BIN=/mnt/unraid/places_swiper/hayer/build/toolchains/flutter-3.47.2/bin/flutter
```

## Routine for a normal change

1. Read `PROJECT.md`, the relevant lane log, and source/tests that will change.
   Use `graft ask "..." --source` first when the executable is available;
   otherwise inspect `graft/INDEX.md` and use `tgrep "literal" .` for exact
   searches. Graph output never replaces reading the actual source.
2. Inspect `git status --short` and history; preserve unrelated changes.
3. Make a focused code/test change. For a server protocol change regenerate:

   ```bash
   cd backend/hayer_server
   ../../build/toolchains/flutter-3.47.2/bin/dart pub global run serverpod_cli:serverpod_cli generate
   ```

   `scripts/preflight.sh` performs the same generation itself.
4. Run a narrow test/analyzer, then preflight where practical. A task is not
   fully complete under project policy until `scripts/build-release-apk.sh`
   succeeds. If signing is unavailable, state that release blocker explicitly.
5. Update the lane log plus shared tracker when warranted, run
   `git diff --check`, stage only task files, and commit with a clear summary.
   Do not commit secrets, APKs, local config, or someone else's changes.

## Essential commands

```bash
# Full local gate: dependencies, Serverpod generation, format, fatal analysis,
# server/app/admin tests, shell syntax, and diff check.
scripts/preflight.sh

# Focused package checks
(cd backend/hayer_server && dart analyze --fatal-infos && dart test)
(cd app && flutter analyze --fatal-infos && flutter test)
(cd admin && flutter analyze --fatal-infos && flutter test)

# Locally containerized PostGIS suite, when Docker Compose exists.
scripts/test-server-integration.sh

# Signed Android APK; needs ignored app/android/key.properties.
scripts/build-release-apk.sh

# Native production image; do after server/app/admin/generated-client changes.
scripts/build-server-image.sh
```

### Toolchain trap

`/home/ahmad/flutter` may be on `PATH` with Dart 3.12.2, which cannot resolve
this Dart `^3.13.0` workspace. `scripts/resolve-toolchain.sh` pairs Dart with
the selected Flutter executable and is covered by `scripts/test-resolve-toolchain.sh`.
For manual work, use an explicit `FLUTTER_BIN` or the paired `bin/dart`.

## Real PostGIS integration testing

`backend/hayer_server/docker-compose.test.yml` provides an isolated
`postgis/postgis:16-3.5-alpine` database. CI uses the equivalent image pinned
by digest. Tests use `dart test integration_test --concurrency=1` because the
files share one database while individual cases exercise concurrent sessions.

When this machine lacks Docker, use:

```bash
scripts/test-integration-remote.sh
```

Its defaults are `192.168.225.20:55432`, `hayer_test`, `postgres`, and
`hayer_test`; `HAYER_TEST_DB_*` variables can override them. It authenticates
with `psql`, demands a `hayer_test*` database name, then supplies matching
`SERVERPOD_DATABASE_*` values. Setup/teardown **truncates catalog, coverage,
category, cache, taxonomy, and operational-metric tables**. Only use a verified,
disposable test instance. Do not rely on `pg_isready` alone and never target
production. A separate PostGIS 16/3.5 container on Unraid is acceptable; the
container command pasted in the previous chat was truncated, so do not run it.

First real-run defects (all reproducible, not flaky):

- F05/F06/F07: overlapping `buildDeck()` calls lose `sushi-only` in the catalog;
  this is a genuine catalog upsert race.
- F20: stale taxonomy validation after an edit should conflict, but an async
  `not_found` leaks into the next test; investigate transaction visibility.
- F20: `Map<String,String>` audit data shaped like `CachePolicy` is wrongly
  deserialized as that generated type, causing a String-to-int cast. Prefixing
  diff keys is a candidate workaround; verify before adopting it.
- F14: a catalog-pruning test expects a deletion but its fixture may leave no
  non-deck catalog row to prune; confirm the fixture before changing code.

Exact locations, the fixed rollback-wrapper test setup, and investigation notes
are in `lane-backend.md`. Treat the three remaining failures as active bugs.

## Build, release, and deployment

`backend/deploy/` is the Unraid unit: nginx, native Serverpod, internal
PostGIS, canaries, and backups. Cloudflare Tunnel reaches public
`hayer.almou.sa` through LAN-bound `192.168.225.20:8432`; public `/admin*` must
404. Private admin is `hayer.vpn.almou.sa` through port 8433/Nginx Proxy
Manager. PostgreSQL remains unexposed.

- `scripts/build-release-apk.sh` builds with
  `SERVER_URL=https://hayer.almou.sa/api/`, writes a versioned APK/checksum and
  updates the ignored `backend/deploy/releases/hayer.apk` stable alias.
- `app/android/key.properties`, keystores, `**/config/passwords.yaml`, release
  APK/AABs, and runtime secrets are intentionally ignored. Keep them private.
- Deploy compatible server/migrations before releasing a client needing a new
  contract. Build the production image after code/web/generated-client changes;
  normal Unraid startup is `cd backend/deploy && docker compose up -d`.
- `scripts/admin-enrollment.sh reenroll` opens private Basic-Auth enrollment
  temporarily, requires verification of two passkeys, and closes it on exit.
  Recovery credentials must remain offline and never be logged.
- Restore is destructive. Read `backend/deploy/README.md` before running
  `restore-backup.sh`; it requires explicit confirmation.

## CI and release gaps

`.github/workflows/ci.yml` currently runs only via `workflow_dispatch`. It does
generation drift, formatting, fatal analyzers, tests, PostGIS integration, web
builds, and a debug APK, but is not an automatic protected PR/push gate.
Enabling/protecting it is a high-value follow-up.

Remaining M7 acceptance includes forged-header/direct-origin gateway proof,
crash/replay and two-device flows, supervised real-authenticator proof,
hardware accessibility/performance checks, a restore drill, and release
announcement/version policy verification. See `PROJECT.md` for exact exits;
source inspection alone cannot close them.

## Non-negotiable safety rules

- Never point remote integration tests at production or a shared database.
- Never hand-edit generated Serverpod protocol/client files.
- Never change production Compose/release aliases/migrations merely to ease
  local testing.
- Before commit: preserve unrelated work, check `git diff --check`, and stage
  only task files.
- Preserve Nominatim/Vela legal and privacy constraints from `PROJECT.md`;
  Vela is reference-only GPL material.
