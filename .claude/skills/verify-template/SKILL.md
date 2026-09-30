---
name: verify-template
description: Render this repo's Copier template into a scratch directory to sanity-check it generates without errors. Use before pushing changes to copier.yml or anything under template/.
---

Render the Copier template in this repo into a temporary directory and verify it completes without errors, then report what was generated.

1. Run `make verify-template`. This renders the template with `uvx copier copy --defaults --data org=example-org --vcs-ref=HEAD . /tmp/ai-workspaces-verify` (local working tree, not the git remote — `org` has no default and must be passed explicitly), then checks that `bootstrap.sh`, `workspace.conf`, `CLAUDE.md`, and `.copier-answers.yml` exist, that `workspace.conf` picked up the org, and that no unrendered `{{ ... }}` placeholders leaked in. It cleans up the scratch directory itself.
2. If specific answers matter for the check (e.g. testing the `https` clone protocol path), run the render step manually instead: `uvx copier copy --defaults --data org=example-org --data clone_protocol=https --vcs-ref=HEAD . /tmp/ai-workspaces-verify-<ts>`, then spot-check the output and clean up (`rm -rf`).
3. If `make verify-template` fails, show the copier error output — most failures are Jinja2 syntax errors in `.jinja` files, a missing required answer (e.g. `org`), or a `copier.yml` validator rejecting the value.
4. Report pass/fail and any output back to the user; don't leave scratch directories behind on success.

The same target runs in CI via `.github/workflows/verify-template.yml`, so this skill and CI never drift.
