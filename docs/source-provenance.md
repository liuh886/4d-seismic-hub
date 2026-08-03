# Source provenance registry

`_data/source_registry.yml` is the provenance layer for `_data/papers.yml`. Every technical record must have exactly one registry entry using the same `map_id`.

## Why the registry is separate

`papers.yml` contains the project-facing title, description, technical parameters, tags, and link consumed by the website. The provenance registry records how confidently that source has been identified and which fields still require confirmation.

Keeping these concerns separate allows the team to improve provenance without rewriting the benchmark dataset or hiding useful provisional records.

## Grade definitions

### Grade A — canonical technical publication

Use when the link opens the identified technical publication or DOI landing page directly.

Required characteristics:

- `source_type: technical-publication`
- `verification_status: canonical`
- no discovery-search URL
- no explicitly estimated benchmark fields

### Grade B — project publication

Use for a direct project, operator, or technology-provider publication that reports relevant field experience.

Required characteristics:

- `source_type: project-publication`
- `verification_status: project-source`
- no discovery-search URL

Grade B is operational evidence, but the site should not describe it as independently peer reviewed unless that is separately established.

### Grade C — discovery record

Use when the current link is a search or discovery page rather than the identified item-level source.

Required characteristics:

- `source_type: discovery-record`
- `verification_status: discovery-only`
- a note stating that bibliographic metadata and benchmark values require item-level confirmation

Grade C records are retained in default technical comparisons because they may still describe established projects, but the grade must remain visible.

### Grade D — provisional record

Use when one or more material fields are unresolved or explicitly estimated.

Required characteristics:

- `source_type: provisional-record`
- `verification_status: provisional`
- a non-empty `provisional_fields` list
- a note explaining what must be confirmed

Grade D records are visible only when requested and do not enter aggregate Benchmark statistics.

## Registry entry

```yaml
- map_id: Project name matching papers.yml
  grade: C
  source_type: discovery-record
  verification_status: discovery-only
  reviewed_at: YYYY-MM-DD
  provisional_fields: [] # required for Grade D
  note: "Specific explanation of the current source boundary and next verification step."
```

## Promotion workflow

A record should move upward only when the underlying evidence changes.

1. Open the candidate item-level source.
2. Confirm the publication title, authors, year, and project identity.
3. Trace each benchmark field that is presented as a project fact.
4. Replace the search URL in `papers.yml` with the canonical or direct project URL.
5. Update the registry grade, source type, status, review date, and note.
6. Remove a field from `provisional_fields` only after it is traceable to the source.
7. Let repository CI validate the one-to-one contract and Benchmark behavior.

Do not promote a source merely because the project is well known or the value appears plausible.

## Current baseline

The initial registry intentionally reflects the actual link quality currently stored in the repository:

- direct technical publication: Grade A;
- direct project publication: Grade B;
- OnePetro search result: Grade C;
- search result plus explicitly estimated fields: Grade D.

This baseline does not claim that all Grade C bibliographic entries are wrong. It states that the repository has not yet tied them to a canonical item-level URL.
