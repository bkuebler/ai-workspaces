#!/usr/bin/env bash
# Print the CHANGELOG.md section for a given version (e.g. "v1.0.0" or "1.0.0").
set -euo pipefail

version="${1:?Usage: changelog-entry.sh <version>}"
version="${version#v}"

cd "$(dirname "$0")/.."

awk -v ver="$version" '
  /^## \[/ {
    if (found) exit
    found = ($0 ~ "^## \\[" ver "\\]")
    next
  }
  /^\[[^]]+\]:/ { if (found) exit }
  found { print }
' CHANGELOG.md
