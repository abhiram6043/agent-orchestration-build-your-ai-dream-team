# Project Pulse Agent Team

Mona's Project Pulse dashboard will be built with GitHub Copilot CLI in a
Codespace, using the custom agents defined under `.github/agents/`.

| Agent | Model | Definition | Responsibilities |
| --- | --- | --- | --- |
| Orchestrator | Claude Opus 4.7 | `.github/agents/orchestrator.agent.md` | Coordinates the team, breaks the dashboard request into phases, assigns explicit file scopes, manages dependencies, integrates the results, and reports the outcome. |
| Planner | Claude Opus 4.7 | `.github/agents/planner.agent.md` | Researches the repository and requirements, identifies risks and edge cases, and produces the implementation plan, file assignments, dependencies, and validation expectations. |
| Designer | Gemini 3.1 Pro | `.github/agents/designer.agent.md` | Defines the Project Pulse information hierarchy, UI/UX, accessibility, responsive behavior, visual styling, project cards, status badges, priority treatment, and deterministic CSS hooks. |
| Coder | GPT-5.5 | `.github/agents/coder.agent.md` | Implements the assigned static dashboard files with clear, deterministic, testable code, creates required runnable-app support files when assigned, and validates the implementation. |

## How They Work Together

1. The Orchestrator receives Mona's Project Pulse request and asks the Planner
   to research the repository and create a practical implementation plan.
2. The Orchestrator turns that plan into phases with non-overlapping file
   ownership and delegates the experience direction to the Designer.
3. The Designer specifies the dashboard structure and visual behavior for
   projects, owners, statuses, activity, priorities, and contributor summaries.
4. The Coder uses the plan and design direction to implement the static Project
   Pulse dashboard and any explicitly assigned launch or data files.
5. The Orchestrator verifies that the integrated dashboard meets the plan,
   coordinates validation, surfaces blockers, and reports the final result.

Git operations remain under the learner's control; the custom agents do not
stage, commit, or push changes.