# 4D Seismic Hub Visual System

## Design direction

The visual system positions 4D Seismic Hub as a technical decision-support resource rather than a generic academic blog. Its visual language combines:

- deep subsurface navy for authority and focus;
- teal for monitoring, continuity, and linked evidence;
- amber for change signals, alerts, and time-lapse differences;
- fine grids and seismic traces as restrained technical texture;
- compact monospace labels for parameters and system states;
- generous white space and strong hierarchy for long-form reading.

## Core tokens

| Role | Token | Value |
| --- | --- | --- |
| Deep background | `--hub-deep` | `#071923` |
| Primary text | `--hub-ink` | `#10232e` |
| Secondary text | `--hub-ink-soft` | `#536975` |
| Primary accent | `--hub-accent` | `#0b7f82` |
| Change signal | `--hub-signal` | `#f2a33a` |
| Soft surface | `--hub-surface-soft` | `#f3f7f8` |
| Border | `--hub-line` | `#d6e2e5` |

The implemented source of truth is `assets/css/hub.css`.

## Information architecture

The primary navigation is reduced to five user goals:

1. Home — understand the product and choose a working mode.
2. Case Library — explore projects and technical evidence.
3. Benchmark — compare parameters across projects.
4. Analysis — read decision-oriented field notes.
5. About — understand scope and governance.

Contribution and working-group actions remain contextual calls to action rather than competing primary navigation items.

## Reusable components

- `hub-page-hero`: page identity, purpose, and scope.
- `hub-card`: primary navigation and feature cards.
- `hub-library-card`: case and paper records.
- `hub-tool-panel`: search and filter controls.
- `hub-map`: shared map container.
- `hub-table`: engineering comparison table.
- `hub-button`: primary and secondary actions.
- `hub-tag`: compact technical metadata.

## Accessibility baseline

- visible keyboard focus on links, controls, rows, and scrollable tables;
- semantic labels for search and filter controls;
- keyboard activation for comparison rows;
- live result counts for search and filters;
- responsive layouts from three columns to one;
- reduced-motion behavior for users who request it;
- color is not the only indication of table selection or interaction state.

## Next visual phase

The next phase should focus on content-level consistency rather than another broad restyle:

1. standardize post front matter for reservoir type, acquisition system, signal driver, repeat interval, and decision outcome;
2. add a shared case-detail header and parameter summary component to all analysis posts;
3. replace generic emoji in legacy pages with a small, consistent icon set;
4. introduce empty, loading, and external-resource states for maps and charts;
5. test real devices and capture visual regression baselines for the home, library, comparison, and post templates.
