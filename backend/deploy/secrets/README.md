# Runtime configuration

No files are required in this directory. The Compose `runtime-init` service
creates database, Serverpod, backup, and nginx credentials in persistent named
Docker volumes on first start.

Set these optional environment variables in the Unraid Compose stack:

- `HAYER_ADMIN_USER` selects the Basic Auth username and defaults to
  `operator`.
- `HAYER_ADMIN_PASSWORD` selects the Basic Auth password. When omitted, a
  secure value is generated and printed once in the `runtime-init` logs. This
  nginx account is used only at `/admin/enroll` and `/admin/enroll-api/` to
  enroll or recover a passkey; it is not the routine dashboard login and Hayer
  never stores it in browser application storage.
- `HAYER_ADMIN_ENROLLMENT_ENABLED` must equal `true` to expose or execute the
  private passkey enrollment flow. It defaults to `false`; all other values
  fail closed.
- `HAYER_ANDROID_SHA256` enables App Links using the release certificate's
  colon-separated SHA-256 fingerprint. App Links remain disabled when it is
  omitted.

Cloudflare Tunnel should publish only `https://hayer.almou.sa`, forwarding to
`http://192.168.225.20:8432` and preserving the public Host header. Private
Nginx Proxy Manager should forward `https://hayer.vpn.almou.sa` to the same
origin, preserve Host and client-IP headers, and enable WebSockets.

For initial setup or recovery, temporarily enable enrollment, recreate
`runtime-init`, `server`, and `gateway`, then open
`https://hayer.vpn.almou.sa/admin/enroll`. Enter the recovery credentials in
the browser's native Basic Auth prompt and create a passkey. Verify two
independent passkeys before disabling enrollment and recreating those services
again. Store the recovery credentials offline. Routine access starts at the
private `/admin/` URL and uses only the passkey-backed Serverpod session.
