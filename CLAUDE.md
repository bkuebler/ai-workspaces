# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

This is a **Copier template** (<https://copier.readthedocs.io>) that scaffolds an "ai-workspaces" meta-repo: a workspace that clones many small org repos into `./repos/` (via `bootstrap.sh`) so coding agents can search across them, instead of forcing everything into one monorepo. This repo itself has no application code — the actual template lives under `template/`.

## Layout

- `copier.yml` — the prompts asked when generating a new workspace (org, clone protocol, topic filter, excludes, etc.)
- `template/` — files rendered into a generated workspace (Jinja2 `.jinja` files are rendered; others are copied as-is)
  - `bootstrap.sh` — idempotent clone/fetch/pull script for the generated workspace, driven by `workspace.conf`
  - `workspace.conf.jinja` → renders to `workspace.conf`, consumed by `bootstrap.sh`
  - `CLAUDE.md.jinja` — the CLAUDE.md injected into *generated* workspaces (not this repo's own CLAUDE.md)
  - `{{_copier_conf.answers_file}}.jinja` — records copier answers; copier-managed, never hand-edit the rendered `.copier-answers.yml`

## Commands

```bash
# Generate a new workspace from this template
uvx copier copy git@github.com:bkuebler/ai-workspaces.git mynew-workspace

# Update an existing generated workspace to a newer template version
uvx copier update   # target workspace must have no uncommitted changes
```

## Linting and verification

CI and local checks share the same commands via the `Makefile`:

```bash
make lint-shell        # shellcheck on template/bootstrap.sh
make lint-yaml         # yamllint on all .yml/.yaml files
make lint-markdown     # markdownlint-cli2 on all .md files
make verify-template   # render the template with defaults, sanity-check the output
make lint              # all lint-* targets
make check             # lint + verify-template
```

Each `.github/workflows/*.yml` just installs the relevant tool and calls the matching `make` target, so there's no drift between what CI runs and what you can run locally.

## Releases

Pushing a tag matching `v*` (e.g. `v1.1.0`) triggers `.github/workflows/release.yml`, which creates a GitHub Release whose body is pulled straight from the matching `## [x.y.z]` section of `CHANGELOG.md` via `make release-notes VERSION=v1.1.0` (backed by `scripts/changelog-entry.sh`). Keep `CHANGELOG.md` up to date — an unmatched version produces an empty release body.

## Gotchas

- `REPOS_DIR` in `workspace.conf.jinja` defaults to `"repos"` — if you change it, also update the corresponding entry in `template/.gitignore`.
- `bootstrap.sh` auto-detects and excludes the workspace repo itself from cloning (via `git remote get-url origin`); don't add manual handling for that case.
- `uvx copier update` refuses to run against a workspace with uncommitted changes.
- All user-facing text (prompts, comments, docs) is English; keep new content in English.
