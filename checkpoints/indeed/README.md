# Indeed API checkpoint

This directory preserves the Indeed API inventory and implements the Idriç CLI.

Snapshot date: 2026-09-09.

Inventory snapshot: 2026-09-09, retained as historical research. Implementation
and official-schema verification: 2026-10-13. The Linux executable builds and
installs; fixture and real local transport tests are separate from live access.

The client is Idriç. The HTTP provider is ICU/Idric-Net's existing socket and
OpenSSL boundary compiled by ICK. There is no Python or C++ substitute client.
The host Idriç compiler uses its maintained Chez backend. Its compiler/runtime
bootstrap is distinct from compiling the ICU consumer library with ICK.

## Commands and exits

`doctor`, `help`, `--help`, `--version`, `url --what WORDS --where LOCATION`,
`search --what WORDS --where LOCATION`, `inspect JOB_ID`, `fixture FILE`, and
`audit-proofs --input FILE` are implemented. `request` prints the actual GraphQL
request without credentials. `inspect JOB_ID --json` preserves descriptions and
provenance in an input directly accepted by `audit-proofs`.

Search accepts `--limit` (local safety range 1–100, default 25) and `--radius`
(miles, default 5). Those bounds are client bounds, not claimed Indeed maxima.
Pass quotes within WORDS for an exact phrase. URLs encode UTF-8, including
supplementary Unicode characters. Location/radius output states the requested
scope; a search hit count is never a nationwide opening count.

| Exit | Meaning |
|---|---|
| 0 | Command completed; evidence column says offline, local test or provider |
| 2 | Invalid arguments or refused test destination |
| 3 | Missing/expired token, inaccessible job data or absent permission |
| 4 | HTTP/GraphQL rejection or unverified pagination |
| 5 | ICU connection, framing or transport failure |
| 6 | Malformed input, missing fields, wrong job identity or credential echo |
| 7 | Input file could not be read |
| 8 | HTTP throttling; retry later |

TSV stdout contains data only. Diagnostics go to stderr. The client reads
`INDEED_ACCESS_TOKEN` and does not print it. The credential-free URL command
requires none. No browser cookies or other provider are accepted. Test endpoint
override requires loopback `/graphql` and the exact synthetic test token.

## Verified API capability

The official example verifies `jobSearch(location: {radius, radiusUnit, where},
what, limit)` selecting `results.job.title` and `sourceEmployerName`. The
downloaded SDL still does **not** contain `jobSearch`. Its unverified IDs,
description fields and pagination are not guessed. Search rows therefore have
incomplete descriptions and cannot establish proof demand.

The SDL does verify `node(id:)`, `EmployerJob.jobData` and
`EmployerJobData.{title,company,description,externalJobPageUrl}`. Inspection uses
an authorized EmployerJob IRI and checks the returned ID and type. This is
employer-scoped access, not arbitrary public search-hit retrieval. Null or
forbidden data is reported inaccessible. No access is inferred from a token's
mere presence. The Job Update guide requires employer-linked OAuth and
`employer_access`/`employer.hosted_job` scopes for that node surface.

Official references checked on 2026-10-13:

- https://docs.indeed.com/getstarted/integrate-and-call-apis
- https://docs.indeed.com/job-update-api/job-update-api-guide
- https://docs.indeed.com/indeed-plus/publisher-js-plugin
- https://docs.indeed.com/public_graphql_schema.graphqls

SDL SHA-256: `c33d7af7631ce722b17c09d076c27bd50f7982c8052874cc8530f99b4fbc40ec`.
The current Publisher JS plugin also requires partner provisioning. No anonymous
result-retrieval method was verified. Public search URLs remain useful.

## Offline input and proof audit

`fixture` parses the same GraphQL response shapes the transport parses.
Normalized supplied inputs use the explicit `provenance` value `synthetic`,
`supplied` or `permitted-response`, with `postings` records containing `id`,
`title`, `employer`, `url`, ISO `observed` date, `description` and `complete`.
The synthetic fixtures are examples of this format. Repeated identical IDs
collapse; conflicting copies reject. Unidentified search rows are not silently
merged by employer/title.

The audit records exact supporting clauses and categories 1–5 from the job
request. Incomplete descriptions yield `unknown`; ambiguous proof requirements
also yield `unknown`. Original construction, mathematical construction,
verification, and reviewing/teaching/evaluation remain distinct. Negated and
aspirational statements cannot become construction requirements. This is a
conservative deterministic phrase classifier, not a claim to solve every
wording in job descriptions. Review unfamiliar phrasing rather than counting it.

