# Hayer operations console

Protected Flutter web UI for catalog inspection, cache policy, quarantine,
metrics, and calibration validation/activation/rollback.

```bash
flutter run -d chrome
flutter test
flutter build web --base-href /admin/cache/
```

The production gateway protects both `/admin/cache/` and `/admin-api/` with
Basic Auth. The app also requires the server-side admin secret and keeps it in
memory only. See `../backend/deploy/secrets/README.md`.
