#!/usr/bin/env bats

setup() {
    snapshot_dir="./snapshots"
    mkdir -p "$snapshot_dir"
}

save_and_compare_snapshot() {
    mkdir -p "$snapshot_dir/$1"
    snapshot="$snapshot_dir/$1/$2.txt"
    if [ ! -f "$snapshot" ]; then
        echo "$3" > "$snapshot"
    fi
    diff -u "$snapshot" <(echo "$3")
}

@test "starts-with-a-ts-c8node-default-true" {
  run npx -s c8 --reporter=none --clean=false node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning  ./src/bin/knevee.ts test/fixtures/starts-with-a.ts "alpha"
  save_and_compare_snapshot "starts-with-a-ts" c8node-default-true "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-c8node-default-false" {
  run npx -s c8 --reporter=none --clean=false node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning  ./src/bin/knevee.ts test/fixtures/starts-with-a.ts "beta"
  save_and_compare_snapshot "starts-with-a-ts" c8node-default-false "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-c8node-default-true-emoji" {
  run npx -s c8 --reporter=none --clean=false node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning  ./src/bin/knevee.ts test/fixtures/starts-with-a.ts "alpha" "--emoji"
  save_and_compare_snapshot "starts-with-a-ts" c8node-default-true-emoji "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-c8node-default-false-emoji" {
  run npx -s c8 --reporter=none --clean=false node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning  ./src/bin/knevee.ts test/fixtures/starts-with-a.ts "beta" "--emoji"
  save_and_compare_snapshot "starts-with-a-ts" c8node-default-false-emoji "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-c8node-default-true-int" {
  run npx -s c8 --reporter=none --clean=false node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning  ./src/bin/knevee.ts test/fixtures/starts-with-a.ts "alpha" "--int"
  save_and_compare_snapshot "starts-with-a-ts" c8node-default-true-int "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-c8node-default-false-int" {
  run npx -s c8 --reporter=none --clean=false node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning  ./src/bin/knevee.ts test/fixtures/starts-with-a.ts "beta" "--int"
  save_and_compare_snapshot "starts-with-a-ts" c8node-default-false-int "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-c8node-deno-true" {
  run npx -s c8 --reporter=none --clean=false node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning  ./src/bin/knevee.ts deno eval -- test/fixtures/starts-with-a.ts "alpha"
  save_and_compare_snapshot "starts-with-a-ts" c8node-deno-true "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-c8node-deno-false" {
  run npx -s c8 --reporter=none --clean=false node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning  ./src/bin/knevee.ts deno eval -- test/fixtures/starts-with-a.ts "beta"
  save_and_compare_snapshot "starts-with-a-ts" c8node-deno-false "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-c8node-deno-true-emoji" {
  run npx -s c8 --reporter=none --clean=false node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning  ./src/bin/knevee.ts deno eval -- test/fixtures/starts-with-a.ts "alpha" "--emoji"
  save_and_compare_snapshot "starts-with-a-ts" c8node-deno-true-emoji "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-c8node-deno-false-emoji" {
  run npx -s c8 --reporter=none --clean=false node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning  ./src/bin/knevee.ts deno eval -- test/fixtures/starts-with-a.ts "beta" "--emoji"
  save_and_compare_snapshot "starts-with-a-ts" c8node-deno-false-emoji "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-c8node-deno-true-int" {
  run npx -s c8 --reporter=none --clean=false node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning  ./src/bin/knevee.ts deno eval -- test/fixtures/starts-with-a.ts "alpha" "--int"
  save_and_compare_snapshot "starts-with-a-ts" c8node-deno-true-int "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-c8node-deno-false-int" {
  run npx -s c8 --reporter=none --clean=false node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning  ./src/bin/knevee.ts deno eval -- test/fixtures/starts-with-a.ts "beta" "--int"
  save_and_compare_snapshot "starts-with-a-ts" c8node-deno-false-int "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-c8node-tsx-true" {
  run npx -s c8 --reporter=none --clean=false node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning  ./src/bin/knevee.ts tsx -e -- test/fixtures/starts-with-a.ts "alpha"
  save_and_compare_snapshot "starts-with-a-ts" c8node-tsx-true "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-c8node-tsx-false" {
  run npx -s c8 --reporter=none --clean=false node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning  ./src/bin/knevee.ts tsx -e -- test/fixtures/starts-with-a.ts "beta"
  save_and_compare_snapshot "starts-with-a-ts" c8node-tsx-false "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-c8node-tsx-true-emoji" {
  run npx -s c8 --reporter=none --clean=false node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning  ./src/bin/knevee.ts tsx -e -- test/fixtures/starts-with-a.ts "alpha" "--emoji"
  save_and_compare_snapshot "starts-with-a-ts" c8node-tsx-true-emoji "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-c8node-tsx-false-emoji" {
  run npx -s c8 --reporter=none --clean=false node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning  ./src/bin/knevee.ts tsx -e -- test/fixtures/starts-with-a.ts "beta" "--emoji"
  save_and_compare_snapshot "starts-with-a-ts" c8node-tsx-false-emoji "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-c8node-tsx-true-int" {
  run npx -s c8 --reporter=none --clean=false node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning  ./src/bin/knevee.ts tsx -e -- test/fixtures/starts-with-a.ts "alpha" "--int"
  save_and_compare_snapshot "starts-with-a-ts" c8node-tsx-true-int "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-c8node-tsx-false-int" {
  run npx -s c8 --reporter=none --clean=false node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning  ./src/bin/knevee.ts tsx -e -- test/fixtures/starts-with-a.ts "beta" "--int"
  save_and_compare_snapshot "starts-with-a-ts" c8node-tsx-false-int "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-c8node-node-ts-true" {
  run npx -s c8 --reporter=none --clean=false node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning  ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/starts-with-a.ts "alpha"
  save_and_compare_snapshot "starts-with-a-ts" c8node-node-ts-true "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-c8node-node-ts-false" {
  run npx -s c8 --reporter=none --clean=false node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning  ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/starts-with-a.ts "beta"
  save_and_compare_snapshot "starts-with-a-ts" c8node-node-ts-false "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-c8node-node-ts-true-emoji" {
  run npx -s c8 --reporter=none --clean=false node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning  ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/starts-with-a.ts "alpha" "--emoji"
  save_and_compare_snapshot "starts-with-a-ts" c8node-node-ts-true-emoji "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-c8node-node-ts-false-emoji" {
  run npx -s c8 --reporter=none --clean=false node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning  ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/starts-with-a.ts "beta" "--emoji"
  save_and_compare_snapshot "starts-with-a-ts" c8node-node-ts-false-emoji "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-c8node-node-ts-true-int" {
  run npx -s c8 --reporter=none --clean=false node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning  ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/starts-with-a.ts "alpha" "--int"
  save_and_compare_snapshot "starts-with-a-ts" c8node-node-ts-true-int "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-c8node-node-ts-false-int" {
  run npx -s c8 --reporter=none --clean=false node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning  ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/starts-with-a.ts "beta" "--int"
  save_and_compare_snapshot "starts-with-a-ts" c8node-node-ts-false-int "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-deno-default-true" {
  run deno run -A ./src/bin/knevee.ts test/fixtures/starts-with-a.ts "alpha"
  save_and_compare_snapshot "starts-with-a-ts" deno-default-true "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-deno-default-false" {
  run deno run -A ./src/bin/knevee.ts test/fixtures/starts-with-a.ts "beta"
  save_and_compare_snapshot "starts-with-a-ts" deno-default-false "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-deno-default-true-emoji" {
  run deno run -A ./src/bin/knevee.ts test/fixtures/starts-with-a.ts "alpha" "--emoji"
  save_and_compare_snapshot "starts-with-a-ts" deno-default-true-emoji "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-deno-default-false-emoji" {
  run deno run -A ./src/bin/knevee.ts test/fixtures/starts-with-a.ts "beta" "--emoji"
  save_and_compare_snapshot "starts-with-a-ts" deno-default-false-emoji "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-deno-default-true-int" {
  run deno run -A ./src/bin/knevee.ts test/fixtures/starts-with-a.ts "alpha" "--int"
  save_and_compare_snapshot "starts-with-a-ts" deno-default-true-int "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-deno-default-false-int" {
  run deno run -A ./src/bin/knevee.ts test/fixtures/starts-with-a.ts "beta" "--int"
  save_and_compare_snapshot "starts-with-a-ts" deno-default-false-int "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-deno-deno-true" {
  run deno run -A ./src/bin/knevee.ts deno eval -- test/fixtures/starts-with-a.ts "alpha"
  save_and_compare_snapshot "starts-with-a-ts" deno-deno-true "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-deno-deno-false" {
  run deno run -A ./src/bin/knevee.ts deno eval -- test/fixtures/starts-with-a.ts "beta"
  save_and_compare_snapshot "starts-with-a-ts" deno-deno-false "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-deno-deno-true-emoji" {
  run deno run -A ./src/bin/knevee.ts deno eval -- test/fixtures/starts-with-a.ts "alpha" "--emoji"
  save_and_compare_snapshot "starts-with-a-ts" deno-deno-true-emoji "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-deno-deno-false-emoji" {
  run deno run -A ./src/bin/knevee.ts deno eval -- test/fixtures/starts-with-a.ts "beta" "--emoji"
  save_and_compare_snapshot "starts-with-a-ts" deno-deno-false-emoji "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-deno-deno-true-int" {
  run deno run -A ./src/bin/knevee.ts deno eval -- test/fixtures/starts-with-a.ts "alpha" "--int"
  save_and_compare_snapshot "starts-with-a-ts" deno-deno-true-int "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-deno-deno-false-int" {
  run deno run -A ./src/bin/knevee.ts deno eval -- test/fixtures/starts-with-a.ts "beta" "--int"
  save_and_compare_snapshot "starts-with-a-ts" deno-deno-false-int "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-deno-tsx-true" {
  run deno run -A ./src/bin/knevee.ts tsx -e -- test/fixtures/starts-with-a.ts "alpha"
  save_and_compare_snapshot "starts-with-a-ts" deno-tsx-true "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-deno-tsx-false" {
  run deno run -A ./src/bin/knevee.ts tsx -e -- test/fixtures/starts-with-a.ts "beta"
  save_and_compare_snapshot "starts-with-a-ts" deno-tsx-false "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-deno-tsx-true-emoji" {
  run deno run -A ./src/bin/knevee.ts tsx -e -- test/fixtures/starts-with-a.ts "alpha" "--emoji"
  save_and_compare_snapshot "starts-with-a-ts" deno-tsx-true-emoji "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-deno-tsx-false-emoji" {
  run deno run -A ./src/bin/knevee.ts tsx -e -- test/fixtures/starts-with-a.ts "beta" "--emoji"
  save_and_compare_snapshot "starts-with-a-ts" deno-tsx-false-emoji "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-deno-tsx-true-int" {
  run deno run -A ./src/bin/knevee.ts tsx -e -- test/fixtures/starts-with-a.ts "alpha" "--int"
  save_and_compare_snapshot "starts-with-a-ts" deno-tsx-true-int "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-deno-tsx-false-int" {
  run deno run -A ./src/bin/knevee.ts tsx -e -- test/fixtures/starts-with-a.ts "beta" "--int"
  save_and_compare_snapshot "starts-with-a-ts" deno-tsx-false-int "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-deno-node-ts-true" {
  run deno run -A ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/starts-with-a.ts "alpha"
  save_and_compare_snapshot "starts-with-a-ts" deno-node-ts-true "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-deno-node-ts-false" {
  run deno run -A ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/starts-with-a.ts "beta"
  save_and_compare_snapshot "starts-with-a-ts" deno-node-ts-false "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-deno-node-ts-true-emoji" {
  run deno run -A ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/starts-with-a.ts "alpha" "--emoji"
  save_and_compare_snapshot "starts-with-a-ts" deno-node-ts-true-emoji "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-deno-node-ts-false-emoji" {
  run deno run -A ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/starts-with-a.ts "beta" "--emoji"
  save_and_compare_snapshot "starts-with-a-ts" deno-node-ts-false-emoji "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-deno-node-ts-true-int" {
  run deno run -A ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/starts-with-a.ts "alpha" "--int"
  save_and_compare_snapshot "starts-with-a-ts" deno-node-ts-true-int "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-deno-node-ts-false-int" {
  run deno run -A ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/starts-with-a.ts "beta" "--int"
  save_and_compare_snapshot "starts-with-a-ts" deno-node-ts-false-int "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-node-ts-default-true" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts test/fixtures/starts-with-a.ts "alpha"
  save_and_compare_snapshot "starts-with-a-ts" node-ts-default-true "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-node-ts-default-false" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts test/fixtures/starts-with-a.ts "beta"
  save_and_compare_snapshot "starts-with-a-ts" node-ts-default-false "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-node-ts-default-true-emoji" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts test/fixtures/starts-with-a.ts "alpha" "--emoji"
  save_and_compare_snapshot "starts-with-a-ts" node-ts-default-true-emoji "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-node-ts-default-false-emoji" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts test/fixtures/starts-with-a.ts "beta" "--emoji"
  save_and_compare_snapshot "starts-with-a-ts" node-ts-default-false-emoji "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-node-ts-default-true-int" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts test/fixtures/starts-with-a.ts "alpha" "--int"
  save_and_compare_snapshot "starts-with-a-ts" node-ts-default-true-int "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-node-ts-default-false-int" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts test/fixtures/starts-with-a.ts "beta" "--int"
  save_and_compare_snapshot "starts-with-a-ts" node-ts-default-false-int "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-node-ts-deno-true" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts deno eval -- test/fixtures/starts-with-a.ts "alpha"
  save_and_compare_snapshot "starts-with-a-ts" node-ts-deno-true "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-node-ts-deno-false" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts deno eval -- test/fixtures/starts-with-a.ts "beta"
  save_and_compare_snapshot "starts-with-a-ts" node-ts-deno-false "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-node-ts-deno-true-emoji" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts deno eval -- test/fixtures/starts-with-a.ts "alpha" "--emoji"
  save_and_compare_snapshot "starts-with-a-ts" node-ts-deno-true-emoji "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-node-ts-deno-false-emoji" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts deno eval -- test/fixtures/starts-with-a.ts "beta" "--emoji"
  save_and_compare_snapshot "starts-with-a-ts" node-ts-deno-false-emoji "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-node-ts-deno-true-int" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts deno eval -- test/fixtures/starts-with-a.ts "alpha" "--int"
  save_and_compare_snapshot "starts-with-a-ts" node-ts-deno-true-int "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-node-ts-deno-false-int" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts deno eval -- test/fixtures/starts-with-a.ts "beta" "--int"
  save_and_compare_snapshot "starts-with-a-ts" node-ts-deno-false-int "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-node-ts-tsx-true" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts tsx -e -- test/fixtures/starts-with-a.ts "alpha"
  save_and_compare_snapshot "starts-with-a-ts" node-ts-tsx-true "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-node-ts-tsx-false" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts tsx -e -- test/fixtures/starts-with-a.ts "beta"
  save_and_compare_snapshot "starts-with-a-ts" node-ts-tsx-false "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-node-ts-tsx-true-emoji" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts tsx -e -- test/fixtures/starts-with-a.ts "alpha" "--emoji"
  save_and_compare_snapshot "starts-with-a-ts" node-ts-tsx-true-emoji "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-node-ts-tsx-false-emoji" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts tsx -e -- test/fixtures/starts-with-a.ts "beta" "--emoji"
  save_and_compare_snapshot "starts-with-a-ts" node-ts-tsx-false-emoji "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-node-ts-tsx-true-int" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts tsx -e -- test/fixtures/starts-with-a.ts "alpha" "--int"
  save_and_compare_snapshot "starts-with-a-ts" node-ts-tsx-true-int "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-node-ts-tsx-false-int" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts tsx -e -- test/fixtures/starts-with-a.ts "beta" "--int"
  save_and_compare_snapshot "starts-with-a-ts" node-ts-tsx-false-int "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-node-ts-node-ts-true" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/starts-with-a.ts "alpha"
  save_and_compare_snapshot "starts-with-a-ts" node-ts-node-ts-true "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-node-ts-node-ts-false" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/starts-with-a.ts "beta"
  save_and_compare_snapshot "starts-with-a-ts" node-ts-node-ts-false "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-node-ts-node-ts-true-emoji" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/starts-with-a.ts "alpha" "--emoji"
  save_and_compare_snapshot "starts-with-a-ts" node-ts-node-ts-true-emoji "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-node-ts-node-ts-false-emoji" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/starts-with-a.ts "beta" "--emoji"
  save_and_compare_snapshot "starts-with-a-ts" node-ts-node-ts-false-emoji "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-node-ts-node-ts-true-int" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/starts-with-a.ts "alpha" "--int"
  save_and_compare_snapshot "starts-with-a-ts" node-ts-node-ts-true-int "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-node-ts-node-ts-false-int" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/starts-with-a.ts "beta" "--int"
  save_and_compare_snapshot "starts-with-a-ts" node-ts-node-ts-false-int "$output"
  [ "$status" -eq 0 ]
}