#!/usr/bin/env ruby
# frozen_string_literal: true

ROOT = File.expand_path("..", __dir__)
errors = []

read = lambda do |path|
  File.read(File.join(ROOT, path), encoding: "UTF-8")
end

layout = read.call("_layouts/single.html")
community = read.call("_includes/community-perspectives.html")
overview = read.call("_includes/case-overview.html")
head = read.call("_includes/head/custom.html")
config = read.call("_config.yml")

checks = {
  "single layout includes community review" => layout.include?("include community-perspectives.html"),
  "single layout includes structured case brief" => layout.include?("include case-overview.html"),
  "community comments config exists" => config.match?(/^community_comments:/),
  "forum label config exists" => config.include?("forum_label"),
  "forum label is wired into utterances" => community.include?('label="{{ forum_label }}"'),
  "stable issue-term fallback exists" => community.include?("page.community_issue_term | default: page.id"),
  "community review states its evidence boundary" => community.include?("Evidence boundary:"),
  "supporting-signals label exists" => community.include?("Supporting signals"),
  "limits-and-counterexamples label exists" => community.include?("Limits and counterexamples"),
  "case overview renders source record" => overview.include?("Technical source record"),
  "case overview renders evidence scope" => overview.include?("Evidence scope"),
  "case overview renders known limitations" => overview.include?("Known limitations"),
  "evidence component styles are loaded" => head.include?("assets/css/evidence.css"),
  "community review styles are loaded" => head.include?("assets/css/community.css")
}

checks.each do |description, passed|
  errors << description unless passed
end

if errors.empty?
  puts "Community review and evidence-boundary contract passed."
  exit 0
end

warn "Community review and evidence-boundary contract failed:"
errors.each { |error| warn "  - #{error}" }
exit 1
