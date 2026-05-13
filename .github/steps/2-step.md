## Step 2: Plan Project Pulse with the Orchestrator and Planner

Great work meeting the agent team! :sparkles:

Now you will ask the Orchestrator to involve the Planner and create an implementation plan for Mona's Project Pulse dashboard.

### Why plan before building?

Intermediate agent workflows work best when the Orchestrator asks for a plan before implementation. The Planner should identify the files to create, dependencies between tasks, which work can happen in parallel, and what validation should prove the dashboard is complete.

For Project Pulse, the expected app files are:

- `app/index.html`
- `app/styles.css`
- `app/project-data.json`

### :keyboard: Activity: Create the implementation plan

1. Return to your Codespace terminal.

1. Start Copilot CLI if it is not already running:

> [!NOTE]
> If you are not already in the Copilot CLI interactive mode, run this command.

   ```bash
   copilot --allow-all --enable-all-github-mcp-tools
   ```

1. Ask the Orchestrator to create a plan for Project Pulse:

   ```prompt
   Use the Orchestrator agent pattern. Read .github/project-pulse-brief.md and .github/agents/. Ask the Planner to create an implementation plan for the Project Pulse dashboard. Save the plan in docs/project-pulse-plan.md.
   ```

1. Review `docs/project-pulse-plan.md`.

1. Make sure the plan includes:

   - The Project Pulse goal.
   - Planner involvement.
   - File assignments for `app/index.html`, `app/styles.css`, and `app/project-data.json`.
   - Designer and Coder responsibilities.
   - Dependencies between the files.
   - Parallel or sequential work decisions.
   - Validation expectations.

1. Commit and push your work:

   ```bash
   git add docs/project-pulse-plan.md
   git commit -m "Plan the Project Pulse dashboard"
   git push
   ```

1. Mona will check your work and post the next lesson.

<details>
<summary>Having trouble? 🤷</summary><br/>

- Make sure you created `docs/project-pulse-plan.md`.
- Include `Project Pulse`, `Planner`, `Designer`, `Coder`, the three app files, and `validation`.
- Make sure you pushed your commit.

</details>
