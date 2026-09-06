# Runtime configuration

No files are required in this directory. The Compose `runtime-init` service
creates database, Serverpod, backup, and nginx credentials in persistent named
Docker volumes on first start.

Set these optional environment variables in the Unraid Compose stack:

- `HAYER_ADMIN_USER` selects the Basic Auth username and defaults to
  `operator`.
- `HAYER_ADMIN_PASSWORD` selects the Basic Auth password. When omitted, a
  secure value is generated and printed once in the `runtime-init` logs. This
  nginx account is used only at `/enroll` and `/enroll-api/` to
  enroll or recover a passkey; it is not the routine dashboard login and Hayer
  never stores it in browser application storage.
- `HAYER_ADMIN_ENROLLMENT_ENABLED` is an internal Compose input shared by the
  gateway initializer and Serverpod. Operators should use
  `scripts/admin-enrollment.sh reenroll` instead of setting it globally.
  It defaults to `false`; all other values fail closed.
- `HAYER_ANDROID_SHA256` enables App Links using the release certificate's
  colon-separated SHA-256 fingerprint. App Links remain disabled when it is
  omitted.

Cloudflare Tunnel should publish only `https://hayer.almou.sa`, forwarding to
`http://192.168.225.20:8432` and preserving the public Host header. Private
Nginx Proxy Manager should forward `https://hayer.vpn.almou.sa` to
`http://192.168.225.20:8433`, preserve Host and client-IP headers, and enable
WebSockets. This private port is separate from Cloudflare's `8432` listener.

For initial setup or recovery, run `scripts/admin-enrollment.sh reenroll`,
then open `https://hayer.vpn.almou.sa/enroll`. Enter the recovery credentials
in the browser's native Basic Auth prompt and create a passkey. Verify two
independent passkeys, then return to the command and press Enter to close
enrollment. Store the recovery credentials offline. Routine access starts at
the private origin root and uses only the passkey-backed Serverpod session.
