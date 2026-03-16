# Superpowers Lite Release Notes

## v1.1.0 (2026-03-16)

Full feature release with all planned optimizations.

**New skills:** combined-reviewer, progress-tracking, token-optimization, config-validation, pipeline-presets, metrics-reporting, custom-skills

**New features:**
- Pipeline presets (startup / enterprise / learning)
- Interrupt/resume across sessions
- Token and metrics tracking
- Per-skill config overrides
- Custom skills directory
- Config validation with warnings
- Interactive config generation (`/init-config`)
- Windows PowerShell scripts

## v1.0.0 (2026-03-16)

Initial release. Forked from [superpowers v5.0.2](https://github.com/obra/superpowers).

**Core changes from superpowers:**
- Quick-mode skill for small tasks
- `.superpowers.yml` configuration file
- Configurable document paths
- Configurable TDD enforcement (required / recommended / off)
- Configurable review mode (separate / combined / off)
- Centralized workflow definition (`workflow.yml`)
- Config-aware core skills (brainstorming, writing-plans, TDD, subagent-driven-dev, using-superpowers)

**Upstream features preserved:**
- All 14 original skills
- Multi-platform support (Claude Code, Cursor, Codex, OpenCode, Gemini CLI)
- Zero-dependency brainstorm server
- Session hooks
- Subagent context isolation
