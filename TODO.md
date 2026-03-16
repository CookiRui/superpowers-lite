# Superpowers Lite — TODO

## Completed

### v1.0.0 — Core Optimizations
- [x] **Quick-mode skill** — Lightweight path for small tasks, skips full pipeline
- [x] **User config file (`.superpowers.yml`)** — Configurable TDD, reviews, paths, pipeline
- [x] **Configurable document paths** — Specs and plans paths read from config, not hardcoded
- [x] **Workflow definition (`workflow.yml`)** — Centralized pipeline stages and transitions
- [x] **Updated core skills** — brainstorming, writing-plans, TDD, subagent-driven-dev, using-superpowers all respect config
- [x] **Loading-config skill** — Reads `.superpowers.yml` at session start

### v1.1.0 — Full Feature Set
- [x] **Combined reviewer prompt** — `combined-reviewer-prompt.md` for `review_mode: combined`
- [x] **Interrupt/resume mechanism** — `progress-tracking` skill with `.superpowers/progress.json`
- [x] **Token usage optimization** — `token-optimization` skill with complexity assessment and smart skipping
- [x] **Windows native support** — PowerShell scripts: `start-server.ps1`, `stop-server.ps1`, `run-hook.ps1`
- [x] **Config validation** — `config-validation` skill warns about invalid keys/values/conflicts
- [x] **Config generation command** — `init-config` command for interactive `.superpowers.yml` setup
- [x] **Per-skill config overrides** — `skills.<name>.<key>` in `.superpowers.yml`
- [x] **Pipeline presets** — `startup`, `enterprise`, `learning` presets
- [x] **Metrics/reporting** — `metrics-reporting` skill with `.superpowers/metrics.jsonl`
- [x] **Custom skill templates** — `custom-skills` skill loads from `.superpowers/skills/`

## Future Ideas

- [ ] **Visual config editor** — Browser-based UI for editing `.superpowers.yml` (like brainstorm visual companion)
- [ ] **Team config sharing** — Separate `.superpowers.team.yml` (committed) and `.superpowers.local.yml` (gitignored)
- [ ] **Skill marketplace** — Discover and install community-created custom skills
- [ ] **AI cost estimator** — Before starting a pipeline, estimate token cost based on task complexity
- [ ] **Pipeline analytics dashboard** — Visualize metrics.jsonl data in browser
