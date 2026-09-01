#!/bin/sh
set -eu

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 /absolute/path/to/hayer-TIMESTAMP.dump" >&2
  exit 64
fi

backup="$1"
if [ ! -f "$backup" ]; then
  echo "Backup does not exist: $backup" >&2
  exit 66
fi

sha256sum -c "${backup}.sha256"
echo "Restore is destructive. Set HAYER_CONFIRM_RESTORE=restore-hayer to continue." >&2
if [ "${HAYER_CONFIRM_RESTORE:-}" != "restore-hayer" ]; then
  exit 65
fi

docker compose exec -T postgres pg_restore \
  --username=hayer --dbname=hayer --clean --if-exists --no-owner < "$backup"
