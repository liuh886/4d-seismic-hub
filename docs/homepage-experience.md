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

## Primary navigation

The site title already returns visitors to the homepage, so `Home` is not duplicated in the header. The primary navigation contains only:

- **Cases**;
- **Benchmark**;
- **About**.

On the homepage, the masthead is fixed over the hero with a transparent background. Once the page scroll position exceeds 24 pixels, the masthead gains a translucent surface, border, shadow, blur, and slightly tighter vertical padding. Other pages retain the standard surfaced masthead.

Analysis, contribution, and working-group pages remain available through contextual homepage and footer links.

## Full-bleed hero

The splash layout can place page content inside a theme-controlled content wrapper. To prevent visible white gutters, `.hub-readest-home` deliberately breaks out of that wrapper using a `100vw` width and viewport-relative margins. Individual content remains constrained by a 1,240-pixel inner shell.

The hero uses the full viewport width and up to one small viewport height. It contains only:

- the project value statement;
- the case-library and Benchmark actions;
- the project, source-record, and case-analysis counts.

It does not contain a simulated product screenshot or a decorative technical illustration.

## Typography and composition

The homepage uses a larger, more deliberate type scale:

- the hero title scales from 3.6rem to 7.35rem;
- the hero introduction scales up to 1.36rem;
- section headings use a stacked editorial composition rather than a mechanical title-left/description-right grid;
- section body copy starts around 1rem and uses generous line height;
- cards, workflow rows, navigation, buttons, and metadata all use larger readable sizes;
- line lengths are constrained and `text-wrap` is used to avoid awkward isolated words.

The hero headline has a deliberate two-line hierarchy without relying on a hard-coded `<br>` element.

## Real-content rule

The homepage must not imply product capability through invented imagery. The following elements are prohibited by validation:

- simulated monitoring workspaces;
- decorative seismic canvases presented as application output;
- synthetic maps and project markers;
- fictional base-versus-monitor comparison panels;
- fabricated evidence-to-decision interfaces;
- inline SVG illustrations used as pseudo-screenshots.

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
- the homepage declares its navigation context before its stylesheet;
- transparent and scrolled masthead states remain implemented;
- the homepage remains full bleed while its inner content stays constrained;
- the enlarged typography and stacked section composition remain present;
- simulated workspace, map, seismic, comparison, and interpretation scenes do not return;
- the homepage contains no inline SVG pseudo-screenshot;
- real collection statistics, workflows, posts, and case records remain present;
- reveal behavior and reduced-motion support remain present;
- homepage JavaScript passes `node --check`;
- homepage CSS braces remain balanced.

The shared repository CI runs this validator with the source, case, community, and Benchmark contracts before the production Jekyll build.