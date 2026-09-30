# AI Workspaces

AI Workspaces is a bootstrap repository for setup an environment for coding
tools like claude code, opencode, pi. It avoids the mono repository approach
where coding agents get all required information about all small pieces of an
platform / organization which is then added into one repository. This repo
will help to keep existing small repositories for every software asset, config
and so on, but give the tool the ability to search required additional domain
information across multiple repositories more structured.

## Create a new workspace

```bash
uvx copier copy git@github.com:bkuebler/ai-workspaces.git mynew-workspace
cd mynew-workspace
git init && git add -A && git commit -m "Initial workspace"
gh repo create MYORG/mynew-workspace --private --source . --push
./bootstrap.sh
```

## Update workspace to a new ai workspaces version

```bash
uvx copier update   # workspace must have no uncommited changes
```

## Releases and versioning

This repo follows [Semantic Versioning](https://semver.org/spec/v2.0.0.html)
and documents every release in [`CHANGELOG.md`](CHANGELOG.md), based on
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

To cut a release:

1. Move the relevant entries from `## [Unreleased]` into a new
   `## [x.y.z] - YYYY-MM-DD` section in `CHANGELOG.md`, and add its compare
   link at the bottom of the file. Commit and push this to `main` first —
   the tag must point at a commit whose changelog already has that section.
2. Tag the commit and push the tag:

   ```bash
   git tag -a vX.Y.Z -m "vX.Y.Z"
   git push origin vX.Y.Z
   ```

3. Pushing a `v*` tag triggers `.github/workflows/release.yml`, which
   creates a GitHub Release whose body is pulled straight from the matching
   `CHANGELOG.md` section (`make release-notes VERSION=vX.Y.Z`, backed by
   `scripts/changelog-entry.sh`). An unmatched version produces an empty
   release body, so step 1 must happen before tagging.

Run `make check` before tagging to make sure shellcheck, yamllint,
markdownlint, and the template render all pass.

## License

[MIT](LICENSE)
