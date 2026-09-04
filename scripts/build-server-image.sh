#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
docker_bin="${DOCKER_BIN:-docker}"
image="hayer-server:local"

"$docker_bin" build \
  --file "$repo_root/backend/hayer_server/Dockerfile.production" \
  --tag "$image" \
  "$repo_root"

"$docker_bin" image inspect \
  --format 'Built {{index .RepoTags 0}} ({{.Size}} bytes)' \
  "$image"
