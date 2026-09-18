#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$repo_root/scripts/resolve-toolchain.sh"

test_root="$(mktemp -d)"
trap 'rm -rf "$test_root"' EXIT

flutter_bin="$test_root/flutter/bin/flutter"
sdk_dart="$test_root/flutter/bin/cache/dart-sdk/bin/dart"
flutter_dart="$test_root/flutter/bin/dart"
path_dart="$test_root/path/bin/dart"
explicit_dart="$test_root/explicit/bin/dart"
mkdir -p "$(dirname "$flutter_bin")" "$(dirname "$sdk_dart")" \
  "$(dirname "$path_dart")" "$(dirname "$explicit_dart")"

for executable in "$flutter_bin" "$sdk_dart" "$flutter_dart" "$path_dart" \
  "$explicit_dart"; do
  printf '#!/usr/bin/env bash\nexit 0\n' >"$executable"
  chmod +x "$executable"
done

assert_equal() {
  local expected="$1"
  local actual="$2"
  local description="$3"
  if [[ "$actual" != "$expected" ]]; then
    echo "$description: expected '$expected', got '$actual'" >&2
    return 1
  fi
}

resolved="$(PATH="$test_root/path/bin:$PATH" hayer_resolve_dart "$flutter_bin")"
assert_equal "$sdk_dart" "$resolved" \
  "The SDK Dart should precede the bin/dart wrapper and PATH"

resolved="$(DART_BIN="$explicit_dart" PATH="$test_root/path/bin:$PATH" \
  hayer_resolve_dart "$flutter_bin")"
assert_equal "$explicit_dart" "$resolved" "DART_BIN should take precedence"

rm "$sdk_dart"
resolved="$(PATH="$test_root/path/bin:$PATH" hayer_resolve_dart "$flutter_bin")"
assert_equal "$flutter_dart" "$resolved" \
  "The bin/dart wrapper should be used without an SDK Dart"

rm "$flutter_dart"
resolved="$(PATH="$test_root/path/bin:$PATH" hayer_resolve_dart "$flutter_bin")"
assert_equal "$path_dart" "$resolved" "PATH should be used without Flutter's Dart"

set +e
error="$(DART_BIN="$test_root/missing-dart" hayer_resolve_dart "$flutter_bin" 2>&1)"
status=$?
set -e
assert_equal 127 "$status" "An invalid DART_BIN should fail closed"
assert_equal \
  "Configured dart executable is not runnable: $test_root/missing-dart" \
  "$error" \
  "An invalid DART_BIN should explain the failure"

echo "Toolchain resolver tests passed."
