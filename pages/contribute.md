---
title: Contribute
layout: default
permalink: /pages/contribute/
---

# Contributing to 4D Seismic Hub

We welcome contributions of open presentations, case studies, and reference citations. This hub is built on a data-driven model using Jekyll and YAML—this means you don't need to write complex HTML to add content.

## How to Add Content

The easiest way to contribute is to submit a **Pull Request (PR)** on GitHub with updates to our data files.

### 1. Adding a New Paper or Report
To add a technical resource, edit `_data/papers.yml`.
Each entry should follow this format:
```yaml
- title: "Your Paper Title"
  authors: ["Author 1", "Author 2"]
  year: 2024
  description: "A short 1-2 sentence summary of the key 4D takeaway."
  link: "https://link-to-original-source.com"
  tags: ["Region", "Technology", "Asset Type"]
```

### 2. Adding a Case Study to the Map
To add a pinpoint to the Global Case Study Map, edit `_data/case_studies_map.yml`.
```yaml
- name: "Field Name"
  location: "Country/Basin"
  latitude: 0.00
  longitude: 0.00
  summary: "What decision was made based on the 4D data?"
```

## Contribution Workflow

1.  **Fork** the repository on GitHub.
2.  **Clone** your fork locally.
3.  **Create a new branch** for your feature (e.g., `add-gullfaks-case`).
4.  **Commit** your changes to the relevant `.yml` files.
5.  **Push** to your fork and submit a **Pull Request**.

## Style & Ethics

*   **Vendor Neutral:** Please avoid promotional or marketing language.
*   **Copyright:** Only link to materials that are already publicly accessible (OnePetro landing pages, open-access journals, public PDFs). Do not upload proprietary documents.
*   **Conciseness:** Focus on the "Decision Intelligence" aspect—how did the 4D data change the reservoir management plan?

## License

By contributing, you agree that your work will be licensed under the [MIT License](/LICENSE).
