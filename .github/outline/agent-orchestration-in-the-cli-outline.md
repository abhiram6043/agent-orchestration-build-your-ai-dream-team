# Exercise Outline: Agent Orchestration in the GitHub Copilot CLI

## Exercise overview

- **Title**: Agent Orchestration in the GitHub Copilot CLI
- **Repository name**: `agent-orchestration-in-the-cli`
- **Audience**: Developers who have basic GitHub and GitHub Copilot familiarity and want to learn how to coordinate specialist agents from the terminal.
- **Experience level**: Intermediate
- **Estimated duration**: Less than one hour
- **Primary environment**: GitHub Codespaces
- **Primary interface**: GitHub Copilot CLI in the integrated terminal

## Summary

Learners use GitHub Copilot CLI in a Codespace to practice an agent orchestration workflow. They define a four-agent model, create a Planner handoff, map the planned work to Coder and Designer tasks, and write a final Orchestrator report that explains phase ordering, parallel work, file ownership, and validation.

The exercise uses a guided simulation with repository artifacts so learners can practice orchestration patterns even if every named model is not available in their account.

## Learning objectives

By the end of this exercise, learners will be able to:

1. Explain the responsibility of an Orchestrator agent in a multi-agent workflow.
1. Describe the Planner, Coder, and Designer specialist roles.
1. Identify model assignments for the exercise agents:
   - Orchestrator: Opus 4.7
   - Planner: Opus 4.7
   - Coder: GPT-5.5
   - Designer: Gemini 3.1 Pro
1. Use GitHub Copilot CLI in a Codespace terminal to inspect and update repository artifacts.
1. Convert a request into planning phases with file assignments and dependencies.
1. Decide which tasks can run in parallel and which must run sequentially.
1. Write delegation prompts that describe desired outcomes, assigned files, and agent ownership without over-prescribing implementation details.
1. Summarize an orchestrated result with validation notes and a final handoff.

## Prerequisites

- A GitHub account.
- Access to GitHub Codespaces.
- Access to GitHub Copilot and GitHub Copilot CLI.
- Basic familiarity with repositories, commits, and Markdown.
- Comfort working in an integrated terminal.

## What learners will build

Learners will inspect repository agent definitions and complete an `orchestration/` workspace.

Repository agent definitions:

- `.github/agents/orchestrator.agent.md`
- `.github/agents/planner.agent.md`
- `.github/agents/coder.agent.md`
- `.github/agents/designer.agent.md`

Learner artifacts:

- `agent-roles.md`: the agent role and model map, created by `postCreate.sh` as the first learner artifact.
- `planner-handoff.md`: a Planner request and planning response structure, created by the learner in Step 2.
- `execution-plan.md`: an Orchestrator execution plan with phase sequencing and agent assignments, created by the learner in Step 3.
- `final-report.md`: an Orchestrator report that summarizes coordination, validation, and handoff, created by the learner in Step 4.

## Codespaces and dev container setup

The bootstrapped repository should include:

- `.devcontainer/devcontainer.json`
- `.devcontainer/postCreate.sh`
- `.devcontainer/postStart.sh`

The dev container should:

- Use a standard development container image suitable for shell, Git, GitHub CLI, Markdown, and light scripting.
- Install or verify GitHub Copilot CLI availability.
- Verify GitHub CLI availability.
- Keep the integrated terminal prominent for the exercise.
- Configure the workspace so learners begin with `copilot --allow-all` from the terminal.
- Print a short orientation message after create/start events.
- Avoid requiring learners to install local desktop tools outside Codespaces.

## Story

Mona is preparing a terminal-first development workflow for a team that wants to use multiple AI agents safely. The team needs an Orchestrator that can collect a plan, split work across specialist agents, prevent file conflicts, and validate the final result. The learner will help Mona design and document the workflow by using GitHub Copilot CLI inside a Codespace.

## Step 1: Start in the Copilot CLI Codespace

