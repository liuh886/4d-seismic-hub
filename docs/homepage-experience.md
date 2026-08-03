# Homepage experience system

The homepage is a focused technical landing page built from real repository content rather than a simulated application interface.

## Reference principles

The page retains the useful interaction discipline of Readest:

- one clear value statement in the first screen;
- small supporting collection statistics;
- a limited number of primary routes;
- one idea per section;
- restrained motion that clarifies hierarchy;
- a navigation bar that recedes at the top and becomes legible only when needed during scrolling.

The implementation does not reproduce Readest branding, imagery, typography, or application UI.

## Native theme integration

The homepage uses the custom `_layouts/home.html` layout. That layout inherits the Minimal Mistakes `default` shell so the standard head, masthead, footer, scripts, and accessibility links remain intact, but it does not route homepage content through the theme's `splash` article and `page__content` wrappers.

This is intentional. The previous implementation attempted to escape the theme's padded and maximum-width `#main` container with `100vw` and viewport-relative negative margins. That mixed two incompatible width models, produced horizontal overflow, and made the page appear zoomed on wide desktop displays.

The native homepage layout now provides a single full-width `<main>` element. Homepage CSS explicitly resets that element to `width: 100%`, `max-width: none`, and zero outer padding. Content sections use a normal 1,240-pixel inner shell. No viewport breakout calculation is required.

## Primary navigation

The site title already returns visitors to the homepage, so `Home` is not duplicated in the header. The primary navigation contains only:

- **Cases**;
- **Benchmark**;
- **About**.

The theme renders `body.layout--home` before CSS and JavaScript run. Homepage masthead styling therefore uses this stable body class instead of adding a temporary class to the document element.

At the top of the homepage, the masthead is fixed over the hero with a transparent background. Once the page scroll position exceeds 24 pixels, the masthead gains a translucent surface, border, shadow, blur, and slightly tighter vertical padding. Other pages retain the standard surfaced masthead.

## Hero and typography

The hero spans the real page width through the native layout and uses a constrained inner content shell. It contains only:

- the project value statement;
- the case-library and Benchmark actions;
- the project, source-record, and case-analysis counts.

Desktop typography uses bounded values rather than aggressive viewport-width scaling:

- the hero title is 5.6rem on large desktops, then steps down at 1,200px and 900px breakpoints;
- section headings use a 3.25rem desktop size and step down at smaller breakpoints;
- the hero introduction is centered within a 65-character line length;
- cards and workflow copy retain readable sizes without forcing excessive minimum heights.

This prevents large monitors from magnifying the interface as though the browser had been zoomed, while preserving a strong product-led hierarchy.

## Vertical rhythm

The hero uses a bounded 560–660 pixel height range. Standard sections use 4.25rem vertical padding, cards use a 220-pixel desktop minimum height, and workflow rows use compact content-driven padding. Mobile removes fixed hero height and reduces section spacing further.

The goal is for a conventional desktop viewport to show a complete content unit and a clear indication of the next section, rather than treating every section as a full-screen slide.

## Real-content rule

The homepage must not imply product capability through invented imagery. Validation prohibits simulated workspaces, decorative seismic canvases presented as output, synthetic maps, fictional comparison panels, fabricated decision interfaces, and inline SVG pseudo-screenshots.

The homepage instead presents actual collection counts, functioning product routes, published posts, real case-study records, and the 4D decision chain.

## Motion policy

Motion is limited to progressive disclosure of real text and content cards:

- `IntersectionObserver` reveals sections when they enter the viewport;
- navigation state follows scroll position without a third-party runtime;
- no parallax or sticky scene-switching interface is used;
- no animation framework or external runtime is loaded;
- content is immediately visible when JavaScript is unavailable;
- `prefers-reduced-motion: reduce` disables reveal and navigation transitions.

## Validation

`tests/validate_homepage_experience.rb` checks:

- the header contains exactly the three intended destinations;
- `index.md` uses the native `home` layout rather than `splash`;
- `_layouts/home.html` inherits `default` and exposes one full-width main element;
- the layered density stylesheet and temporary document-class workaround remain removed;
- `100vw`, viewport-relative breakout margins, and aggressive wide-screen font scaling do not return;
- transparent and scrolled masthead states remain implemented;
- bounded hero, section, and card sizing remains present;
- simulated visual scenes do not return;
- real statistics, workflows, posts, and case records remain present;
- homepage JavaScript passes `node --check` and CSS braces remain balanced.

The shared repository CI runs this validator with the source, case, community, and Benchmark contracts before the production Jekyll build.
