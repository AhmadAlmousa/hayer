# Hayer server

Serverpod monolith containing the authenticated session engine, shared
PostGIS POI catalog, calibrated Google web extractor, maintenance jobs, admin
API, and public web routes. Redis is deliberately disabled for the beta.

The bundled place calibration is the offline fallback. The running server
checks Vela's detached-signature-protected calibration feed at startup and once
per hour, ignores fields outside Hayer's search contract, and automatically
activates relevant changes only after schema validation and a Riyadh live
canary. Failed candidates are retained for inspection while the previous
calibration remains active.

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

The production Docker image compiles the server, runtime initializer, and both
canaries to standalone native executables. Its final Debian stage contains no
Dart or Flutter SDK. Build it explicitly with
`../../scripts/build-server-image.sh`; routine `docker compose up` calls never
build the image.

The session integration suite uses an isolated, in-memory PostGIS container and
does not need `config/passwords.yaml`:

```bash
../../scripts/test-server-integration.sh
```

The script removes its test container and database when the suite finishes.
