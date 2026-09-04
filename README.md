# Hayer

Hayer is an Android-first place decision app: pick a category and location,
swipe a deterministic deck of nearby places, or share a three-character session
so a group can decide from the same ordered deck. The repository also contains
the Serverpod/PostGIS backend and a protected Flutter web operations console.

The product decisions, implementation status, verification evidence, and next
release gates live in [`PROJECT.md`](PROJECT.md). The longer product brief is
[`overview.md`](overview.md).

## Repository layout

```text
app/                    Flutter consumer app (Android beta target)
admin/                  Flutter web cache/calibration console
backend/hayer_server/   Serverpod API, catalog, extractor, migrations, web
backend/hayer_client/   Generated shared client and protocol models
backend/deploy/         Unraid Compose stack, gateway, backup and restore
references/Vela/        Pinned GPL reference submodule; not linked or copied
scripts/                Developer preflight and release APK helpers
```

## POI acquisition

Hayer uses one place source: logged-out Google Maps web search through an
original Dart implementation informed by Vela's observable behavior. A
versioned positional calibration fallback is stored in
`backend/hayer_server/config/place_calibration.json`. At startup and hourly,
the backend checks Vela's signed remote calibration, projects only the search
fields Hayer consumes, and automatically activates a relevant change after its
Riyadh live canary passes. The backend:

- searches English first and uses Arabic only to fill a short deck;
- fetches offsets 0, 20, and 40 only when more candidates are needed;
- captures stable identity, name/type, coordinates, address, rating/reviews,
  price, closure/open state, weekly hours, phone, HTTPS website, map URL, up to
  three allowlisted photos, and optional summary/featured review;
- applies exact-radius, closure, price, deduplication, deterministic ranking,
  and category-diversity rules before persisting an immutable session deck;
- serves a shared PostGIS catalog first, refreshes after 72 hours, and permits
  a guarded 30-day fallback with dynamic fields suppressed;
- rate-limits source traffic, coalesces identical refreshes, bounds responses,
  uses a 30-second creation deadline, and fails safely on parser drift.

Map tiles are visual context only and are never queried as a fallback POI
catalog.

## Local setup

Prerequisites are Flutter 3.44.2, Dart 3.12.2, Serverpod CLI 3.4.13, and a
PostgreSQL 16 database with PostGIS for integration/runtime work.

```bash
flutter pub get
cd backend/hayer_server
serverpod generate
cp config/passwords.yaml.example config/passwords.yaml
dart run bin/main.dart --apply-migrations
```

In another terminal, run the consumer or admin:

```bash
cd app && flutter run --dart-define=SERVER_URL=http://localhost:8080/
cd admin && flutter run -d chrome
```

`config/passwords.yaml`, signing keys, built web assets, and release APKs are
intentionally ignored. Production Compose credentials are generated into
private Docker volumes when the stack first starts.

## Verification

Run the repository preflight before a commit or deployment:

```bash
scripts/preflight.sh
```

It regenerates Serverpod code, checks formatting and analysis, runs the server
unit suite and both Flutter widget suites, and checks the Git diff. CI also
compiles consumer/admin web bundles and a debug APK. Run the isolated PostGIS
session integration suite separately:

```bash
scripts/test-server-integration.sh
```

This runner is fully containerized; the host only needs Docker Compose.

## Release and Unraid deployment

1. Create an external Android keystore and copy
   `app/android/key.properties.example` to the ignored `key.properties`.
2. Run `scripts/build-release-apk.sh`; it writes the APK and SHA-256 file under
   the ignored `backend/deploy/releases/` directory, including the stable
   `hayer.apk` filename served by the stack.
3. Clone or copy the repository to the Docker host and place the release files
   under `backend/deploy`. Optionally set `HAYER_ADMIN_USER`,
   `HAYER_ADMIN_PASSWORD`, and `HAYER_ANDROID_SHA256` in the Compose stack.
4. Run `scripts/build-server-image.sh` once to build the native production
   image. Flutter and Dart are build-only and are absent from the runtime image.
5. Run `docker compose up -d` from `backend/deploy`. Startup never builds or
   pulls the server image; Compose initializes persistent runtime credentials
   and runs the source and public-gateway canaries automatically. Re-run the
   image build script only after application, generated-client, or server code
   changes—not after Compose, nginx, environment, or APK changes. If no admin
   password was supplied, save the generated password shown in the
   `runtime-init` container logs.
6. Point the external TLS reverse proxy at port `8432`, verify HTTPS/WSS and
   App Links, and complete the backup restore drill before tagging a beta.

The Compose stack exposes only the gateway. PostgreSQL, Serverpod Insights,
and backups remain on the internal application network.