### Theory

GitHub Copilot CLI brings Copilot into the terminal so developers can work with an agentic assistant without leaving the command line. In this exercise, Codespaces provides the consistent development environment and the integrated terminal is the main workspace.

The four agents in this exercise are:

| Agent | Model | Responsibility |
| --- | --- | --- |
| Orchestrator | Opus 4.7 | Coordinates the request, delegates to specialists, sequences phases, prevents file conflicts, integrates results, and validates the outcome. |
| Planner | Opus 4.7 | Researches context and produces a practical implementation plan with steps, file assignments, dependencies, edge cases, and open questions. |
| Coder | GPT-5.5 | Implements code-oriented tasks and fixes, following existing project patterns and quality expectations. |
| Designer | Gemini 3.1 Pro | Handles UI/UX direction, usability, accessibility, and visual design choices. |

### Activity

1. Open the exercise in Codespaces.
1. Open the integrated terminal in the editor area.
1. Start GitHub Copilot CLI with `copilot --allow-all`.
1. Ask Copilot CLI to inspect `.github/agents/` and summarize the repository agent definitions.
1. Update `orchestration/agent-roles.md` so it captures the four agents, requested models, responsibilities, and the CLI-first workflow.
1. Commit and push the change.

### Action trigger

- Event: `push`
- Path filter: `orchestration/agent-roles.md`

### Grading checks

- `orchestration/agent-roles.md` exists.
- `.github/agents/orchestrator.agent.md`, `.github/agents/planner.agent.md`, `.github/agents/coder.agent.md`, and `.github/agents/designer.agent.md` exist.
- The file includes `Orchestrator`, `Planner`, `Coder`, and `Designer`.
- The file includes `Opus 4.7`, `GPT-5.5`, and `Gemini 3.1 Pro`.
- The file references GitHub Copilot CLI and Codespaces.

### Transition

After the learner maps the agents and models, the exercise introduces the Planner handoff the Orchestrator needs before delegation.

## Step 2: Create the Planner handoff

### Theory

An Orchestrator should not jump directly into implementation. It first asks a Planner to research the request and return a plan that can be turned into execution phases. A useful Planner handoff includes the user request, relevant context, expected deliverables, file assignments, dependencies, edge cases, validation expectations, and open questions.

### Activity

1. Use Copilot CLI to read the sample request in `orchestration/sample-request.md`.
1. Ask Copilot CLI to draft a Planner handoff for the sample request.
1. Create `orchestration/planner-handoff.md` with:
   - The original user request.
   - Context the Planner should inspect.
   - Expected output format.
   - Required file assignments.
   - Dependency and edge-case prompts.
   - Validation expectations.
1. Commit and push the change.

### Action trigger

- Event: `push`
- Path filter: `orchestration/planner-handoff.md`

### Grading checks

- `orchestration/planner-handoff.md` exists.
- The file includes `Planner`.
- The file includes `file assignments`.
- The file includes `dependencies`.
- The file includes `edge cases`.
- The file includes `validation`.

### Transition

After the Planner handoff is ready, the learner turns planning output into an execution plan that the Orchestrator can run.

## Step 3: Map work to specialist agents

### Theory

The Orchestrator parses the Planner result into phases. Tasks with no overlapping files and no data dependency can run in parallel. Tasks that modify the same file or depend on earlier output must be sequential. Explicit file ownership helps avoid conflicts when delegating work to Coder and Designer.

Delegation prompts should describe the outcome and file scope, not the exact implementation technique. This gives each specialist room to solve the task while keeping the Orchestrator in control of boundaries.

### Activity

1. Use Copilot CLI to review `orchestration/planner-handoff.md`.
1. Ask Copilot CLI to create an Orchestrator execution plan.
1. Create `orchestration/execution-plan.md` with:
   - At least two phases.
   - Agent assignments for Coder and Designer.
   - File scope for each task.
   - Clear parallel or sequential labels.
   - A note explaining how conflicts are avoided.
