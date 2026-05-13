## Step 2: Create the Planner handoff

Great work mapping the agents! :sparkles:

Now you will create the handoff an Orchestrator gives to a Planner before any implementation starts.

### Why start with a Planner?

An Orchestrator should not jump directly into implementation. The first delegation should usually go to a Planner so the team has a clear view of the request, context, file ownership, dependencies, edge cases, and validation expectations.

A useful Planner handoff includes:

- The original user request.
- The context the Planner should inspect.
- The format the Planner should return.
- Expected file assignments.
- Dependencies and edge cases to consider.
- Validation expectations.

### :keyboard: Activity: Draft the Planner handoff

1. Return to your Codespace terminal.

1. Start Copilot CLI if it is not already running:

   ```bash
   copilot --allow-all
   ```

1. Ask Copilot CLI to read the sample request:

   ```prompt
   Read orchestration/sample-request.md and help me draft a Planner handoff for this orchestration exercise.
   ```

1. Create `orchestration/planner-handoff.md`.

1. Your handoff should include:

   - The original user request.
   - The context the Planner should inspect.
   - The expected Planner output format.
   - A request for file assignments.
   - A request to identify dependencies.
   - A request to identify edge cases.
   - A request for validation expectations.

1. Save the file.

1. Commit and push your work:

   ```bash
   git add orchestration/planner-handoff.md
   git commit -m "Create planner handoff"
   git push
   ```

1. Mona will check your work and post the next lesson.

<details>
<summary>Having trouble? 🤷</summary><br/>

- Make sure you updated `orchestration/planner-handoff.md`.
- Include the exact ideas "file assignments", "dependencies", "edge cases", and "validation" in your handoff.
- Make sure you pushed your commit.

</details>
