## Step 1: Start in the Copilot CLI Codespace

Welcome to **Agent Orchestration in the GitHub Copilot CLI**! :robot:

In this exercise, you will use GitHub Copilot CLI from a Codespace terminal to practice a four-agent orchestration workflow.

### What is GitHub Copilot CLI?

GitHub Copilot CLI brings Copilot into your terminal so you can ask for help, inspect files, edit content, run commands, and work through tasks without leaving the command line.

For this exercise, the terminal is the main workspace. Codespaces gives everyone a consistent environment, and Copilot CLI is the interface you will use to complete each activity.

### The four-agent orchestration model

You will practice this agent model:

| Agent | Model | Responsibility |
| --- | --- | --- |
| Orchestrator | Opus 4.7 | Coordinates the request, delegates to specialists, sequences phases, prevents file conflicts, integrates results, and validates the outcome. |
| Planner | Opus 4.7 | Researches context and produces a practical implementation plan with steps, file assignments, dependencies, edge cases, and open questions. |
| Coder | GPT-5.5 | Implements code-oriented tasks and fixes, following existing project patterns and quality expectations. |
| Designer | Gemini 3.1 Pro | Handles UI/UX direction, usability, accessibility, and visual design choices. |

> [!NOTE]
> This exercise is a guided simulation. You will document the orchestration workflow in repository files, even if every named model is not available in your account.

### :keyboard: Activity: Open the Codespace and start Copilot CLI

1. Right-click the button below to open the **Create Codespace** page in a new tab.

   [![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/{{full_repo_name}}?quickstart=1)

1. Confirm the **Repository** field is your copy of the exercise, then select **Create Codespace**.

   - ✅ Your copy: `/{{full_repo_name}}`
   - ❌ Original: `/skills-dev/agent-orchestration-in-the-cli`

1. Wait for the Codespace to finish loading.

1. Open the integrated terminal. If it is not already visible, use **Terminal: Create New Terminal** from the command palette.

1. The Codespace opens a terminal in the editor area and starts GitHub Copilot CLI with broad exercise permissions:

   ```bash
   copilot --allow-all --enable-all-github-mcp-tools
   ```

1. If the CLI is not already running, start it with `copilot --allow-all --enable-all-github-mcp-tools`. If prompted, use `/login` to authenticate.

1. Ask Copilot CLI to inspect the repository agent definitions:

   ```prompt
   Inspect .github/agents/ and summarize the agents I will use in this exercise.
   ```

### :keyboard: Activity: Map the agents

1. Use Copilot CLI to update `orchestration/agent-roles.md` based on the files in `.github/agents/`.

1. Your file should include:

   - The Orchestrator, Planner, Coder, and Designer agents.
   - The model assignment for each agent.
   - A short responsibility for each agent.
   - A reference to the `.github/agents/` files.
   - A note that this exercise is completed with GitHub Copilot CLI in Codespaces.

1. Save the file.

1. From the terminal, commit and push your work:

   ```bash
   git add orchestration/agent-roles.md
   git commit -m "Map orchestration agent roles"
   git push
   ```

1. Mona will check your work and post the next lesson.

<details>
<summary>Having trouble? 🤷</summary><br/>

- Make sure you updated `orchestration/agent-roles.md`.
- Make sure your summary references the `.github/agents/` files.
- Make sure the file includes all four agent names.
- Make sure the file uses the updated models: Opus 4.7, GPT-5.5, and Gemini 3.1 Pro.
- Make sure you pushed your commit.

</details>
