# Indeed CLI: values, actions and acceptance

Request: SUN INDEED-CLI-01. Target: Ubuntu 24.04 x86-64 Linux.

The existing checkpoint is preserved from `indeed` at
639f5507a9e42835efa59f42b54ddb4059f06294, on the current `cli` base
b710708e9fc1426f10bca2d426fbb210fc729c20. The earlier inventory is
Ashtray-Archer/az `indeed-api` at 84d2737b819d885eeba296870099d30908c8094e.

## Type sketch before implementation

Decoded `Text` differs from encoded URL bytes. A search contains keyword text,
location text and a bounded result limit. `search_request` is pure and produces
JSON, with strings escaped before inclusion in GraphQL. `search_url` is pure
and percent-encodes UTF-8 bytes, not Unicode scalar values.

A `Posting` retains identifier, employer, title, source URL, observation date,
description and completeness. Absent descriptions are incomplete. An explicit
complete flag is accepted only on supplied offline records; the verified live
selection contains only title and sourceEmployerName. A `ProofFinding` has a
finite classification and a verbatim supporting clause. Incomplete records
cannot yield a negative employment finding. Vague mathematical skill does not
imply proof construction. Duplicate identified postings must agree; missing
identifiers must never be merged merely because their titles match.

`decode_response : Text → Either Problem (List Posting)` is shared by fixture
and provider paths. `classify : Posting → ProofFinding` is deterministic and
conservative. `fetch : Search → IO (Either Problem Text)` uses checked
Idric-Net POST framing and ICU's native transport; credentials are environment
inputs and never output. HTTP status, transport failure, GraphQL rejection and
empty results have separate outcomes.

Effects: argument/environment reads, bounded file reads, socket/TLS through
ICU, stdout TSV and stderr diagnostics, exit status. No shell subprocess fetch,
browser cookies, partner impersonation, alternative job provider or credentials
in source. No named holes in the delivered client.

## Current documented boundary

2026-10-13: the official getting-started example documents `jobSearch`, location
with radius/where/radiusUnit, what, limit and results.job.title/sourceEmployerName.
The downloaded SDL omits jobSearch. Pagination, identifiers and full description
fields for that operation cannot be verified from it. Do not invent them.
The separate documented `node(EmployerJob IRI).jobData.description` path is
implemented for authenticated employer-scoped inspection; null/forbidden data
is inaccessible. Its JSON output feeds the real audit parser. A supplied
fixture may contain more data than the current verified live selection.

## Required primitives and runtime

Idriç compiler, Language.JSON, System.File and ICU/Idric-Net; Linux Chez backend
is the existing host runtime. Native transport compilation must use ICK.
Android is a separate NOT_RUN target. Build, installation, parser execution,
transport and live-provider evidence remain distinct.

## Result

Implementation and executed results are recorded in checkpoints/indeed/receipts.
No client fallback is authorized. The first dependency or compile failure must
remain visible instead of being relabeled successful retrieval.
