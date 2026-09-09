# Hayer server

Serverpod monolith containing the authenticated session engine, shared
PostGIS POI catalog, calibrated Google web extractor, maintenance jobs, admin
API, WebAuthn passkey verifier, and public web routes. Redis is deliberately
disabled for the beta.

Multiplayer destination ballots are stored separately from swipe likes. The
`chooseDestination` RPC accepts one matched place and the caller's expected
choice revision, authorizes membership server-side, and returns aggregate
counts plus only the caller's ballot. The highest count leads; the host's own
ballot breaks a leading tie. Deploy migration
`20260908061228738-destination-choices` with this server before exposing the
build-7 choice UI.

Session creation can resolve an ordered shortlist of 2–20 saved place IDs from
the authoritative catalog, optionally adding up to five fresh candidates.
Selected places remain first, in order; local cached snapshots and private
notes are never accepted by the API. Deploy this additive server contract
before exposing saved-shortlist creation in a client.

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

Production configures the Serverpod passkey relying party as
`hayer.almou.sa`; development/test use `localhost`. Admin endpoints require an
authenticated `admin` scope and the gateway's exact-origin marker. The separate
Basic-Auth enrollment endpoint issues only a short bootstrap flow, and its
token is revoked immediately after a passkey is registered.

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
