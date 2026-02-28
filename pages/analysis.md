---
title: Recent Analysis
layout: default
permalink: /pages/analysis/
---

<style>
.analysis-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
  gap: 2rem;
  margin-top: 2rem;
}
.analysis-card {
  border: 1px solid #e2e8f0;
  border-radius: 12px;
  padding: 1.5rem;
  background: #fff;
  transition: all 0.3s ease;
  height: 100%;
  display: flex;
  flex-direction: column;
}
.analysis-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 12px 24px -10px rgba(0, 0, 0, 0.1);
  border-color: var(--hub-accent, #B509AC);
}
.analysis-card h2 {
  margin-top: 0;
  color: var(--hub-primary, #1a202c);
  font-size: 1.4rem;
  margin-bottom: 0.75rem;
}
.analysis-card .date {
  color: var(--hub-accent, #B509AC);
  font-weight: 600;
  font-size: 0.9rem;
  margin-bottom: 0.5rem;
}
.analysis-card .excerpt {
  color: var(--hub-secondary, #4a5568);
  line-height: 1.6;
  flex-grow: 1;
}
.tag-list {
  margin-top: 1rem;
  display: flex;
  gap: 0.5rem;
}
.tag {
  font-size: 0.7rem;
  background: #f1f5f9;
  padding: 0.2rem 0.6rem;
  border-radius: 4px;
  color: #64748b;
}
</style>

# 4D Seismic Recent Analysis

Deep dives into specific 4D monitoring projects, technical innovations, and field results.

<div class="analysis-grid">
{% for post in site.posts %}
  <a href="{{ post.url | relative_url }}" style="text-decoration: none; color: inherit;">
    <article class="analysis-card">
      <div class="date">{{ post.date | date: "%B %d, %Y" }}</div>
      <h2>{{ post.title }}</h2>
      <div class="excerpt">{{ post.excerpt | strip_html | truncate: 160 }}</div>
      <div class="tag-list">
        {% for tag in post.tags %}
          <span class="tag">#{{ tag }}</span>
        {% endfor %}
      </div>
    </article>
  </a>
{% endfor %}
</div>
