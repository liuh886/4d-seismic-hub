#!/usr/bin/env ruby
# frozen_string_literal: true

require "date"
require "uri"
require "yaml"

ROOT = File.expand_path("..", __dir__)
PAPERS_PATH = File.join(ROOT, "_data", "papers.yml")
REGISTRY_PATH = File.join(ROOT, "_data", "source_registry.yml")
ALLOWED_GRADES = %w[A B C D].freeze
REQUIRED_FIELDS = %w[map_id grade source_type verification_status reviewed_at note].freeze

load_yaml = lambda do |path|
  YAML.safe_load(
    File.read(path, encoding: "UTF-8"),
    permitted_classes: [Date, Time],
    aliases: true
  ) || []
end

papers = load_yaml.call(PAPERS_PATH)
registry = load_yaml.call(REGISTRY_PATH)
errors = []

paper_ids = papers.map { |record| record["map_id"].to_s }
registry_ids = registry.map { |record| record["map_id"].to_s }

paper_ids.group_by(&:itself).each do |map_id, matches|
  errors << "papers.yml contains duplicate map_id #{map_id.inspect}" if matches.length > 1
end

registry_ids.group_by(&:itself).each do |map_id, matches|
  errors << "source_registry.yml contains duplicate map_id #{map_id.inspect}" if matches.length > 1
end

(paper_ids - registry_ids).each do |map_id|
  errors << "source registry is missing paper record #{map_id.inspect}"
end

(registry_ids - paper_ids).each do |map_id|
  errors << "source registry contains orphan record #{map_id.inspect}"
end

paper_index = papers.to_h { |record| [record["map_id"].to_s, record] }

registry.each do |record|
  map_id = record["map_id"].to_s

  REQUIRED_FIELDS.each do |field|
    value = record[field]
    errors << "#{map_id.inspect}: source registry field #{field} is missing" if value.nil? || value.to_s.strip.empty?
  end

  grade = record["grade"].to_s
  errors << "#{map_id.inspect}: invalid source grade #{grade.inspect}" unless ALLOWED_GRADES.include?(grade)

  note = record["note"].to_s.strip
  errors << "#{map_id.inspect}: provenance note must be specific" if note.length < 40

  reviewed_at = record["reviewed_at"]
  unless reviewed_at.is_a?(Date) || reviewed_at.to_s.match?(/\A\d{4}-\d{2}-\d{2}\z/)
    errors << "#{map_id.inspect}: reviewed_at must be an ISO date"
  end

  paper = paper_index[map_id]
  next unless paper

  link = paper["link"].to_s
  begin
    uri = URI.parse(link)
    errors << "#{map_id.inspect}: source link must use HTTPS" unless uri.is_a?(URI::HTTPS) && !uri.host.to_s.empty?
  rescue URI::InvalidURIError
    errors << "#{map_id.inspect}: source link is invalid"
  end

  discovery_link = link.include?("onepetro.org/search?")
  estimated_fields = %w[title authors year description bin_size repeat_interval sensor_type nrms_median main_driver water_depth]
    .select { |field| paper[field].to_s.match?(/estimated/i) }

  case grade
  when "A"
    errors << "#{map_id.inspect}: Grade A cannot use a discovery search URL" if discovery_link
    errors << "#{map_id.inspect}: Grade A must use source_type technical-publication" unless record["source_type"] == "technical-publication"
    errors << "#{map_id.inspect}: Grade A cannot contain explicitly estimated fields" if estimated_fields.any?
  when "B"
    errors << "#{map_id.inspect}: Grade B cannot use a discovery search URL" if discovery_link
    errors << "#{map_id.inspect}: Grade B must use source_type project-publication" unless record["source_type"] == "project-publication"
  when "C"
    errors << "#{map_id.inspect}: Grade C must use a discovery search URL in the current registry" unless discovery_link
    errors << "#{map_id.inspect}: Grade C must use source_type discovery-record" unless record["source_type"] == "discovery-record"
    errors << "#{map_id.inspect}: explicitly estimated fields require Grade D" if estimated_fields.any?
  when "D"
    provisional_fields = Array(record["provisional_fields"]).map(&:to_s)
    errors << "#{map_id.inspect}: Grade D must name provisional_fields" if provisional_fields.empty?
    missing_markers = provisional_fields.reject do |field|
      paper.key?(field) && (paper[field].to_s.match?(/estimated/i) || %w[title authors year].include?(field))
    end
    if missing_markers.any?
      errors << "#{map_id.inspect}: provisional_fields are not traceable to current uncertainty: #{missing_markers.join(', ')}"
    end
    errors << "#{map_id.inspect}: Grade D must use source_type provisional-record" unless record["source_type"] == "provisional-record"
  end
end

if errors.empty?
  counts = registry.group_by { |record| record["grade"] }.transform_values(&:length)
  puts "Source registry contract passed for #{registry.length} records (#{counts.sort.map { |grade, count| "#{grade}=#{count}" }.join(', ')})."
  exit 0
end

warn "Source registry contract failed:"
errors.each { |error| warn "  - #{error}" }
exit 1
