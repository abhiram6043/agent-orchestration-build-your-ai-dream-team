#!/usr/bin/env bash
set -euo pipefail

echo "Setting up Agent Orchestration in the GitHub Copilot CLI..."

if ! command -v gh >/dev/null 2>&1; then
  echo "GitHub CLI was not found. The dev container image should include gh."
  exit 1
fi

if ! command -v copilot >/dev/null 2>&1; then
  echo "Installing GitHub Copilot CLI with npm..."
  npm install -g @github/copilot
else
  echo "GitHub Copilot CLI is already installed."
fi

mkdir -p orchestration

echo ""
echo "Setup complete."
echo "Open the integrated terminal and run: copilot"
echo "If prompted, use /login inside Copilot CLI."
