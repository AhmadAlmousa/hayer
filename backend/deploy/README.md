# Hayer deployment

This directory is the Unraid deployment unit. `docker-compose.yml` runs nginx,
the Serverpod monolith, PostGIS, source/public canaries, and a daily backup
sidecar. Only nginx port `8432` is published.

No secret files need to be created on Unraid. On a development machine, build
the signed APK with `../../scripts/build-release-apk.sh`, then copy the
resulting `releases` directory beside this Compose file on Unraid. The stable
download artifact must be named `releases/hayer.apk`.

Optional Compose environment variables are `HAYER_ADMIN_USER` (defaults to
`operator`), `HAYER_ADMIN_PASSWORD`, and the release certificate fingerprint
`HAYER_ANDROID_SHA256`. When no admin password is supplied, `runtime-init`
generates one on first start and prints it once in that container's logs. When
no fingerprint is supplied, the stack starts normally but Android App Links
remain disabled.

Build the local production image once after cloning, or whenever application,
admin, generated client, or server code changes:

```bash
../../scripts/build-server-image.sh
```

The build uses Flutter and Dart only in disposable build stages. The resulting
runtime image contains four small native executables, the web bundles, and the
minimum Debian runtime packages; it contains neither SDK nor source tree.

Normal startup and all Compose, nginx, environment, certificate-fingerprint,
and APK-only changes use the existing image and never invoke Flutter:

```bash
docker compose up -d
```

The Compose file uses `pull_policy: never`, so startup fails with a direct
missing-image error instead of pulling or silently rebuilding. A one-shot initializer
stores generated database, Serverpod, backup, gateway, and public configuration
in private Docker volumes before dependent services start. Compose then runs a
live Riyadh place-deck canary before starting the native server, applies
migrations on start, and runs an
unauthenticated public bootstrap RPC canary after the gateway is healthy. Set
`HAYER_PUBLIC_API_URL` only when verifying a hostname other than
`https://hayer.almou.sa/api/`.

The external proxy must terminate TLS for `hayer.almou.sa`, forward to 8432,
and retain WebSocket upgrade headers. After deployment, verify `/api/`,
`/admin/`, `/admin/api/`, `/.well-known/assetlinks.json`, and the
APK checksum/download route. The admin API accepts only browser RPCs whose
exact origin is `https://hayer.almou.sa`; nginx overwrites the internal origin
marker before forwarding requests.

Serverpod 3.4 may print a database-integrity warning that its target schema is
missing the custom `location` columns, spatial/search indexes, and cascading
foreign keys. The comparison is reporting PostGIS objects that exist in the
live database but cannot be represented by Serverpod's generated model; it
does not mean the migration failed. Do not apply a repair migration merely to
silence this warning, because it can remove those custom objects.

If Compose generated the initial admin password, read the `runtime-init`
container logs in Unraid (or run `docker compose logs runtime-init`) and save
the displayed credentials. The nginx Basic Auth prompt at `/admin/` is the
dashboard's only sign-in; the same cached browser credentials protect its
`/admin/api/` requests.

Docker caches the web build separately from backend compilation. Backend-only
changes therefore reuse the Flutter layer unless the generated client changed.
Do not pass `--build` to `docker compose up`; use
`../../scripts/build-server-image.sh` when a new image is actually required.

Restore drills are deliberately guarded:

```bash
HAYER_CONFIRM_RESTORE=restore-hayer \
  backend/deploy/restore-backup.sh /absolute/path/to/hayer-TIMESTAMP.dump
```

Run this only against the intended stack; `pg_restore --clean` replaces the
current database objects.
