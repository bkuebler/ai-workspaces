SCRATCH := /tmp/ai-workspaces-verify

.PHONY: lint lint-shell lint-yaml lint-markdown verify-template release-notes check clean

lint: lint-shell lint-yaml lint-markdown

lint-shell:
	shellcheck template/bootstrap.sh scripts/changelog-entry.sh

lint-yaml:
	yamllint -c .yamllint.yaml .

lint-markdown:
	npx --yes markdownlint-cli2 "**/*.md"

verify-template:
	rm -rf $(SCRATCH)
	uvx copier copy --defaults --data org=example-org --vcs-ref=HEAD . $(SCRATCH)
	test -f $(SCRATCH)/bootstrap.sh
	test -f $(SCRATCH)/workspace.conf
	test -f $(SCRATCH)/CLAUDE.md
	test -f $(SCRATCH)/.copier-answers.yml
	grep -q 'ORG="example-org"' $(SCRATCH)/workspace.conf
	! grep -q '{{' $(SCRATCH)/workspace.conf
	rm -rf $(SCRATCH)

release-notes:
	@test -n "$(VERSION)" || (echo "VERSION is required, e.g. make release-notes VERSION=v1.1.0" >&2; exit 1)
	@scripts/changelog-entry.sh "$(VERSION)"

check: lint verify-template

clean:
	rm -rf $(SCRATCH)
