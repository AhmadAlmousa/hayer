#!/bin/sh
set -eu

umask 077
cp /run/secrets/pgpass "$PGPASSFILE"
chmod 600 "$PGPASSFILE"
mkdir -p /backups
while true; do
  hour="$(date +%H)"; hour="${hour#0}"
  minute="$(date +%M)"; minute="${minute#0}"
  second="$(date +%S)"; second="${second#0}"
  now_seconds="$((hour * 3600 + minute * 60 + second))"
  target_seconds=10800
  if [ "$now_seconds" -lt "$target_seconds" ]; then
    wait_seconds="$((target_seconds - now_seconds))"
  else
    wait_seconds="$((86400 - now_seconds + target_seconds))"
  fi
  sleep "$wait_seconds"
  stamp="$(date +%Y%m%d-%H%M%S)"
  target="/backups/hayer-${stamp}.dump"
  pg_dump --format=custom --compress=9 --file="$target"
  sha256sum "$target" > "${target}.sha256"
  find /backups -type f -name 'hayer-*.dump' -mtime +7 -delete
  find /backups -type f -name 'hayer-*.dump.sha256' -mtime +7 -delete
done
