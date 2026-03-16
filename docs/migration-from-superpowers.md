# Migrating from Superpowers to Superpowers Lite

Superpowers Lite is a drop-in replacement for superpowers. With no config file, it behaves identically to the original.

## Step 1: Swap the Plugin

```bash
# Remove original
/plugin uninstall superpowers

# Install lite
/plugin install superpowers-lite@CookiRui
```

## Step 2: (Optional) Add Configuration

Create `.superpowers.yml` in your project root to customize behavior. Without it, everything works like the original.

Quickest way:
```
/init-config
```

Or start with a preset:
```yaml
preset: startup
```

## Step 3: (Optional) Move Existing Docs

If you have spec/plan documents from the original superpowers:

```bash
# Old location
docs/superpowers/specs/
docs/superpowers/plans/

# New default location
docs/specs/
docs/plans/
```

Move them if you want, or configure the paths to match your old structure:

```yaml
paths:
  specs: "docs/superpowers/specs"
  plans: "docs/superpowers/plans"
```

## What's Different

### Behavior Changes (with default config)

**Nothing.** Without `.superpowers.yml`, superpowers-lite behaves identically to superpowers v5.0.2.

### Behavior Changes (with config)

Only what you configure changes:

| Config | Effect |
|--------|--------|
| `mode: auto` | Small tasks get quick mode instead of full pipeline |
| `tdd: recommended` | TDD encouraged but not strictly enforced |
| `review_mode: combined` | One review pass instead of two |
| `preset: startup` | Multiple settings changed at once for fast iteration |

### New Features Available

- Quick mode for small tasks
- Configurable TDD strictness
- Configurable review mode
- Pipeline presets
- Interrupt/resume
- Token tracking
- Custom skills
- Windows PowerShell support

All opt-in. Nothing forced.

## Compatibility

- All 14 original skills are included and work the same way
- Existing spec and plan documents are fully compatible
- Git worktrees, branches, and hooks work the same
- Multi-platform support (Claude Code, Cursor, Codex, OpenCode, Gemini CLI) preserved
