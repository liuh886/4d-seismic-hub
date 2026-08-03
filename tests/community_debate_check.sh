#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

rg -q "include community-perspectives.html" "$repo_root/_layouts/single.html" || {
  echo "single layout does not include community perspectives"
  exit 1
}

rg -q "include case-overview.html" "$repo_root/_layouts/single.html" || {
  echo "single layout does not include the structured case brief"
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

rg -q 'page.community_issue_term \| default: page.id' "$repo_root/_includes/community-perspectives.html" || {
  echo "missing stable issue term fallback"
  exit 1
}

rg -q "Evidence boundary:" "$repo_root/_includes/community-perspectives.html" || {
  echo "community review does not state its evidence boundary"
  exit 1
}

rg -q "Supporting signals" "$repo_root/_includes/community-perspectives.html" || {
  echo "missing supporting-signals summary label"
  exit 1
}

rg -q "Limits and counterexamples" "$repo_root/_includes/community-perspectives.html" || {
  echo "missing limits-and-counterexamples summary label"
  exit 1
}

rg -q "Technical source record" "$repo_root/_includes/case-overview.html" || {
  echo "case overview does not render the technical source record"
  exit 1
}

rg -q "Evidence scope" "$repo_root/_includes/case-overview.html" || {
  echo "case overview does not render the evidence scope"
  exit 1
}

rg -q "Known limitations" "$repo_root/_includes/case-overview.html" || {
  echo "case overview does not render known limitations"
  exit 1
}

rg -q "assets/css/evidence.css" "$repo_root/_includes/head/custom.html" || {
  echo "evidence component styles are not loaded"
  exit 1
}

rg -q "assets/css/community.css" "$repo_root/_includes/head/custom.html" || {
  echo "community review styles are not loaded"
  exit 1
}

echo "community review and evidence-boundary wiring looks present"
