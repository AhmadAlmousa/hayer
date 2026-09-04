#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$repo_root/scripts/resolve-toolchain.sh"
flutter_bin="$(hayer_resolve_flutter)"
properties="$repo_root/app/android/key.properties"
if [[ ! -f "$properties" ]]; then
  echo "Missing app/android/key.properties for the external release keystore." >&2
  exit 66
fi

cd "$repo_root/app"
"$flutter_bin" build apk --release \
  --dart-define=SERVER_URL=https://hayer.almou.sa/api/

release_dir="$repo_root/backend/deploy/releases"
mkdir -p "$release_dir"
version="$(sed -n 's/^version: //p' pubspec.yaml | tr '+' '-')"
target="$release_dir/hayer-${version}.apk"
cp build/app/outputs/flutter-apk/app-release.apk "$target"
sha256sum "$target" > "${target}.sha256"
cp "$target" "$release_dir/hayer.apk"
sha256sum "$release_dir/hayer.apk" > "$release_dir/hayer.apk.sha256"
echo "$target"
