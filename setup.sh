#!/usr/bin/env bash
set -euo pipefail

REPOS=(
  actions-swing
  setup-chrome
  setup-firefox
  setup-edge
  setup-geckodriver
  release-chrome-extension
  release-firefox-addon
)

ORG="browser-actions"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_DIR="$(dirname "$SCRIPT_DIR")"
WORKSPACES_DIR="$SCRIPT_DIR/workspaces"

mkdir -p "$WORKSPACES_DIR"

for repo in "${REPOS[@]}"; do
  target="$BASE_DIR/$repo"

  if [ -d "$target" ]; then
    echo "[$repo] already cloned, skipping"
  else
    echo "[$repo] cloning..."
    git clone "https://github.com/$ORG/$repo.git" "$target"
  fi

  link="$WORKSPACES_DIR/$repo"
  if [ -L "$link" ]; then
    echo "[$repo] symlink already exists, skipping"
  else
    ln -s "$target" "$link"
    echo "[$repo] symlink created → $target"
  fi
done
