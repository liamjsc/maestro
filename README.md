# Agent Orchestration Repo

A self-improving repository of specialized Claude Code agents for software development.

## Quickstart

**1. Clone and open**
```bash
git clone <repo-url> agents
cd agents
claude  # open Claude Code in this directory
```

Claude Code auto-discovers the agents in `.claude/agents/` at startup.

**2. Start a project**

Talk to the `orchestrator` agent:
```
Use the orchestrator agent.

I want to build a todo app. Create it at /Users/me/code/my-todo-app.
```

The orchestrator will ask a few clarifying questions, then run autonomously — gathering requirements, designing the system, planning implementation, and building the project in parallel.

**3. Output**

All project artifacts land in the `TARGET_DIR` you provide (e.g. `/Users/me/code/my-todo-app`). This repo only stores evaluation logs.

---

## Agents

| Agent | Role | Invoked By |
|-------|------|------------|
| `orchestrator` | User-facing coordinator | You |
| `requirements-analyst` | Structures requirements | orchestrator |
| `systems-architect` | Technical spec + plan review | orchestrator |
| `project-planner` | Task graph with parallelization | orchestrator |
| `dev` | Code implementation | orchestrator |
| `designer` | Design system + tokens | orchestrator |
| `figma` | Figma project creation | designer |
| `agent-refinement` | Improves agents from evaluations | You (periodically) |

---

## Self-Improvement

After each project, the orchestrator writes evaluation files to `evaluations/{agent-name}/`.

To refine an underperforming agent:
```
Use the agent-refinement agent.
AGENTS_REPO: /absolute/path/to/this/repo
TARGET_AGENT: systems-architect
```

The refinement agent reads evaluation history, identifies trends, and makes targeted edits to the agent definition with a version bump.

---

## Global Install

To use these agents from any Claude Code session (not just this directory):

```bash
chmod +x scripts/install.sh
./scripts/install.sh
```

This symlinks each agent to `~/.claude/agents/`.

---

## Requirements

- [Claude Code](https://claude.ai/code) installed
- `FIGMA_API_KEY` environment variable (optional — only needed for Figma output)
