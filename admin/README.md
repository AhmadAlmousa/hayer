# Hayer operations console

Protected Flutter web UI for catalog and coverage inspection, refresh-job
operations, cache policy and retention pruning, KPI trends, audit history, and
calibration validation/activation/rollback.

```bash
flutter run -d chrome
flutter test
flutter build web --base-href /admin/cache/
```

The production gateway protects `/admin/cache/` and its nested API route with
the same nginx Basic Auth credentials. Mutating and read RPCs also require an
exact `https://hayer.almou.sa` browser origin marker set by nginx. See
`../backend/deploy/secrets/README.md`.
