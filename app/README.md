# Hayer consumer

Android-first Flutter client for solo and multiplayer place swiping. It uses
Riverpod, GoRouter, Serverpod anonymous auth, secure active-session storage,
and a Drift swipe outbox.

Current multiplayer codes are shown and shared as `ABC-124`. The API stores
the canonical `ABC124` value; pasted dashed/plain codes, localized digits, and
active historical three- or six-character codes remain accepted. Build 5 is
the minimum server-supported build for this format.

```bash
flutter run --dart-define=SERVER_URL=http://localhost:8080/
flutter test
flutter build apk --debug --dart-define=SERVER_URL=https://hayer.almou.sa/api/
```

Release signing requires the ignored `android/key.properties`; start from
`android/key.properties.example`. See the repository `README.md` and
`PROJECT.md` for backend setup and current release gates.
