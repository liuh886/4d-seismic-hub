---
layout: home
author_profile: false
---

{% assign case_count = site.data.case_studies_map | size %}
{% assign paper_count = site.data.papers | size %}
{% assign analysis_count = site.posts | size %}

<div class="hub-readest-home">
  <section class="hub-r-hero" aria-labelledby="home-title">
    <div class="hub-shell hub-r-hero-inner">
      <div class="hub-r-hero-copy">
        <p class="hub-r-eyebrow">Time-lapse subsurface intelligence</p>
        <h1 id="home-title">
          <span>See the reservoir.</span>
          <span>Understand the change.</span>
        </h1>
        <p class="hub-r-hero-lede">Explore documented 4D seismic projects, compare the acquisition choices behind repeatability, and connect observed change to monitoring decisions.</p>

        <div class="hub-r-actions" aria-label="Primary actions">
          <a class="hub-r-button hub-r-button--primary" href="{{ '/pages/knowledge-base/' | relative_url }}">Explore cases <span aria-hidden="true">→</span></a>
          <a class="hub-r-button hub-r-button--secondary" href="{{ '/pages/comparison-tool/' | relative_url }}">Open benchmark</a>
        </div>

        <dl class="hub-r-mini-stats" aria-label="Hub collection statistics">
          <div><dt>{{ case_count }}</dt><dd>field projects</dd></div>
          <div><dt>{{ paper_count }}</dt><dd>source records</dd></div>
          <div><dt>{{ analysis_count }}</dt><dd>case analyses</dd></div>
        </dl>
      </div>
    </div>
  </section>

  <section class="hub-r-section hub-r-section--white" aria-labelledby="routes-title">
    <div class="hub-shell">
      <header class="hub-r-section-heading" data-reveal>
        <p class="hub-r-eyebrow">Three direct routes</p>
        <h2 id="routes-title">Start with the engineering question.</h2>
        <p>The Hub is organized around three practical tasks: locate an analogous field project, compare the technical choices behind performance, and understand what the evidence can support.</p>
      </header>

      <div class="hub-r-workflow-list" data-reveal>
        <a class="hub-r-workflow" href="{{ '/pages/knowledge-base/' | relative_url }}">
          <span class="hub-r-workflow-index">01</span>
          <div>
            <h3>Find a relevant field case.</h3>
            <p>Browse projects by monitoring objective, reservoir setting, sensor system, region, evidence scope, and source grade.</p>
          </div>
          <span class="hub-r-workflow-link">Cases →</span>
        </a>

        <a class="hub-r-workflow" href="{{ '/pages/comparison-tool/' | relative_url }}">
          <span class="hub-r-workflow-index">02</span>
          <div>
            <h3>Compare technical choices.</h3>
            <p>Inspect NRMS, repeat interval, bin size, water depth, signal driver, and provenance without collapsing unlike metrics into a synthetic score.</p>
          </div>
          <span class="hub-r-workflow-link">Benchmark →</span>
        </a>

        <a class="hub-r-workflow" href="{{ '/pages/analysis/' | relative_url }}">
          <span class="hub-r-workflow-index">03</span>
          <div>
            <h3>Interpret the evidence.</h3>
            <p>Read decision-focused analyses that separate source records, editorial synthesis, limitations, and community review.</p>
          </div>
          <span class="hub-r-workflow-link">Analysis →</span>
        </a>
      </div>
    </div>
  </section>

  <section class="hub-r-section" aria-labelledby="notes-title">
    <div class="hub-shell">
      <header class="hub-r-section-heading" data-reveal>
        <p class="hub-r-eyebrow">Latest field notes</p>
        <h2 id="notes-title">Evidence distilled for engineering reuse.</h2>
        <p>Recent analyses focus on the monitoring problem, the evidence produced, and the operational judgment that followed.</p>
      </header>

      <div class="hub-r-editorial-grid" data-reveal>
        {% for post in site.posts limit:3 %}
        <a class="hub-r-editorial-card {% if forloop.first %}is-featured{% endif %}" href="{{ post.url | relative_url }}">
          <time datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date: "%d %b %Y" }}</time>
          <h3>{{ post.title }}</h3>
          <p>{{ post.excerpt | strip_html | truncate: 142 }}</p>
          <span class="hub-r-card-link">Read analysis →</span>
        </a>
        {% endfor %}
      </div>
    </div>
  </section>

  <section class="hub-r-section hub-r-section--white" aria-labelledby="cases-title">
    <div class="hub-shell">
      <header class="hub-r-section-heading" data-reveal>
        <p class="hub-r-eyebrow">Featured monitoring cases</p>
        <h2 id="cases-title">Cases with explicit evidence boundaries.</h2>
        <p>Each record connects the monitoring uncertainty, acquisition response, observed evidence, operational outcome, and limits on transferability.</p>
      </header>

      <div class="hub-r-case-grid" data-reveal>
        {% for case in site.data.case_studies_map limit:3 %}
        <a class="hub-r-case-card" href="{% if case.post_url %}{{ case.post_url | relative_url }}{% else %}{{ '/pages/knowledge-base/' | relative_url }}{% endif %}">
          <span class="hub-r-card-meta">{{ case.location }}</span>
          <h3>{{ case.name }}</h3>
          <p>{{ case.summary | truncate: 152 }}</p>
          <span class="hub-r-card-link">{% if case.post_url %}Read case{% else %}View in library{% endif %} →</span>
        </a>
        {% endfor %}
      </div>
    </div>
  </section>

  <section class="hub-r-section hub-r-chain" aria-labelledby="chain-title">
    <div class="hub-shell">
      <header class="hub-r-section-heading" data-reveal>
        <p class="hub-r-eyebrow">The 4D decision chain</p>
        <h2 id="chain-title">Monitoring value is created across the whole loop.</h2>
        <p>A strong program connects acquisition repeatability to interpretable change, then connects that change to a reservoir or storage decision.</p>
      </header>

      <div class="hub-r-chain-grid" data-reveal>
        <article class="hub-r-chain-step"><span>01</span><h3>Frame the decision</h3><p>Define the uncertainty, expected signal, decision threshold, and monitoring cadence.</p></article>
        <article class="hub-r-chain-step"><span>02</span><h3>Design for repeatability</h3><p>Control geometry, positioning, equipment behavior, environmental variation, and timing.</p></article>
        <article class="hub-r-chain-step"><span>03</span><h3>Separate signal from noise</h3><p>Process the difference while tracking repeatability metrics and interpretation uncertainty.</p></article>
        <article class="hub-r-chain-step"><span>04</span><h3>Act on the evidence</h3><p>Translate observed change into well, injection, depletion, compaction, or storage action.</p></article>
      </div>
    </div>
  </section>

  <section class="hub-r-section" aria-labelledby="contribute-title">
    <div class="hub-shell">
      <div class="hub-r-cta" data-reveal>
        <div>
          <p class="hub-r-eyebrow">Open technical resource</p>
          <h2 id="contribute-title">Help make field knowledge easier to reuse.</h2>
          <p>Contribute a case, trace a source to its canonical publication, challenge an interpretation, or join the group maintaining the evidence base.</p>
        </div>
        <div class="hub-r-actions" aria-label="Contribution actions">
          <a class="hub-r-button hub-r-button--primary" href="{{ '/pages/contribute/' | relative_url }}">Contribute</a>
          <a class="hub-r-button hub-r-button--secondary" href="{{ '/pages/working-group/' | relative_url }}">Working group</a>
        </div>
      </div>
    </div>
  </section>
</div>
