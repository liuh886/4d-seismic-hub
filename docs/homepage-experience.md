# Homepage experience system

The homepage is a focused technical landing page built from real repository content rather than a simulated application interface.

## Reference principles

The page retains the useful interaction discipline of Readest:

- one clear value statement in the first screen;
- very small supporting collection statistics;
- a limited number of primary routes;
- one idea per section;
- restrained motion that clarifies hierarchy.

The implementation does not reproduce Readest branding, imagery, typography, or application UI.

## Primary navigation

The site title already returns visitors to the homepage, so `Home` is not duplicated in the header.

The primary navigation contains only:

- **Cases**;
- **Benchmark**;
- **About**.

Analysis, contribution, and working-group pages remain available through contextual homepage and footer links.

## Hero density

The hero contains only:

- the project value statement;
- the case-library and Benchmark actions;
- the project, source-record, and case-analysis counts.

It does not contain a simulated product screenshot or a decorative technical illustration. The statistics remain a compact inline rail with small numerals.

## Real-content rule

The homepage must not imply product capability through invented imagery. The following elements have been removed and are prohibited by validation:

- simulated monitoring workspaces;
- decorative seismic canvases presented as application output;
- synthetic maps and project markers;
- fictional base-versus-monitor comparison panels;
- fabricated evidence-to-decision interfaces;
- inline SVG illustrations used as pseudo-screenshots.

The homepage instead presents:

- actual collection counts derived from repository data;
- functioning links to the case library, Benchmark, and analysis pages;
- real published posts;
- real case-study records;
- a concise description of the 4D decision chain.

## Motion policy

Motion is limited to progressive disclosure of real text and content cards:

- `IntersectionObserver` reveals sections when they enter the viewport;
- no parallax or scroll-linked transformation is used;
- no sticky scene-switching interface is used;
- no animation framework or external runtime is loaded;
- content is immediately visible when JavaScript is unavailable;
- `prefers-reduced-motion: reduce` disables reveal transitions.

## Validation

`tests/validate_homepage_experience.rb` checks:

- the header contains exactly the three intended destinations;
- `Home` and `Analysis` do not return to the primary navigation;
- simulated workspace, map, seismic, comparison, and interpretation scenes do not return;
- the homepage contains no inline SVG pseudo-screenshot;
- real collection statistics, workflows, posts, and case records remain present;
- reveal behavior and reduced-motion support remain present;
- homepage JavaScript passes `node --check`;
- homepage CSS braces remain balanced.

The shared repository CI runs this validator with the source, case, community, and Benchmark contracts before the production Jekyll build.
