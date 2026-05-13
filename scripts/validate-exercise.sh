#!/usr/bin/env bash
set -euo pipefail

failures=0

fail() {
  echo "FAIL: $*"
  failures=$((failures + 1))
}

pass() {
  echo "PASS: $*"
}

require_file() {
  local file="$1"
  if [ -f "$file" ]; then
    pass "$file exists"
  else
    fail "$file is missing"
  fi
}

require_executable() {
  local file="$1"
  if [ -x "$file" ]; then
    pass "$file is executable"
  else
    fail "$file is not executable"
  fi
}

require_grep() {
  local pattern="$1"
  local file="$2"
  local description="$3"
  if grep -Eq "$pattern" "$file"; then
    pass "$description"
  else
    fail "$description"
  fi
}

for file in .github/workflows/*.yml; do
  ruby -e "require 'yaml'; YAML.load_file(ARGV.fetch(0))" "$file" >/dev/null
  pass "$file parses as YAML"
done

python3 -m json.tool .devcontainer/devcontainer.json >/dev/null
pass ".devcontainer/devcontainer.json parses as JSON"

python3 -m json.tool .vscode/tasks.json >/dev/null
pass ".vscode/tasks.json parses as JSON"

bash -n .devcontainer/postCreate.sh
pass ".devcontainer/postCreate.sh parses as shell"

bash -n .devcontainer/postStart.sh
pass ".devcontainer/postStart.sh parses as shell"

require_executable .devcontainer/postCreate.sh
require_executable .devcontainer/postStart.sh

require_grep '"waitFor": "postCreateCommand"' .devcontainer/devcontainer.json "Codespace waits for postCreate setup"
require_grep '"terminal.integrated.defaultLocation": "editor"' .devcontainer/devcontainer.json "Terminal default location is editor"
require_grep '"task.allowAutomaticTasks": "on"' .devcontainer/devcontainer.json "Automatic folder-open task is enabled"
require_grep '"runOn": "folderOpen"' .vscode/tasks.json "Folder-open task displays the final terminal"

require_grep 'https://gh.io/copilot-install' .devcontainer/postCreate.sh "Copilot CLI installs with official install script"
require_grep 'copilot --version' .devcontainer/postCreate.sh "Copilot CLI install is smoke tested"
require_grep 'copilot --allow-all' .devcontainer/postCreate.sh "postCreate guidance uses copilot --allow-all"
require_grep 'exec copilot --allow-all' .devcontainer/postStart.sh "Folder-open terminal starts Copilot CLI with --allow-all"
require_grep 'copilot --allow-all' .github/steps/1-step.md "Step 1 starts Copilot CLI with --allow-all"
if grep -q 'npm install -g @github/copilot' .devcontainer/postCreate.sh; then
  fail "postCreate.sh should not install Copilot CLI with npm"
else
  pass "postCreate.sh avoids npm global install"
fi

for step in 1 2 3 4; do
  file=".github/workflows/${step}-step.yml"
  require_grep 'github\.event\.created == false' "$file" "Step $step skips branch-creation pushes"
  require_grep "github\\.event\\.head_commit\\.message != 'Initial commit'" "$file" "Step $step skips template initial commit"
done

declare -a learner_files=(
  "orchestration/agent-roles.md"
  "orchestration/planner-handoff.md"
  "orchestration/execution-plan.md"
  "orchestration/final-report.md"
)

tracked_learner_files="$(git ls-files "${learner_files[@]}" || true)"
if [ -z "$tracked_learner_files" ]; then
  pass "Learner answer files are not tracked in the template"
else
  fail "Learner answer files are tracked in the template: $tracked_learner_files"
fi

require_file orchestration/sample-request.md

if command -v copilot >/dev/null 2>&1; then
  copilot --version >/dev/null
  pass "Installed Copilot CLI responds to --version"
else
  echo "SKIP: Copilot CLI is not installed in this environment"
fi

if [ "$failures" -gt 0 ]; then
  echo "$failures validation check(s) failed."
  exit 1
fi

echo "All exercise validation checks passed."
