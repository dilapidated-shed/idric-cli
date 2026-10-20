# Installed-command acceptance attempts

Purpose: execute the actual maintained CLI, Kitchen installation, independent
AICI tests and public-provider fixtures. Synthetic self-tests and registration
alone are not installed/provider acceptance. The compiler stage, source build,
installation, independent oracle and provider stage remain separate gates.

Type sketch: bootstrap takes one finite mode and builds the exact Idriç
compiler and packages; accept takes that same mode with explicit environment
inputs, then passes absolute source/compiler/install paths to maintained FP
operations. Grease reads inherited environment through ENV, not implicit shell
variables. A missing compiler remains a refusal, never an ambient fallback.

Recorded host runtime: native payload SHA-256
7e31cd05b7a9d8fb2a4a9e003a7f3fcb0159138506d17f0fb28da8cbe22aa85c;
portable Grease launcher SHA-256
37088097c36a2f82cf45aaea9392e4a4cf16155fecb9da87d08a9c7fb4d92e4a.
This is the declared host compatibility profile, not the C++-free FP2 closure.

Historical failures, preserved in Git history and workflow logs:

- Relative custom shell path resolved under the runner tool directory instead
  of the workspace. CLI #11 run 39338242402 failed before its program build.
- A github.workspace expression in steps.shell produced jobless workflow
  validation failures (39341414535 and 39341422112). No product ran.
- Literal shell grease with verified GITHUB_PATH staging starts real jobs.
  Exact heads 3e3e2771ae1d8c894ed8c2021e6abeeefa63641a and
  92845765167e374d4436d3fdf0d60b5865148fd6 passed actual pinned ICK
  qualification but bootstrap refused Undefined variable PWD in runs
  39343217350 and 39343225688. No CLI/provider pass was produced.
- The actual local Grease also refuses implicit PATH. ENV.PATH succeeds with
  the same real entrypoint. Workflow paths now use explicit github.workspace
  and ENV.PATH; ICK is bound from ENV explicitly inside accept.

A separate successful pinned-ICK producer job allows the maintained action to
retain its exact compiler/runtime cache even when a later consumer fails.
The consumer still restores and requalifies that same immutable compiler;
a green compiler job cannot clear a failing installed/provider job.

No physical A1/C67, APK publication, release, private provider account or
installed interactive-device acceptance is claimed here.


Publication observation: the Git transport and branch-ref API showed the
repaired commit, while the PR head and workflow list still showed its
predecessor. That observation is not a current-head run or a passing check.
This normal contents commit records the mismatch without force, branch
replacement, approval fabrication or retirement of the PR.
