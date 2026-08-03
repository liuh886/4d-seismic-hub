import fs from 'node:fs/promises';
import path from 'node:path';
import { chromium } from 'playwright-core';

const chromePath = process.env.CHROME_BIN;
const homeUrl = process.env.HOME_URL || 'http://127.0.0.1:4173/4d-seismic-hub/';
const screenshotDir = process.env.SCREENSHOT_DIR || '_site-checks';

if (!chromePath) {
  throw new Error('CHROME_BIN is required for the homepage browser smoke test.');
}

const viewports = [
  { name: 'desktop-1366x768', width: 1366, height: 768 },
  { name: 'desktop-1440x900', width: 1440, height: 900 },
  { name: 'desktop-1920x1080', width: 1920, height: 1080 },
  { name: 'tablet-768x1024', width: 768, height: 1024 },
  { name: 'mobile-390x844', width: 390, height: 844 }
];

await fs.mkdir(screenshotDir, { recursive: true });

const browser = await chromium.launch({
  executablePath: chromePath,
  headless: true,
  args: ['--no-sandbox', '--disable-dev-shm-usage']
});

const failures = [];
const within = (actual, expected, tolerance = 1) => Math.abs((actual ?? -999) - expected) <= tolerance;

for (const viewport of viewports) {
  const page = await browser.newPage({
    viewport: { width: viewport.width, height: viewport.height },
    deviceScaleFactor: 1,
    reducedMotion: 'reduce'
  });

  const badResponses = [];
  page.on('response', (response) => {
    if (response.status() >= 400) badResponses.push(`${response.status()} ${response.url()}`);
  });

  const response = await page.goto(homeUrl, { waitUntil: 'networkidle' });
  if (!response || !response.ok()) {
    failures.push(`${viewport.name}: homepage response was not successful`);
    await page.close();
    continue;
  }

  await page.evaluate(() => document.fonts?.ready);

  const metrics = await page.evaluate(() => {
    const html = document.documentElement;
    const hero = document.querySelector('.hub-r-hero');
    const title = document.querySelector('.hub-r-hero h1');
    const lede = document.querySelector('.hub-r-hero-lede');
    const shell = document.querySelector('.hub-r-section .hub-shell');
    const section = document.querySelector('.hub-r-section');
    const sectionTitle = document.querySelector('.hub-r-section-heading h2');
    const editorialGrid = document.querySelector('.hub-r-editorial-grid');
    const masthead = document.querySelector('.masthead');
    const navLink = document.querySelector('.greedy-nav .visible-links a');
    const primaryButton = document.querySelector('.hub-r-button--primary');

    const visibleOverflow = Array.from(document.body.querySelectorAll('*')).filter((element) => {
      const rect = element.getBoundingClientRect();
      const style = getComputedStyle(element);
      if (style.display === 'none' || style.visibility === 'hidden' || rect.width === 0 || rect.height === 0) return false;
      if (style.position === 'fixed') return false;
      return rect.left < -1 || rect.right > html.clientWidth + 1;
    }).slice(0, 8).map((element) => `${element.tagName.toLowerCase()}.${element.className}`);

    const heroRect = hero?.getBoundingClientRect();
    const ledeRect = lede?.getBoundingClientRect();
    const shellRect = shell?.getBoundingClientRect();
    const buttonRect = primaryButton?.getBoundingClientRect();
    const sectionStyle = section ? getComputedStyle(section) : null;
    const gridStyle = editorialGrid ? getComputedStyle(editorialGrid) : null;
    const mastheadStyle = masthead ? getComputedStyle(masthead) : null;

    return {
      rootFontSize: Number.parseFloat(getComputedStyle(html).fontSize),
      clientWidth: html.clientWidth,
      scrollWidth: html.scrollWidth,
      bodyScrollWidth: document.body.scrollWidth,
      mainCount: document.querySelectorAll('#main').length,
      h1Count: document.querySelectorAll('h1').length,
      heroLeft: heroRect?.left,
      heroRight: heroRect?.right,
      heroHeight: heroRect?.height,
      titleFontSize: title ? Number.parseFloat(getComputedStyle(title).fontSize) : null,
      ledeFontSize: lede ? Number.parseFloat(getComputedStyle(lede).fontSize) : null,
      ledeTextAlign: lede ? getComputedStyle(lede).textAlign : null,
      ledeCenterDelta: ledeRect ? Math.abs((ledeRect.left + ledeRect.right) / 2 - html.clientWidth / 2) : null,
      sectionTitleFontSize: sectionTitle ? Number.parseFloat(getComputedStyle(sectionTitle).fontSize) : null,
      navLinkFontSize: navLink ? Number.parseFloat(getComputedStyle(navLink).fontSize) : null,
      primaryButtonHeight: buttonRect?.height,
      shellWidth: shellRect?.width,
      shellCenterDelta: shellRect ? Math.abs((shellRect.left + shellRect.right) / 2 - html.clientWidth / 2) : null,
      sectionPaddingTop: sectionStyle ? Number.parseFloat(sectionStyle.paddingTop) : null,
      gridColumns: gridStyle ? gridStyle.gridTemplateColumns.split(' ').filter(Boolean).length : null,
      mastheadTransparent: mastheadStyle ? mastheadStyle.backgroundColor === 'rgba(0, 0, 0, 0)' : null,
      visibleOverflow
    };
  });

  const isMobile = viewport.width <= 700;
  const isTablet = viewport.width > 700 && viewport.width <= 980;
  const isShortDesktop = viewport.width >= 981 && viewport.height <= 820;
  const isLargeDesktop = viewport.width >= 1600 && viewport.height >= 900;

  const expectedColumns = isMobile ? 1 : viewport.width <= 980 ? 2 : 3;
  const maxHeroHeight = isMobile ? 780 : isShortDesktop ? 580 : isLargeDesktop ? 660 : 640;
  const minHeroHeight = isMobile ? 0 : isShortDesktop ? 560 : isLargeDesktop ? 640 : 620;
  const expectedTitleRem = isMobile
    ? 3.05
    : isShortDesktop
      ? 5.05
      : isTablet
        ? 4.1
        : viewport.width <= 1180
          ? 4.8
          : isLargeDesktop
            ? 6.1
            : 5.8;
  const expectedLedeRem = isMobile ? 1.04 : 1.2;
  const expectedSectionTitleRem = isMobile ? 2.35 : isTablet ? 2.7 : 3.15;
  const expectedTitlePx = expectedTitleRem * metrics.rootFontSize;
  const expectedLedePx = expectedLedeRem * metrics.rootFontSize;
  const expectedSectionTitlePx = expectedSectionTitleRem * metrics.rootFontSize;

  const checks = [
    [metrics.scrollWidth <= metrics.clientWidth + 1, `document scrollWidth ${metrics.scrollWidth} exceeds clientWidth ${metrics.clientWidth}`],
    [metrics.bodyScrollWidth <= metrics.clientWidth + 1, `body scrollWidth ${metrics.bodyScrollWidth} exceeds clientWidth ${metrics.clientWidth}`],
    [metrics.visibleOverflow.length === 0, `visible elements overflow horizontally: ${metrics.visibleOverflow.join(', ')}`],
    [metrics.mainCount === 1, `expected one #main, found ${metrics.mainCount}`],
    [metrics.h1Count === 1, `expected one h1, found ${metrics.h1Count}`],
    [Math.abs(metrics.heroLeft ?? 99) <= 1, `hero left edge is ${metrics.heroLeft}`],
    [Math.abs((metrics.heroRight ?? 0) - metrics.clientWidth) <= 1, `hero right edge is ${metrics.heroRight}`],
    [(metrics.heroHeight ?? 9999) <= maxHeroHeight, `hero height ${metrics.heroHeight} exceeds ${maxHeroHeight}`],
    [(metrics.heroHeight ?? -1) >= minHeroHeight, `hero height ${metrics.heroHeight} is below ${minHeroHeight}`],
    [within(metrics.titleFontSize, expectedTitlePx), `title font size ${metrics.titleFontSize}px does not match ${expectedTitleRem}rem × ${metrics.rootFontSize}px = ${expectedTitlePx}px`],
    [within(metrics.ledeFontSize, expectedLedePx), `lede font size ${metrics.ledeFontSize}px does not match ${expectedLedeRem}rem × ${metrics.rootFontSize}px = ${expectedLedePx}px`],
    [within(metrics.sectionTitleFontSize, expectedSectionTitlePx), `section title font size ${metrics.sectionTitleFontSize}px does not match ${expectedSectionTitleRem}rem × ${metrics.rootFontSize}px = ${expectedSectionTitlePx}px`],
    [isMobile || (metrics.navLinkFontSize ?? 0) >= metrics.rootFontSize, `desktop navigation font size ${metrics.navLinkFontSize}px is smaller than the root size ${metrics.rootFontSize}px`],
    [(metrics.primaryButtonHeight ?? 0) >= (isMobile ? 47 : 49), `primary button height ${metrics.primaryButtonHeight}px is too small`],
    [metrics.ledeTextAlign === 'center', `hero lede text-align is ${metrics.ledeTextAlign}`],
    [(metrics.ledeCenterDelta ?? 99) <= 2, `hero lede center delta is ${metrics.ledeCenterDelta}`],
    [(metrics.shellWidth ?? 9999) <= 1241, `content shell width ${metrics.shellWidth} exceeds the 1240px homepage grid`],
    [(metrics.shellCenterDelta ?? 99) <= 2, `content shell center delta is ${metrics.shellCenterDelta}`],
    [(metrics.sectionPaddingTop ?? 999) <= 60, `section padding ${metrics.sectionPaddingTop} exceeds the compact 60px rhythm`],
    [metrics.gridColumns === expectedColumns, `editorial grid has ${metrics.gridColumns} columns; expected ${expectedColumns}`],
    [metrics.mastheadTransparent === true, 'masthead is not transparent at the top']
  ];

  for (const [passed, message] of checks) {
    if (!passed) failures.push(`${viewport.name}: ${message}`);
  }

  if (badResponses.length) failures.push(`${viewport.name}: failed assets: ${badResponses.join('; ')}`);

  await page.evaluate(() => window.scrollTo(0, 0));
  await page.screenshot({
    path: path.join(screenshotDir, `${viewport.name}-top.png`),
    fullPage: true
  });

  await page.evaluate(() => window.scrollTo(0, 96));
  await page.waitForTimeout(100);
  const surfaced = await page.locator('.masthead').evaluate((element) => {
    const color = getComputedStyle(element).backgroundColor;
    return element.classList.contains('is-scrolled') && color !== 'rgba(0, 0, 0, 0)';
  });
  if (!surfaced) failures.push(`${viewport.name}: masthead did not surface after scrolling`);

  await page.screenshot({
    path: path.join(screenshotDir, `${viewport.name}-nav-scrolled.png`),
    fullPage: false
  });

  await page.close();
}

await browser.close();

if (failures.length) {
  console.error('Homepage browser smoke test failed:');
  failures.forEach((failure) => console.error(`  - ${failure}`));
  process.exit(1);
}

console.log(`Homepage browser smoke test passed at ${viewports.length} viewports with balanced scale.`);