1. Commit and push the change.

### Action trigger

- Event: `push`
- Path filter: `orchestration/execution-plan.md`

### Grading checks

- `orchestration/execution-plan.md` exists.
- The file includes `Phase 1` and `Phase 2`.
- The file includes `Coder` and `Designer`.
- The file includes `Files:`.
- The file includes `parallel` or `PARALLEL`.
- The file includes `sequential` or `SEQUENTIAL`.

### Transition

After the work is assigned to specialists, the learner completes the final Orchestrator report.

## Step 4: Run the orchestration simulation

### Theory

The Orchestrator is responsible for more than dispatching tasks. It tracks phase progress, waits for dependent work, integrates specialist outputs, validates the result, and reports the final outcome to the user. A strong final report explains what ran, why it ran in that order, what was validated, and what changed.

### Activity

1. Use Copilot CLI to review the previous artifacts.
1. Ask Copilot CLI to draft the final Orchestrator handoff.
1. Create `orchestration/final-report.md` with:
   - A summary of the request.
   - The agents involved.
   - The phase order.
   - Parallel and sequential decisions.
   - Validation notes.
   - A final user-facing result.
1. Commit and push the change.

### Action trigger

- Event: `push`
- Path filter: `orchestration/final-report.md`

### Grading checks

- `orchestration/final-report.md` exists.
- The file includes `Orchestrator`, `Planner`, `Coder`, and `Designer`.
- The file includes `validation`.
- The file includes `parallel`.
- The file includes `sequential`.
- The file includes `final result` or `handoff`.

### Transition

After the final report passes, the exercise completes and points learners to additional Copilot CLI and multi-agent workflow resources.

## Review content

The review step should congratulate learners for completing a terminal-first agent orchestration workflow and recap that they:

- Used GitHub Copilot CLI in Codespaces.
- Mapped agent roles and model assignments.
- Wrote a Planner handoff.
- Converted work into phases and specialist assignments.
- Prevented file conflicts through explicit file scopes.
- Produced a final Orchestrator report with validation.

### What's next

Suggested next steps:

- Try the same orchestration pattern on a real feature in one of your repositories.
- Use `/agent`, `/model`, `/tasks`, and `/fleet` in GitHub Copilot CLI to explore agent and subagent workflows.
- Add repository instructions that explain when to use Planner, Coder, Designer, and Orchestrator roles.
- Explore GitHub Codespaces dev container configuration for repeatable CLI-first development environments.

## References

- GitHub Copilot CLI documentation: https://docs.github.com/copilot/concepts/agents/about-copilot-cli
- GitHub Copilot CLI install and usage documentation from the CLI README.
- GitHub Copilot CLI help topics: `/agent`, `/model`, `/tasks`, `/fleet`, `/terminal-setup`, `/init`, `/skills`, and `/mcp`.
- Source multi-agent gist: https://gist.github.com/burkeholland/0e68481f96e94bbb98134fa6efd00436#file-three-agent-md
- GitHub Codespaces dev containers: https://docs.github.com/en/codespaces/setting-up-your-project-for-codespaces/introduction-to-dev-containers
- Dev Container JSON reference: https://containers.dev/implementors/json_reference/
- GitHub Actions events that trigger workflows: https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows

## Bootstrap notes

- Use push-based triggers for every learner step to keep the flow simple in Codespaces.
- The template should not commit learner answer files that match Step 1-4 path filters, because copied repositories treat the template contents as an initial push.
- `postCreate.sh` should create only the Step 1 starter file so committing all new local files in Step 1 cannot trigger later step workflows early.
- The dev container scripts should be idempotent and should not overwrite learner work.
- Keep step theory sections short and focused. Put longer references in "Read more" links.
- Confirm all step instructions tell learners to work through GitHub Copilot CLI in the integrated terminal.
