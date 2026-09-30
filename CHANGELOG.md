# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- `README.md` section documenting the release/versioning process.
- `LICENSE` (MIT).
- `README.md` Prerequisites section listing `git`, `gh`, and `uv`.

### Changed

- `gh` marked optional in the README Prerequisites section, noting
  `bootstrap.sh` is GitHub-specific today with Gitea/Forgejo/GitLab
  support planned (tracked in [#1]).

## [1.1.0] - 2026-09-30

### Added

- `CLAUDE.md` with repo overview, layout, commands, and gotchas for Claude Code.
- `.claude/skills/verify-template` skill to render and sanity-check the Copier
  template before pushing changes.
- `Makefile` with `lint-shell`, `lint-yaml`, `lint-markdown`, `verify-template`,
  `lint`, and `check` targets, shared between local use and CI.
- CI workflows (`.github/workflows/`) for shellcheck, yamllint, markdownlint,
  and template rendering, each calling the matching `make` target.
- Linter configs: `.shellcheckrc`, `.yamllint.yaml`, `.markdownlint.yaml`.
- `.github/workflows/release.yml` to create a GitHub Release on every `v*`
  tag push, with the release body pulled from the matching `CHANGELOG.md`
  section via `scripts/changelog-entry.sh` / `make release-notes`.

### Changed

- The `org` prompt in `copier.yml` no longer has a default — an
  organization must now be provided explicitly via `--data org=...` or
  the interactive prompt.

### Fixed

- Stray trailing blank line in `README.md`.
- Translated remaining German text (`copier.yml` prompts/validator, a
  `bootstrap.sh` error message, a code comment) to English.

## [1.0.0] - 2026-09-30

### Added

- Initial Copier template for scaffolding Claude Code / coding-agent
  workspaces: `copier.yml` prompts, and `template/` with `bootstrap.sh`,
  `workspace.conf.jinja`, and `CLAUDE.md.jinja`.

[#1]: https://github.com/bkuebler/ai-workspaces/issues/1
[Unreleased]: https://github.com/bkuebler/ai-workspaces/compare/v1.1.0...HEAD
[1.1.0]: https://github.com/bkuebler/ai-workspaces/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/bkuebler/ai-workspaces/releases/tag/v1.0.0
