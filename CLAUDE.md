# Maestro

This repo contains specialized Claude Code agents for software development orchestration.

## How It Works

Agents are defined as `.md` files in `.claude/agents/`. Claude Code auto-discovers them and makes them available as `subagent_type` values in Task calls.

The **orchestrator** is the user-facing entry point. It delegates every step to specialized agents. It never writes code, specs, or designs itself.

## Agents

| Agent | Role |
|-------|------|
| `orchestrator` | User-facing coordinator. Follows the full workflow. Delegates everything. |
| `requirements-analyst` | Structures raw goals into an unambiguous requirements document. |
| `systems-architect` | Produces a detailed tech spec (DESIGN mode) or reviews a plan (REVIEW mode). |
| `project-planner` | Creates a task graph with parallelization groups and acceptance criteria. |
| `dev` | Implements code, writes tests, debugs. Test-driven. |
| `designer` | Creates design systems, design tokens, component specs. |
| `figma` | Creates Figma projects from design specs (requires `FIGMA_API_KEY`). |
| `agent-refinement` | Reads evaluations, identifies trends, and improves agent definitions. |

## TARGET_DIR Convention

All project artifacts (code, designs, specs) are written to a `TARGET_DIR` — an absolute path provided by the user at the start of a session. This repo never contains user project code.

The orchestrator:
1. Asks the user for `TARGET_DIR` during GATHER REQUIREMENTS
2. Threads it through every Task call

Evaluation files are always written to this repo's `evaluations/` directory, not to `TARGET_DIR`.

## Evaluation Files

Path: `evaluations/{agent-name}/YYYY-MM-DD-HHMMSS.md`

The orchestrator writes one evaluation per agent after each task. The `agent-refinement` agent reads these to improve agent definitions over time.

## Versioning

Each agent has a `version` field in its YAML frontmatter (semver). Git commit hash serves as the build ID recorded in each evaluation.

- **PATCH**: prompt refinements
- **MINOR**: new capabilities or tools
- **MAJOR**: changes to role or output contract

## Running Agent Refinement

To improve a specific agent based on accumulated evaluations:

```
Use the agent-refinement agent.
AGENTS_REPO: /absolute/path/to/this/repo
TARGET_AGENT: systems-architect
```

## Global Installation

To make these agents available in all Claude Code sessions (not just when running from this directory):

```bash
./scripts/install.sh
```

This symlinks each agent to `~/.claude/agents/`.
