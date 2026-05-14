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

2. Start Copilot CLI if needed:

> [!NOTE]
> If you are not already in the Copilot CLI interactive mode, run this command.

   ```bash
   copilot --allow-all --enable-all-github-mcp-tools
   ```

3. Ask the Orchestrator to validate and summarize the work:

   > ![Static Badge](https://img.shields.io/badge/-Prompt-text?style=social&logo=github%20copilot)
   >
   > ```prompt
   > Use the Orchestrator agent pattern. Review docs/agent-team.md, docs/project-pulse-plan.md, and the files in app/. Validate the Project Pulse dashboard and write a final handoff in docs/final-handoff.md.
   > ```

4. Review `docs/final-handoff.md`.

5. Make sure the handoff includes:

   - Orchestrator, Planner, Designer, and Coder.
   - The final Project Pulse result.
   - The app files that were created.
   - Validation notes.
   - Any next steps or limitations.

6. Ask Copilot CLI to stage, commit, and push your work. Copy and paste this prompt into the Copilot CLI interactive mode:

   > ![Static Badge](https://img.shields.io/badge/-Prompt-text?style=social&logo=github%20copilot)
   >
   > ```prompt
   > Stage docs/final-handoff.md, commit it with the message "Validate and hand off Project Pulse", and push the commit.
   > ```

7. Mona will check your work and complete the exercise.

<details>
<summary>Having trouble? 🤷</summary><br/>

- Make sure you created `docs/final-handoff.md`.
- Include all four agent names.
- Include `Project Pulse`, `validation`, and the app file names.
- Make sure you pushed your commit.

</details>
