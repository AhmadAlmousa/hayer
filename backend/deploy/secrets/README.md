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
- `HAYER_ANDROID_SHA256` enables App Links using the release certificate's
  colon-separated SHA-256 fingerprint. App Links remain disabled when it is
  omitted.

The external reverse proxy should forward `https://hayer.almou.sa` to port
`8432` and preserve WebSocket upgrade headers.

After deployment, open `https://hayer.almou.sa/admin/enroll`, enter the recovery
credentials in the browser's native Basic Auth prompt, and create a passkey.
Store the recovery credentials offline. Routine access starts at `/admin` and
uses only the passkey-backed Serverpod session.
