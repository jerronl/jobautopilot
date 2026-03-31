#!/usr/bin/env bash
# publish-all.sh — publish all three jobautopilot skills to ClawHub
# Usage: bash publish-all.sh [--dry-run]

set -e

DRY_RUN=""
[ "$1" = "--dry-run" ] && DRY_RUN="--dry-run"

# Format: "folder:slug"
SKILLS=(
  "jobautopilot-search:jobautopilot/search"
  "jobautopilot-tailor:jobautopilot/tailor"
  "jobautopilot-submitter:jobautopilot/submit"
)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Checking ClawHub auth..."
clawhub whoami || { echo "Run 'clawhub login' first"; exit 1; }

for entry in "${SKILLS[@]}"; do
  folder="${entry%%:*}"
  slug="${entry##*:}"
  echo ""
  echo "==> Publishing $folder as $slug ..."
  clawhub publish "$SCRIPT_DIR/$folder" \
    --slug "$slug" \
    $DRY_RUN
  echo "    Done: $slug"
done

echo ""
echo "All skills published."
echo "Browse at: https://clawhub.ai/skills?q=jobautopilot"
