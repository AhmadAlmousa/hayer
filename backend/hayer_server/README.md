# Hayer server

Serverpod monolith containing the authenticated session engine, shared
PostGIS POI catalog, calibrated Google web extractor, maintenance jobs, admin
API, and public web routes. Redis is deliberately disabled for the beta.

```bash
cp config/passwords.yaml.example config/passwords.yaml
serverpod generate
dart run bin/main.dart --apply-migrations
dart analyze --fatal-infos
dart test
```

Runtime and database integration require PostgreSQL 16 with PostGIS. Production
deployment is defined in `../deploy/`; broader setup and verification status
are in the repository `README.md` and `PROJECT.md`.
