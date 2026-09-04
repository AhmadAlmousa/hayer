# Runtime configuration

No files are required in this directory. The Compose `runtime-init` service
creates database, Serverpod, backup, and nginx credentials in persistent named
Docker volumes on first start.

Set these optional environment variables in the Unraid Compose stack:

- `HAYER_ADMIN_USER` selects the Basic Auth username and defaults to
  `operator`.
- `HAYER_ADMIN_PASSWORD` selects the Basic Auth password. When omitted, a
  secure value is generated and printed once in the `runtime-init` logs. This
  nginx Basic Auth account is the dashboard's only login.
- `HAYER_ANDROID_SHA256` enables App Links using the release certificate's
  colon-separated SHA-256 fingerprint. App Links remain disabled when it is
  omitted.

The external reverse proxy should forward `https://hayer.almou.sa` to port
`8432` and preserve WebSocket upgrade headers.
