# Agent Orchestration in the GitHub Copilot CLI

_Practice coordinating specialist agents from the terminal with GitHub Copilot CLI._

## Welcome

GitHub Copilot CLI brings an agentic coding assistant directly into your terminal. In this exercise, you will use a Codespace and the integrated terminal to practice an orchestration pattern with an Orchestrator, Planner, Coder, and Designer.

- **Who is this for**: Developers who have basic GitHub and GitHub Copilot familiarity and want to learn how to coordinate specialist agents from the terminal.
- **What you'll learn**: How to use GitHub Copilot CLI in Codespaces to define agent roles, create a Planner handoff, map work to specialist agents, and summarize an orchestrated result.
- **What you'll build**: Repository agent definitions plus orchestration artifacts that document agent roles, planning handoffs, execution phases, file ownership, parallel work, sequential work, and final validation.
- **Prerequisites**:
  - A GitHub account with access to GitHub Copilot.
  - Access to GitHub Codespaces.
  - Basic familiarity with repositories, commits, and Markdown.
  - Comfort working in an integrated terminal.

- **How long**: This exercise takes less than one hour to complete.

In this exercise, you will:

1. Start a Codespace that puts GitHub Copilot CLI front and center.
1. Inspect the Orchestrator, Planner, Coder, and Designer files under `.github/agents/`.
1. Create a Planner handoff for a sample request.
1. Convert planned work into an Orchestrator execution plan.
1. Summarize the final coordinated result with validation notes.

### How to start this exercise

Simply copy the exercise to your account, then give your favorite Octocat (Mona) **about 20 seconds** to prepare the first lesson, then **refresh the page**.

[![](https://img.shields.io/badge/Copy%20Exercise-%E2%86%92-1f883d?style=for-the-badge&logo=github&labelColor=197935)](https://github.com/new?template_owner=skills-dev&template_name=agent-orchestration-in-the-cli&owner=%40me&name=skills-agent-orchestration-in-the-cli&description=Exercise:+Agent+Orchestration+in+the+GitHub+Copilot+CLI&visibility=public)

<details>
<summary>Having trouble? 🤷</summary><br/>

When copying the exercise, we recommend the following settings:

- For owner, choose your personal account or an organization to host the repository.

- We recommend creating a public repository, since private repositories will use Actions minutes.

If the exercise isn't ready in 20 seconds, please check the [Actions](../../actions) tab.

- Check to see if a job is running. Sometimes it simply takes a bit longer.

- If the page shows a failed job, please submit an issue. Nice, you found a bug! 🐛

</details>

---

&copy; 2026 GitHub &bull; [Code of Conduct](https://www.contributor-covenant.org/version/2/1/code_of_conduct/code_of_conduct.md) &bull; [MIT License](https://gh.io/mit)
