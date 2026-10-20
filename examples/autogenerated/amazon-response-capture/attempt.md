# Retain the response behind an actual parsing refusal

The maintained installed-command census at CLI head
52df6a2664d9421b2e4b0fb2968e3abc11c4ac87 failed twice in run39351726025.
Attempt1 correctly refused a changing reported population; attempt2 failed
at stage13 with `search endpoint returned invalid JSON`. Artifact12238615966
ZIP SHA25652fd001040eaf2e59364c1f5bd0992dc8a575ff7bf918dfcd4c847831ca45898
was downloaded and verified. The raw failing response was absent, so neither
a provider defect nor a parser defect has been established.

The new Idriç function preserves the actual failed stdout plus request/offset
and process-status context only when the caller supplies an evidence path.
It returns the original refusal, augmented by capture success/failure. JSON
parsing, population identity, denominator and all completeness checks remain
unchanged. The real provider pipeline retains these diagnostics, including
on failure. A failed write never changes a failed query into a successful one.

Type/effect sketch: immutable options, offset, process status, raw Text and
refusal Text enter an optional IO diagnostic effect. The only new effect is
writing caller-selected evidence and its context; no parsed jobs are created.
The separate tiny Idriç invalid-response executable has only stdout and never
uses networking. The Grease diagnostic mode installs that executable as curl
on an isolated PATH for one synthetic negative test, then requires exit1,
empty product stdout, the original refusal and byte-identical captured data.
Subsequent real-provider stages use their normal PATH. Synthetic bytes are
never described as provider evidence.

Before publication, the branch normally merges accepted cli revision
8b6aec4ba89d2ca74bf72ed758fb5667e8453091. Both command targets, sources,
fixtures, workflows and historical failure accounts are retained. The
compiler pin becomes accepted a5398b6cf385a78bd203bc0499da0c5da6fb3714 and
uses its maintained hidden-root paths, matching the real accepted VIN build.
Current-head compilation, diagnostics, installed/independent/provider stages
and the sibling VIN workflow must all execute before integration. Physical
A1/C67 and release acceptance remain NOT_RUN.

Local `git diff --check` and parsing through the recorded Grease host runtime
pass. Idriç compilation and execution have not yet run on this new source;
the hosted workflow must supply them. The accepted VIN tree is preserved,
including its independent/live-provider distinctions. Idric sourcea5398b6
actually landed on canonical Idriç at0e8cfdd1106ebdeffd01b6c519880ea3afc7dc35;
VIN source9b0aeea actually landed on cli at8b6aec4ba89d2ca74bf72ed758fb5667e8453091
after its own13-stage run39359021214 passed. These are dependency facts, not
acceptance of this subsequent combined Amazon.jobs head.

The normal two-parent integration commit is b100b8377f3381e539f8e4e3b3489dfc06436232;
its remote root treee846f287c6353c4be14dfd5eec4b6fe38fa867a4 exactly matches the
locally reconciled index. No branch was forced or deleted. This source-bound
attempt note starts qualification of the real combined candidate; it does not
transfer acceptance from either predecessor.
