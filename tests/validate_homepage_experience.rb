#!/usr/bin/env ruby
# frozen_string_literal: true

require "open3"
require "yaml"

ROOT = File.expand_path("..", __dir__)
INDEX = File.join(ROOT, "index.md")
CSS = File.join(ROOT, "assets", "css", "home-readest.css")
JS = File.join(ROOT, "assets", "js", "home-scroll.js")
NAV = File.join(ROOT, "_data", "navigation.yml")

index = File.read(INDEX, encoding: "UTF-8")
css = File.read(CSS, encoding: "UTF-8")
js = File.read(JS, encoding: "UTF-8")
navigation = YAML.safe_load(File.read(NAV, encoding: "UTF-8")) || {}
errors = []

main_nav = Array(navigation["main"])
nav_titles = main_nav.map { |item| item["title"] }
nav_urls = main_nav.map { |item| item["url"] }

expected_titles = %w[Cases Benchmark About]
expected_urls = [
  "/pages/knowledge-base/",
  "/pages/comparison-tool/",
  "/pages/about/"
]

errors << "primary navigation must contain exactly three items" unless main_nav.length == 3
errors << "primary navigation titles must be #{expected_titles.inspect}" unless nav_titles == expected_titles
errors << "primary navigation URLs must be #{expected_urls.inspect}" unless nav_urls == expected_urls
errors << "Home must use the site-title link rather than a duplicate nav item" if nav_titles.include?("Home")
errors << "Analysis must remain a contextual link rather than a permanent nav item" if nav_titles.include?("Analysis")

required_index = [
  "document.documentElement.classList.add('hub-home-page')",
  "hub-readest-home",
  "hub-r-hero-copy",
  "hub-r-mini-stats",
  "hub-r-workflow-list",
  "site.posts limit:3",
  "site.data.case_studies_map limit:3",
  "/pages/knowledge-base/",
  "/pages/comparison-tool/",
  "/pages/analysis/",
  "assets/css/home-readest.css",
  "assets/js/home-scroll.js",
  "See the reservoir.<span>Understand the change.</span>"
]

required_index.each do |fragment|
  errors << "homepage is missing required content or context #{fragment.inspect}" unless index.include?(fragment)
end

errors << "hero headline must not rely on a hard-coded line break" if index.include?("See the reservoir.<br>")

forbidden_index = [
  "hub-home-hero",
  "hub-stat-band",
  "hub-r-product-window",
  "hub-r-seismic-canvas",
  "hub-r-story-visual",
  "hub-r-map-scene",
  "hub-r-compare-scene",
  "hub-r-interpret-scene",
  "data-hero-stage",
  "data-story-step",
  "<svg"
]

forbidden_index.each do |fragment|
  errors << "homepage still contains simulated or superseded visual #{fragment.inspect}" if index.include?(fragment)
end

required_css = [
  "width: 100vw",
  "margin-inline: calc(50% - 50vw)",
  ".hub-home-page .masthead",
  ".hub-home-page .masthead.is-scrolled",
  "background: transparent",
  "background: rgba(250, 252, 249, .86)",
  "min-height: min(780px, 100svh)",
  "font-size: clamp(3.6rem, 8.6vw, 7.35rem)",
  "font-size: clamp(1.08rem, 1.75vw, 1.36rem)",
  ".hub-r-section-heading",
  "max-width: 860px",
  "font-size: clamp(2.45rem, 5vw, 4.35rem)",
  ".hub-r-mini-stat strong",
  ".hub-r-workflow-list",
  ".hub-r-editorial-grid",
  ".has-home-motion .hub-readest-home [data-reveal]",
  "@media (prefers-reduced-motion: reduce)"
]

required_css.each do |fragment|
  errors << "homepage CSS is missing immersive layout contract #{fragment.inspect}" unless css.include?(fragment)
end

forbidden_css = [
  ".hub-r-product-window",
  ".hub-r-seismic-canvas",
  ".hub-r-story-visual",
  ".hub-r-map-scene",
  ".hub-r-compare-scene",
  ".hub-r-interpret-scene",
  "grid-template-columns: minmax(0, 1.1fr) minmax(280px, .9fr)"
]

forbidden_css.each do |fragment|
  errors << "homepage CSS still supports simulated or awkward layout #{fragment.inspect}" if css.include?(fragment)
end

if css.count("{") != css.count("}")
  errors << "homepage CSS has unbalanced braces"
end

required_js = [
  "hub-home-page",
  "IntersectionObserver",
  "prefers-reduced-motion: reduce",
  "data-reveal",
  "is-scrolled",
  "window.scrollY > 24",
  "window.addEventListener('scroll', syncState, { passive: true })"
]

required_js.each do |fragment|
  errors << "homepage interaction behavior is missing #{fragment.inspect}" unless js.include?(fragment)
end

forbidden_js = [
  "requestAnimationFrame",
  "data-story-step",
  "data-story-visual",
  "data-hero-stage",
  "gsap",
  "ScrollMagic",
  "AOS",
  "jquery"
]

forbidden_js.each do |fragment|
  errors << "homepage script still contains unnecessary scene or animation logic #{fragment.inspect}" if js.downcase.include?(fragment.downcase)
end

stdout, stderr, status = Open3.capture3("node", "--check", JS)
unless status.success?
  errors << "homepage JavaScript failed node --check: #{stderr.strip.empty? ? stdout.strip : stderr.strip}"
end

if errors.empty?
  puts "Immersive homepage, typography, and navigation contract passed."
  exit 0
end

warn "Homepage experience contract failed:"
errors.each { |error| warn "  - #{error}" }
exit 1