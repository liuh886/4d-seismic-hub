---
layout: splash
author_profile: false
classes: wide
---

{% assign case_count = site.data.case_studies_map | size %}
{% assign paper_count = site.data.papers | size %}
{% assign analysis_count = site.posts | size %}

<section class="hub-home-hero">
  <div class="hub-shell hub-hero-grid">
    <div>
      <p class="hub-kicker">Time-lapse subsurface intelligence</p>
      <h1 class="hub-display">See how reservoirs change.</h1>
      <p class="hub-lede">A decision-oriented knowledge hub for 4D seismic acquisition, repeatability, interpretation, and reservoir monitoring—built from real projects, technical evidence, and field lessons.</p>
      <div class="hub-actions">
        <a class="hub-button hub-button--primary" href="{{ '/pages/knowledge-base/' | relative_url }}">Explore case library <span aria-hidden="true">→</span></a>
        <a class="hub-button hub-button--secondary" href="{{ '/pages/comparison-tool/' | relative_url }}">Open benchmarking tool</a>
      </div>
    </div>

    <div class="hub-seismic-panel" aria-label="Stylized time-lapse seismic monitoring display">
      <div class="hub-panel-topline">
        <span><span class="hub-live-dot"></span>Monitoring view</span>
        <span>BASE / MONITOR</span>
      </div>
      <div class="hub-seismic-visual" aria-hidden="true">
        <svg viewBox="0 0 700 420" preserveAspectRatio="none" role="img">
          <defs>
            <linearGradient id="traceFade" x1="0" x2="1">
              <stop offset="0" stop-color="#58d4cf" stop-opacity="0.1"/>
              <stop offset="0.48" stop-color="#7ee4df" stop-opacity="0.9"/>
              <stop offset="1" stop-color="#58d4cf" stop-opacity="0.14"/>
            </linearGradient>
            <linearGradient id="signalFade" x1="0" x2="1">
              <stop offset="0" stop-color="#f2a33a" stop-opacity="0"/>
              <stop offset="0.52" stop-color="#f2a33a" stop-opacity="0.95"/>
              <stop offset="1" stop-color="#f2a33a" stop-opacity="0"/>
            </linearGradient>
          </defs>
          <g fill="none" stroke="url(#traceFade)" stroke-width="1.4" opacity="0.82">
            <path d="M0 32 C78 4 118 60 188 31 S312 9 378 36 S502 62 700 18"/>
            <path d="M0 66 C80 39 128 94 204 63 S338 42 412 71 S548 98 700 52"/>
            <path d="M0 101 C70 74 132 126 210 99 S342 79 426 107 S560 132 700 90"/>
            <path d="M0 137 C86 109 135 165 220 133 S350 113 442 143 S570 168 700 128"/>
            <path d="M0 174 C78 143 146 199 224 169 S366 146 452 179 S582 202 700 163"/>
            <path d="M0 212 C90 181 151 238 238 206 S376 186 468 218 S590 241 700 200"/>
            <path d="M0 250 C80 220 157 276 245 245 S390 225 480 256 S604 278 700 238"/>
            <path d="M0 288 C92 258 164 316 252 283 S400 265 490 295 S613 318 700 278"/>
            <path d="M0 326 C83 298 170 351 260 322 S412 302 504 333 S626 353 700 316"/>
          </g>
          <path d="M64 282 C145 249 201 315 279 274 S427 227 505 281 S617 322 684 257" fill="none" stroke="url(#signalFade)" stroke-width="4"/>
          <g stroke="#87bbc2" stroke-opacity="0.12" stroke-width="1">
            <path d="M70 0 V420"/><path d="M140 0 V420"/><path d="M210 0 V420"/><path d="M280 0 V420"/><path d="M350 0 V420"/><path d="M420 0 V420"/><path d="M490 0 V420"/><path d="M560 0 V420"/><path d="M630 0 V420"/>
          </g>
        </svg>
      </div>
      <div class="hub-seismic-metrics">
        <div class="hub-seismic-metric"><span>Repeatability</span><strong>NRMS-informed</strong></div>
        <div class="hub-seismic-metric"><span>Change signal</span><strong>Δ amplitude</strong></div>
        <div class="hub-seismic-metric"><span>Decision loop</span><strong>Acquire → Act</strong></div>
      </div>
    </div>
  </div>
</section>

<div class="hub-shell hub-stat-band">
  <div class="hub-stat-grid" aria-label="Hub collection statistics">
    <div class="hub-stat"><strong>{{ case_count }}</strong><span>documented monitoring projects</span></div>
    <div class="hub-stat"><strong>{{ paper_count }}</strong><span>technical papers and reports</span></div>
    <div class="hub-stat"><strong>{{ analysis_count }}</strong><span>decision-oriented field analyses</span></div>
  </div>
</div>

