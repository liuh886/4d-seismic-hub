#!/usr/bin/env ruby
# frozen_string_literal: true

require "open3"
require "yaml"

ROOT = File.expand_path("..", __dir__)
INDEX = File.join(ROOT, "index.md")
HOME_LAYOUT = File.join(ROOT, "_layouts", "home.html")
CSS = File.join(ROOT, "assets", "css", "home-readest.css")
DENSITY_CSS = File.join(ROOT, "assets", "css", "home-density.css")
JS = File.join(ROOT, "assets", "js", "home-scroll.js")
NAV = File.join(ROOT, "_data", "navigation.yml")

index = File.read(INDEX, encoding: "UTF-8")
home_layout = File.read(HOME_LAYOUT, encoding: "UTF-8")
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
  "layout: home",
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
  errors << "homepage is missing required content or native layout context #{fragment.inspect}" unless index.include?(fragment)
end

forbidden_index = [
  "layout: splash",
  "classes: wide",
  "document.documentElement.classList.add('hub-home-page')",
  "assets/css/home-density.css",
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
  "<svg",
  "See the reservoir.<br>"
]

forbidden_index.each do |fragment|
  errors << "homepage still contains superseded framework or visual structure #{fragment.inspect}" if index.include?(fragment)
end

required_layout = [
  "layout: default",
  "id=\"main\"",
  "class=\"home-main\"",
  "{{ content }}"
]

required_layout.each do |fragment|
  errors << "native homepage layout is missing #{fragment.inspect}" unless home_layout.include?(fragment)
end

errors << "layered homepage density stylesheet must be removed" if File.exist?(DENSITY_CSS)

required_css = [
  ".layout--home",
  ".layout--home .initial-content",
  "#main.home-main",
  "max-width: none",
  "width: 100%",
  ".layout--home .masthead",
  ".layout--home .masthead.is-scrolled",
  "background: transparent",
  "background: rgba(250, 252, 249, .88)",
  "min-height: clamp(560px, 72svh, 660px)",
  "font-size: 5.6rem",
  "@media (max-width: 1200px)",
  "font-size: 4.9rem",
  "width: min(100%, 65ch)",
  "text-align: center",
  "padding-block: 4.25rem",
  "font-size: 3.25rem",
  "min-height: 220px",
  ".hub-r-mini-stat strong",
  ".hub-r-workflow-list",
  ".hub-r-editorial-grid",
  ".has-home-motion .hub-readest-home [data-reveal]",
  "@media (prefers-reduced-motion: reduce)"
]

required_css.each do |fragment|
  errors << "homepage CSS is missing native-layout contract #{fragment.inspect}" unless css.include?(fragment)
end

forbidden_css = [
  "width: 100vw",
  "max-width: 100vw",
  "margin-inline: calc(50% - 50vw)",
  ".hub-home-page",
  "8.6vw",
  "font-size: clamp(2.45rem, 5vw, 4.35rem)",
  ".hub-r-product-window",
  ".hub-r-seismic-canvas",
  ".hub-r-story-visual",
  ".hub-r-map-scene",
  ".hub-r-compare-scene",
  ".hub-r-interpret-scene",
  "grid-template-columns: minmax(0, 1.1fr) minmax(280px, .9fr)"
]

forbidden_css.each do |fragment|
  errors << "homepage CSS still contains overflow-prone or superseded rule #{fragment.inspect}" if css.include?(fragment)
end

errors << "homepage CSS has unbalanced braces" if css.count("{") != css.count("}")

required_js = [
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
  "hub-home-page",
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
  errors << "homepage script still contains framework workaround or unnecessary animation #{fragment.inspect}" if js.downcase.include?(fragment.downcase)
end

stdout, stderr, status = Open3.capture3("node", "--check", JS)
unless status.success?
  errors << "homepage JavaScript failed node --check: #{stderr.strip.empty? ? stdout.strip : stderr.strip}"
end

if errors.empty?
  puts "Native homepage layout, bounded typography, and overflow contract passed."
  exit 0
end

warn "Homepage experience contract failed:"
errors.each { |error| warn "  - #{error}" }
exit 1
