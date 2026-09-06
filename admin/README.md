# Hayer admin

Passkey-protected Flutter web suite for anonymous product analytics, live usage,
place-vote insights, versioned taxonomy, catalog and coverage inspection,
refresh jobs, cache policy, audit history, and calibration rollout.

The browser routes are `/overview`, `/usage`, `/places`, `/taxonomy`,
`/catalog`, `/coverage`, `/jobs`, `/settings`, `/calibration`, and `/audit`
under the production `/admin/` mount. Historical analytics refresh every
five minutes; live session and participant counts refresh every 30 seconds.

Taxonomy changes stay in a draft until structural validation and location-
selected live canaries pass. Publishing and rollback require a reason and are
audited. Published consumer payloads contain labels and structure only, never
provider query strings.

```bash
flutter run -d chrome
flutter test
flutter build web --base-href /admin/
```

The production entry point is `https://hayer.vpn.almou.sa/admin/`, resolvable
and reachable only from LAN or Tailscale. Public `hayer.almou.sa/admin*`
requests return 404. Every read and mutation RPC requires a passkey-issued JWT
with `admin` scope and the exact `https://hayer.vpn.almou.sa` origin marker set
by nginx. Sign-out revokes the server token and clears secure client storage.

For the first passkey, or recovery, open
set `HAYER_ADMIN_ENROLLMENT_ENABLED=true`, recreate the runtime initializer,
server, and gateway, then open `https://hayer.vpn.almou.sa/admin/enroll`.
nginx protects that page and `/admin/enroll-api/` with the break-glass Basic
Auth account. It issues an
`admin-enrollment`-only token, registers one discoverable passkey with required
user verification, revokes the enrollment token, and performs a fresh passkey
login. Register and verify two independent recovery passkeys, then set the flag
back to `false` and recreate the same services. Disabled enrollment returns
404 at nginx and is independently rejected by Serverpod. Hayer never saves the
Basic Auth password. `local_auth` is not used: local device approval alone
cannot authenticate a web administrator to the server.

The web build self-hosts the `passkeys` package's documented browser bridge as
`web/passkeys_bundle.js` alongside its redistribution license; its verified
upstream SHA-384 is
`lJXabVIVTplZn8Gq0rr7HchxKSYaVleDXbBqiFCwr5wJ9cQnHZGdx89nnZX9xHcavar`.
Refresh the vendored bridge and recorded hash together when upgrading
`passkeys`. See `../backend/deploy/secrets/README.md` for recovery credential
handling.
