# Sample request

Mona wants to add a lightweight dashboard to an existing repository. The dashboard should show project status, recent activity, and a short summary for contributors.

The Orchestrator needs to coordinate the work safely:

- Ask the Planner to inspect the request and produce implementation phases.
- Assign code-oriented work to the Coder.
- Assign layout, interaction, and accessibility decisions to the Designer.
- Avoid file conflicts when tasks can run in parallel.
- Sequence tasks when one task depends on another or touches the same file.
- Validate the final result before reporting back to the user.
