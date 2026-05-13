## Step 4: Validate and hand off the dashboard

You built Project Pulse. Now finish the orchestration loop. :rocket:

### What should the Orchestrator report?

The Orchestrator is responsible for more than dispatching work. It should explain:

- Which agents participated.
- How the plan was used.
- What Designer contributed.
- What Coder implemented.
- What validation was completed.
- What the final result is.

### :keyboard: Activity: Validate and summarize

1. Return to your Codespace terminal.

1. Start Copilot CLI if needed:

> [!NOTE]
> If you are not already in the Copilot CLI interactive mode, run this command.

   ```bash
   copilot --allow-all --enable-all-github-mcp-tools
   ```

1. Ask the Orchestrator to validate and summarize the work:

   ```prompt
   Use the Orchestrator agent pattern. Review docs/agent-team.md, docs/project-pulse-plan.md, and the files in app/. Validate the Project Pulse dashboard and write a final handoff in docs/final-handoff.md.
   ```

1. Review `docs/final-handoff.md`.

1. Make sure the handoff includes:

   - Orchestrator, Planner, Designer, and Coder.
   - The final Project Pulse result.
   - The app files that were created.
   - Validation notes.
   - Any next steps or limitations.

1. Commit and push your work:

   ```bash
   git add docs/final-handoff.md
   git commit -m "Validate and hand off Project Pulse"
   git push
   ```

1. Mona will check your work and complete the exercise.

<details>
<summary>Having trouble? 🤷</summary><br/>

- Make sure you created `docs/final-handoff.md`.
- Include all four agent names.
- Include `Project Pulse`, `validation`, and the app file names.
- Make sure you pushed your commit.

</details>
