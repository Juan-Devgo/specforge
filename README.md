# specforge

Spec-driven development (SDD) for [Claude Code](https://claude.com/claude-code): a set of skills and subagents that run the whole loop, from project principles to validated code.

## Install

```bash
git clone https://github.com/Juan-Devgo/specforge.git
cd specforge
./install.sh
```

`install.sh` links `add-sdd` into `~/.local/bin` (adding it to your `PATH` if needed). The link points back to this clone, so `git pull` updates what `add-sdd` installs.

## Use

From the root of any project:

```bash
add-sdd                 # install skills and agents into ./.claude
add-sdd ~/code/myproj   # or into another project
add-sdd --force         # overwrite files that already exist
```

Existing files are skipped unless you pass `--force`.

Then, in Claude Code, say "use the coordinator" or "start another development loop".

## What gets installed

```
.claude/
├── skills/
│   ├── sdd-constitution/SKILL.md
│   ├── sdd-agents/SKILL.md
│   ├── sdd-spec/SKILL.md
│   ├── sdd-clarification/SKILL.md
│   ├── sdd-plan/SKILL.md
│   ├── sdd-tasks/SKILL.md
│   ├── sdd-implement/SKILL.md
│   └── sdd-validation/SKILL.md
└── agents/
    ├── planner.md
    ├── clarifier.md
    ├── technician.md
    ├── developer.md
    └── validator.md
```

## Workflow

The `planner` is the coordinator and the only agent that talks to you. Subagents return questions to it, and it asks you. They exchange short JSON messages.

| Step | Who | Skill | Output |
| --- | --- | --- | --- |
| 1. Setup | planner | `sdd-constitution`, `sdd-agents` | `docs/constitution.md`, `AGENTS.md` (skipped if they exist) |
| 2. Spec | planner | `sdd-spec` | `docs/specs/###-name/spec.md` |
| 3. Clarify | clarifier | `sdd-clarification` | Answers recorded in the spec, then you approve it |
| 4. Plan | technician | `sdd-plan`, `sdd-tasks` | `plan.md`, `tasks.md` |
| 5. Implement | developer | `sdd-implement` | One phase per fresh developer instance |
| 6. Validate | validator | `sdd-validation` | Consistency report (read-only) |

Each agent gets only the tools it needs (lowest privilege): the validator is read-only, and only the planner can ask the user.

## Layout of this repo

- `skills/`: source skills, installed as `.claude/skills/<name>/SKILL.md`.
- `.claude/agents/`: source agents, installed as-is.
- `add-sdd`: the installer.
- `install.sh`: puts `add-sdd` on your `PATH`.
