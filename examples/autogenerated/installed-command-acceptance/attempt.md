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


## Actual hidden-root prefix failure and repair

Current-head run https://github.com/dilapidated-shed/idric-cli/actions/runs/39345776319, job 118384644913, qualified the explicit ICK compiler and built the real Idriç source into stage 2, then failed: `INTERNAL ERROR: Can't find data file chez/support.ss`. The original full failed process source remains at commit 2c5ff1c7ec99653a0ef2237ec5acfd0c5b35740c; it is not a passing installed-command receipt.

Current-head run https://github.com/dilapidated-shed/idric-cli/actions/runs/39345780098, job 118382267469, qualified the explicit ICK compiler and built the real Idriç source into stage 2, then failed: `INTERNAL ERROR: Can't find data file chez/support.ss`. The original full failed process source remains at commit 1d075dd28125a8fd0ad7e6328f066ae480cf30ed; it is not a passing installed-command receipt.

The consumer-level IDRIS2_PREFIX pointed at the stable top-level bootstrap-build path before the actual root edric wrapper had created that symlink. That environment also overrode the bootstrap Makefile's own prefix selection. Bootstrap now removes only IDRIS2_PREFIX and IDRIS2_PATH from its child environment, matching the established successful recipe. The same source, explicit ICK CC/CFLAGS, private pinned Chez and full edric all smoke tests remain required. Once bootstrap returns, the wrapper's stable paths exist and the consumer prefix plus its own contrib are used as before. No support file is fabricated or borrowed from a stock compiler.

The registered FP launcher is tracked mode 100644 with a Python shebang. Invoke that unchanged maintained executor through its declared Python interpreter; this does not turn its legacy source into checked-Ithon/FP2 acceptance. Actual build, installed command, independent oracle and provider stages still have to execute. Fresh failure, missing or cancelled stages remain NOT_ACCEPTED.

## Exact clean-source refusal after successful bootstrap

Run https://github.com/dilapidated-shed/idric-cli/actions/runs/39351728358 at head 2d9918f668efbcd384411aae2b9aef8fe020f589 built the actual pinned compiler and packages, then the maintained source-pin gate refused the Idriç working tree. The root edric wrapper creates top-level .tools, bootstrap-build, build and idris2 symlinks that this pinned source does not ignore. No installed-command or provider acceptance followed that refusal. Artifact 12233919831 retains the exact PIN_OK predecessors and failing stderr.

The consumer now invokes the same maintained _/edric all entrypoint directly and uses its _/build executable, _/bootstrap-build prefix and _/.tools Scheme. This keeps generated state within the source's existing ignored hidden directories. The full pinned compiler bootstrap, smoke tests, qualified ICK and independent clean-source enforcement remain required; no output is removed to conceal a source change and no clean-tree gate is disabled. A source diff and status are printed before acceptance. The next exact-head run must establish whether this resolves the refusal.

## Generated compiler-test source refused by the independent gate

Run39356116445 at e09f199c23444de0a07f5fa50680989ffc095aa8 successfully rebuilt
the owned compiler and full smoke suite, then source-pin enforcement refused
untracked _/tests/idris2/basic/edric007/Tests.idr and UnitsTimeIntervals.idr.
The actual script copies canonical units examples into its source directory.
Those outputs were not deleted and no ignore/clean-source rule was weakened.
Artifact12236465328, ZIP2614589b985a0f61d7914b9b28f9c00e912e75d3ebc46f812ecabb626a627810,
retains this second real refusal.

The upstream repair is isomorphisms/Idric PR140, “Keep compiler smoke fixture
sources in their build directory”, https://github.com/isomorphisms/Idric/pull/140.
Its exact candidate source a5398b6cf385a78bd203bc0499da0c5da6fb3714 moves identical
compatibility copies under the existing build directory, preserving all tests
and the original executable mode. The consumer now pins that same source for
both compiler and JSON package and retains hidden-root bootstrap/prefix paths.
This is a candidate dependency under qualification, not an accepted-main claim.
PR140 must pass and land on canonical Idriç before this consumer can merge;
its own installed/independent/provider stages must separately execute and pass.
