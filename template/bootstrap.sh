#!/usr/bin/env bash
# Clone of missing repositories of the organization and update existing.
# Idempotent, delete by default nothing.
set -euo pipefail
cd "$(dirname "$0")"

source ./workspace.conf
[ -f ./workspace.local.conf ] && source ./workspace.local.conf

SELF=$(basename -s .git "$(git remote get-url origin 2>/dev/null || pwd)")
EXCLUDE+=("$SELF")

GH_ARGS=(--limit "$LIMIT" --json name --jq '.[].name')
[ "$SKIP_ARCHIVED" = true ] && GH_ARGS+=(--no-archived)
[ "$SKIP_FORKS" = true ] && GH_ARGS+=(--source)
[ -n "$TOPIC" ] && GH_ARGS+=(--topic "$TOPIC")

case "$CLONE_PROTOCOL" in
  ssh)   BASE_URL="git@github.com:$ORG" ;;
  https) BASE_URL="https://github.com/$ORG" ;;
  *) echo "Unbekanntes CLONE_PROTOCOL: $CLONE_PROTOCOL" >&2; exit 1 ;;
esac

REPOS=$(gh repo list "$ORG" "${GH_ARGS[@]}")

mkdir -p "$REPOS_DIR"
for r in $REPOS; do
  [[ " ${EXCLUDE[*]} " == *" $r "* ]] && continue
  dir="$REPOS_DIR/$r"
  if [ -d "$dir/.git" ]; then
    if [ "$UPDATE_MODE" = pull ]; then
      git -C "$dir" pull --ff-only || echo "⚠ $r: Pull skipped"
    else
      git -C "$dir" fetch --all --prune || echo "⚠ $r: Fetch failed"
    fi
  elif [ -e "$dir" ]; then
    echo "⚠ $r: Directory exists, but no Git-Repo, skipped"
  else
    git clone "$BASE_URL/$r.git" "$dir" || echo "⚠ $r: Clone failed"
  fi
done
