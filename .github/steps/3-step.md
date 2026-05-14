## Step 3: Build the Project Pulse dashboard

Nice! You have a plan. :tada:

Now you will use the Orchestrator to delegate design and coding work so Project Pulse becomes a real static dashboard.

### What should the dashboard include?

The dashboard should help contributors quickly understand Mona's team projects. It should include:

- A clear Project Pulse title.
- Cards or sections for multiple projects.
- Status, recent activity, and priority or risk information.
- Accessible markup and readable styling.
- Data in `app/project-data.json`.

### :keyboard: Activity: Delegate design and coding work

1. Return to your Codespace terminal.

1. Start Copilot CLI if needed:

> [!NOTE]
> If you are not already in the Copilot CLI interactive mode, run this command.

   ```bash
   copilot --allow-all --enable-all-github-mcp-tools
   ```

1. Ask the Orchestrator to delegate the build:

   ```prompt
   Use the Orchestrator agent pattern and the plan in docs/project-pulse-plan.md. Delegate visual and accessibility decisions to Designer and implementation to Coder. Build the Project Pulse dashboard in app/index.html, app/styles.css, and app/project-data.json.
   ```

1. Review the generated files.

1. Make sure:

   - `app/index.html` includes `Project Pulse`.
   - `app/index.html` links to `styles.css`.
   - `app/index.html` loads or references `project-data.json`.
   - `app/styles.css` styles the dashboard layout.
   - `app/project-data.json` contains project data.

1. Ask Copilot CLI to stage, commit, and push your work. Copy and paste this prompt into the Copilot CLI interactive mode:

   ```prompt
   Stage app/index.html, app/styles.css, and app/project-data.json. Commit them with the message "Build the Project Pulse dashboard", and push the commit.
   ```

1. Mona will check your work and post the next lesson.

<details>
<summary>Having trouble? 🤷</summary><br/>

- Make sure all three app files exist.
- Make sure `app/index.html` references `styles.css` and `project-data.json`.
- Make sure `app/project-data.json` includes project data.
- Make sure you pushed your commit.

</details>
