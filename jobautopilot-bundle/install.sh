#!/usr/bin/env bash
# install.sh — install all three Job Autopilot skills
set -e

echo "==> Installing Job Autopilot skills..."
clawhub install jobautopilot-search
clawhub install jobautopilot-tailor
clawhub install jobautopilot-submitter
echo ""
echo "All three skills installed."
echo "Run setup next: bash skills/jobautopilot-bundle/setup.sh"
