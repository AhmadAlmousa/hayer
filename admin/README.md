# Hayer admin

Protected Flutter web suite for anonymous product analytics, live usage,
place-vote insights, versioned taxonomy, catalog and coverage inspection,
refresh jobs, cache policy, audit history, and calibration rollout.

The browser routes are `/overview`, `/usage`, `/places`, `/taxonomy`,
`/catalog`, `/coverage`, `/jobs`, `/settings`, `/calibration`, and `/audit`
under the production `/admin/` mount. Historical analytics refresh every
five minutes; live session and participant counts refresh every 30 seconds.

Taxonomy changes stay in a draft until structural validation and location-
selected live canaries pass. Publishing and rollback require a reason and are
audited. Published consumer payloads contain labels and structure only, never
provider query strings.

```bash
flutter run -d chrome
flutter test
flutter build web --base-href /admin/
```

The production gateway protects `/admin/` and its nested API route with
the same nginx Basic Auth credentials. Mutating and read RPCs also require an
exact `https://hayer.almou.sa` browser origin marker set by nginx. See
`../backend/deploy/secrets/README.md`.
