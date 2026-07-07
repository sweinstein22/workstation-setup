## Code Comments

- Never leave "slop" comments that narrate what was added, removed, or moved. Examples of slop:
  - `// NB: validation was moved to the map layer`
  - `// Removed: old validation logic`
  - `// Added: new metric for X`
- Comments should explain WHY, not describe the diff.

- NEVER remove or rewrite existing comments in code you are editing unless the comment is factually wrong due to your change. Pre-existing comments were written by humans for good reasons -- they explain intent, constraints, or non-obvious behavior. The "no slop" rule above applies only to comments YOU are adding, not to comments already in the codebase.

## Pull Requests

- Always open PRs in draft mode: pass `--draft` to every `gh pr create` invocation (including stacked PRs), unless I explicitly say to open it ready-for-review.
