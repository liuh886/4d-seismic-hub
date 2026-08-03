#!/usr/bin/env ruby
# frozen_string_literal: true

require "open3"

ROOT = File.expand_path("..", __dir__)
INDEX = File.join(ROOT, "index.md")
CSS = File.join(ROOT, "assets", "css", "home-readest.css")
JS = File.join(ROOT, "assets", "js", "home-scroll.js")

index = File.read(INDEX, encoding: "UTF-8")
css = File.read(CSS, encoding: "UTF-8")
js = File.read(JS, encoding: "UTF-8")
errors = []

required_index = [
  "hub-readest-home",
  "hub-r-hero-copy",
  "hub-r-mini-stats",
  "data-hero-stage",
  "data-story-visual",
  "data-story-step=\"discover\"",
  "data-story-step=\"compare\"",
  "data-story-step=\"interpret\"",
  "assets/css/home-readest.css",
  "assets/js/home-scroll.js"
]

required_index.each do |fragment|
  errors << "homepage is missing #{fragment.inspect}" unless index.include?(fragment)
end

forbidden_index = [
  "hub-home-hero",
  "hub-stat-band",
  "hub-stat-grid",
  "hub-hero-grid"
]

forbidden_index.each do |fragment|
  errors << "homepage still uses superseded hero structure #{fragment.inspect}" if index.include?(fragment)
end

required_css = [
  "height: clamp(300px, 35vw, 380px)",
  ".hub-r-mini-stat strong",
  "font-size: clamp(1rem, 1.5vw, 1.25rem)",
  ".hub-r-story-visual",
  "position: sticky",
  ".has-home-motion .hub-readest-home [data-reveal]",
  "@media (prefers-reduced-motion: reduce)"
]

required_css.each do |fragment|
  errors << "homepage CSS is missing #{fragment.inspect}" unless css.include?(fragment)
end

if css.count("{") != css.count("}")
  errors << "homepage CSS has unbalanced braces"
end

required_js = [
  "IntersectionObserver",
  "prefers-reduced-motion: reduce",
  "data-story-step",
  "requestAnimationFrame",
  "aria-current"
]

required_js.each do |fragment|
  errors << "homepage scroll behavior is missing #{fragment.inspect}" unless js.include?(fragment)
end

forbidden_js = ["gsap", "ScrollMagic", "AOS", "jquery"]
forbidden_js.each do |fragment|
  errors << "homepage introduces an unnecessary animation dependency #{fragment.inspect}" if js.downcase.include?(fragment.downcase)
end

stdout, stderr, status = Open3.capture3("node", "--check", JS)
unless status.success?
  errors << "homepage JavaScript failed node --check: #{stderr.strip.empty? ? stdout.strip : stderr.strip}"
end

if errors.empty?
  puts "Compact homepage and scroll-story contract passed."
  exit 0
end

warn "Homepage experience contract failed:"
errors.each { |error| warn "  - #{error}" }
exit 1
