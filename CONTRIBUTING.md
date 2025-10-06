# Contributing to the 4D Seismic Hub

We appreciate your interest in contributing to this project.  To maintain high quality and consistency across the site, please follow these guidelines when submitting changes.

## Types of contributions

* **New resources** – Add papers, presentations or tutorials that are publicly available on the web.  Update the `/_data/papers.yml` file with a new entry containing `id`, `title`, `authors`, `year`, a concise **description**, a `link` to the landing page and a list of `tags`.  Only link to open materials; do **not** upload proprietary PDFs or slides.  The description should summarise the essence of the work in your own words—think of it as a one‑sentence abstract.
* **Case studies and cards** – Share examples where 4D data influenced reservoir decisions.  Create or update the `pages/case-studies.md` file or add a new Markdown page under `pages/`.  Follow the *Problem–Approach–Outcome* template and anonymise sensitive details.  In addition to full case write‑ups, you can create **case cards** summarising the question, workflow and outcome, as well as **design checklists** and **pitfall notes**.  These card templates are described in the [About page](/pages/about).
* **Documentation** – Improve the README, About page or other documentation.  Clarify instructions, fix typos or translate content (for example, adding a Chinese version under `/zh/`).
* **Infrastructure** – Help improve the Jekyll layout, add continuous integration workflows or fix build issues.

## Workflow

1. **Fork** the repository on GitHub and clone your fork locally.
2. **Create a branch** for your changes.  Use a descriptive name such as `add-new-paper` or `update-case-study-xyz`.
3. **Make your changes** following the guidelines in this document and the `pages/contribute.md` file.
4. **Commit** your changes with a meaningful commit message.
5. **Push** the branch to your fork and open a **pull request** against the `main` branch of the upstream repository.
6. A member of the working group will review your pull request.  They may request changes or clarification.  Once approved, your contribution will be merged.

## Style and formatting

* Write in English using clear, concise language.
* Use standard Markdown syntax.  Keep tables narrow; avoid long sentences inside tables.
* For YAML files, ensure proper indentation and quoting.  Each paper entry should use hyphens for lists.
* Provide accurate and neutral descriptions.  Do not include marketing language or exaggerations.

## Licensing

By contributing, you agree that your code and prose will be released under the MIT License (for code) and the Creative Commons Attribution 4.0 International License (for documentation and content).  Ensure that you have the right to contribute any material you submit.

## Code of Conduct

Please review the [Code of Conduct](/CODE_OF_CONDUCT.md).  We are committed to providing a welcoming and harassment‑free experience for everyone.  Inappropriate behaviour will not be tolerated.
