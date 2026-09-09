# Hayer consumer

Android-first Flutter client for solo and multiplayer place decisions. Swipe
cards open the shared details sheet without advancing. Multiplayer results show
aggregate destination-choice counts and one editable `My choice` ballot per
participant; the highest count wins and the host's ballot breaks a leading tie.
Users can save places into private on-device Want to try/Favorites lists, add
private notes, and create solo or multiplayer rooms from 2–20 selected places
with an optional five-place fresh mix. It uses Riverpod, GoRouter, Serverpod
anonymous auth, secure active-session/saved-place storage, and a Drift swipe
outbox. Saved places and notes are not synced or exportable; shortlist requests
send only ordered place IDs, and the client rejects servers that do not preserve
that selection.

Current multiplayer codes are shown and shared as `ABC-124`. The API stores
the canonical `ABC124` value; pasted dashed/plain codes, localized digits, and
active historical three- or six-character codes remain accepted. Build 5 is
the minimum server-supported build for this format. Build 7 keeps legacy
results when an older server omits the optional destination-choice state, but
the choice action is available only after the additive build-7 server migration.

```bash
flutter run --dart-define=SERVER_URL=http://localhost:8080/
flutter test
flutter build apk --debug --dart-define=SERVER_URL=https://hayer.almou.sa/api/
```

Release signing requires the ignored `android/key.properties`; start from
`android/key.properties.example`. See the repository `README.md` and
`PROJECT.md` for backend setup and current release gates.
