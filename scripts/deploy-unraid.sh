#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

scripts/preflight.sh
if [[ -z "${HAYER_ANDROID_SHA256:-}" ]]; then
  echo "Set HAYER_ANDROID_SHA256 to the release certificate fingerprint." >&2
  exit 65
fi
if [[ ! "$HAYER_ANDROID_SHA256" =~ ^([[:xdigit:]]{2}:){31}[[:xdigit:]]{2}$ ]]; then
  echo "HAYER_ANDROID_SHA256 must be 32 colon-separated SHA-256 bytes." >&2
  exit 65
fi
(cd app && flutter build web --base-href /app/)
(cd admin && flutter build web --base-href /admin/cache/)

mkdir -p backend/hayer_server/web/app backend/hayer_server/web/admin
rsync -a --delete app/build/web/ backend/hayer_server/web/app/
rsync -a --delete admin/build/web/ backend/hayer_server/web/admin/
mkdir -p backend/hayer_server/web/static/.well-known backend/hayer_server/web/static/downloads
sed "s/__HAYER_ANDROID_SHA256__/${HAYER_ANDROID_SHA256}/g" \
  backend/deploy/assetlinks.json.template \
  > backend/hayer_server/web/static/.well-known/assetlinks.json
if compgen -G 'backend/deploy/releases/*' > /dev/null; then
  rsync -a backend/deploy/releases/ backend/hayer_server/web/static/downloads/
fi
release_apk="$(ls -1t backend/deploy/releases/*.apk 2>/dev/null | head -1 || true)"
if [[ -z "$release_apk" || ! -f "${release_apk}.sha256" ]]; then
  echo "Build a signed APK and checksum before deployment." >&2
  exit 66
fi
release_name="$(basename "$release_apk")"
release_sha256="$(cut -d ' ' -f 1 "${release_apk}.sha256")"
if [[ ! "$release_sha256" =~ ^[[:xdigit:]]{64}$ ]]; then
  echo "The release checksum file is invalid." >&2
  exit 65
fi
mkdir -p backend/hayer_server/web/static/download
sed \
  -e "s/__HAYER_APK_NAME__/${release_name}/g" \
  -e "s/__HAYER_APK_SHA256__/${release_sha256}/g" \
  backend/deploy/download.html.template \
  > backend/hayer_server/web/static/download/index.html

docker compose -f backend/deploy/docker-compose.yml build server
docker compose -f backend/deploy/docker-compose.yml up -d --remove-orphans
docker compose -f backend/deploy/docker-compose.yml ps
