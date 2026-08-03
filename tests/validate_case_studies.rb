#!/usr/bin/env ruby
# frozen_string_literal: true

require "date"
require "uri"
require "yaml"

ROOT = File.expand_path("..", __dir__)
CASE_CATEGORIES = %w[4d-case-study ccs-monitoring].freeze
REQUIRED_FIELDS = %w[
  map_id
  monitoring_objective
  decision_outcome
  transferable_lesson
  evidence_status
  evidence_scope
].freeze
REQUIRED_HEADINGS = [
  "## Decision context",
  "## Monitoring approach",
  "## Evidence",
  "## Operational outcome",
  "## Transferable lesson"
].freeze
REQUIRED_BENCHMARK_FIELDS = %w[title authors year link].freeze

errors = []

load_yaml = lambda do |path|
  YAML.safe_load(
    File.read(path, encoding: "UTF-8"),
    permitted_classes: [Date, Time],
    aliases: true
  )
end

https_url = lambda do |value|
  uri = URI.parse(value.to_s)
  uri.is_a?(URI::HTTPS) && !uri.host.to_s.empty?
rescue URI::InvalidURIError
  false
end

maps = load_yaml.call(File.join(ROOT, "_data", "case_studies_map.yml")) || []
papers = load_yaml.call(File.join(ROOT, "_data", "papers.yml")) || []
map_index = maps.to_h { |entry| [entry.fetch("name"), entry] }
paper_index = papers.group_by { |entry| entry["map_id"] }
seen_map_ids = {}

Dir.glob(File.join(ROOT, "_posts", "*.md")).sort.each do |path|
  source = File.read(path, encoding: "UTF-8")
  front_matter = source.match(/\A---\s*\n(.*?)\n---\s*\n/m)

  unless front_matter
    errors << "#{path}: missing YAML front matter"
    next
  end

  data = YAML.safe_load(
    front_matter[1],
    permitted_classes: [Date, Time],
    aliases: true
  ) || {}

  categories = Array(data["categories"]).map(&:to_s)
  is_case_post = (categories & CASE_CATEGORIES).any?
  case_data = data["case_study"]

  if is_case_post && !case_data.is_a?(Hash)
    errors << "#{path}: case-study post is missing case_study metadata"
    next
  end

  next unless case_data.is_a?(Hash)

  REQUIRED_FIELDS.each do |field|
    value = case_data[field]
    errors << "#{path}: case_study.#{field} is missing" if value.nil? || value.to_s.strip.empty?
  end

  limitations = case_data["limitations"]
  unless limitations.is_a?(Array) && limitations.length >= 2 && limitations.all? { |item| !item.to_s.strip.empty? }
    errors << "#{path}: case_study.limitations must contain at least two non-empty items"
  end

  REQUIRED_HEADINGS.each do |heading|
    errors << "#{path}: missing required heading #{heading.inspect}" unless source.include?(heading)
  end

  classes = Array(data["classes"]).flat_map { |value| value.to_s.split }
  errors << "#{path}: classes must include case-study" unless classes.include?("case-study")

  summary = data["community_summary"]
  if summary
    unless summary.is_a?(Hash)
      errors << "#{path}: community_summary must be a mapping"
    else
      errors << "#{path}: community_summary.updated_at is missing" if summary["updated_at"].nil?
      %w[pro con].each do |side|
        items = summary[side]
        unless items.is_a?(Array) && items.any? && items.all? { |item| !item.to_s.strip.empty? }
          errors << "#{path}: community_summary.#{side} must contain non-empty items"
        end
      end
    end
  end

  map_id = case_data["map_id"].to_s
  next if map_id.empty?

  if seen_map_ids.key?(map_id)
    errors << "#{path}: map_id #{map_id.inspect} is already used by #{seen_map_ids[map_id]}"
  else
    seen_map_ids[map_id] = path
  end

  unless map_index.key?(map_id)
    errors << "#{path}: map_id #{map_id.inspect} is missing from _data/case_studies_map.yml"
    next
  end

  benchmark_records = paper_index[map_id]
  unless benchmark_records
    errors << "#{path}: map_id #{map_id.inspect} is missing from _data/papers.yml"
    next
  end

  if benchmark_records.length != 1
    errors << "#{path}: map_id #{map_id.inspect} must resolve to exactly one paper record"
    next
  end

  benchmark = benchmark_records.first
  REQUIRED_BENCHMARK_FIELDS.each do |field|
    value = benchmark[field]
    missing = value.nil? || value.respond_to?(:empty?) && value.empty?
    errors << "#{path}: benchmark #{map_id.inspect} is missing #{field}" if missing
  end

  unless https_url.call(benchmark["link"])
    errors << "#{path}: benchmark #{map_id.inspect} must use a valid HTTPS source link"
  end

  if map_index[map_id]["post_url"].to_s.strip.empty?
    errors << "#{path}: map entry #{map_id.inspect} is missing post_url"
  end
end

if errors.empty?
  puts "Case-study evidence contract passed for #{seen_map_ids.length} posts."
  exit 0
end

warn "Case-study evidence contract failed:"
errors.each { |error| warn "  - #{error}" }
exit 1
