# NHTSA vPIC VIN CLI

`nhtsa-vin` is an Idriç client using the **ICU response-capture API** and
Idric-Net typed HTTP requests. No shell `curl`, Python, JavaScript or C++
substitute is used. ICU's existing socket/OpenSSL adapter is the current
native boundary; maintained native compilation uses ICK.

## Commands

```sh
nhtsa-vin decode 1HGCM82633A004352
nhtsa-vin decode 1HGCM82633A004352 --modelyear 2003 --tsv
nhtsa-vin url 1HGCM82633A004352
nhtsa-vin fixture 1HGCM82633A004352 checkpoints/nhtsa/fixtures/honda-synthetic.json --tsv
```

Input validation requires exactly 17 ASCII VIN characters, excluding I/O/Q.
Lowercase is normalized to uppercase. The local validator does **not** assert
a correct ninth-character check digit: NHTSA returns its own ErrorCode/ErrorText
and can report invalid or incomplete vehicle information. This command does
not cover vPIC's separate partial/masked-VIN API feature.

`--modelyear YYYY` passes an optional model-year hint for provider decoding.
The returned year is the provider field, not automatically the hint. vPIC
manufacturer records may leave trim/series/other fields blank; do not invent
a trim, body style or drivetrain. The caller receives ErrorCode and ErrorText.

Output is human-readable plaintext by default. `--tsv` produces lines of
`field<TAB>present|missing<TAB>value`. `present` with an empty value differs
from `missing`; tabs, newlines and backslashes within values are escaped.
The provider, provenance and exact request URL accompany each result. A
supplied fixture is labeled distinctly from a successful live provider fetch.

## Ownership and building

- Source: `checkpoints/nhtsa/idric/Nhtsa.idric`.
- Idriç: VIN type, validation, URL construction, JSON decoder, optional values,
  provider error handling, and plaintext/TSV projection.
- Idric-Net + ICU: typed GET request, TLS, status and bounded UTF-8 response
  capture; current implementation has a native socket/OpenSSL adapter.
- ICK: the maintained native compilation stage for ICU's transport library.
- Kitchen: preflight and provenance for the actual source-pinned build/install.
- Flexible Pipes: job admission and source/output receipts.
- ai-ci: independent fixture/schema, error-path, and installed-command checks.

Install compatible `contrib` JSON, `idric_net`, and `icu_response`
packages with the **same Idriç compiler and IDRIS2_PREFIX** first. The
`icu_response` package is in the ICU checkout (`icu-response.ipkg`).
Then build and test from this repository:

```sh
make nhtsa-vin IDRIC=/absolute/path/to/idris2 ICK=/absolute/path/to/ick ICU_ROOT=/absolute/path/to/icu
make nhtsa-vin-test
make install-nhtsa-vin PREFIX=/absolute/prefix
```

`nhtsa-vin-test` refuses missing executables. Successful fixture parsing
does not establish a successful provider request. NHTSA publishes an automated
rate-control mechanism; consumers must bound frequency and preserve HTTP
failure and throttling outcomes.

Current evidence: source and synthetic fixture committed; host build, installed
execution, live response, A1 ARM32, and C67 ARM64 have not been executed here.
Cat Food must keep its Android `idric-cli` delivery gap until immutable
packages are built, published and accepted for each target.

## References

- https://vpic.nhtsa.dot.gov/api/Home/Index
- https://vpic.nhtsa.dot.gov/api/vehicles/DecodeVinValues/1HGCM82633A004352?format=json
