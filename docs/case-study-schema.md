# Case-study content contract

The case-study template separates narrative judgment from shared benchmark data.

## Source of truth

Each case post stores only the fields that belong to the editorial interpretation:

```yaml
classes: case-study
case_study:
  map_id: Project name used by shared datasets
  monitoring_objective: The uncertainty or operational question being monitored
  decision_outcome: What the evidence changed or supported
  transferable_lesson: What another project team can reuse
  evidence_status: A short maturity label
```

Technical benchmark values are not duplicated in post front matter. The case overview resolves the same `map_id` against:

- `_data/case_studies_map.yml` for location and case-library routing;
- `_data/papers.yml` for sensor type, repeat interval, NRMS, main signal driver, water depth, and source URL.

## Required article structure

Case posts should use the following sequence:

1. **Decision context** — the uncertainty, risk, or development decision.
2. **Monitoring approach** — the acquisition or surveillance response.
3. **Evidence** — the observed signal and relevant repeatability evidence.
4. **Operational outcome** — the action, assurance, or decision supported.
5. **Transferable lesson** — what can and cannot be reused elsewhere.

The headings may be adapted when a case genuinely requires it, but the decision chain should remain visible.

## Validation

`tests/validate_case_studies.rb` checks that:

- every post in the `4d-case-study` or `ccs-monitoring` category has structured metadata;
- required editorial fields are present;
- each case uses the `case-study` page class;
- `map_id` exists in both shared datasets;
- each documented case has a map `post_url`;
- no two posts claim the same `map_id`.

The validation runs in the pull-request workflow before the Jekyll build.

## Editorial rule

Do not copy benchmark parameters into post front matter or prose merely to populate the overview. Update the shared dataset once, then let the template render the value everywhere. This prevents the case page, map, and benchmarking tool from drifting apart.