## Source-pinned build and installation

`source-pins.tsv` declares the exact compiler, networking and ICK revisions.
`host-dependencies.tsv` declares the executed Ubuntu 24.04 x86-64 runtime.
Provision dependencies as a separate stage; `build.grease` installs nothing.

1. Materialize each declared revision on the Linux build host. Bootstrap the
   pinned Idriç fork through its repository's `edric bootstrap` procedure.
   Install `contrib` from the separately pinned Idric-JSON revision (it repairs
   lowercase JSON hex escapes and validates surrogate pairs), and `network`
   from the core compiler revision, then the pinned Idric-Net
   `idric-net.ipkg` and ICU `icu-response.ipkg` with that same compiler/prefix.
2. Build the declared ICK source. The executed host configuration used C only,
   no bootstrap, no multilib/NLS and the system x86-64 binutils. Its GCC bootstrap
   substrate is not the client compiler. The Unicode assignment qualification
   in this directory rejects substitution of ordinary GCC for ICK.
3. Supply absolute `IDRIC_ROOT`, `IDRIC_JSON_ROOT`, `IDRIC_NET_ROOT`, `ICU_ROOT`, `ICK_SOURCE_ROOT`,
   `IDRIC`, `ICK`, `CHEZ` and `IDRIS2_PREFIX` values. For an uninstalled ICK
   driver supply `ICK_DRIVER_DIR`; the executed host additionally supplied
   `HOST_LIBGCC_DIR=/usr/lib/gcc/x86_64-linux-gnu/13`, explicitly selecting its
   static runtime archive. Invoke `make -C ABSOLUTE_CLI_ROOT indeed` with the
   verified `GREASE` entrypoint. Source pin mismatches fail before compilation.
4. Invoke `make -C ABSOLUTE_CLI_ROOT install-indeed PREFIX=ABSOLUTE_PREFIX`,
   again supplying `GREASE`. It copies the real executable, its Chez application
   and the ICK-built ICU library. The pinned Chez executable must remain
   available at the path embedded by that host build; this is a host install,
   not a claimed portable standalone binary distribution.
5. Run `indeed-test` with `INDEED_PROGRAM` pointing to the installed executable.
   The test server and independent request checker are also compiled Idriç.
   Run from outside the source directory and repeat installation and tests.

The default generic `make test` remains the inherited az/abe suite. Indeed
acceptance is `indeed-test`; it does not skip when compiler/executable inputs
are missing. Android and Termux remain a separate `NOT_RUN` target.

## Acceptance ownership

Flexible Pipes' `indeed-cli-acceptance` pipeline is the job envelope. It captures
the actual Kitchen command, source revisions, stdout/stderr and run identity.
Kitchen's `tasks/indeed-cli/1.grease` preflights the exact source and installed
program. Independent ai-ci `indeed/proof-classification.contract.tsv` compares
the executed audit with its own oracle and rejects a deliberately wrong
original-proof classification. Local fixture success does not confer provider
access. See `receipts/` for executed stage records and the motivating test.

## Important access boundary

Indeed does not currently offer an anonymous public replacement for the retired Publisher Job Search API. The current documentation shows a `jobSearch` GraphQL query, but the same official example shows access denied when the app is not provisioned for the `job-retrieval-service`. Treat `jobSearch` as permissioned.

Most current partner APIs require an Indeed partner relationship, provisioned application credentials, product-specific scopes, and sometimes product review/approval. Hiring Lab uses an Indeed-issued API key instead of OAuth.

## Files

- `API.md` — structural inventory of the current API families, operations, protocols, authentication, and important limits.
- `endpoints.txt` — machine-scannable HTTP routes and named GraphQL operations.
- `PROVENANCE.md` — where this inventory came from and what was refreshed.

## Canonical Indeed documentation

- API catalog: https://docs.indeed.com/api-guides/
- Integration basics: https://docs.indeed.com/integration-basics/
- Authentication: https://docs.indeed.com/authentication/
- Full GraphQL schema: https://docs.indeed.com/public_graphql_schema.graphqls
- GraphQL API reference: https://docs.indeed.com/api/graphql_schema
- Release notes: https://docs.indeed.com/release-notes

The downloadable GraphQL SDL is the canonical type-level surface. This checkpoint records the product/operation-level interface and the non-GraphQL protocols without copying Indeed's documentation prose wholesale.
