# Hayer operations console

Protected Flutter web UI for catalog inspection, cache policy, quarantine,
metrics, and calibration validation/activation/rollback.

```bash
flutter run -d chrome
flutter test
flutter build web --base-href /admin/cache/
```

The production gateway protects `/admin/cache/` and its nested API route with
the same nginx Basic Auth credentials. See
`../backend/deploy/secrets/README.md`.
