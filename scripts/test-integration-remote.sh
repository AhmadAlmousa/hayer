#!/usr/bin/env bash
# Run the PostGIS integration suite against a database this host can reach,
# instead of the local Docker Compose stack in test-server-integration.sh.
#
# The suite is destructive: in setUp and tearDown, integration_test truncates
# the shared catalog with its coverage, category evidence and detail-refresh
# tables; sessions, reports, jobs, rate limits, audits and metrics; the Swipe
# and Discover policy and taxonomy; and Discover's harvest, area coverage,
# manifest and type-observation tables. Point it only at a disposable database.
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# PATH may carry an older Flutter than the pinned toolchain, and the resolver
# prefers PATH over the repository copy. Pin it here unless already set.
if [[ -z "${FLUTTER_BIN:-}" ]]; then
  pinned="$repo_root/build/toolchains/flutter-3.47.2/bin/flutter"
  [[ -x "$pinned" ]] && export FLUTTER_BIN="$pinned"
fi

source "$repo_root/scripts/resolve-toolchain.sh"

db_host="${HAYER_TEST_DB_HOST:-192.168.225.20}"
db_port="${HAYER_TEST_DB_PORT:-55432}"
db_name="${HAYER_TEST_DB_NAME:-hayer_test}"
db_user="${HAYER_TEST_DB_USER:-postgres}"
db_password="${HAYER_TEST_DB_PASSWORD:-hayer_test}"

# Production is POSTGRES_DB=hayer. Requiring the hayer_test prefix keeps a
# mistyped host or a stale export from truncating the live catalog.
if [[ "$db_name" != hayer_test* ]]; then
  echo "Refusing to run: database name '$db_name' is not a hayer_test database." >&2
  echo "The suite truncates catalog tables; it must target a disposable database." >&2
  exit 2
fi

# pg_isready answers for any Postgres on the port, including one that is not
# ours, so authenticate and confirm the database we actually reached.
reached="$(PGCONNECT_TIMEOUT=8 PGPASSWORD="$db_password" \
  psql -h "$db_host" -p "$db_port" -U "$db_user" -d "$db_name" \
  -tAc 'select current_database();' 2>/dev/null || true)"

if [[ "$reached" != "$db_name" ]]; then
  echo "Could not reach database '$db_name' as '$db_user' on $db_host:$db_port." >&2
  echo "Start the throwaway container on the Docker host, then retry." >&2
  exit 1
fi

flutter_bin="$(hayer_resolve_flutter)"
dart_bin="$(hayer_resolve_dart "$flutter_bin")"

echo "Running integration suite against $db_host:$db_port/$db_name"
echo "Using $("$dart_bin" --version 2>&1)"
cd "$repo_root/backend/hayer_server"
SERVERPOD_DATABASE_HOST="$db_host" \
SERVERPOD_DATABASE_PORT="$db_port" \
SERVERPOD_DATABASE_NAME="$db_name" \
SERVERPOD_DATABASE_USER="$db_user" \
SERVERPOD_DATABASE_PASSWORD="$db_password" \
  "$dart_bin" test integration_test --concurrency=1 "$@"
