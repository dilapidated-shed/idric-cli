# Published dependencies and acceptance owners

- [dilapidated-shed/icu PR #32, “Expose captured HTTP responses to Idriç API clients”](https://github.com/dilapidated-shed/icu/pull/32)
- [isomorphisms/Idric PR #135, “Correct JSON Unicode escapes and surrogate decoding”](https://github.com/isomorphisms/Idric/pull/135)
- [isomorphisms/ai-ci PR #259, “Add independent Indeed proof requirement oracle”](https://github.com/isomorphisms/ai-ci/pull/259)
- [isomorphisms/kitchen PR #48, “Preflight and verify an installed Indeed CLI”](https://github.com/isomorphisms/kitchen/pull/48)
- [isomorphisms/flexible-pipes PR #107, “Bind Indeed CLI acceptance to Kitchen and ai-ci”](https://github.com/isomorphisms/flexible-pipes/pull/107)

The client pins the published ICU response and JSON-library commits. The core
compiler is the original qualified compiler revision; the contrib repair does
not require pretending it was bootstrapped into a different compiler. Kitchen
and ai-ci are separate acceptance owners. Flexible Pipes captures the assignment
and executed run. These changes are published for review, not merged.
