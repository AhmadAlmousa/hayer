#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$repo_root/scripts/resolve-toolchain.sh"
flutter_bin="$(hayer_resolve_flutter)"
dart_bin="$(hayer_resolve_dart "$flutter_bin")"
export PATH="$(dirname "$dart_bin"):$PATH"
cd "$repo_root"

"$flutter_bin" pub get
(
  cd backend/hayer_server
  "$dart_bin" pub global run serverpod_cli:serverpod_cli generate
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
bash -n scripts/resolve-toolchain.sh scripts/preflight.sh \
  scripts/build-release-apk.sh scripts/build-server-image.sh \
  scripts/test-server-integration.sh
sh -n backend/deploy/backup-loop.sh backend/deploy/restore-backup.sh
git diff --check
