# Hayer deployment

This directory is the Unraid deployment unit. `docker-compose.yml` runs nginx,
the Serverpod monolith, PostGIS, source/public canaries, and a daily backup
sidecar. nginx publishes separate public and private-admin ports. Both sockets
are bound to the Unraid LAN address—`192.168.225.20:8432` for cloudflared and
`192.168.225.20:8433` for NPM—not every host interface.

No secret files need to be created on Unraid. On a development machine, build
the signed APK with `../../scripts/build-release-apk.sh`, then copy the
resulting `releases` directory beside this Compose file on Unraid. The stable
download artifact must be named `releases/hayer.apk`.

Optional Compose environment variables are `HAYER_ADMIN_USER` (defaults to
`operator`), `HAYER_ADMIN_PASSWORD`, the release certificate fingerprint
`HAYER_ANDROID_SHA256`, and `HAYER_ADMIN_ENROLLMENT_ENABLED` (defaults to
`false`). The admin username/password are break-glass passkey enrollment
credentials, not the routine dashboard login. When no admin password is
supplied, `runtime-init` generates one on first start and prints it once in that
container's logs. When no fingerprint is supplied, the stack starts normally
but Android App Links remain disabled.

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

## Network topology

Cloudflare Tunnel publishes only `hayer.almou.sa` and targets
`http://192.168.225.20:8432`. Its public hostname serves the consumer, API,
WebSocket, App Links, and downloads; nginx returns 404 for all `/admin` paths.
The tunnel is an outbound connector, so no router/NAT port-forward for `8432`
is required or permitted.

Private DNS resolves `hayer.vpn.almou.sa` to Nginx Proxy Manager at
`192.168.225.21`. NPM terminates valid TLS and proxies to
`192.168.225.20:8433`, preserving Host and client-IP headers with WebSocket
support. This hostname must be reachable only from LAN or via a Tailscale
subnet route. The private listener serves the admin at `/`, its RPCs at
`/api/`, and recovery at `/enroll`; consumer routes are unavailable there.
Legacy private `/admin/*` bookmarks redirect to their root-mounted equivalent.

Restrict the Unraid/Docker host firewall so `8432/tcp` accepts only the local
cloudflared connector and `8433/tcp` accepts only NPM. Docker-published ports
may bypass a simple UFW rule, so enforce this in Unraid's Docker firewall
(`DOCKER-USER`) path and verify it from a separate WAN host. Cloudflare Tunnel
satisfies origin-isolation and upstream DDoS protection only after every WAN
forward/direct origin path is closed.

At Cloudflare, add these defense-in-depth rules in addition to the origin
nginx limits:

- block `http.host eq "hayer.almou.sa" and starts_with(http.request.uri.path,
  "/admin")`;
- rate-limit POSTs to `/api/anonymousIdp/login` and
  `/api/hayerSession/join` to 10 requests/minute per source IP with a temporary
  block response.

After deployment, verify the public `/`, `/api/`, `/api/websocket`, join,
App-Link, and APK routes. Confirm public `/admin`, `/admin/api/`, and
`/admin/enroll` return 404. From both LAN and Tailscale, verify the private
root, passkey login, dashboard RPCs, and exact-origin rejection. Direct access
to `8432` with the private Host and to `8433` with the public Host must return
404.

Serverpod 3.4 may print a database-integrity warning that its target schema is
missing the custom `location` columns, spatial/search indexes, and cascading
foreign keys. The comparison is reporting PostGIS objects that exist in the
live database but cannot be represented by Serverpod's generated model; it
does not mean the migration failed. Do not apply a repair migration merely to
silence this warning, because it can remove those custom objects.

## Passkey enrollment and private-domain migration

Existing passkeys for `hayer.almou.sa` cannot authenticate the new
`hayer.vpn.almou.sa` WebAuthn relying party. Keep the generated/configured
Basic credentials available for this one-time migration.

The Serverpod client posts passkey RPCs to `/api/passkeyIdp` without a
trailing slash. Keep the gateway's exact-match route for that path: redirecting
the POST to `/api/passkeyIdp/` can turn it into a bodyless GET and prevent the
browser's passkey ceremony from starting.

From the repository root, run this single command:

```bash
scripts/admin-enrollment.sh reenroll
```

It recreates `runtime-init`, `server`, and `gateway` with one process-scoped
value and verifies that both protection layers are enabled. Open
`https://hayer.vpn.almou.sa/enroll`, satisfy Basic Auth, and register two
independent passkeys. Verify each through a separate fresh browser session,
then return to the command and press Enter. It disables and verifies both
layers; its exit trap also attempts to close enrollment if the command is
interrupted. Confirm both `/enroll` and `/enroll-api/` return 404 while both
passkeys still perform routine login. `admin-enrollment.sh status` reports both
layers without making changes; explicit `enable` and `disable` actions are
available for troubleshooting. All Compose defaults remain fail-closed; no
global variable or persistent enrollment setting is required.

`runtime-init` rewrites the gateway's fail-closed enrollment policy on every
recreation. Serverpod also checks the flag before creating an enrollment user
or accepting registration, and limits an operator to six starts per hour.
Retain the Basic credentials offline and rotate them if exposed.

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

## Deferred container hardening

Do not combine the next container-hardening step with this network migration.
In a separate rollback window: introduce non-root runtime UIDs and explicit
volume ownership; add read-only filesystems, controlled tmpfs mounts,
`no-new-privileges`, and dropped capabilities; split edge/application/data/
backup/egress networks; move migrations to a one-shot job; add CPU, memory,
PID, and log limits; then canary seccomp/AppArmor rules and complete a restore
drill. The current initializer and persistent-volume permissions assume root,
so changing them independently avoids an opaque startup failure.
