<!-- Copilot / AI agent instructions for contributors and coding agents -->
# Copilot instructions for 4D Seismic Hub

This repository is a content‑driven Jekyll site (GitHub Pages) that curates open 4D seismic resources. The guidance below helps an AI coding agent be immediately productive when editing content, adding resources, or changing site configuration.

**Quick facts**
- **Site engine:** Jekyll (remote theme: `mmistakes/minimal-mistakes@4.27.3`) — see `_config.yml`.
- **Local preview:** run `bundle install` then `bundle exec jekyll serve` from the repository root (see `README.md`).
- **Base URL:** `baseurl: "/4d-seismic-hub"` and `url` are configured in `_config.yml` — use `absolute_url`/`relative_url` helpers when generating links.
- **Data-driven resources:** resources are stored in `_data/papers.yml` and rendered by `pages/resources.md` using `site.data.papers`.

**What to change and where (concrete references)**
- To add or edit bibliographic entries: update `/_data/papers.yml`. Each entry uses an `id` (lowercase, hyphenated), `title`, `authors`, `year`, `description`, `link`, and `tags`. See `pages/contribute.md` for the required fields and examples.
- To add a case study or card: create or edit Markdown files in `pages/` (e.g. `pages/case-studies.md`). Follow the repository's Problem–Approach–Outcome template and use short, decision‑oriented summaries.
- To change navigation, edit `_data/navigation.yml` (the Jekyll theme uses this file to build menus).
- Site config changes: `_config.yml` defines theme, plugins, `collections.docs` and `baseurl`. Keep `remote_theme` pinned where possible.

**Patterns and conventions an AI should follow**
- Content style: concise, non‑promotional, vendor‑neutral language. Contributions act as “online abstracts” — summarise in your own words and always link to the original source.
- IDs and filenames: use lowercase, hyphenated `id` values (example: `id: example-case-2023`) and filename slugs that match those ids.
- Data-first rendering: the `Resources` page is rendered from `_data/papers.yml` rather than individual HTML pages — prefer editing YAML entries for bibliographic updates.
- Card templates: three card types are expected — **Design checklist**, **Case card**, **Pitfall note**. Keep each card short (one paragraph + bullet list or small table). Place long workflows in `docs/` instead.
- No proprietary uploads: do not add PDFs or proprietary data. The project only links to publicly accessible materials (see `pages/contribute.md`).

**Developer workflows**
- Local preview: `bundle install` then `bundle exec jekyll serve` — changes to `pages/`, `_data/` and `_config.yml` are visible locally.
- CI / deploy: GitHub Actions are preconfigured for site builds on push (see `README.md`). Expect the Pages build to honour `_config.yml` settings including `baseurl`.
- Debugging rendering issues: run `bundle exec jekyll build --trace` to see Liquid/Jekyll errors; check that `_data` YAML is valid (use a YAML linter) and that `id` fields are unique.

**Examples the agent can use**
- When adding a resource entry, mirror the fields used in `/_data/papers.yml` (title, authors, year, description, link, tags). Example render loop: `pages/resources.md` uses `{% for paper in site.data.papers %}` to iterate.
- When changing navigation, update `_data/navigation.yml` and verify the menu by running `bundle exec jekyll serve`.

**Limitations & safety checks**
- Licensing: content is CC BY 4.0 and code is MIT. Do not add content you do not have the right to license (no proprietary data or PDFs).
- Confidentiality: avoid including field names or proprietary company data in case studies; follow `CONTRIBUTING.md` rules.
- Merge behavior: the working group reviews PRs; leave clear PR descriptions and link to source materials.

If anything in these instructions is unclear or you want the agent to include additional examples (e.g., YAML snippets or example card templates), please tell me which section to expand.
