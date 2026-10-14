# Amazon.jobs — Idriç CLI

Owner: `dilapidated-shed/idric-cli`, source `AmazonJobs.idric`.

## Commands

```sh
make amazon-jobs-test IDRIC=/opt/Idric/build/exec/idris2

./build/exec/amazon-jobs 'data center technician' --location Michigan --requirements
./build/exec/amazon-jobs 'software engineer' --max-years 0 --format jsonl
./build/exec/amazon-jobs --category software-development --sort relevant --all --max-pages 100 --format jsonl > amazon-sde.jsonl
```

`--all` requests pages until Amazon's reported `hits` records have been scanned,
requiring the same reported count across pages and that all records carry
distinct numeric requisition identities. If a page changes, the result is
incomplete, a prerequisite is unavailable, or the safety bound is reached,
the program exits nonzero. The caller must discard incomplete stdout.
The command does not infer that one posting represents one hire.

The search preserves `business_category` and `team` **as Amazon feed labels**,
not a verified hierarchy. `source_record_id` is separate from the numeric
public requisition ID. The JSONL output also includes job description and
qualification text. `--max-years` is only a heuristic against explicit
year requirements and does not establish that a job is genuinely entry level.
Missing basic qualifications exclude jobs from its experience-filtered output.

The provider endpoint is a public, undocumented interface; schemas, pagination
and access can change without notice. This CLI uses `curl` strictly as the
HTTPS transport process. Idriç owns normalization, filtering, controls and
output. Replace the transport only with a verified Idric-Net/ICU path, and do
not claim one before tested.

## Source and acceptance boundaries

Offline `--self-test` checks a synthetic response, requisition/source ID
separation, organizational fields, and years-filter examples. It is not a
provider test. Full acceptance requires a pinned Idriç compiler and contrib
package, a real compiled executable, independently checked adversarial cases,
and a source-bound Flexible Pipes job with ai-ci acceptance receipts. A
live provider attempt is separate and its failure is never an empty successful
census. Historical reference snapshot:
[Blackball's September 16, 2026 Amazon census](https://github.com/bl4ckb4ll/blackball/tree/main/FAANG/amazon).
