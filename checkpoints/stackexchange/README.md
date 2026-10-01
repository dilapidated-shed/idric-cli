# Stack Exchange public API documentation checkpoint

Audit baseline: 2026-10-01.

This checkpoint records the public Stack Exchange API surface before implementing a client.

The immediate consumer is Black Ball's computer-science syllabus research. The first question is descriptive rather than prescriptive: what did programmers actually ask about, upvote, revisit, leave unanswered, and tag during a given period? Curriculum decisions come later.

Stack Overflow is one site on the Stack Exchange API. The API is network-wide; callers select Stack Overflow with `site=stackoverflow`.

## Files

- `SOURCES.tsv` — canonical public documentation URLs and why each matters.
- `SURFACE.md` — annotated reading of the documented contracts and the first useful read-side surface.
- `DOCUMENTED_SURFACE.tsv` — compact factual dump of the endpoints and query shapes relevant to corpus work.
- `mirror-docs` — reproducible raw-document mirror command. It downloads the URLs in `SOURCES.tsv`, records hashes, and does not rewrite their contents.

The raw mirror is intentionally generated rather than copied into these notes. The notes should remain readable when the upstream HTML layout changes.

## Evidence boundary

This branch is documentation/research only. It does not yet claim:

- an implemented Stack Exchange client;
- a complete archive of Stack Overflow;
- a statistically unbiased measure of programmer difficulty;
- a curriculum recommendation.

Question score is an observable signal, not a definition of difficulty. Age, tag population, traffic, moderation, deletion, migration, changes in voting behavior, and changes in Stack Overflow usage all affect what survives and how many votes it accumulates.

For year-by-year work, preserve the actual creation window and compare within that window rather than ranking the entire historical corpus by raw score.

## Likely CLI direction

A later client can expose a small read-side vocabulary such as:

```text
stack questions --site stackoverflow --from 2025-01-01 --to 2025-12-31 --sort votes
stack questions --site stackoverflow --tag c --from 2025-01-01 --to 2025-12-31
stack no-answers --site stackoverflow --tag c --from 2025-01-01 --to 2025-12-31
stack unanswered --site stackoverflow --tag c --from 2025-01-01 --to 2025-12-31
stack tags --site stackoverflow
```

That interface is not yet committed as implementation. Keep the API observations separate from later command design.
