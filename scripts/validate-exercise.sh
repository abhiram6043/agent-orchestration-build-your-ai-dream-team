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
require_grep '"terminal.integrated.copyOnSelection": true' .devcontainer/devcontainer.json "Terminal copies selected text automatically"
require_grep '"terminal.integrated.rightClickBehavior": "copyPaste"' .devcontainer/devcontainer.json "Terminal right-click supports copy/paste"
require_grep '"terminal.integrated.enableMultiLinePasteWarning": false' .devcontainer/devcontainer.json "Terminal multiline paste warning is disabled"
require_grep '"task.allowAutomaticTasks": "on"' .devcontainer/devcontainer.json "Automatic folder-open task is enabled"
require_grep '"runOn": "folderOpen"' .vscode/tasks.json "Folder-open task displays the final terminal"

require_grep 'https://gh.io/copilot-install' .devcontainer/postCreate.sh "Copilot CLI installs with official install script"
require_grep 'copilot --version' .devcontainer/postCreate.sh "Copilot CLI install is smoke tested"
require_grep 'copilot --allow-all --enable-all-github-mcp-tools' .devcontainer/postCreate.sh "postCreate guidance enables all GitHub MCP tools"
require_grep 'exec copilot --allow-all --enable-all-github-mcp-tools' .devcontainer/postStart.sh "Folder-open terminal starts Copilot CLI with all GitHub MCP tools"
for step_file in .github/steps/1-step.md .github/steps/2-step.md .github/steps/3-step.md .github/steps/4-step.md; do
  require_grep 'copilot --allow-all --enable-all-github-mcp-tools' "$step_file" "$step_file starts Copilot CLI with all GitHub MCP tools"
  require_grep '^> \[!NOTE\]$' "$step_file" "$step_file includes a left-aligned NOTE before the launch command"
  require_grep 'Copy and paste this prompt into the Copilot CLI interactive mode' "$step_file" "$step_file uses Copilot CLI for git operations"
  require_grep '^[[:space:]]*> !\[Static Badge\]\(https://img\.shields\.io/badge/-Prompt-text\?style=social&logo=github%20copilot\)$' "$step_file" "$step_file uses the Copilot prompt badge"
  require_grep '^[[:space:]]*> ```prompt$' "$step_file" "$step_file uses quoted prompt fences"
done
for step_file in .github/steps/2-step.md .github/steps/3-step.md .github/steps/4-step.md; do
  require_grep 'run `/agent`, select \*\*Orchestrator\*\*' "$step_file" "$step_file has learners select the Orchestrator with /agent"
done
require_grep 'Ask the Planner to create an implementation plan for the Project Pulse dashboard\. Save the plan in docs/project-pulse-plan\.md\.' .github/steps/2-step.md "Step 2 uses the Orchestrator-to-Planner prompt"
if grep -R '^[[:space:]]*git \\(add\\|commit\\|push\\)' .github/steps; then
  fail "Step files should not include raw git add, commit, or push commands"
else
  pass "Step files avoid raw git add, commit, and push commands"
fi
if grep -q 'npm install -g @github/copilot' .devcontainer/postCreate.sh; then
  fail "postCreate.sh should not install Copilot CLI with npm"
else
  pass "postCreate.sh avoids npm global install"
fi

for step in 1 2 3 4; do
  file=".github/workflows/${step}-step.yml"
  require_grep 'github\.event\.created == false' "$file" "Step $step skips branch-creation pushes"
  require_grep "github\\.event\\.head_commit\\.message != 'Initial commit'" "$file" "Step $step skips template initial commit"
  require_grep 'uses: skills/action-keyphrase-checker@v2' "$file" "Step $step uses the keyphrase checker action"
  require_grep 'uses: skills/exercise-toolkit/actions/file-exists@v0\.9\.3' "$file" "Step $step uses the file-exists action"
done
if grep -R 'grep -' .github/workflows; then
  fail "Workflow keyphrase checks should use skills/action-keyphrase-checker@v2 instead of inline grep"
else
  pass "Workflow keyphrase checks use skills/action-keyphrase-checker@v2 instead of inline grep"
fi
if grep -RE 'run:.*(test[[:space:]]+-[ef]|\[[[:space:]]+-[ef][[:space:]]|stat[[:space:]]|ls[[:space:]])|^[[:space:]]*(test[[:space:]]+-[ef]|\[[[:space:]]+-[ef][[:space:]]|stat[[:space:]]|ls[[:space:]])' .github/workflows; then
  fail "Workflow file-existence checks should use skills/exercise-toolkit/actions/file-exists@v0.9.3"
else
  pass "Workflow file-existence checks use skills/exercise-toolkit/actions/file-exists@v0.9.3"
fi

declare -a learner_files=(
  "docs/agent-team.md"
  "docs/project-pulse-plan.md"
  "docs/final-handoff.md"
  "app/index.html"
  "app/styles.css"
  "app/project-data.json"
)

tracked_learner_files="$(git ls-files "${learner_files[@]}" || true)"
if [ -z "$tracked_learner_files" ]; then
  pass "Learner answer files are not tracked in the template"
else
  fail "Learner answer files are tracked in the template: $tracked_learner_files"
fi

require_file .github/project-pulse-brief.md
if [ -e orchestration ]; then
  fail "orchestration directory should not exist in the template"
else
  pass "orchestration directory is not present in the template"
fi

require_grep 'docs/agent-team.md' .github/workflows/1-step.yml "Step 1 watches docs/agent-team.md"
require_grep 'docs/project-pulse-plan.md' .github/workflows/2-step.yml "Step 2 watches docs/project-pulse-plan.md"
require_grep 'app/\*\*' .github/workflows/3-step.yml "Step 3 watches app outputs"
require_grep 'docs/final-handoff.md' .github/workflows/4-step.yml "Step 4 watches docs/final-handoff.md"
require_grep 'Project Pulse' README.md "README explains Project Pulse story"

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