<section class="hub-section">
  <div class="hub-shell">
    <div class="hub-section-header">
      <div>
        <p class="hub-kicker">One hub, three working modes</p>
        <h2>Move from examples to engineering decisions.</h2>
      </div>
      <p>The hub is organized around the questions project teams actually ask: what has worked, how projects differ, and what the evidence means for the next survey or monitoring program.</p>
    </div>

    <div class="hub-card-grid">
      <article class="hub-card">
        <span class="hub-card__index">01 / DISCOVER</span>
        <h3>Explore real monitoring cases</h3>
        <p>Browse project context, reservoir setting, acquisition choices, repeatability constraints, and interpreted outcomes.</p>
        <a class="hub-card__link" href="{{ '/pages/knowledge-base/' | relative_url }}">Open case library →</a>
      </article>
      <article class="hub-card">
        <span class="hub-card__index">02 / COMPARE</span>
        <h3>Benchmark technical parameters</h3>
        <p>Compare sensor types, bin sizes, repeat intervals, NRMS, water depths, and the physical drivers behind the signal.</p>
        <a class="hub-card__link" href="{{ '/pages/comparison-tool/' | relative_url }}">Launch comparison →</a>
      </article>
      <article class="hub-card">
        <span class="hub-card__index">03 / INTERPRET</span>
        <h3>Read decision-focused analysis</h3>
        <p>Turn conference knowledge and case-study evidence into concise lessons for survey design, processing, and reservoir management.</p>
        <a class="hub-card__link" href="{{ '/pages/analysis/' | relative_url }}">Read field notes →</a>
      </article>
    </div>
  </div>
</section>

<section class="hub-section hub-section--tint">
  <div class="hub-shell">
    <div class="hub-section-header">
      <div>
        <p class="hub-kicker">Latest field notes</p>
        <h2>New evidence, distilled for reuse.</h2>
      </div>
      <p>Recent analyses focus on the technical choices and decision logic that can transfer across assets—not just on retelling project history.</p>
    </div>

    <div class="hub-note-grid">
      {% for post in site.posts limit:3 %}
      <a class="hub-note" href="{{ post.url | relative_url }}">
        <time datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date: "%d %b %Y" }}</time>
        <h3>{{ post.title }}</h3>
        <p>{{ post.excerpt | strip_html | truncate: 128 }}</p>
      </a>
      {% endfor %}
    </div>
  </div>
</section>

<section class="hub-section">
  <div class="hub-shell">
    <div class="hub-section-header">
      <div>
        <p class="hub-kicker">Featured monitoring cases</p>
        <h2>Different reservoirs. Different signals. Shared lessons.</h2>
      </div>
      <p>Each case is framed around the monitoring problem, the acquisition response, and the evidence needed to support an operational decision.</p>
    </div>

    <div class="hub-case-grid">
      {% for case in site.data.case_studies_map limit:3 %}
      <article class="hub-case">
        <span class="hub-case__meta">{{ case.location }}</span>
        <h3>{{ case.name }}</h3>
        <p>{{ case.summary | truncate: 150 }}</p>
        {% if case.post_url %}<a href="{{ case.post_url | relative_url }}">Read case →</a>{% else %}<a href="{{ '/pages/knowledge-base/' | relative_url }}">View in library →</a>{% endif %}
      </article>
      {% endfor %}
    </div>
  </div>
</section>

<section class="hub-section hub-section--dark">
  <div class="hub-shell">
    <div class="hub-section-header">
      <div>
        <p class="hub-kicker">The 4D decision chain</p>
        <h2>Monitoring value is created across the whole loop.</h2>
      </div>
      <p>A strong 4D program connects acquisition repeatability to interpretable change, and interpretable change to a reservoir decision.</p>
    </div>

    <div class="hub-process">
      <article class="hub-process-step"><span>01</span><h3>Frame the decision</h3><p>Define the reservoir uncertainty, expected signal, decision threshold, and monitoring cadence.</p></article>
      <article class="hub-process-step"><span>02</span><h3>Design for repeatability</h3><p>Control geometry, positioning, source and receiver behavior, environmental variation, and timing.</p></article>
      <article class="hub-process-step"><span>03</span><h3>Separate signal from noise</h3><p>Process and interpret the difference while tracking repeatability metrics and uncertainty.</p></article>
      <article class="hub-process-step"><span>04</span><h3>Act on the evidence</h3><p>Translate the observed change into well, injection, depletion, compaction, or storage decisions.</p></article>
    </div>
  </div>
</section>

<section class="hub-section hub-section--compact">
  <div class="hub-shell">
    <div class="hub-cta">
      <div>
        <p class="hub-kicker">Built as a living technical resource</p>
        <h2>Help make field knowledge easier to reuse.</h2>
        <p>Contribute a case, challenge an interpretation, improve a benchmark, or join the working group maintaining the evidence base.</p>
      </div>
      <div class="hub-actions">
        <a class="hub-button hub-button--primary" href="{{ '/pages/contribute/' | relative_url }}">Contribute</a>
        <a class="hub-button hub-button--secondary" href="{{ '/pages/working-group/' | relative_url }}">Meet the group</a>
      </div>
    </div>
  </div>
</section>
