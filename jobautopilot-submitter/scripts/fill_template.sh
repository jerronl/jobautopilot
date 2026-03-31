#!/bin/bash
# Fill script template - with variant option matching integrated
# Based on snapshot: <timestamp>, targetId: <TARGET_ID>
# Fields to fill this run (from check_required_fields unfilled): <fields_list>
PROFILE="submit"
TARGET_ID="<TARGET_ID>"
ERRORS=()

# Load variant matching helpers
source "$HOME/.openclaw/workspace/job_sub_agent/scripts/match_variant_options.sh"

check() {
  local result=$1
  local ref=$2
  local label=$3
  if echo "$result" | grep -q '"ok":false'; then
    ERRORS+=("[$ref] $label: action failed, response: $result")
    echo "FAIL: $label"
    return 1
  fi
  echo "OK: $label"
  return 0
}

# Ref extraction helpers (snapshot is plain text, must use sed not jq)
get_ref() {
  local snap="$1"; local label="$2"
  echo "$snap" | grep -F "\"$label\"" | sed 's/.*\[ref=\([^]]*\)\].*/\1/' | head -1
}
get_ref_fuzzy() {
  local snap="$1"; local keyword="$2"
  echo "$snap" | grep -i "$keyword" | sed 's/.*\[ref=\([^]]*\)\].*/\1/' | head -1
}
count_label() {
  local snap="$1"; local label="$2"
  echo "$snap" | grep -cF "\"$label\""
}

# Step 1: snapshot to get current refs
SNAP=$(openclaw browser --browser-profile $PROFILE snapshot \
  --target-id $TARGET_ID --limit 500 --efficient)

# --- Fill logic start ---
# <auto_generated_fill_logic>
# --- Fill logic end ---

# Final: unified error report
if [ ${#ERRORS[@]} -gt 0 ]; then
  echo ""
  echo "===== FAILED — the following steps need attention ====="
  for ERR in "${ERRORS[@]}"; do
    echo "  - $ERR"
  done
  exit 1
else
  echo ""
  echo "===== ALL STEPS COMPLETED SUCCESSFULLY ====="
  exit 0
fi
