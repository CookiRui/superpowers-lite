# Superpowers Lite — TODO

## Completed (v1.0.0)

- [x] **Quick-mode skill** — Lightweight path for small tasks, skips full pipeline
- [x] **User config file (`.superpowers.yml`)** — Configurable TDD, reviews, paths, pipeline
- [x] **Configurable document paths** — Specs and plans paths read from config, not hardcoded
- [x] **Workflow definition (`workflow.yml`)** — Centralized pipeline stages and transitions
- [x] **Updated core skills** — brainstorming, writing-plans, TDD, subagent-driven-dev, using-superpowers all respect config
- [x] **Loading-config skill** — Reads `.superpowers.yml` at session start

## Planned

### High Priority

- [ ] **Review step merging** — When `review_mode: combined`, implement a single reviewer prompt that covers both spec compliance and code quality in one pass. Currently the config flag exists but the combined reviewer prompt template doesn't.

- [ ] **Interrupt/resume mechanism** — Persist task progress to `.superpowers/progress.json` so a new session can pick up where the last one left off. Should track:
  - Current pipeline stage
  - Which plan tasks are done/in-progress/pending
  - Last commit SHA per task
  - Any pending review feedback

- [ ] **Token usage optimization** — Smart review skipping based on task complexity:
  - Skip reviews for tasks touching 1 file with < 50 lines changed
  - Reduce review depth for mechanical tasks (rename, config change)
  - Track and report token usage per task for cost awareness

### Medium Priority

- [ ] **Windows native support** — Add PowerShell equivalents for all bash scripts:
  - `start-server.ps1` alongside `start-server.sh`
  - `stop-server.ps1` alongside `stop-server.sh`
  - `run-hook.ps1` alongside `run-hook.cmd`
  - Auto-detect shell and use appropriate script

- [ ] **Combined reviewer prompt template** — Create `skills/subagent-driven-development/combined-reviewer-prompt.md` that merges spec-reviewer and code-quality-reviewer into a single pass

- [ ] **Config validation** — Warn user if `.superpowers.yml` has invalid keys or values instead of silently using defaults

- [ ] **Config generation command** — `/superpowers init` command that generates a `.superpowers.yml` with interactive prompts for preferences

### Low Priority

- [ ] **Per-skill config overrides** — Allow `.superpowers.yml` to override settings per skill:
  ```yaml
  skills:
    brainstorming:
      max_questions: 5
    subagent-driven-development:
      model_preference: fast
  ```

- [ ] **Metrics/reporting** — Track across sessions:
  - Total tokens used per feature
  - Time spent per pipeline stage
  - Review iteration counts
  - Quick-mode vs full-pipeline ratio

- [ ] **Custom skill templates** — Allow users to define custom skills in `.superpowers/skills/` that extend or override built-in skills

- [ ] **Pipeline presets** — Named pipeline configurations:
  ```yaml
  preset: startup    # fast iteration, minimal reviews
  preset: enterprise # full pipeline, all reviews, strict TDD
  preset: learning   # verbose explanations, extra checkpoints
  ```
