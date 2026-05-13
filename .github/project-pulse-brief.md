# Project Pulse dashboard brief

Mona's team needs a lightweight Project Pulse dashboard for contributors.

The dashboard should help the team quickly understand:

- which projects are active
- each project's current status
- recent activity
- priority or risk level
- a short contributor-friendly summary

The final dashboard should be a small static app with:

- `app/index.html`
- `app/styles.css`
- `app/project-data.json`

Use the custom agents in `.github/agents/`:

- The Orchestrator coordinates the work.
- The Planner creates the implementation plan and identifies phases, dependencies, and file ownership.
- The Designer guides layout, information hierarchy, accessibility, and visual design.
- The Coder implements the static dashboard files.

The learner should use GitHub Copilot CLI to practice the orchestration flow instead of doing all work as a single undifferentiated prompt.
