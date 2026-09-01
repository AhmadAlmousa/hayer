# Hayer deployment

This directory is the Unraid deployment unit. `docker-compose.yml` runs nginx,
the Serverpod monolith, PostGIS, and a daily backup sidecar. Only nginx port
`8432` is published.

Prepare ignored runtime files according to `secrets/README.md`, build the
signed APK with `../../scripts/build-release-apk.sh`, and deploy from the
repository root with:

```bash
export HAYER_ANDROID_SHA256='AA:BB:...'
scripts/deploy-unraid.sh
```

The external proxy must terminate TLS for `hayer.almou.sa`, forward to 8432,
and retain WebSocket upgrade headers. After deployment, verify `/api/`,
`/admin/cache/`, `/admin-api/`, `/.well-known/assetlinks.json`, and the APK
checksum/download route.

Restore drills are deliberately guarded:

```bash
HAYER_CONFIRM_RESTORE=restore-hayer \
  backend/deploy/restore-backup.sh /absolute/path/to/hayer-TIMESTAMP.dump
```

Run this only against the intended stack; `pg_restore --clean` replaces the
current database objects.
