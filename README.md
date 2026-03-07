<div align="center">
  <img src="assets/images/logo.svg" width="120" alt="4D Seismic Hub Logo">
  <h1>4D Seismic Hub</h1>

  <p><b>The Living Abstract for Time-Lapse Monitoring</b></p>

  [![Link Check](https://github.com/liuh886/4d-seismic-hub/actions/workflows/links.yml/badge.svg)](https://github.com/liuh886/4d-seismic-hub/actions/workflows/links.yml)
  [![Pages Deploy](https://github.com/liuh886/4d-seismic-hub/actions/workflows/pages.yml/badge.svg)](https://github.com/liuh886/4d-seismic-hub/actions/workflows/pages.yml)
  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

  <h4><a href="https://liuh886.github.io/4d-seismic-hub/">Explore the Hub</a></h4>
</div>

---

### 🌐 Overview

The **4D Seismic Hub** bridges the gap between high-level conference presentations and actionable project planning. We summarize complex geophysical workflows into reusable, decision-oriented formats, ensuring that valuable industry knowledge remains accessible and citable.

---

### 🚀 Key Features

- **📂 Curated Knowledge Base**: Decision-oriented summaries of open-access presentations and case studies.
- **📊 Comparison Tool**: Side-by-side technical parameter analysis (NRMS, bin size, acquisition geometry)).
- **🗺️ Case Study Map**: Interactive global view of 4D projects with narrative context.
- **💬 Community Perspectives**: Every analysis post now supports separate Pro and Con issue-backed discussion threads plus agent-ready summary cards.
- **🤝 Working Group**: A collaborative framework for geoscientists to maintain and extend the hub.
- **🤖 AI Agent Support**: This project includes a specialized **AI Maintenance Agent** skill (located in `4d-seismic-hub-maintenance/`) that automates data validation, curation, and site health audits.

---

### 🤖 AI Agent Maintenance

This project is optimized for AI-assisted maintenance using **Gemini CLI**. The integrated Agent skill ensures that the hub remains accurate, high-quality, and up-to-date with minimal manual effort.

#### 🛠️ How to use the AI Agent:
If you are using Gemini CLI, you can trigger automated workflows by pointing to the maintenance folder:

*   **Run Routine Audit**: `"Agent, run routine maintenance for this project."`
    *   *Result*: The agent will scan `_data/`, `_posts/`, and `index.md` for schema errors, broken links, or missing technical parameters.
*   **Intelligent Curation**: `"Agent, add this new case study [URL/DOI] to the hub."`
    *   *Result*: The agent will extract decision intelligence, geocoordinates, and technical benchmarks, then generate the necessary YAML and Markdown files automatically.
*   **Governance Check**: `"Agent, verify the data integrity of the knowledge base."`

The logic and automated scripts for these actions are stored in `4d-seismic-hub-maintenance/`.

---

### 🛠️ Getting Started


To run the hub locally (Jekyll environment):

```bash
# Clone the repository
git clone https://github.com/liuh886/4d-seismic-hub.git
cd 4d-seismic-hub

# Install dependencies
bundle install

# Start the development server
bundle exec jekyll serve
```

The site will be available at `http://localhost:4000/4d-seismic-hub/`.

---

### 💬 Community Perspectives Setup

Analysis posts render a single discussion module backed by GitHub Issues via `utterances`.

- `4D Forum` captures technical upside, caveats, questions, and counterexamples in one shared thread.
- The `Pro / Con` summary cards above the thread are reserved for agent-maintained synthesis using each post's `community_summary` front matter.

The live comments configuration lives in `_config.yml` under `community_comments`.

If you need an issue thread to survive future title edits or permalink cleanup, set a dedicated `community_issue_term` in the post front matter. Otherwise the site falls back to `page.id`.

---

### 🤝 Contributing

We rely on the community to keep this "online abstract" alive. Whether you are adding a new case study or fixing a technical parameter, your contributions are welcome.

1.  **Fork** the repository.
2.  **Create** a new branch for your feature or case study.
3.  **Submit** a Pull Request for peer review by the Working Group.

---

### 📄 License & Citation

- **Code**: [MIT License](LICENSE)
- **Content**: [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)

If you use the Hub for your research or project planning, please cite it as:
> *4D Seismic Hub Working Group (2026). 4D Seismic Hub: An online abstract of best practices. https://liuh886.github.io/4d-seismic-hub/*
