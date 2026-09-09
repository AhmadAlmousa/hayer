# Hayer

Hayer is an Android-first place decision app: pick a category and location,
swipe a deterministic deck of nearby places, or share an `ABC-124` session
so a group can decide from the same ordered deck. Swipe cards can open full
place details without consuming a vote. After group matching, every participant
gets one editable `My choice` ballot; plurality wins and the host's own ballot
breaks a leading tie. Users can privately save places on one device, organize
Want to try/Favorites lists, and start a room from an ordered saved shortlist
with an optional five-place fresh mix. The repository also contains the
Serverpod/PostGIS backend and a protected Flutter web operations console.

The product decisions, implementation status, verification evidence, and next
release gates live in [`PROJECT.md`](PROJECT.md). The longer product brief is
[`overview.md`](overview.md).

## Repository layout

```text
app/                    Flutter consumer app (Android beta target)
admin/                  Flutter web analytics/operations console with passkeys
backend/hayer_server/   Serverpod API, catalog, extractor, migrations, web
backend/hayer_client/   Generated shared client and protocol models
backend/deploy/         Unraid Compose stack, gateway, backup and restore
references/Vela/        Pinned GPL reference submodule; not linked or copied
scripts/                Developer preflight and release APK helpers
```

## Branding

The canonical consumer logo is `app/assets/branding/hayer_icon.png`.
`flutter_launcher_icons` 0.14.4 generates the Android launcher resources and
iOS AppIcon catalog from that source; Android also receives a white-backed
adaptive icon, while iOS output is flattened onto white to satisfy App Store
alpha requirements. Regenerate all configured platform icons from `app/` with
`dart run flutter_launcher_icons`.

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

Prerequisites are Flutter 3.47.2, Dart 3.13.2, Serverpod CLI 3.4.13, and a
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

The production admin entry point is
`https://hayer.vpn.almou.sa/`, available only through LAN or Tailscale.
The public `hayer.almou.sa` host returns 404 for every `/admin` route. First-time
setup and recovery run `scripts/admin-enrollment.sh reenroll`, then use
`https://hayer.vpn.almou.sa/enroll` with the break-glass
`HAYER_ADMIN_USER`/`HAYER_ADMIN_PASSWORD` credentials. Routine visits use a
passkey and never ask Hayer to store that Basic Auth password. Admin JWTs are
kept in the platform's secure client storage and are revoked on sign-out. The
command waits while two passkeys are registered and verified, then closes both
enrollment layers when Enter is pressed or the command exits. The toggle is
scoped to that Compose invocation and is not a global setting.

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
3. Clone or copy the repository to the Docker host without replacing the
   currently served `hayer.apk`. Optionally set `HAYER_ADMIN_USER`,
   `HAYER_ADMIN_PASSWORD`, and `HAYER_ANDROID_SHA256` in the Compose stack.
   The admin username/password are recovery-only credentials used to enroll a
   passkey, so keep them outside the browser password store.
4. Run `scripts/build-server-image.sh` once to build the native production
   image. Flutter and Dart are build-only and are absent from the runtime image.
5. Run `docker compose up -d` from `backend/deploy`. Startup never builds or
   pulls the server image; Compose initializes persistent runtime credentials
   and runs the source and public-gateway canaries automatically. Re-run the
   image build script only after application, generated-client, or server code
   changes—not after Compose, nginx, environment, or APK changes. If no admin
   password was supplied, save the generated recovery password shown in the
   `runtime-init` container logs. Keep enrollment disabled during routine use.
6. For a generated-contract or migration change, verify that server with the
   previously accepted app before replacing `backend/deploy/releases/hayer.apk`.
   Build 7's destination-choice migration is additive, but its `My choice`
   action requires the new server. Deploy the P05 server before a client that
   creates saved shortlists; the client rejects a response that does not begin
   with its exact ordered saved selection.
7. Copy the new release files under `backend/deploy/releases`, verify their
   SHA-256 manifests and public download, then configure Cloudflare Tunnel for
   public `hayer.almou.sa` only, targeting
   `http://192.168.225.20:8432`. Configure the private Nginx Proxy Manager host
   `hayer.vpn.almou.sa` to `http://192.168.225.20:8433`, with private DNS and
   TLS. The two host ports terminate on separate nginx listeners.
8. Run `scripts/admin-enrollment.sh reenroll`, register and verify two
   private-host passkeys, press Enter to close enrollment, then verify
   HTTPS/WSS, App Links, public-admin rejection, and the backup restore drill.

The gateway binds public port `8432` and private-admin port `8433` only to
`192.168.225.20`. Remove every WAN port-forward for both ports. Allow `8432`
only from the local cloudflared connector and `8433` only from Nginx Proxy
Manager. PostgreSQL, Serverpod Insights, and backups remain unpublished.
