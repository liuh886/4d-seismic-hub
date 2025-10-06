---
title: Contribute
layout: default
---

## Contributing to the 4D Seismic Hub

We welcome contributions of open presentations, case studies, tutorials, reusable card summaries and corrections.  To maintain quality and ensure transparency, please follow the steps below when proposing changes.

1. **Fork this repository.**  You can do this on GitHub via the “Fork” button.  Then clone your fork locally.
2. **Add or update content.**
   * **New resources:** To add a new paper or presentation, edit `/_data/papers.yml`.  Each entry must include an `id` (a unique, lowercase, hyphenated string), `title`, `authors`, `year`, a short **description**, a `link` to the landing page and a list of `tags`.  Only link to materials that are already publicly accessible on the web.  **Do not** upload copyrighted or proprietary PDFs.
   * **Case studies:** To add a case study, create a new Markdown file in `/pages` or edit `case-studies.md` following the **Problem–Approach–Outcome** format.  Omit proprietary data and confidential field names.  Keep sentences concise—remember that this site is an “abstract” for your audience.
   * **Reusable cards:** To add a **design checklist**, **case card** or **pitfall note**, create a new subsection in a relevant page (e.g., `/pages/case-studies.md`) or a new Markdown file in `/pages`.  
     • A **design checklist** should include a short introductory sentence and a table summarising recommended repeatability metrics, normalisation strategies and attribute thresholds.  
     • A **case card** should list the **question**, **workflow** and **outcome** in bullet form, along with any key metrics.  
     • A **pitfall note** should describe the issue encountered and outline mitigation strategies.  
     Each card should cite the original source and be written in your own words.
   * **Join the working group:** To join the working group, edit `pages/working-group.md` to add your name and short biography, and open an issue labelled `wg‑join` so we can welcome you.
3. **Provide citations.**  Always link to the original article or presentation landing page.  Your summaries must be written in your own words; **avoid copying text verbatim**.  Think of your contribution as an online abstract that points readers back to the source.
4. **Submit a pull request.**  Describe your changes clearly and link to any relevant discussions or issues.  A member of the working group will review your contribution and merge it when ready.

### Style guidelines

* Write in clear, concise English.  Avoid promotional language; this site is vendor‑neutral.
* Use standard Markdown.  For tables, restrict content to short phrases rather than long sentences.
* When adding code or workflows, place them in fenced code blocks and consider creating a separate `docs/` entry if the content is lengthy.
* Keep in mind that this site serves as a summary or abstract of the literature—your writing should be succinct and decision‑oriented.

### Licensing

By contributing, you agree that your contributions will be released under the [MIT License](/LICENSE) for code and the [Creative Commons Attribution 4.0 International License](https://creativecommons.org/licenses/by/4.0/) for content.  Please only contribute material that you have the right to share.
