# Jobicy command-line application

## Type sketch before implementation

The input is either command arguments, a UTF-8 public Jobicy response, or a
clearly labelled offline fixture. A search carries page size (1–200), geographic
eligibility, industry, keyword, and an opaque cursor. A traversal carries its
unchanged search, seen cursors, exact IDs, page count and a finite request budget.

`read_page : response_text → Result problem page` validates successful HTTP/API
meaning, counts, pagination consistency, exact integer identities and complete
descriptions. `advance_traversal : traversal → page → Result problem traversal`
deduplicates identical IDs, refuses conflicting copies and repeated cursors.
`fetch_page : search → IO (Result problem observation)` uses ICU/Idric-Net.
`render_job : output_format → observation → posting → Text` preserves descriptions
with reversible escaping. Status is a three-way choice: active, closed, unknown.
Unknown and feed disappearance cannot imply closed.

Effects belong in Run; protocol validation and output construction belong in
Protocol. The current compiler's Chez backend implements these effects; ICU's
existing native socket/OpenSSL provider is compiled by ICK. No substitute
network client or generated-C language backend is used.

The inherited JSON representation stores numbers as a host floating value.
Therefore decoding also preserves number lexemes in a second parse after the
original JSON grammar validates the document. IDs and salary values retain
their original digits, including integers beyond binary64's exact range.
Digit preservation is a representation boundary, not a new Jobicy identity.

Current executable syntax uses the compiler's accepted Unicode arrows, Text,
snake_case names and explicit covering I/O boundaries. Richer purpose phrases
in this sketch are descriptive, not claimed grammar.

## Verification

Execution results and source/toolchain pins belong in checkpoints/jobicy and
the source-bound Flexible Pipes receipts. Synthetic fixtures, real local HTTP
transport, live-provider evidence, and physical devices remain distinct.
No fallback is selected. Device compilation is forbidden.
