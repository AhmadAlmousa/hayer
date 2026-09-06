#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
deploy_dir="$repo_root/backend/deploy"
compose=(docker compose --project-directory "$deploy_dir" -f "$deploy_dir/docker-compose.yml")
action="${1:-status}"

refresh_status() {
  server_state="$("${compose[@]}" exec -T server printenv HAYER_ADMIN_ENROLLMENT_ENABLED 2>/dev/null || true)"
  gateway_policy="$("${compose[@]}" exec -T gateway cat /etc/nginx/secrets/admin-enrollment-policy.conf 2>/dev/null || true)"
  if [[ "$gateway_policy" == *"temporarily enabled"* ]]; then
    gateway_state=true
  elif [[ "$gateway_policy" == *"return 404;"* ]]; then
    gateway_state=false
  else
    gateway_state=unknown
  fi
  [[ -n "$server_state" ]] || server_state=unknown
}

show_status() {
  refresh_status
  printf 'Server enrollment:  %s\n' "$server_state"
  printf 'Gateway enrollment: %s\n' "$gateway_state"
}

apply_state() {
  local desired_state="$1"

  HAYER_ADMIN_ENROLLMENT_ENABLED="$desired_state" \
    "${compose[@]}" up -d --force-recreate --no-build \
      runtime-init server gateway

  for ((attempt = 1; attempt <= 30; attempt++)); do
    refresh_status
    if [[ "$server_state" == "$desired_state" &&
      "$gateway_state" == "$desired_state" ]]; then
      show_status
      return 0
    fi
    sleep 1
  done

  show_status
  echo "Enrollment layers did not converge on $desired_state." >&2
  return 1
}

reenrollment_open=false
close_reenrollment() {
  if [[ "$reenrollment_open" == true ]]; then
    echo 'Closing admin passkey enrollment...'
    apply_state false
    reenrollment_open=false
  fi
}

case "$action" in
  reenroll)
    reenrollment_open=true
    trap close_reenrollment EXIT
    trap 'exit 129' HUP
    trap 'exit 130' INT
    trap 'exit 143' TERM
    apply_state true
    echo 'Open https://hayer.vpn.almou.sa/enroll and register two independent passkeys.'
    read -r -p 'Press Enter after both passkeys have been verified to close enrollment... '
    close_reenrollment
    echo 'Admin passkey enrollment is closed.'
    trap - EXIT HUP INT TERM
    ;;
  enable)
    apply_state true
    echo 'Open https://hayer.vpn.almou.sa/enroll to register a passkey.'
    echo "Run $0 disable after verifying two independent passkeys."
    ;;
  disable)
    apply_state false
    echo 'Admin passkey enrollment is closed.'
    ;;
  status)
    show_status
    [[ "$server_state" == true && "$gateway_state" == true ]] ||
      [[ "$server_state" == false && "$gateway_state" == false ]]
    ;;
  *)
    echo "Usage: $0 {reenroll|enable|disable|status}" >&2
    exit 64
    ;;
esac
