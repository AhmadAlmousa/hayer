#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

flutter pub get
(
  cd backend/hayer_server
  serverpod generate
)
dart format --output=none --set-exit-if-changed \
  backend/hayer_server/lib backend/hayer_server/bin \
  backend/hayer_server/tool backend/hayer_server/test \
  backend/hayer_client/lib app/lib app/test admin/lib admin/test
(cd backend/hayer_server && dart analyze --fatal-infos && dart test)
(cd backend/hayer_client && dart analyze --fatal-infos)
(cd app && flutter analyze --fatal-infos && flutter test)
(cd admin && flutter analyze --fatal-infos && flutter test)
bash -n scripts/preflight.sh scripts/deploy-unraid.sh scripts/build-release-apk.sh
sh -n backend/deploy/backup-loop.sh backend/deploy/restore-backup.sh
git diff --check
