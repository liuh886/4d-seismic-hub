#!/usr/bin/env ruby
# frozen_string_literal: true

ROOT = File.expand_path("..", __dir__)
INDEX = File.join(ROOT, "_site", "index.html")
CSS = File.join(ROOT, "_site", "assets", "css", "home-readest.css")
JS = File.join(ROOT, "_site", "assets", "js", "home-scroll.js")
LOGO = File.join(ROOT, "_site", "assets", "images", "logo.svg")

missing = [INDEX, CSS, JS, LOGO].reject { |path| File.file?(path) && File.size?(path) }
unless missing.empty?
  warn "Built homepage assets are missing:"
  missing.each { |path| warn "  - #{path.delete_prefix(ROOT + File::SEPARATOR)}" }
  exit 1
end

html = File.read(INDEX, encoding: "UTF-8")
css = File.read(CSS, encoding: "UTF-8")
js = File.read(JS, encoding: "UTF-8")
logo = File.read(LOGO, encoding: "UTF-8")
errors = []

head_end = html.index("</head>")
body_start = html.index("<body")
style_index = html.index("home-readest.css")
script_index = html.index("home-scroll.js")

errors << "built homepage must contain body.layout--home" unless html.match?(/<body[^>]*class="[^"]*layout--home[^"]*"/)
errors << "built homepage must contain exactly one #main" unless html.scan(/id="main"/).length == 1
errors << "built homepage must contain the native home-main element" unless html.include?("class=\"home-main\"")
errors << "built homepage must preserve skip-link focusability" unless html.match?(/<main[^>]*id="main"[^>]*tabindex="-1"/)
errors << "built homepage must contain exactly one h1" unless html.scan(/<h1\b/).length == 1
errors << "built homepage must retain semantic collection statistics" unless html.include?("<dl class=\"hub-r-mini-stats\"") && html.scan(/<dt>/).length >= 3
errors << "built homepage must not contain splash wrappers" if html.match?(/class="[^"]*splash|class="page__content"/)
errors << "homepage stylesheet must be emitted in head" unless style_index && head_end && style_index < head_end
errors << "homepage script must be emitted in head" unless script_index && head_end && script_index < head_end
errors << "homepage script must remain deferred" unless html.match?(/<script[^>]*home-scroll\.js[^>]*defer/)
errors << "homepage stylesheet must be emitted exactly once" unless html.scan(/home-readest\.css/).length == 1
errors << "homepage script must be emitted exactly once" unless html.scan(/home-scroll\.js/).length == 1
errors << "homepage assets must not be injected after body begins" if body_start && ((style_index && style_index > body_start) || (script_index && script_index > body_start))
errors << "SVG favicon must be present" unless html.match?(/rel="icon"[^>]*logo\.svg/)
errors << "unresolved Liquid markup remains in homepage" if html.match?(/\{\{[^}]+\}\}|\{%[^%]+%\}/)

forbidden_css = ["100vw", "50vw", "overflow-x:", "8.6vw", "72svh", ".hub-home-page"]
forbidden_css.each do |fragment|
  errors << "built homepage CSS contains forbidden workaround #{fragment.inspect}" if css.include?(fragment)
end
errors << "built homepage JavaScript must target body.layout--home" unless js.include?("body.classList.contains('layout--home')")
errors << "built logo must use the compact canvas" unless logo.include?("viewBox=\"0 0 64 64\"")
errors << "built logo still contains legacy dimensions" if logo.match?(/800|600/)

if errors.empty?
  puts "Built homepage DOM, head placement, assets, and native-wrapper contract passed."
  exit 0
end

warn "Built homepage contract failed:"
errors.each { |error| warn "  - #{error}" }
exit 1
