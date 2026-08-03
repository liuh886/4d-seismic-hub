# Homepage experience system

The homepage is structured as a product-led technical landing page rather than a portal dashboard.

## Reference principles

The redesign draws on the interaction discipline of modern product sites such as Readest:

- one clear value statement in the first screen;
- a strong product demonstration immediately below the primary actions;
- small, supporting collection statistics rather than dominant KPI cards;
- one feature idea per scroll scene;
- restrained motion that clarifies hierarchy instead of decorating every element.

The implementation does not copy Readest branding, imagery, typography, or product UI. The visual language remains specific to 4D seismic monitoring.

## Hero density

The previous homepage used a two-column hero with a fixed minimum height and a separate statistics band. The new hero:

- has no fixed minimum viewport height;
- centers the value statement and two primary actions;
- renders project, source, and analysis counts in a compact inline statistics rail;
- limits the technical product window to `380px` on desktop;
- reduces top and bottom padding;
- keeps the technical visual inside the hero rather than leaving a gap before the next section.

## Product demonstration

The hero product window previews a realistic Hub workflow:

- select a monitoring case;
- inspect base-versus-monitor change;
- connect repeatability, signal driver, and decision outcome.

It is built from semantic HTML and inline SVG. No screenshots or external image assets are required.

## Scroll storytelling

The central section uses a sticky visual with three states:

1. **Discover** — project context and field selection;
2. **Compare** — base and monitor survey comparison;
3. **Interpret** — evidence flow into a decision note.

`IntersectionObserver` activates the scene nearest the reading focus. The text remains normal document content, so the workflow is still understandable when JavaScript is unavailable.

## Motion policy

- reveal transitions run only after JavaScript adds the `has-home-motion` class;
- the hero receives a maximum 16px scroll-linked shift;
- scene transitions use opacity and small transforms;
- no animation framework or external runtime is loaded;
- `prefers-reduced-motion: reduce` disables parallax, pulsing, reveal transforms, and scene transitions;
- mobile layouts remove sticky behavior and show each story step in normal flow.

## Validation

`tests/validate_homepage_experience.rb` checks:

- the old tall hero and standalone statistics structures do not return;
- the compact product window and small statistics styles remain present;
- the Discover / Compare / Interpret story states remain wired;
- reduced-motion support remains present;
- no heavy animation dependency is introduced;
- homepage JavaScript passes `node --check`;
- homepage CSS braces remain balanced.

The shared repository CI runs this validator with the existing source, case, community, and Benchmark contracts before the production Jekyll build.
