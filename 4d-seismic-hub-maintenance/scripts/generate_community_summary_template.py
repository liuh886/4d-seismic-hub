#!/usr/bin/env python3
import argparse
from pathlib import Path


def load_frontmatter(post_path: Path) -> dict[str, str]:
    content = post_path.read_text(encoding="utf-8")
    if not content.startswith("---"):
        raise ValueError(f"{post_path} is missing frontmatter")

    parts = content.split("---", 2)
    if len(parts) < 3:
        raise ValueError(f"{post_path} has malformed frontmatter")

    frontmatter = {}
    for line in parts[1].splitlines():
        if not line.strip() or line.startswith(" ") or ":" not in line:
            continue
        key, value = line.split(":", 1)
        frontmatter[key.strip()] = value.strip().strip("'\"")

    return frontmatter


def build_issue_term(frontmatter: dict[str, str], post_path: Path) -> str:
    if frontmatter.get("community_issue_term"):
        return frontmatter["community_issue_term"]

    stem = post_path.stem
    if len(stem) > 11 and stem[4] == "-" and stem[7] == "-":
        return stem[11:]
    return stem


def build_template(frontmatter: dict[str, str], post_path: Path) -> str:
    issue_term = build_issue_term(frontmatter, post_path)
    title = frontmatter.get("title", post_path.stem)

    return f"""post_title: "{title}"
issue_term_hint: "{issue_term}"
review_note: "Community synthesis is a review input, not a replacement for the technical source or evidence scope."
community_summary:
  updated_at: YYYY-MM-DD
  pro:
    - Supporting evidence or field experience tied to a specific article claim.
    - A second evidence-based supporting signal.
  con:
    - A limitation, counterexample, or transfer condition tied to a specific claim.
    - A second skeptical point that should remain visible.
"""


def main() -> int:
    parser = argparse.ArgumentParser(
        description="Generate a community review synthesis template for a post."
    )
    parser.add_argument("post", help="Path to the post markdown file")
    args = parser.parse_args()

    post_path = Path(args.post).resolve()
    frontmatter = load_frontmatter(post_path)
    print(build_template(frontmatter, post_path))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
