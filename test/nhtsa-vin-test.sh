#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
program=${NHTSA_PROGRAM:-"$PWD/build/exec/nhtsa-vin"}
vin=1HGCM82633A004352
test -x "$program" || { printf 'NOT_RUN: compiled nhtsa-vin executable missing\n' >&2; exit 1; }
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

"$program" --version > "$tmp/version"
grep -Fx 'nhtsa-vin 0.1.0' "$tmp/version"
"$program" url "$vin" > "$tmp/url"
grep -Fx "https://vpic.nhtsa.dot.gov/api/vehicles/DecodeVinValues/$vin?format=json" "$tmp/url"
"$program" url "$vin" --modelyear 2003 > "$tmp/url-year"
grep -Fx "https://vpic.nhtsa.dot.gov/api/vehicles/DecodeVinValues/$vin?format=json&modelyear=2003" "$tmp/url-year"
"$program" fixture "$vin" checkpoints/nhtsa/fixtures/honda-synthetic.json --tsv > "$tmp/vehicle"
grep -Fx "$(printf 'Trim\tpresent\t')" "$tmp/vehicle"
grep -Fx "$(printf 'Series\tmissing\t')" "$tmp/vehicle"
grep -Fx "$(printf 'Make\tpresent\tHONDA')" "$tmp/vehicle"
grep -Fx "$(printf 'Evidence\tpresent\tsupplied-fixture; not live provider evidence')" "$tmp/vehicle"
"$program" fixture "$vin" checkpoints/nhtsa/fixtures/honda-synthetic.json > "$tmp/plain"
grep -Fx 'Make: HONDA' "$tmp/plain"

expect_status() {
  local expected="$1"; shift
  local got=0
  "$program" "$@" > "$tmp/rejected.out" 2> "$tmp/rejected.err" || got=$?
  test "$got" -eq "$expected" || { printf 'FAIL: expected exit %s got %s\n' "$expected" "$got" >&2; exit 1; }
  test ! -s "$tmp/rejected.out" || { printf 'FAIL: rejected input produced data\n' >&2; exit 1; }
}
expect_status 2 url '1HGCM82633A00435I'
expect_status 2 url '1HGCM82633A004352/../../'
expect_status 2 url "$vin" --modelyear 200X
expect_status 6 fixture "$vin" checkpoints/nhtsa/fixtures/malformed.json
expect_status 6 fixture "$vin" checkpoints/nhtsa/fixtures/mismatched.json
expect_status 7 fixture "$vin" checkpoints/nhtsa/fixtures/not-present.json
printf '%s\n' 'PASS: NHTSA vPIC Idriç CLI offline/installed-command fixtures'
