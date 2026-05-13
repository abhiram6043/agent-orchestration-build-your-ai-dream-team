## Step 4: Run the orchestration simulation

You have an execution plan. Now it is time to finish the Orchestrator handoff. :rocket:

### What the Orchestrator reports

The Orchestrator is responsible for more than dispatching tasks. It should:

- Track phase progress.
- Wait for dependent work.
- Integrate specialist outputs.
- Validate that the result hangs together.
- Report the final outcome clearly to the user.

A strong final report explains what ran, why it ran in that order, what was validated, and what changed.

### :keyboard: Activity: Write the final report

1. Return to your Codespace terminal.

1. Start Copilot CLI if needed:

> [!NOTE]
> If you are not already in the Copilot CLI interactive mode, run this command.

   ```bash
   copilot --allow-all --enable-all-github-mcp-tools
   ```

1. Ask Copilot CLI to review the artifacts you created:

   ```prompt
   Review orchestration/agent-roles.md, orchestration/planner-handoff.md, and orchestration/execution-plan.md. Help me draft the final Orchestrator report with phase order, parallel and sequential decisions, validation notes, and a final result.
   ```

1. Create `orchestration/final-report.md`.

1. Your final report should include:

   - The original request summary.
   - The Orchestrator, Planner, Coder, and Designer.
   - The phase order.
   - Parallel decisions.
   - Sequential decisions.
   - Validation notes.
   - A final result or handoff.

1. Save the file.

1. Commit and push your work:

   ```bash
   git add orchestration/final-report.md
   git commit -m "Write final orchestration report"
   git push
   ```

1. Mona will check your work and complete the exercise.

<details>
<summary>Having trouble? 🤷</summary><br/>

- Make sure you updated `orchestration/final-report.md`.
- Include all four agent names.
- Include the words `validation`, `parallel`, `sequential`, and either `final result` or `handoff`.
- Make sure you pushed your commit.

</details>
