# 4D Seismic Hub

The **4D Seismic Hub** is an open, community‑driven project whose purpose is to provide a concise, accessible “**abstract**” of the best practices in time‑lapse (4D) seismic monitoring.  Rather than allowing valuable knowledge to languish behind paywalls or be forgotten after a conference talk, this hub curates open‑access presentations and case studies and summarises them in reusable formats.  By doing so, we make it easier for engineers, geoscientists and researchers to reuse proven ideas at conferences, in proposals and during project planning.

This repository contains the source for a public GitHub Pages site where we collect links to open presentations, case studies and other resources related to 4D seismic and ocean‑bottom node (OBN) acquisition.  It also includes guidelines on how to join the working group, contribute new materials and cite the hub.  The site aims to act as an **online abstract** for 4D seismic practice: short, decision‑oriented summaries point back to the original sources, enabling you to quickly understand what was done and why.

The site is structured as a Jekyll website with the following key sections:

* **About** – a short description of the initiative and our vision.
* **Resources** – a page that automatically renders the list of papers stored in `/_data/papers.yml`, including the five EarthDoc presentations referenced in our internal discussions.
* **Case studies** – examples of 4D seismic projects with narrative context explaining the questions asked, the methods applied and the results obtained.
* **Working Group** – outlines the charter, membership and meeting cadence of the community.
* **Contribute** – instructions for submitting new resources, case studies or improvements to the site.

Feel free to fork this repo and build your own customised instance, or submit a pull request to propose a change.  The code and content are licensed permissively (MIT for code, CC BY 4.0 for content) to encourage reuse and adaptation.  We encourage you to view this project not merely as a website but as a living abstract that can be cited, extended and remixed for your own needs.

## Getting started

To spin up the site locally you need Ruby and Bundler installed.  Clone the repository, install the dependencies and run the development server:

```bash
git clone https://github.com/your‑organisation/4D‑Seismic‑Initiative.git
cd 4D‑Seismic‑Initiative
bundle install
bundle exec jekyll serve
```

You can then push the contents to a new GitHub repository and enable Pages via the repository settings.  GitHub Actions support is pre‑configured for automatic builds on every push.
