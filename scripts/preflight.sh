#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$repo_root/scripts/resolve-toolchain.sh"
flutter_bin="$(hayer_resolve_flutter)"
dart_bin="$(hayer_resolve_dart "$flutter_bin")"
serverpod_bin="${SERVERPOD_BIN:-serverpod}"
export PATH="$(dirname "$dart_bin"):$PATH"
cd "$repo_root"

bash scripts/test-resolve-toolchain.sh
"$flutter_bin" pub get
if ! command -v "$serverpod_bin" >/dev/null 2>&1; then
  echo "Serverpod CLI 4.0.0 is required; install it with: dart install serverpod_cli@4.0.0" >&2
  exit 1
fi
serverpod_version="$($serverpod_bin --version)"
if [[ "$serverpod_version" != "Serverpod version: 4.0.0" ]]; then
  echo "Expected Serverpod CLI 4.0.0, got: $serverpod_version" >&2
  exit 1
fi
(
  cd backend/hayer_server
  "$serverpod_bin" --no-analytics generate
)
mapfile -t dart_sources < <(
  rg --files \
    backend/hayer_server/lib backend/hayer_server/bin \
    backend/hayer_server/tool backend/hayer_server/test \
    backend/hayer_server/integration_test \
    backend/hayer_client/lib backend/hayer_client/tool \
    app/lib app/test admin/lib admin/test \
    -g '*.dart' \
    -g '!backend/hayer_server/lib/src/generated/**' \
    -g '!backend/hayer_server/test/integration/test_tools/**' \
    -g '!backend/hayer_client/lib/src/protocol/**'
)
"$dart_bin" format --output=none --set-exit-if-changed "${dart_sources[@]}"
(cd backend/hayer_server && "$dart_bin" analyze --fatal-infos && "$dart_bin" test)
(cd backend/hayer_client && "$dart_bin" analyze --fatal-infos)
(cd app && "$flutter_bin" analyze --fatal-infos && "$flutter_bin" test)
(cd admin && "$flutter_bin" analyze --fatal-infos && "$flutter_bin" test)
bash -n scripts/resolve-toolchain.sh scripts/test-resolve-toolchain.sh \
  scripts/preflight.sh \
  scripts/build-release-apk.sh scripts/build-server-image.sh \
  scripts/test-server-integration.sh scripts/admin-enrollment.sh \
  scripts/test-integration-remote.sh scripts/benchmark-discovery-query.sh \
  scripts/benchmark-analytics.sh
sh -n backend/deploy/backup-loop.sh backend/deploy/restore-backup.sh
git diff --check
