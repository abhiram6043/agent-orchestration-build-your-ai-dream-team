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

python3 -m json.tool .vscode/launch.json >/dev/null
pass ".vscode/launch.json parses as JSON"

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
require_grep '"name": "Run Project Pulse Dashboard"' .vscode/launch.json "Dashboard launch configuration has the expected name"
require_grep '"command": "python3 -m http.server 5500"' .vscode/launch.json "Dashboard launch configuration starts a static server"
require_grep '"uriFormat": "http://localhost:%s/app/index.html"' .vscode/launch.json "Dashboard launch configuration opens app/index.html"
require_grep '"serverReadyAction"' .vscode/launch.json "Dashboard launch configuration opens the browser when ready"

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
require_grep 'Ask the Planner to create an implementation plan for the Project Pulse dashboard\.' .github/steps/2-step.md "Step 2 asks the Orchestrator to involve the Planner"
require_grep 'Save the plan in docs/project-pulse-plan\.md\.' .github/steps/2-step.md "Step 2 saves the Planner output"
require_grep 'include a \.dashboard selector' .github/steps/3-step.md "Step 3 prompt makes dashboard CSS deterministic"
require_grep 'top-level "projects" key' .github/steps/3-step.md "Step 3 prompt makes project data deterministic"
require_grep 'name, owner, status, recentActivity, and priority' .github/steps/3-step.md "Step 3 prompt makes visible project fields deterministic"
require_grep 'Run Project Pulse Dashboard' .github/steps/3-step.md "Step 3 explains how to run the dashboard"
require_grep 'app/index.html' .github/steps/3-step.md "Step 3 launch guidance references the running app"
require_grep 'lowercase word "validation"' .github/steps/4-step.md "Step 4 prompt makes validation wording deterministic"
require_grep 'lowercase word "handoff"' .github/steps/4-step.md "Step 4 prompt makes handoff wording deterministic"
require_grep 'Run Project Pulse Dashboard' .github/steps/4-step.md "Step 4 handoff includes the launch configuration"
require_grep '\.vscode/launch\.json' .github/steps/4-step.md "Step 4 handoff includes the launch file"
if awk '
  /^[[:space:]]*> ```prompt$/ { in_prompt = 1; next }
  in_prompt && /^[[:space:]]*> ```$/ { in_prompt = 0; next }
  in_prompt && length($0) > 100 { print FILENAME ":" FNR ":" length($0) ":" $0; found = 1 }
  END { exit found }
' .github/steps/*.md; then
  pass "Prompt text lines avoid horizontal scrolling"
else
  fail "Prompt text lines should be wrapped to avoid horizontal scrolling"
fi
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
require_grep '\.vscode/launch\.json' .github/workflows/3-step.yml "Step 3 watches and checks the launch configuration"
require_grep 'docs/final-handoff.md' .github/workflows/4-step.yml "Step 4 watches docs/final-handoff.md"
require_grep 'Run Project Pulse Dashboard' .github/workflows/3-step.yml "Step 3 checks the launch configuration name"
require_grep 'python3 -m http.server 5500' .github/workflows/3-step.yml "Step 3 checks the launch command"
require_grep 'keyphrase: name' .github/workflows/3-step.yml "Step 3 checks project name data"
require_grep 'recentActivity' .github/workflows/3-step.yml "Step 3 checks recent activity data"
require_grep 'priority' .github/workflows/3-step.yml "Step 3 checks priority data"
require_grep 'Run Project Pulse Dashboard' .github/workflows/4-step.yml "Step 4 checks the handoff references the launch configuration"
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
