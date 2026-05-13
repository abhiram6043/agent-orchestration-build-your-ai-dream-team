## Step 3: Map work to specialist agents

Nice! Your Orchestrator now has a Planner handoff. :tada:

Next, you will turn planning output into an execution plan that assigns work to specialist agents.

### How the Orchestrator creates phases

The Orchestrator parses the Planner result into phases:

- Tasks with no overlapping files and no data dependency can run in **parallel**.
- Tasks that modify the same file or need earlier output must run **sequentially**.
- Each delegated task should have explicit file scope so agents do not conflict.

Delegation prompts should describe **what** outcome is needed and **which files** are in scope. Avoid telling the specialist exactly how to solve the task.

### :keyboard: Activity: Create the execution plan

1. Return to your Codespace terminal.

1. Start Copilot CLI if needed:

   ```bash
   copilot --allow-all
   ```

1. Ask Copilot CLI to review your Planner handoff:

   ```prompt
   Review orchestration/planner-handoff.md and help me create an Orchestrator execution plan with phases, specialist agent assignments, file scopes, and parallel or sequential labels.
   ```

1. Create `orchestration/execution-plan.md`.

1. Your execution plan should include:

   - At least `Phase 1` and `Phase 2`.
   - Tasks assigned to Coder and Designer.
   - `Files:` lines for delegated tasks.
   - Clear `PARALLEL` or `SEQUENTIAL` labels.
   - A short note explaining how file conflicts are avoided.

1. Save the file.

1. Commit and push your work:

   ```bash
   git add orchestration/execution-plan.md
   git commit -m "Create orchestrator execution plan"
   git push
   ```

1. Mona will check your work and post the next lesson.

<details>
<summary>Having trouble? 🤷</summary><br/>

- Make sure you updated `orchestration/execution-plan.md`.
- Include `Phase 1`, `Phase 2`, `Coder`, `Designer`, `Files:`, `parallel`, and `sequential`.
- Make sure you pushed your commit.

</details>
