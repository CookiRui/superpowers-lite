# Changelog

All notable changes to Superpowers Lite are documented in this file.

## [1.1.0] - 2026-03-16

### Added
- **Combined reviewer prompt** — `review_mode: combined` now has a dedicated template
- **Progress tracking** — Interrupt/resume mechanism via `.superpowers/progress.json`
- **Token optimization** — Smart review skipping based on task complexity
- **Windows PowerShell scripts** — `start-server.ps1`, `stop-server.ps1`, `run-hook.ps1`
- **Config validation** — Warns about invalid keys, values, and conflicts in `.superpowers.yml`
- **Config generation** — `/init-config` command for interactive setup
- **Per-skill config overrides** — `skills.<name>.<key>` in `.superpowers.yml`
- **Pipeline presets** — `startup`, `enterprise`, `learning`
- **Metrics/reporting** — Token and pipeline metrics to `.superpowers/metrics.jsonl`
- **Custom skills** — Load user-defined skills from `.superpowers/skills/`

## [1.0.0] - 2026-03-16

### Added
- **Quick-mode skill** — Lightweight path for small tasks
- **User config file** — `.superpowers.yml` per project
- **Loading-config skill** — Reads config at session start
- **Workflow definition** — `workflow.yml` for centralized pipeline stages
- **Configurable document paths** — No more hardcoded `docs/superpowers/`
- **Configurable TDD** — `required` / `recommended` / `off`
- **Configurable reviews** — `separate` / `combined` / off

### Changed
- Updated brainstorming skill for config-aware paths and spec review toggle
- Updated writing-plans skill for configurable plan paths
- Updated test-driven-development skill for configurable strictness
- Updated subagent-driven-development skill for review mode config
- Updated using-superpowers skill for quick-mode routing and config loading

### Based On
- Forked from [superpowers v5.0.2](https://github.com/obra/superpowers) by Jesse Vincent
