#!/usr/bin/env ruby
# frozen_string_literal: true

require "open3"
require "tempfile"

ROOT = File.expand_path("..", __dir__)
PAGE = File.join(ROOT, "pages", "comparison-tool.md")
HEAD = File.join(ROOT, "_includes", "head", "custom.html")

source = File.read(PAGE, encoding: "UTF-8")
head = File.read(HEAD, encoding: "UTF-8")
errors = []

required_fragments = [
  "Data completeness for source-eligible records",
  "How benchmark metrics and source grades are handled",
  "function sourceRecord",
  "function isSourceEligible",
  "function sourceMatches",
  "function parseMetric",
  "function parseDurationYears",
  "function median",
  "function coverage",
  "range midpoint",
  "method: 'censored'",
  "Median plottable NRMS",
  "Median repeat interval",
  "Median first bin dimension",
  "Median water depth",
  "Benchmark eligible (A–C)",
  "Grade D provisional records",
  "const analysisData = filtered.filter(isSourceEligible)",
  "site.data.source_registry | jsonify"
]

required_fragments.each do |fragment|
  errors << "comparison tool is missing #{fragment.inspect}" unless source.include?(fragment)
end

forbidden_fragments = [
  "type: 'radar'",
  "Filtered technical profile",
  "Water depth / 20",
  "average(data, 'repeat_interval') * 10",
  "average(data, 'water_depth') / 20",
  "updateSummary(filtered)",
  "updateCharts(filtered)"
]

forbidden_fragments.each do |fragment|
  errors << "comparison tool contains unsafe benchmark logic #{fragment.inspect}" if source.include?(fragment)
end

unless head.include?("assets/css/benchmark.css")
  errors << "benchmark component styles are not loaded"
end

script_blocks = source.scan(/<script>(.*?)<\/script>/m).flatten
inline_script = script_blocks.last
if inline_script.nil? || inline_script.strip.empty?
  errors << "comparison tool inline script is missing"
else
  sanitized = inline_script
    .gsub(/\{\{\s*site\.data\.papers\s*\|\s*jsonify\s*\}\}/, "[]")
    .gsub(/\{\{\s*site\.data\.case_studies_map\s*\|\s*jsonify\s*\}\}/, "[]")
    .gsub(/\{\{\s*site\.data\.source_registry\s*\|\s*jsonify\s*\}\}/, "[]")

  Tempfile.create(["benchmark-contract", ".js"]) do |file|
    file.write(sanitized)
    file.flush
    stdout, stderr, status = Open3.capture3("node", "--check", file.path)
    unless status.success?
      errors << "comparison tool JavaScript failed node --check: #{stderr.strip.empty? ? stdout.strip : stderr.strip}"
    end
  end
end

if errors.empty?
  puts "Benchmark metric, provenance, and JavaScript contract passed."
  exit 0
end

warn "Benchmark metric contract failed:"
errors.each { |error| warn "  - #{error}" }
exit 1
