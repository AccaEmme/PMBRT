#!/bin/bash

# Default values
SOURCE=""
SHOW_HELP=false

# Help message
show_help() {
  echo "Usage: proxmox-restore.sh --source PATH"
  echo ""
  echo "Options:"
  echo "  --source PATH   Path to the backup archive to restore"
  echo "  --help          Show this help message"
  exit 0
}

# Parse arguments
while [[ "$#" -gt 0 ]]; do
  case $1 in
    --source) SOURCE="$2"; shift ;;
    --help) show_help ;;
    *) echo "Unknown parameter: $1"; show_help ;;
  esac
  shift
done

# Validate input
if [[ -z "$SOURCE" ]]; then
  echo "Error: --source is required"
  show_help
fi

# Run restore
echo "Restoring backup from: $SOURCE"
tar xzvf "$SOURCE" -C /
