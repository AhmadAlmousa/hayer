#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
compose_file="$repo_root/backend/hayer_server/docker-compose.test.yml"

cleanup() {
  docker compose -f "$compose_file" down --volumes
}
trap cleanup EXIT

docker compose -f "$compose_file" up \
  --build \
  --abort-on-container-exit \
  --exit-code-from integration-tests \
  integration-tests
