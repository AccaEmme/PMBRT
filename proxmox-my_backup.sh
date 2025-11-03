#!/bin/bash

# Default values
INCLUDE_IMAGES=false
DEST="/root/proxmox-backup-$(date +%F).tar.gz"

# Help message
show_help() {
  echo "Usage: proxmox-backup.sh [--include-images] [--dest PATH] [--help]"
  echo ""
  echo "Options:"
  echo "  --include-images   Include VM/container disk images in the backup"
  echo "  --dest PATH        Set custom destination path for the backup file"
  echo "  --help             Show this help message"
  #exit 0
}

# Parse arguments
while [[ "$#" -gt 0 ]]; do
  case $1 in
    --include-images) INCLUDE_IMAGES=true ;;
    --dest) DEST="$2"; shift ;;
    --help) show_help ;;
    *) echo "Unknown parameter: $1"; show_help ;;
  esac
  shift
done

# Build exclude options
EXCLUDES=""
if [ "$INCLUDE_IMAGES" = false ]; then
  EXCLUDES="--exclude='/var/lib/vz/images' \
--exclude='/var/lib/vz/images/*' \
--exclude='/var/lib/vz/dump' \
--exclude='/var/lib/vz/dump/*' \
--exclude='/var/lib/vz/template/iso' \
--exclude='/var/lib/vz/template/iso/*' \
--exclude='/var/lib/vz/template/cache' \
--exclude='/var/lib/vz/template/cache/*'"
fi

# Run backup
echo Inizio il backup
show_help

echo "Creating backup at: $DEST"
#tar czvf "$DEST" /etc/pve /etc/network/interfaces /var/lib/vz $EXCLUDES
eval tar czvf "$DEST" $EXCLUDES /etc/pve /etc/network/interfaces /var/lib/vz


