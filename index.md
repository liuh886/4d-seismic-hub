---
title: "Welcome"
layout: home
author_profile: false
---

<style>
:root {
  --hub-midnight: #0b1f2a;
  --hub-emerald: #0da19d;
  --hub-ink: #0f1820;
  --hub-sand: #f7f1e7;
  --hub-pond: #124057;
  --hub-shadow: rgba(3, 9, 22, 0.45);
}

.hero {
  background: radial-gradient(circle at 20% -20%, rgba(13, 161, 157, 0.45), transparent 35%),
    linear-gradient(135deg, #0f1820, #082534 60%, #0f1820);
  color: #fff;
  padding: 3rem 2.5rem;
  border-radius: 1.75rem;
  margin-bottom: 2.75rem;
  box-shadow: 0 30px 70px var(--hub-shadow);
  overflow: hidden;
}

.hero__content {
  max-width: 760px;
}

.hero__eyebrow {
  text-transform: uppercase;
  letter-spacing: 0.3rem;
  font-size: 0.75rem;
  color: rgba(255, 255, 255, 0.7);
  margin-bottom: 0.75rem;
}

.hero h1 {
  margin-top: 0;
  margin-bottom: 1rem;
  font-size: clamp(2.5rem, 2.3vw + 1.5rem, 3.35rem);
  line-height: 1.1;
}

.hero p {
  margin-bottom: 1rem;
  color: rgba(255, 255, 255, 0.9);
  font-size: 1.05rem;
}

.hero__actions {
  display: flex;
  gap: 0.75rem;
  flex-wrap: wrap;
  margin: 1.5rem 0;
}

.hero__btn {
  border: none;
  padding: 0.85rem 1.75rem;
  border-radius: 999px;
  font-weight: 600;
  text-decoration: none;
  cursor: pointer;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  font-size: 1rem;
}

.hero__btn--primary {
  background: linear-gradient(135deg, #15c3b8, #0f8f77);
  color: #fff;
  box-shadow: 0 10px 25px rgba(3, 9, 22, 0.4);
}

.hero__btn--ghost {
  border: 1px solid rgba(255, 255, 255, 0.7);
  color: #fff;
  background: transparent;
}

.hero__meta {
  display: flex;
  gap: 1.25rem;
  flex-wrap: wrap;
  margin-top: 1rem;
}

.hero__meta strong {
  display: block;
  font-size: 1.15rem;
  margin-top: 0.25rem;
}

.highlight-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
  gap: 1.5rem;
  margin-bottom: 2.75rem;
}

.feature-card {
  border: 1px solid rgba(15, 24, 32, 0.08);
  border-radius: 1.25rem;
  padding: 1.75rem;
  background: #fff;
  box-shadow: 0 15px 35px rgba(3, 9, 22, 0.08);
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}

.feature-card__eyebrow {
  font-size: 0.85rem;
  letter-spacing: 0.2rem;
  text-transform: uppercase;
  color: #4a5663;
  margin-bottom: 0.5rem;
}

.feature-card h3 {
  margin: 0 0 0.65rem;
  font-size: 1.35rem;
}

.feature-card ul {
  padding-left: 1rem;
  margin: 0.5rem 0 1.25rem;
  color: #2a3440;
}

.feature-card li {
  margin-bottom: 0.35rem;
}

.feature-card a {
  margin-top: auto;
  color: var(--hub-emerald);
  font-weight: 600;
  text-decoration: none;
}

.design-section {
  margin-bottom: 2.75rem;
}

.design-section h2 {
  margin-bottom: 0.5rem;
}

.design-grid {
  display: grid;
  gap: 1.25rem;
  grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
}

.design-card {
  background: var(--hub-sand);
  border-radius: 1.25rem;
  padding: 1.5rem;
  border: 1px solid rgba(15, 24, 32, 0.08);
  min-height: 220px;
  display: flex;
  flex-direction: column;
}

.design-card h3 {
  margin-top: 0;
  margin-bottom: 0.6rem;
}

.design-card p {
  flex: 1;
  color: #162028;
  margin-bottom: 0.85rem;
}

.design-card small {
  color: #3f4a55;
}

.cta-panel {
  background: #0b1f2a;
  color: #fff;
  padding: 2rem 2.25rem;
  border-radius: 1.5rem;
  border: 1px solid rgba(255, 255, 255, 0.1);
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
}

.cta-panel a {
  color: #fff;
  font-weight: 600;
  text-decoration: none;
}

.cta-panel .cta-actions {
  margin-top: 0.75rem;
  display: flex;
  gap: 1rem;
  flex-wrap: wrap;
}

.cta-panel .cta-btn {
  border-radius: 999px;
  padding: 0.65rem 1.4rem;
  font-size: 1rem;
  border: 1px solid rgba(255, 255, 255, 0.5);
  background: transparent;
  color: #fff;
  text-decoration: none;
  font-weight: 600;
}

.cta-panel blockquote {
  margin: 0;
  font-style: italic;
  color: rgba(255, 255, 255, 0.85);
}

@media (min-width: 768px) {
  .hero {
    padding: 3.5rem 3rem;
  }

  .hero__actions {
    gap: 1rem;
  }
}
</style>

<section class="hero">
  <div class="hero__content">
    <p class="hero__eyebrow">4D Seismic Hub</p>
    <h1>Accelerating mature-field redevelopment with decision-oriented seismic intelligence</h1>
    <p>
      Time-lapse or <strong>four-dimensional (4D) seismic</strong> monitoring is transforming how mature operators
      understand reservoirs, optimise production and plan infill drilling. By comparing repeat surveys over the same area,
      we directly observe fluid movement, compaction, pressure evolution and other signals that drive confident decisions.
    </p>
    <p>
      This site is curated by the 4D Seismic Hub Working Group to collect open-access presentations, case studies, tutorials
      and best practices so that the insights can be reused in proposals, board decks or operational planning.
    </p>
    <div class="hero__actions">
      <a class="hero__btn hero__btn--primary" href="/pages/resources">Explore resources</a>
      <a class="hero__btn hero__btn--ghost" href="/pages/case-studies">Browse case studies</a>
    </div>
    <div class="hero__meta">
      <div>
        <span>Resources</span>
        <strong>Open & curated</strong>
      </div>
      <div>
        <span>Case studies</span>
        <strong>Decision-focused narratives</strong>
      </div>
      <div>
        <span>Community</span>
        <strong>Working Group</strong>
      </div>
    </div>
  </div>
</section>

<section class="highlight-grid">
  <article class="feature-card">
    <p class="feature-card__eyebrow">Jump into knowledge</p>
    <h3>Curated resources with context</h3>
    <p>
      The [Resources](/pages/resources) page renders every open-access paper, presentation or dataset that the hub has
      collected, helping you find relevant studies and follow their application notes.
    </p>
    <ul>
      <li>Filters highlight key geographies, acquisition styles or processing approaches.</li>
      <li>Links stay true to the original reports so references can be cited directly.</li>
      <li>New contributions can use the same structure for consistent navigation.</li>
    </ul>
    <a href="/pages/resources">Visit the resource catalog →</a>
  </article>

  <article class="feature-card">
    <p class="feature-card__eyebrow">Operational stories</p>
    <h3>Case studies that show how 4D makes decisions</h3>
    <p>
      Example narratives in [Case studies](/pages/case-studies) distil the question asked, the workflow applied and the outcomes observed,
      so you can gauge how 4D seismic data changes reservoir management plans.
    </p>
    <ul>
      <li>Standards for describing ambiguities, constraints and success metrics.</li>
      <li>Highlights on how data informed drilling, infill or EOR choices.</li>
      <li>Lessons learned for mature fields and complex carbonates.</li>
    </ul>
    <a href="/pages/case-studies">Read the case stories →</a>
  </article>

  <article class="feature-card">
    <p class="feature-card__eyebrow">Collaborative structure</p>
    <h3>Working Group initiatives & contributions</h3>
    <p>
      The hub grew from collaborative discussions between operators, service providers and researchers. Learn how the
      Working Group charter, meeting cadence and membership work in [Documentation](/docs/charter), then add your own material
      via the [Contribute](/pages/contribute) page.
    </p>
    <ul>
      <li>Transparent governance for volunteer contributors.</li>
      <li>Open calls for new case cards, checklists and datasets.</li>
      <li>Reusable templates keep the tone consistent.</li>
    </ul>
    <a href="/pages/contribute">Join the collaboration →</a>
  </article>
</section>

<section class="design-section">
  <h2>Reusable card templates</h2>
  <p>
    To help teams digest complex documents quickly, we are developing compact cards that capture the essence of
    4D workflows. The [About](/pages/about) page explains their structure, but here is a preview of the three main
    families we keep updated:
  </p>
  <div class="design-grid">
    <article class="design-card">
      <h3>Design checklists</h3>
      <p>
        Metric-driven reminders on repeatability, normalisation, attribute picks and acquisition tuning so every monitor
        survey starts with the right assumptions.
      </p>
      <small>Helpful when planning a new monitor acquisition.</small>
    </article>

    <article class="design-card">
      <h3>Case cards</h3>
      <p>
        Structured summaries that capture the question, workflow and outcome for a specific field or technology, letting
        you compare what worked (and what didn't) with minimal reading.
      </p>
      <small>Great for conference abstracts and operational briefings.</small>
    </article>

    <article class="design-card">
      <h3>Pitfall notes</h3>
      <p>
        Concise documentation of common issues, their detection and mitigation strategies so newcomers avoid repeated mistakes.
      </p>
      <small>Suited for lessons-learned sessions and training kits.</small>
    </article>
  </div>
</section>

<section class="cta-panel">
  <h2>Ready to amplify 4D success stories?</h2>
  <p>
    Whether you operate ocean-bottom nodes, deliver new processing techniques or publish research, we invite you to read,
    reuse and extend the hub. Browse the sections above or bring your own contribution to life.
  </p>
  <div class="cta-actions">
    <a class="cta-btn" href="/pages/contribute">Contribute materials</a>
    <a class="cta-btn" href="/pages/about">Learn about the hub</a>
  </div>
  <blockquote>
    “This initiative is completely open and unfunded; we rely on volunteers to keep the content current. If you would
    like to help maintain the site, please see our Contribute page.”
  </blockquote>
</section>
