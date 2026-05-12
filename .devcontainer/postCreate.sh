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

if [ ! -f orchestration/agent-roles.md ]; then
  cat > orchestration/agent-roles.md <<'EOF'
# Agent roles

Replace this starter text with a role map for the four-agent orchestration workflow.

Include:

- each agent name
- the target model for each agent
- the responsibility of each agent
- where the agent definition lives under the repository agent folder
- a note that you are completing the exercise with the Copilot CLI in a Codespace
EOF
fi

echo ""
echo "Setup complete."
echo "Open the integrated terminal and run: copilot"
echo "If prompted, use /login inside Copilot CLI."
