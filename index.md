---
title: "Dashboard"
layout: home
author_profile: false
---

<style>
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&family=Merriweather:ital,wght@0,300;0,700;1,300&display=swap');

:root {
  --hub-primary: #1a202c;
  --hub-secondary: #4a5568;
  --hub-accent: #B509AC;
  --hub-accent-hover: #9d00e8;
  --hub-bg: #ffffff;
  --hub-section-bg: #f7fafc;
  --hub-border: #e2e8f0;
}

body {
  font-family: 'Inter', sans-serif;
  color: var(--hub-primary);
}

h1, h2, h3 {
  font-family: 'Merriweather', serif;
}

.hero {
  padding: 3rem 1rem;
  text-align: center;
  border-bottom: 1px solid var(--hub-border);
  margin-bottom: 2rem;
}

.hero img.logo {
  width: 120px;
  margin-bottom: 1.5rem;
}

/* Responsive Typography Fix */
.hero h1 {
  font-size: clamp(1.75rem, 4vw, 2.5rem);
  margin-bottom: 1rem;
  line-height: 1.2;
}

.hero p {
  font-size: clamp(1rem, 2vw, 1.15rem);
  color: var(--hub-secondary);
  max-width: 700px;
  margin: 0 auto 2rem auto;
}

.dashboard-grid {
  display: grid;
  grid-template-columns: 2fr 1fr;
  gap: 3rem;
}

.featured-list {
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
}

.content-card {
  padding: 1.5rem;
  border: 1px solid var(--hub-border);
  border-radius: 8px;
  transition: border-color 0.2s;
  background: #fff;
}

.content-card:hover {
  border-color: var(--hub-accent);
}

.content-card h3 {
  margin-top: 0;
  font-size: 1.15rem;
}

.btn-academic {
  display: inline-block;
  padding: 0.6rem 1.2rem;
  background: var(--hub-accent);
  color: #fff !important;
  border-radius: 4px;
  text-decoration: none !important;
  font-weight: 600;
  transition: background 0.2s;
}

.btn-academic:hover {
  background: var(--hub-accent-hover);
}

.sidebar-box {
  background: var(--hub-section-bg);
  padding: 1.5rem;
  border-radius: 8px;
  margin-bottom: 2rem;
  border: 1px solid var(--hub-border);
}

.sidebar-box h4 {
  margin-top: 0;
  text-transform: uppercase;
  font-size: 0.75rem;
  letter-spacing: 0.1em;
  color: var(--hub-secondary);
  margin-bottom: 1rem;
}

@media (max-width: 768px) {
  .dashboard-grid {
    grid-template-columns: 1fr;
  }
}
</style>

<section class="hero">
  <img src="{{ '/assets/images/logo.svg' | relative_url }}" alt="4D Seismic Hub Logo" class="logo">
  <h1>4D Seismic Knowledge Hub</h1>
  <p>
    An open platform for curating best practices, case studies, and research in 4D (time-lapse) seismic monitoring.
  </p>
  <a href="/pages/knowledge-base" class="btn-academic">Access Knowledge Base</a>
</section>

<div class="dashboard-grid">
  <main class="featured-list">
    <h2 style="font-size: 1.5rem; margin-bottom: 0;">Featured Insights</h2>

    {% for paper in site.data.papers limit:3 %}
    <article class="content-card">
      <h3>{{ paper.title }}</h3>
      <p>{{ paper.description | truncate: 150 }}</p>
      <a href="{{ paper.link }}" target="_blank" style="color: var(--hub-accent); font-weight: 600; text-decoration: none; font-size: 0.9rem;">Read Paper &rarr;</a>
    </article>
    {% endfor %}

    <a href="/pages/knowledge-base" style="text-align: center; margin-top: 1rem; color: var(--hub-secondary); text-decoration: none;">View all resources...</a>
  </main>

  <aside>
    <div class="sidebar-box">
      <h4>Working Group</h4>
      <p style="font-size: 0.9rem;">This initiative is maintained by the 4D Seismic Hub Working Group. We rely on volunteers for content curation.</p>
      <a href="/pages/contribute" style="font-weight: 600; color: var(--hub-accent); text-decoration: none;">Join us &rarr;</a>
    </div>

    <div class="sidebar-box">
      <h4>Featured Case Study</h4>
      {% assign featured_case = site.data.case_studies_map | first %}
      <p><strong>{{ featured_case.name }}</strong></p>
      <p style="font-size: 0.9rem;">{{ featured_case.summary }}</p>
      <a href="/pages/knowledge-base" style="font-weight: 600; color: var(--hub-accent); text-decoration: none;">Explore Case &rarr;</a>
    </div>
  </aside>
</div>
