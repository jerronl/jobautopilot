#!/usr/bin/env bash
# publish-all.sh — publish all three jobautopilot skills to ClawHub
# Usage:
#   bash publish-all.sh           # publish
#   bash publish-all.sh --dry-run # preview (no actual publish)

set -e

DRY_RUN=false
[ "$1" = "--dry-run" ] && DRY_RUN=true

# Format: "folder:slug"
SKILLS=(
  "jobautopilot-search:jobautopilot-search"
  "jobautopilot-tailor:jobautopilot-tailor"
  "jobautopilot-submitter:jobautopilot-submitter"
  "jobautopilot-bundle:jobautopilot-bundle"
)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Checking ClawHub auth..."
clawhub whoami || { echo "Run 'clawhub login' first"; exit 1; }

for entry in "${SKILLS[@]}"; do
  folder="${entry%%:*}"
  slug="${entry##*:}"

  # Read version from SKILL.md frontmatter
  SKILL_MD="$SCRIPT_DIR/$folder/SKILL.md"
  VERSION=$(grep '^version:' "$SKILL_MD" | head -1 | sed 's/version: *//;s/"//g;s/ *$//')
  if [ -z "$VERSION" ]; then
    echo "ERROR: could not read version from $SKILL_MD"
    exit 1
  fi

  echo ""
  echo "==> $folder → $slug @ v$VERSION"

  if [ "$DRY_RUN" = true ]; then
    echo "    [dry-run] clawhub publish $SCRIPT_DIR/$folder --version $VERSION"
  else
    clawhub publish "$SCRIPT_DIR/$folder" \
      --version "$VERSION"
    echo "    Done: $slug"
  fi
done

echo ""
if [ "$DRY_RUN" = true ]; then
  echo "Dry run complete — no skills were published."
else
  echo "All skills published."
  echo "Browse at: https://clawhub.ai/skills?q=jobautopilot"
fi
