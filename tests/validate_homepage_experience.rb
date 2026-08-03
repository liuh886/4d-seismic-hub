#!/usr/bin/env ruby
# frozen_string_literal: true

require "open3"
require "yaml"

ROOT = File.expand_path("..", __dir__)
INDEX = File.join(ROOT, "index.md")
HOME_LAYOUT = File.join(ROOT, "_layouts", "home.html")
HEAD_CUSTOM = File.join(ROOT, "_includes", "head", "custom.html")
CSS = File.join(ROOT, "assets", "css", "home-readest.css")
JS = File.join(ROOT, "assets", "js", "home-scroll.js")
LOGO = File.join(ROOT, "assets", "images", "logo.svg")
NAV = File.join(ROOT, "_data", "navigation.yml")
DENSITY_CSS = File.join(ROOT, "assets", "css", "home-density.css")

index = File.read(INDEX, encoding: "UTF-8")
home_layout = File.read(HOME_LAYOUT, encoding: "UTF-8")
head_custom = File.read(HEAD_CUSTOM, encoding: "UTF-8")
css = File.read(CSS, encoding: "UTF-8")
js = File.read(JS, encoding: "UTF-8")
logo = File.read(LOGO, encoding: "UTF-8")
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
errors << "Analysis must remain contextual rather than permanent navigation" if nav_titles.include?("Analysis")

required_index = [
  "layout: home",
  "hub-readest-home",
  "aria-labelledby=\"home-title\"",
  "<h1 id=\"home-title\">",
  "<dl class=\"hub-r-mini-stats\"",
  "<dt>{{ case_count }}</dt>",
  "hub-r-workflow-list",
  "hub-r-workflow-link",
  "site.posts limit:3",
  "site.data.case_studies_map limit:3",
  "/pages/knowledge-base/",
  "/pages/comparison-tool/",
  "/pages/analysis/"
]

required_index.each do |fragment|
  errors << "homepage is missing semantic native content #{fragment.inspect}" unless index.include?(fragment)
end

forbidden_index = [
  "layout: splash",
  "classes: wide",
  "<link rel=\"stylesheet\"",
  "<script src=",
  "assets/css/home-density.css",
  "document.documentElement.classList.add",
  "hub-home-hero",
  "hub-stat-band",
  "hub-r-product-window",
  "hub-r-seismic-canvas",
  "data-hero-stage",
  "data-story-step",
  "<svg",
  "<br>"
]

forbidden_index.each do |fragment|
  errors << "homepage still contains body-level assets or superseded structure #{fragment.inspect}" if index.include?(fragment)
end

required_layout = [
  "layout: default",
  "<main id=\"main\" class=\"home-main\" tabindex=\"-1\">",
  "{{ content }}"
]
required_layout.each do |fragment|
  errors << "native homepage layout is missing #{fragment.inspect}" unless home_layout.include?(fragment)
end
errors << "homepage layout must not reintroduce splash wrappers" if home_layout.match?(/article|page__content|class=\"splash\"/)

required_head = [
  "rel=\"icon\"",
  "{% if page.layout == 'home' %}",
  "assets/css/home-readest.css",
  "assets/js/home-scroll.js",
  "defer"
]
required_head.each do |fragment|
  errors << "head integration is missing #{fragment.inspect}" unless head_custom.include?(fragment)
end

errors << "layered homepage density stylesheet must remain removed" if File.exist?(DENSITY_CSS)

required_css = [
  ".layout--home .masthead",
  ".layout--home .masthead.is-scrolled",
  "-webkit-backdrop-filter",
  "#main.home-main",
  "min-height: 600px",
  "font-size: 4.75rem",
  "font-size: 4.25rem",
  "font-size: 3.65rem",
  "width: min(100%, 68ch)",
  "padding-block: 3.75rem",
  "font-size: 2.75rem",
  "grid-template-columns: repeat(2, minmax(0, 1fr))",
  ".hub-r-mini-stats dt",
  ".hub-r-workflow-link",
  ".hub-r-card-link",
  "@media (hover: hover) and (pointer: fine)",
  "@media (prefers-reduced-motion: reduce)"
]
required_css.each do |fragment|
  errors << "homepage CSS is missing final native contract #{fragment.inspect}" unless css.include?(fragment)
end

forbidden_css = [
  "width: 100vw",
  "max-width: 100vw",
  "margin-inline: calc(50% - 50vw)",
  "overflow-x:",
  ".hub-readest-home .hub-shell",
  ".layout--home .masthead__inner-wrap {\n  width:",
  "8.6vw",
  "7.35rem",
  "5.6rem",
  "72svh",
  ".hub-home-page",
  ".hub-r-product-window",
  ".hub-r-seismic-canvas",
  ".hub-r-story-visual"
]
forbidden_css.each do |fragment|
  errors << "homepage CSS still contains scaling, overflow masking, or old workaround #{fragment.inspect}" if css.include?(fragment)
end
errors << "homepage CSS has unbalanced braces" if css.count("{") != css.count("}")

required_js = [
  "document.body",
  "layout--home",
  "IntersectionObserver",
  "prefers-reduced-motion: reduce",
  "is-scrolled",
  "window.scrollY > 24",
  "window.addEventListener('scroll', syncNavigation, { passive: true })",
  "window.addEventListener('pageshow', syncNavigation)"
]
required_js.each do |fragment|
  errors << "homepage interaction behavior is missing #{fragment.inspect}" unless js.include?(fragment)
end

forbidden_js = [
  "requestAnimationFrame",
  "DOMContentLoaded",
  "data-story-step",
  "data-story-visual",
  "data-hero-stage",
  "gsap",
  "ScrollMagic",
  "AOS",
  "jquery"
]
forbidden_js.each do |fragment|
  errors << "homepage script contains unnecessary framework workaround #{fragment.inspect}" if js.downcase.include?(fragment.downcase)
end

required_logo = [
  "viewBox=\"0 0 64 64\"",
  "fill=\"#071923\"",
  "4D Seismic Hub"
]
required_logo.each do |fragment|
  errors << "compact logo is missing #{fragment.inspect}" unless logo.include?(fragment)
end
errors << "logo must not retain the oversized legacy canvas" if logo.match?(/width=\"800\"|height=\"600\"|viewBox=\"0 0 800 600\"/)

stdout, stderr, status = Open3.capture3("node", "--check", JS)
unless status.success?
  errors << "homepage JavaScript failed node --check: #{stderr.strip.empty? ? stdout.strip : stderr.strip}"
end

if errors.empty?
  puts "Final native homepage structure, typography, assets, and interaction contract passed."
  exit 0
end

warn "Homepage experience contract failed:"
errors.each { |error| warn "  - #{error}" }
exit 1
