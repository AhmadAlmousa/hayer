#!/usr/bin/env bash

hayer_resolve_executable() {
  local configured="$1"
  local command_name="$2"
  shift 2

  if [[ -n "$configured" ]]; then
    if [[ -x "$configured" ]]; then
      printf '%s\n' "$configured"
      return
    fi
    echo "Configured $command_name executable is not runnable: $configured" >&2
    return 127
  fi

  local discovered
  discovered="$(command -v "$command_name" || true)"
  if [[ -n "$discovered" ]]; then
    printf '%s\n' "$discovered"
    return
  fi

  local fallback
  for fallback in "$@"; do
    if [[ -n "$fallback" && -x "$fallback" ]]; then
      printf '%s\n' "$fallback"
      return
    fi
  done

  echo "Could not find $command_name. Configure its explicit *_BIN path." >&2
  return 127
}

hayer_resolve_flutter() {
  hayer_resolve_executable \
    "${FLUTTER_BIN:-}" \
    flutter \
    "${HOME:-}/flutter/bin/flutter"
}

hayer_resolve_dart() {
  local flutter_executable="$1"
  local configured="${DART_BIN:-}"
  if [[ -n "$configured" ]]; then
    hayer_resolve_executable "$configured" dart
    return
  fi

  local flutter_dart
  flutter_dart="$(dirname "$flutter_executable")/dart"
  if [[ -x "$flutter_dart" ]]; then
    printf '%s\n' "$flutter_dart"
    return
  fi

  hayer_resolve_executable "" dart "${HOME:-}/flutter/bin/dart"
}
