#!/usr/bin/env bash

set -e

REPO_URL="https://github.com/zabbix/zabbix-docker.git"
DEST_DIR="$HOME/zabbix-docker"

echo "=== Move to home directory ==="
cd "$HOME"

if [ -d "$DEST_DIR" ]; then
  echo "ERROR: $DEST_DIR already exists."
  echo "If you want to re-clone, remove it first:"
  echo "  rm -rf $DEST_DIR"
  exit 1
fi

echo "=== Cloning zabbix-docker repository ==="
git clone "$REPO_URL"

echo "=== Done ==="
echo "Repository cloned to: $DEST_DIR"

