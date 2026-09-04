# Project Pulse Implementation Plan

## Goal

Build Mona's lightweight static **Project Pulse** dashboard for contributors.
It should make active projects, owners, current status, recent activity,
priority or risk, and contributor-friendly summaries easy to scan. The first
view must be a polished dashboard with project cards, status badges, and
readable spacing rather than a server directory listing.

## Coordinated Responsibilities

- **Orchestrator:** Coordinates the phases, assigns non-overlapping file scopes,
  manages dependencies, integrates the specialist work, and verifies the final
  dashboard.
- **Planner:** Researches the repository and brief, turns requirements into
  these phases, identifies dependencies and edge cases, and defines validation.
- **Designer:** Owns the information hierarchy, accessibility, responsive
  behavior, and visual direction. The Designer guides project cards, status
  badges, priority treatment, readable spacing, contrast, and the `.dashboard`
  and `.project-card` hooks.
- **Coder:** Implements the assigned static files with deterministic,
  testable behavior and validates the runnable app. The Coder owns the HTML,
  CSS, JSON data, and launch configuration assignments below.

## Implementation Phases and File Assignments

1. **Plan and design contract:** The Planner confirms the brief and the
   Orchestrator assigns the Designer the visual and interaction requirements.
   No implementation files are changed in this phase.
2. **Create the data contract:** The Coder creates `app/project-data.json` with
   a top-level `projects` array. Every project object includes `name`, `owner`,
   `status`, `recentActivity`, and `priority`.
3. **Build the dashboard structure:** The Coder creates `app/index.html`, using
   the data contract to present project names, owners, statuses, recent
   activity, priorities, and summaries with accessible structure and the
   `.dashboard` and `.project-card` hooks.
4. **Apply the visual design:** The Coder creates `app/styles.css` from the
   Designer's direction, including polished cards, status badges, priority
   treatment, readable spacing, contrast, rounded corners, shadows, and
   responsive behavior.
5. **Make it runnable:** The Coder creates `.vscode/launch.json` with strict
   JSON and a `Run Project Pulse Dashboard` configuration. It serves from
   `${workspaceFolder}/app`, uses `cwd` set to that path, and opens `index.html`.
6. **Integrate and validate:** The Orchestrator checks that the data, markup,
   styling, and launch configuration agree, then reports the final result and
   any remaining risks.

## Dependencies and Parallel Work

- `app/project-data.json` is the data contract for `app/index.html`; the Coder
  must define it before wiring the page to project data.
- The Designer's layout and accessibility direction must precede final
  `app/styles.css` implementation, while the Coder owns the CSS file.
- `app/index.html` and `app/styles.css` can be developed in parallel after the
  Designer defines shared hooks and the HTML structure is agreed, but their
  integration check must run afterward.
- The launch configuration can be prepared in parallel with the data and UI
  work because it has a separate file scope, but final launch validation must
  happen after `app/index.html` exists.
- Integration and end-to-end validation run sequentially after all four target
  files are complete.

## Validation Expectations

- Confirm all four assigned files exist and remain within their assigned scopes.
- Parse `app/project-data.json` as strict JSON and verify the top-level
  `projects` array and required fields on each project.
- Check `app/index.html` for Project Pulse content, project cards, status and
  priority information, accessible structure, and the `.dashboard` and
  `project-card` hooks.
- Check `app/styles.css` for `.dashboard`, `.project-card`, `border-radius`,
  `box-shadow`, readable spacing, contrast, and responsive layout rules.
- Parse `.vscode/launch.json` as strict JSON and verify the exact launch name,
  app working directory, and `index.html` launch target.
- Run the configured dashboard and confirm the browser opens the Project Pulse
  UI from `app/index.html`, not a directory listing.
- The Orchestrator reviews the integrated result and reports validation status,
  blockers, and remaining edge cases.

## Edge Cases and Open Questions

- Handle missing or empty project data without breaking the dashboard layout.
- Keep status and priority labels readable at narrow viewport widths.
- Avoid relying on nondeterministic data or unavailable services in the static
  app.
- Confirm the chosen local serving command is available in the Codespace when
  the Coder finalizes the launch configuration.
