---
layout: splash
author_profile: false
classes: wide
---

{% assign case_count = site.data.case_studies_map | size %}
{% assign paper_count = site.data.papers | size %}
{% assign analysis_count = site.posts | size %}

<link rel="stylesheet" href="{{ '/assets/css/home-readest.css' | relative_url }}">
<script src="{{ '/assets/js/home-scroll.js' | relative_url }}" defer></script>

<div class="hub-readest-home">
  <section class="hub-r-hero" data-home-hero>
    <div class="hub-shell hub-r-hero-inner">
      <div class="hub-r-hero-copy" data-reveal>
        <p class="hub-r-eyebrow">Time-lapse subsurface intelligence</p>
        <h1>See the reservoir.<br><span>Understand the change.</span></h1>
        <p class="hub-r-hero-lede">A focused workspace for exploring 4D seismic cases, comparing acquisition and repeatability choices, and turning field evidence into monitoring decisions.</p>

        <div class="hub-r-actions">
          <a class="hub-r-button hub-r-button--primary" href="{{ '/pages/knowledge-base/' | relative_url }}">Explore case library <span aria-hidden="true">→</span></a>
          <a class="hub-r-button hub-r-button--secondary" href="{{ '/pages/comparison-tool/' | relative_url }}">Open benchmark</a>
        </div>

        <div class="hub-r-mini-stats" aria-label="Hub collection statistics">
          <div class="hub-r-mini-stat"><strong>{{ case_count }}</strong><span>projects</span></div>
          <div class="hub-r-mini-stat"><strong>{{ paper_count }}</strong><span>source records</span></div>
          <div class="hub-r-mini-stat"><strong>{{ analysis_count }}</strong><span>case analyses</span></div>
        </div>
      </div>

      <div class="hub-r-product-window" data-hero-stage data-reveal aria-label="4D Seismic Hub monitoring workspace preview">
        <div class="hub-r-window-bar">
          <div class="hub-r-window-dots" aria-hidden="true"><i></i><i></i><i></i></div>
          <span>4D Seismic Hub / Monitoring workspace</span>
          <span class="hub-r-window-status">Evidence linked</span>
        </div>

        <div class="hub-r-window-body">
          <aside class="hub-r-window-sidebar" aria-label="Example project list">
            <span>Monitoring cases</span>
            <div class="hub-r-case-list">
              <div class="hub-r-case-row is-active">Gullfaks Main Field</div>
              <div class="hub-r-case-row">Jubarte PRM</div>
              <div class="hub-r-case-row">Sleipner CCS</div>
              <div class="hub-r-case-row">Weyburn-Midale</div>
            </div>
          </aside>

          <div class="hub-r-monitor">
            <div class="hub-r-monitor-head">
              <strong>Base / monitor difference</strong>
              <span>Amplitude response · interpreted</span>
            </div>

            <div class="hub-r-seismic-canvas" aria-hidden="true">
              <svg viewBox="0 0 720 330" preserveAspectRatio="none">
                <defs>
                  <linearGradient id="homeTrace" x1="0" x2="1">
                    <stop offset="0" stop-color="#5fd1cc" stop-opacity=".08"/>
                    <stop offset=".5" stop-color="#80e5df" stop-opacity=".82"/>
                    <stop offset="1" stop-color="#5fd1cc" stop-opacity=".08"/>
                  </linearGradient>
                  <linearGradient id="homeSignal" x1="0" x2="1">
                    <stop offset="0" stop-color="#f2a33a" stop-opacity="0"/>
                    <stop offset=".52" stop-color="#f2a33a" stop-opacity=".98"/>
                    <stop offset="1" stop-color="#f2a33a" stop-opacity="0"/>
                  </linearGradient>
                </defs>
                <g fill="none" stroke="url(#homeTrace)" stroke-width="1.4">
                  <path d="M0 34 C78 7 124 62 200 34 S332 10 410 40 S548 67 720 22"/>
                  <path d="M0 72 C86 44 132 101 214 69 S350 48 430 79 S568 104 720 61"/>
                  <path d="M0 112 C78 83 143 138 225 108 S365 88 448 119 S584 145 720 101"/>
                  <path d="M0 154 C91 122 151 181 239 149 S381 129 466 161 S599 184 720 142"/>
                  <path d="M0 198 C82 167 164 222 250 193 S399 173 485 204 S616 226 720 184"/>
                  <path d="M0 242 C94 212 172 267 262 237 S414 218 502 249 S629 270 720 228"/>
                  <path d="M0 286 C88 258 183 310 273 281 S431 261 519 292 S644 310 720 273"/>
                </g>
                <path class="hub-r-signal-pulse" d="M84 230 C168 196 228 267 309 224 S458 178 536 235 S649 276 702 209" fill="none" stroke="url(#homeSignal)" stroke-width="4.2"/>
              </svg>
            </div>

            <div class="hub-r-monitor-metrics">
              <div class="hub-r-monitor-metric"><span>Repeatability</span><strong>NRMS 23.5%</strong></div>
              <div class="hub-r-monitor-metric"><span>Signal driver</span><strong>Saturation + pressure</strong></div>
              <div class="hub-r-monitor-metric"><span>Decision</span><strong>Infill targeting</strong></div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>

  <section class="hub-r-section hub-r-section--white">
    <div class="hub-shell">
      <div class="hub-r-section-heading" data-reveal>
        <p class="hub-r-eyebrow">One evidence base, three ways to work</p>
        <h2>Move from field examples to engineering judgment.</h2>
        <p>The Hub is organized as a working product rather than a long catalogue: find a relevant case, compare the parameters behind performance, then interpret what can transfer to the next monitoring decision.</p>
      </div>

      <div class="hub-r-story">
        <div class="hub-r-story-visual" data-story-visual data-active="discover" aria-live="polite">
          <div class="hub-r-story-bar">
            <span class="hub-r-story-tab" data-tab="discover">Discover</span>
            <span class="hub-r-story-tab" data-tab="compare">Compare</span>
            <span class="hub-r-story-tab" data-tab="interpret">Interpret</span>
          </div>

          <div class="hub-r-story-stage">
            <div class="hub-r-story-scene" data-scene="discover">
              <div class="hub-r-map-scene">
                <div class="hub-r-map-contour"></div>
                <div class="hub-r-map-contour"></div>
                <div class="hub-r-map-contour"></div>
                <div class="hub-r-map-point"></div>
                <div class="hub-r-map-point"></div>
                <div class="hub-r-map-point"></div>
                <div class="hub-r-map-point"></div>
                <div class="hub-r-map-card">
                  <span>Selected case</span>
                  <strong>Jubarte PRM</strong>
                  <p>Permanent optical receivers, deepwater heavy oil, and a documented well-placement decision.</p>
                </div>
              </div>
            </div>

            <div class="hub-r-story-scene" data-scene="compare">
              <div class="hub-r-compare-scene">
                <div class="hub-r-compare-panel">
                  <span>Base survey</span>
                  <svg viewBox="0 0 320 430" preserveAspectRatio="none" aria-hidden="true">
                    <g fill="none" stroke="#6fd7d1" stroke-opacity=".62" stroke-width="1.35">
                      <path d="M0 70 C48 38 92 98 141 66 S232 41 320 84"/><path d="M0 119 C54 86 101 145 154 113 S245 89 320 132"/><path d="M0 170 C48 137 111 197 162 164 S259 141 320 183"/><path d="M0 222 C61 190 118 248 177 215 S270 194 320 235"/><path d="M0 276 C55 244 129 302 186 270 S280 249 320 291"/><path d="M0 329 C67 296 137 356 201 321 S289 304 320 343"/>
                    </g>
                  </svg>
                </div>
                <div class="hub-r-compare-panel">
                  <span>Monitor survey</span>
                  <svg viewBox="0 0 320 430" preserveAspectRatio="none" aria-hidden="true">
                    <g fill="none" stroke="#6fd7d1" stroke-opacity=".62" stroke-width="1.35">
                      <path d="M0 70 C48 38 92 98 141 66 S232 41 320 84"/><path d="M0 119 C54 86 101 145 154 113 S245 89 320 132"/><path d="M0 170 C48 137 111 197 162 164 S259 141 320 183"/><path d="M0 222 C61 190 118 248 177 215 S270 194 320 235"/><path d="M0 276 C55 244 129 302 186 270 S280 249 320 291"/><path d="M0 329 C67 296 137 356 201 321 S289 304 320 343"/>
                    </g>
                    <path d="M18 265 C77 218 135 326 202 258 S279 232 320 277" fill="none" stroke="#f2a33a" stroke-width="5"/>
                  </svg>
                </div>
                <div class="hub-r-difference-chip">Repeatability controlled · change isolated</div>
              </div>
            </div>

            <div class="hub-r-story-scene" data-scene="interpret">
              <div class="hub-r-interpret-scene">
                <div class="hub-r-evidence-flow">
                  <div class="hub-r-flow-row"><span>Acquisition</span><div class="hub-r-flow-track"><i></i><i></i><i></i></div></div>
                  <div class="hub-r-flow-row"><span>Difference</span><div class="hub-r-flow-track"><i></i><i></i><i></i></div></div>
                  <div class="hub-r-flow-row"><span>Decision</span><div class="hub-r-flow-track"><i></i><i></i><i></i></div></div>
                </div>
                <div class="hub-r-decision-card">
                  <span>Decision note</span>
                  <strong>Evidence supports a targeted infill opportunity.</strong>
                  <p>Source grade, repeatability boundary, signal driver, and transfer limits remain visible alongside the conclusion.</p>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="hub-r-story-copy">
          <article class="hub-r-story-step" data-story-step="discover" aria-current="true">
            <span>01 / Discover</span>
            <h3>Start with the field setting.</h3>
            <p>Search documented projects by reservoir environment, monitoring objective, sensor system, and region. Each case exposes its source grade and known evidence boundary.</p>
            <a href="{{ '/pages/knowledge-base/' | relative_url }}">Explore the case library →</a>
          </article>

          <article class="hub-r-story-step" data-story-step="compare" aria-current="false">
            <span>02 / Compare</span>
            <h3>Compare choices without inventing a score.</h3>
            <p>Inspect NRMS, repeat interval, bin size, water depth, and signal drivers in their original units. Provisional records stay visible but do not distort aggregate statistics.</p>
            <a href="{{ '/pages/comparison-tool/' | relative_url }}">Open the benchmark →</a>
          </article>

          <article class="hub-r-story-step" data-story-step="interpret" aria-current="false">
            <span>03 / Interpret</span>
            <h3>Connect the signal to a decision.</h3>
            <p>Read concise analyses that separate technical source records, editorial synthesis, known limitations, and community review.</p>
            <a href="{{ '/pages/analysis/' | relative_url }}">Read field analyses →</a>
          </article>
        </div>
      </div>
    </div>
  </section>

  <section class="hub-r-section">
    <div class="hub-shell">
      <div class="hub-r-section-heading" data-reveal>
        <p class="hub-r-eyebrow">Latest field notes</p>
        <h2>New evidence, distilled for reuse.</h2>
        <p>Recent analyses focus on the monitoring problem, the evidence produced, and the operational judgment that followed.</p>
      </div>

      <div class="hub-r-editorial-grid" data-reveal>
        {% for post in site.posts limit:3 %}
        <a class="hub-r-editorial-card {% if forloop.first %}is-featured{% endif %}" href="{{ post.url | relative_url }}">
          <time datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date: "%d %b %Y" }}</time>
          <h3>{{ post.title }}</h3>
          <p>{{ post.excerpt | strip_html | truncate: 142 }}</p>
        </a>
        {% endfor %}
      </div>
    </div>
  </section>

  <section class="hub-r-section hub-r-section--white">
    <div class="hub-shell">
      <div class="hub-r-section-heading" data-reveal>
        <p class="hub-r-eyebrow">Featured monitoring cases</p>
        <h2>Different reservoirs. Shared decision patterns.</h2>
        <p>Cases are framed around the uncertainty, acquisition response, observed evidence, operational outcome, and transfer limits.</p>
      </div>

      <div class="hub-r-case-grid" data-reveal>
        {% for case in site.data.case_studies_map limit:3 %}
        <a class="hub-r-case-card" href="{% if case.post_url %}{{ case.post_url | relative_url }}{% else %}{{ '/pages/knowledge-base/' | relative_url }}{% endif %}">
          <span>{{ case.location }}</span>
          <h3>{{ case.name }}</h3>
          <p>{{ case.summary | truncate: 152 }}</p>
          <b>{% if case.post_url %}Read case{% else %}View in library{% endif %} →</b>
        </a>
        {% endfor %}
      </div>
    </div>
  </section>

  <section class="hub-r-section hub-r-chain">
    <div class="hub-shell">
      <div class="hub-r-section-heading" data-reveal>
        <p class="hub-r-eyebrow">The 4D decision chain</p>
        <h2>Monitoring value is created across the whole loop.</h2>
        <p>A strong program connects acquisition repeatability to interpretable change, then connects that change to a reservoir or storage decision.</p>
      </div>

      <div class="hub-r-chain-grid" data-reveal>
        <article class="hub-r-chain-step"><span>01</span><h3>Frame the decision</h3><p>Define the uncertainty, expected signal, decision threshold, and monitoring cadence.</p></article>
        <article class="hub-r-chain-step"><span>02</span><h3>Design for repeatability</h3><p>Control geometry, positioning, equipment behavior, environmental variation, and timing.</p></article>
        <article class="hub-r-chain-step"><span>03</span><h3>Separate signal from noise</h3><p>Process the difference while tracking repeatability metrics and interpretation uncertainty.</p></article>
        <article class="hub-r-chain-step"><span>04</span><h3>Act on the evidence</h3><p>Translate observed change into well, injection, depletion, compaction, or storage action.</p></article>
      </div>
    </div>
  </section>

  <section class="hub-r-section">
    <div class="hub-shell">
      <div class="hub-r-cta" data-reveal>
        <div>
          <h2>Help make field knowledge easier to reuse.</h2>
          <p>Contribute a case, trace a source to its canonical publication, challenge an interpretation, or join the group maintaining the evidence base.</p>
        </div>
        <div class="hub-r-actions">
          <a class="hub-r-button hub-r-button--primary" href="{{ '/pages/contribute/' | relative_url }}">Contribute</a>
          <a class="hub-r-button hub-r-button--secondary" href="{{ '/pages/working-group/' | relative_url }}">Meet the group</a>
        </div>
      </div>
    </div>
  </section>
</div>
