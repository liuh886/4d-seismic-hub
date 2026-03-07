---
name: 4d-seismic-hub-maintenance
description: Intelligent Agent workflows for maintaining the 4D Seismic Hub. Includes one-click auditing, data governance, and automated content curation.
---

# 🤖 4D Seismic Hub Maintenance (Agent Mode)

This skill provides a comprehensive, automated framework for the long-term maintenance and growth of the 4D Seismic Hub. It leverages an **AI Maintenance Agent** to ensure data integrity, consistent styling, and high-quality decision intelligence.

## 🚀 One-Click Maintenance
**Trigger:** User says "Run routine maintenance" or "Audit the site".

The Agent will autonomously perform the following:
1.  **Health Audit**: Run `python 4d-seismic-hub-maintenance/scripts/audit_hub.py`. This script verifies:
    *   YAML Schema compliance for all data files.
    *   Coordinate validity for map markers.
    *   Markdown frontmatter and layout consistency for analysis posts.
2.  **Taxonomy Cleanup**: Standardize tags across the repository (e.g., merging "ccs" and "CCS").
3.  **Link Verification**: Periodically check for broken external links in `papers.yml`.
4.  **Auto-Correction**: Fix formatting, YAML indentation, and minor typos without manual intervention.

## 🧠 Intelligent Curation
**Trigger:** User provides a source (URL/PDF) and says "Add this case to the hub".

The Agent will:
1.  **Extract Decision Intelligence**: Identify how the 4D data impacted field development (the "So What?").
2.  **Synthesize Data**: Automatically generate YAML entries and a deep-dive analysis post (`_posts/`).
3.  **Inject Community Modules**: Ensure every new post includes the "Pro/Cons" interactive module with the direct GitHub edit link.
4.  **Coordinate Mapping**: Find and apply GPS coordinates for the field if not provided.

## 💬 Community Summary Maintenance
**Trigger:** User says "Summarize the forum thread for this post" or "Update the community summary".

The Agent will:
1.  Review the post front matter for any existing `community_summary`.
2.  Read the current GitHub issue thread associated with `community_issue_term` (or the post `page.id` fallback).
3.  Distill the strongest supporting and skeptical arguments into:
    *   `community_summary.pro`
    *   `community_summary.con`
    *   `community_summary.updated_at`
4.  Keep each bullet concrete, technical, and non-redundant.
5.  Update the post front matter rather than injecting synthesized text into the body.

## 🛡️ Quality Standards
*   **Mandatory Fields**: Every paper entry MUST have `nrms_median`, `sensor_type`, and `water_depth`.
*   **Aesthetic Uniformity**: All generated content must respect the design tokens in `assets/css/main.scss`.
*   **Verified Sources**: NRMS values must be cross-checked against the processing version (e.g., raw vs processed).

---
*Maintained by the 4D Seismic Hub AI Agent.*
