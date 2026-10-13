# Migration provenance

This repository was populated by copying the current CLI program sources from `isomorphisms/az`. The source repository and branches were left intact; this is a consolidation copy, not a destructive history rewrite.

Copied from `az` `main`:

- `bin/az`
- `bin/abe`
- their configuration examples, tests, and AbeBooks note

Copied from current service branch tips:

- `ap-api` → `checkpoints/ap/idric/Ap.idric`
- `economist-api` → `checkpoints/economist/idric/Economist.idric`
- `ft-api` → `checkpoints/ft/idric/Ft.idric`
- `guardian-api` → `checkpoints/guardian/idric/Guardian.idric`
- `nyt-api` → `checkpoints/nyt/idric/Nyt.idric`
- `reddit-api` → the current Idriç Reddit checkpoint, fixture, and manual check
- `reuters-api` → `checkpoints/reuters/idric/Reuters.idric`
- `wayback-api` → `checkpoints/wayback/idric/Wayback.idric`

The branch history previously contained Ithon and Fieldmouse variants for several checkpoints. Those variants had already been removed from the live branch tips during the one-language cleanup, so this migration does not resurrect them.

The following `az` API branches were documentation/research only at migration time and therefore were not copied as CLI programs: `adzuna-api`, `arbeitnow-api`, `careerjet-api`, `indeed-api`, `jobicy-api`, `jooble-api`, `linkedin-api`, `openai-api`, `reed-api`, `remotive-api`, `themuse-api`, `usajobs-api`, and `ziprecruiter-api`.

Date of consolidation: 2026-09-01.

# Indeed execution slice

The implementation branch starts at `cli` b710708e9fc1426f10bca2d426fbb210fc729c20
and incorporates all six Indeed checkpoint paths from the diverged `indeed`
branch at 639f5507a9e42835efa59f42b54ddb4059f06294. The top-level symbolic link is
preserved. The inherited inventory and its earlier Ashtray-Archer/az provenance
are retained. New executable source replaces the 25-line insights checkpoint;
it does not overwrite the inventory or newer repository instructions.
