# Superpowers Lite

An optimized fork of [superpowers](https://github.com/obra/superpowers) by Jesse Vincent. Adds configurable pipelines, a quick-mode for small tasks, and user preferences — while keeping the same disciplined workflow foundation.

## What's Different from Superpowers?

| Feature | Superpowers | Superpowers Lite |
|---------|-------------|-----------------|
| Workflow mode | Always full pipeline | Full, Quick, or Auto mode |
| Small tasks | Full brainstorming → spec → plan | Quick mode: straight to implementation |
| TDD | Always required | Required / Recommended / Off (configurable) |
| Document paths | Hardcoded `docs/superpowers/specs/` | Configurable via `.superpowers.yml` |
| Reviews | Always two-stage | Separate / Combined / Off (configurable) |
| Pipeline stages | Hardcoded in each skill | Centralized in `workflow.yml` |
| User config | None | `.superpowers.yml` per project |

## Quick Start

### Installation

```bash
# In Claude Code
/plugin install superpowers-lite@CookiRui
```

### Configuration (Optional)

Create `.superpowers.yml` in your project root:

```yaml
# Quick start: just set the mode
mode: auto          # auto | full | quick

# Common overrides
tdd: recommended    # required | recommended | off
auto_commit: true
paths:
  specs: "docs/specs"
  plans: "docs/plans"
```

See [`.superpowers.yml`](.superpowers.yml) for all available options.

If you don't create a config file, everything works like the original superpowers.

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

### Full Mode

Same as original superpowers — full pipeline for everything.

### Quick Mode

Every task goes through the lightweight path. Best for maintenance/iteration work.

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
- **loading-config** — Reads `.superpowers.yml` at session start

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

Edit `pipeline` in `.superpowers.yml` to add/remove/reorder stages:

```yaml
# Minimal pipeline: skip worktree and reviews
pipeline:
  - brainstorming
  - writing-plans
  - subagent-driven-development
  - finishing-a-development-branch
```

See [`workflow.yml`](workflow.yml) for the full pipeline definition.

## Credits

Based on [superpowers](https://github.com/obra/superpowers) by [Jesse Vincent](https://github.com/obra). Original project licensed under MIT.

## License

MIT License — see LICENSE file for details.

## Links

- **Original project**: https://github.com/obra/superpowers
- **Issues**: https://github.com/CookiRui/superpowers-lite/issues
