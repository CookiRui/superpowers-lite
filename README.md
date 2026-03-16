# Superpowers Lite

An optimized fork of [superpowers](https://github.com/obra/superpowers) by Jesse Vincent. Adds configurable pipelines, a quick-mode for small tasks, and user preferences — while keeping the same disciplined workflow foundation.

## What's Different from Superpowers?

| Feature | Superpowers | Superpowers Lite |
|---------|-------------|-----------------|
| Workflow mode | Always full pipeline | Full, Quick, or Auto mode |
| Small tasks | Full brainstorming → spec → plan | Quick mode: straight to implementation |
| CLAUDE.md | Manual | Auto-generated from spec/plan/config |
| TDD | Always required | Required / Recommended / Off |
| Document paths | Hardcoded `docs/superpowers/specs/` | Configurable via `.superpowers.yml` |
| Reviews | Always two-stage | Separate / Combined / Off |
| Pipeline stages | Hardcoded in each skill | Centralized, customizable `workflow.yml` |
| User config | None | `.superpowers.yml` per project |
| Per-skill overrides | None | `skills.<name>.<key>` in config |
| Presets | None | startup / enterprise / learning |
| Interrupt/resume | None | Progress persisted to `.superpowers/progress.json` |
| Config validation | None | Warns about typos, invalid values, conflicts |
| Windows | Bash only | PowerShell scripts included |
| Token tracking | None | Optional metrics and token logging |
| Custom skills | None | `.superpowers/skills/` directory |

## Quick Start

### Installation

```bash
# In Claude Code
/plugin install superpowers-lite@CookiRui
```

### Configuration (Optional)

Generate a config interactively:
```
/init-config
```

Or create `.superpowers.yml` manually:

```yaml
# Quick start with a preset
preset: startup       # startup | enterprise | learning

# Or configure individually
mode: auto            # auto | full | quick
tdd: recommended      # required | recommended | off
review_mode: combined # separate | combined
auto_commit: true
paths:
  specs: "docs/specs"
  plans: "docs/plans"
```

See [`.superpowers.yml`](.superpowers.yml) for all available options.

No config file = original superpowers behavior (all defaults).

## How It Works

### Auto Mode (default)

The agent assesses each task and picks the right pipeline:

**Complex task** → "Build a payment system"
```
brainstorming → writing-plans → worktree → subagent execution → finish
```

**Small task** → "Fix the typo in the header"
```
quick-mode → implement → verify → commit
```

### Pipeline Presets

| Preset | Best For | TDD | Reviews | Mode |
|--------|----------|-----|---------|------|
| `startup` | Prototyping, solo devs | recommended | off | auto |
| `enterprise` | Production, teams | required | separate | full |
| `learning` | New users, education | required | separate (verbose) | full |

### Interrupt/Resume

If a session is interrupted mid-pipeline, the next session detects `.superpowers/progress.json` and offers to resume:

```
Found interrupted work: "payment-system"
- Progress: 3/5 tasks completed
- Options: Resume / Start over / Ignore
```

## Skills Library

### Core Pipeline
- **brainstorming** — Socratic design refinement (config-aware)
- **writing-plans** — Detailed implementation plans (configurable paths)
- **using-git-worktrees** — Isolated development branches
- **subagent-driven-development** — Task execution with configurable review
- **executing-plans** — Batch execution with checkpoints
- **finishing-a-development-branch** — Merge/PR decision workflow

### New in Lite
- **quick-mode** — Fast-track small tasks without full pipeline
- **project-setup** — Auto-generate CLAUDE.md from spec/plan/config before implementation
- **loading-config** — Reads config, applies presets, validates, loads custom skills
- **config-validation** — Warns about invalid config values
- **progress-tracking** — Persist/resume interrupted work
- **token-optimization** — Smart review skipping based on complexity
- **pipeline-presets** — Named config presets (startup/enterprise/learning)
- **metrics-reporting** — Track tokens, time, review iterations
- **custom-skills** — Load user-defined skills from `.superpowers/skills/`

### Quality & Discipline
- **test-driven-development** — RED-GREEN-REFACTOR (configurable strictness)
- **systematic-debugging** — 4-phase root cause investigation
- **verification-before-completion** — Evidence before claims

### Collaboration
- **requesting-code-review** — Automated code review dispatch
- **receiving-code-review** — Review feedback handling
- **dispatching-parallel-agents** — Concurrent problem solving

### Meta
- **writing-skills** — Create new custom skills
- **using-superpowers** — Skill discovery and routing (config-aware)

## Pipeline Customization

Edit `pipeline` in `.superpowers.yml`:

```yaml
pipeline:
  - brainstorming
  - writing-plans
  - subagent-driven-development
  - my-deploy-check              # custom skill
  - finishing-a-development-branch
```

## Custom Skills

Create project-specific skills in `.superpowers/skills/`:

```
.superpowers/skills/my-deploy-check/SKILL.md
```

Skills are auto-discovered. Same name as a built-in = override.

## Windows Support

PowerShell scripts included alongside bash:
- `start-server.ps1` / `start-server.sh`
- `stop-server.ps1` / `stop-server.sh`
- `run-hook.ps1` / `run-hook.cmd`

## Credits

Based on [superpowers](https://github.com/obra/superpowers) by [Jesse Vincent](https://github.com/obra). Original project licensed under MIT.

## License

MIT License — see LICENSE file for details.

## Links

- **Original project**: https://github.com/obra/superpowers
- **Issues**: https://github.com/CookiRui/superpowers-lite/issues
