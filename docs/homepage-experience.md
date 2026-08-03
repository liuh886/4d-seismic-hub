# Homepage experience system

The homepage is a focused technical landing page built from real repository content and the native Minimal Mistakes shell.

## Architecture

`_layouts/home.html` inherits the theme `default` layout. This preserves the standard head, masthead, footer, scripts, and skip links while bypassing only the `splash` article and `page__content` wrappers that are inappropriate for a full-width landing page.

The homepage therefore uses one native `<main id="main" class="home-main">` element. It does not use `100vw`, negative viewport margins, or overflow masking. Inner content reuses the shared `--hub-content` width of 1,180 pixels so the masthead, homepage, and inner pages align to the same grid.

Homepage assets are conditionally loaded from `_includes/head/custom.html`. Stylesheets and deferred JavaScript are emitted in the document head rather than inserted into page content.

## Navigation

The site title returns to the homepage, so the primary navigation contains only:

- **Cases**;
- **Benchmark**;
- **About**.

Minimal Mistakes renders `body.layout--home` before assets execute. The homepage masthead uses that native class: transparent at the top, then surfaced after 24 pixels of scrolling with a translucent background, border, shadow, and blur. Other layouts retain the normal masthead behavior.

## Typography and rhythm

Typography is bounded by explicit breakpoints instead of continuous viewport scaling:

- hero title: 4.75rem on standard desktop, 4.25rem below 1,180px, 3.65rem below 980px, and 2.85rem on mobile;
- section title: 2.75rem on desktop with stepped reductions below 980px and 700px;
- hero introduction: centered within a 68-character measure;
- standard sections: 3.75rem vertical padding;
- cards: 210-pixel desktop minimum height and content-driven height on mobile.

The desktop hero is 600 pixels high, contracts to 540 pixels on short laptop screens, and grows only to 620 pixels on large high-resolution displays. This keeps the first screen immersive without turning every section into a full-screen slide.

## Content and semantics

The homepage contains no simulated product UI or decorative pseudo-screenshot. It presents actual collection counts, functioning routes, published posts, real case-study records, and the 4D decision chain.

Collection counts use a semantic description list. Sections are associated with their headings through `aria-labelledby`. The custom main element remains keyboard-focusable so the theme's native skip link works correctly.

The compact SVG mark uses a 64×64 viewBox with no legacy 800×600 canvas or opaque page-sized background. The same asset is used as the masthead logo and SVG favicon.

## Motion

Motion is limited to progressive disclosure of real content:

- the hero is stable on first paint and is not reveal-animated;
- `IntersectionObserver` reveals lower sections;
- a passive scroll listener updates masthead state;
- no animation framework, parallax, sticky scene switcher, or `requestAnimationFrame` loop is used;
- reduced-motion users receive immediate content with effectively disabled transitions.

## Quality gates

`tests/validate_homepage_experience.rb` checks source structure, native layout integration, head asset placement, bounded type, semantic markup, logo dimensions, JavaScript syntax, and removal of old overflow workarounds.

`scripts/validate_built_homepage.rb` checks the generated HTML after Jekyll build: one main element, one H1, no splash wrappers, stylesheet and deferred script in the head, semantic statistics, resolved Liquid, and compact built assets.

`scripts/homepage_browser_smoke.mjs` renders the built site in system Chrome at five viewports:

- 1366×768;
- 1440×900;
- 1920×1080;
- 768×1024;
- 390×844.

The browser gate verifies horizontal overflow, full-width hero geometry, centered content shell and introduction, bounded hero height and title size, responsive grid columns, top-state transparency, and surfaced navigation after scrolling. Full-page screenshots are retained as a seven-day CI artifact for visual review.
