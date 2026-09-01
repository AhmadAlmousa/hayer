# Hayer consumer

Android-first Flutter client for solo and multiplayer place swiping. It uses
Riverpod, GoRouter, Serverpod anonymous auth, secure active-session storage,
and a Drift swipe outbox.

```bash
flutter run --dart-define=SERVER_URL=http://localhost:8080/
flutter test
flutter build apk --debug --dart-define=SERVER_URL=https://hayer.almou.sa/api/
```

Release signing requires the ignored `android/key.properties`; start from
`android/key.properties.example`. See the repository `README.md` and
`PROJECT.md` for backend setup and current release gates.
