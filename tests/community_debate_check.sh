#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

rg -q "include community-perspectives.html" "$repo_root/_layouts/single.html" || {
  echo "single layout does not include community perspectives"
  exit 1
}

rg -q "^community_comments:" "$repo_root/_config.yml" || {
  echo "missing community_comments config"
  exit 1
}

rg -q "forum_label" "$repo_root/_config.yml" || {
  echo "missing forum_label config"
  exit 1
}

rg -q 'label=\"\{\{ forum_label \}\}\"' "$repo_root/_includes/community-perspectives.html" || {
  echo "missing forum label wiring"
  exit 1
}

rg -q 'page.community_issue_term | default: page.id' "$repo_root/_includes/community-perspectives.html" || {
  echo "missing stable issue term fallback"
  exit 1
}

rg -q "^community_summary:" "$repo_root/_posts/2026-03-05-jubarte-prm.md" || {
  echo "missing seeded community summary"
  exit 1
}

echo "community debate wiring looks present"
