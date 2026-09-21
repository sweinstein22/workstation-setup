# Claude / Cursor rules

Snapshot copies, kept here for posterity. **This directory is not the live
source** -- nothing installs from it, and editing a file here changes nothing on
any machine.

The live source is `control-infra/sweinstein22/rules/` on the `control-infra`
branch of [chronosphereio/spacejunk](https://github.com/chronosphereio/spacejunk).
agentd's SyncController polls that branch every 60s and publishes the merged
tree (the shared `devbox/setup` baseline, then this subtree on top) into
`~/.claude/rules` and `~/.cursor/rules`. It publishes by swapping the whole
destination directory and deleting the old one, so any file hand-written into
`~/.claude/rules` is destroyed on the next poll. Edit in spacejunk, push, wait.

The user layer only deploys when `DEVBOX_DEPLOY_USER_ASSETS` is `auto` or
`true` in `~/.devbox.local`. If none of these rules seem to be in force, check
that first, then check `~/agentd/logs/agentd-sync.log` for
`layer control-infra/sweinstein22/rules: absent, skipped`.

| File | What it covers |
| --- | --- |
| `pr-conventions.mdc` | Ask before landing, `sweinstein-<id>` branches, `[sc-#####]` titles, draft state |
| `writing-voice.mdc` | How PR descriptions and comments written as me should sound |
| `shortcut-access.mdc` | MCP server first, `~/.config/shortcut/token` as the fallback |
| `clarifying-questions.mdc` | When to ask, when to assume, how to batch the borderline calls |
| `test-coverage.mdc` | Failure modes over case counts; table-driven over enumerated |

To refresh the snapshot:

```bash
cp ~/spacejunk-sync/control-infra/sweinstein22/rules/*.mdc claude-rules/
```
