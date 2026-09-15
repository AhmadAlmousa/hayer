#!/usr/bin/env bash
# Measure product analytics over a year of synthetic hourly aggregates (F22
# evidence): report latency, EXPLAIN (ANALYZE, BUFFERS) for each report
# statement, drain throughput over a pending event backlog, and pruning.
#
# Destructive: it truncates hayer_product_analytics_event,
# hayer_product_analytics_hour and hayer_operational_metric, and leaves the
# generated year in place until the next run. Like test-integration-remote.sh
# it refuses any database whose name does not start with hayer_test.
#
# Usage: scripts/benchmark-analytics.sh [output-file]
# Environment: HAYER_TEST_DB_* as in test-integration-remote.sh,
# HAYER_BENCHMARK_PLACES_PER_HOUR (default 60) and
# HAYER_BENCHMARK_PENDING_EVENTS (default 200000).
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

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
output="${1:-$repo_root/build/analytics-benchmark.txt}"

if [[ "$db_name" != hayer_test* ]]; then
  echo "Refusing to run: database name '$db_name' is not a hayer_test database." >&2
  exit 2
fi

reached="$(PGCONNECT_TIMEOUT=8 PGPASSWORD="$db_password" \
  psql -h "$db_host" -p "$db_port" -U "$db_user" -d "$db_name" \
  -tAc 'select current_database();' 2>/dev/null || true)"
if [[ "$reached" != "$db_name" ]]; then
  echo "Could not reach database '$db_name' as '$db_user' on $db_host:$db_port." >&2
  exit 1
fi

flutter_bin="$(hayer_resolve_flutter)"
dart_bin="$(hayer_resolve_dart "$flutter_bin")"

mkdir -p "$(dirname "$output")"
output="$(cd "$(dirname "$output")" && pwd)/$(basename "$output")"
echo "Benchmarking product analytics against $db_host:$db_port/$db_name"
cd "$repo_root/backend/hayer_server"
SERVERPOD_DATABASE_HOST="$db_host" \
SERVERPOD_DATABASE_PORT="$db_port" \
SERVERPOD_DATABASE_NAME="$db_name" \
SERVERPOD_DATABASE_USER="$db_user" \
SERVERPOD_DATABASE_PASSWORD="$db_password" \
HAYER_BENCHMARK_OUTPUT="$output" \
  "$dart_bin" test benchmark/analytics_benchmark_test.dart \
  --concurrency=1 --timeout=60m --reporter=expanded
echo "Results written to $output"
