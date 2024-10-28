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

@test "greeting-passthrough-ts-c8node-default-help" {
  run npx -s c8 --reporter=none --clean=false node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning  ./src/bin/knevee.ts test/fixtures/greeting-passthrough.ts "--help"
  save_and_compare_snapshot "greeting-passthrough-ts" c8node-default-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-passthrough-ts-c8node-default-missing-args" {
  run npx -s c8 --reporter=none --clean=false node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning  ./src/bin/knevee.ts test/fixtures/greeting-passthrough.ts
  save_and_compare_snapshot "greeting-passthrough-ts" c8node-default-missing-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-passthrough-ts-c8node-default-valid-args" {
  run npx -s c8 --reporter=none --clean=false node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning  ./src/bin/knevee.ts test/fixtures/greeting-passthrough.ts "John"
  save_and_compare_snapshot "greeting-passthrough-ts" c8node-default-valid-args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-passthrough-ts-c8node-default-extra-args" {
  run npx -s c8 --reporter=none --clean=false node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning  ./src/bin/knevee.ts test/fixtures/greeting-passthrough.ts "John" "extra"
  save_and_compare_snapshot "greeting-passthrough-ts" c8node-default-extra-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-passthrough-ts-c8node-deno-help" {
  run npx -s c8 --reporter=none --clean=false node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning  ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-passthrough.ts "--help"
  save_and_compare_snapshot "greeting-passthrough-ts" c8node-deno-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-passthrough-ts-c8node-deno-missing-args" {
  run npx -s c8 --reporter=none --clean=false node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning  ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-passthrough.ts
  save_and_compare_snapshot "greeting-passthrough-ts" c8node-deno-missing-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-passthrough-ts-c8node-deno-valid-args" {
  run npx -s c8 --reporter=none --clean=false node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning  ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-passthrough.ts "John"
  save_and_compare_snapshot "greeting-passthrough-ts" c8node-deno-valid-args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-passthrough-ts-c8node-deno-extra-args" {
  run npx -s c8 --reporter=none --clean=false node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning  ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-passthrough.ts "John" "extra"
  save_and_compare_snapshot "greeting-passthrough-ts" c8node-deno-extra-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-passthrough-ts-c8node-tsx-help" {
  run npx -s c8 --reporter=none --clean=false node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning  ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-passthrough.ts "--help"
  save_and_compare_snapshot "greeting-passthrough-ts" c8node-tsx-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-passthrough-ts-c8node-tsx-missing-args" {
  run npx -s c8 --reporter=none --clean=false node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning  ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-passthrough.ts
  save_and_compare_snapshot "greeting-passthrough-ts" c8node-tsx-missing-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-passthrough-ts-c8node-tsx-valid-args" {
  run npx -s c8 --reporter=none --clean=false node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning  ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-passthrough.ts "John"
  save_and_compare_snapshot "greeting-passthrough-ts" c8node-tsx-valid-args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-passthrough-ts-c8node-tsx-extra-args" {
  run npx -s c8 --reporter=none --clean=false node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning  ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-passthrough.ts "John" "extra"
  save_and_compare_snapshot "greeting-passthrough-ts" c8node-tsx-extra-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-passthrough-ts-c8node-node-ts-help" {
  run npx -s c8 --reporter=none --clean=false node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning  ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/greeting-passthrough.ts "--help"
  save_and_compare_snapshot "greeting-passthrough-ts" c8node-node-ts-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-passthrough-ts-c8node-node-ts-missing-args" {
  run npx -s c8 --reporter=none --clean=false node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning  ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/greeting-passthrough.ts
  save_and_compare_snapshot "greeting-passthrough-ts" c8node-node-ts-missing-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-passthrough-ts-c8node-node-ts-valid-args" {
  run npx -s c8 --reporter=none --clean=false node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning  ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/greeting-passthrough.ts "John"
  save_and_compare_snapshot "greeting-passthrough-ts" c8node-node-ts-valid-args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-passthrough-ts-c8node-node-ts-extra-args" {
  run npx -s c8 --reporter=none --clean=false node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning  ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/greeting-passthrough.ts "John" "extra"
  save_and_compare_snapshot "greeting-passthrough-ts" c8node-node-ts-extra-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-passthrough-ts-deno-default-help" {
  run deno run -A ./src/bin/knevee.ts test/fixtures/greeting-passthrough.ts "--help"
  save_and_compare_snapshot "greeting-passthrough-ts" deno-default-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-passthrough-ts-deno-default-missing-args" {
  run deno run -A ./src/bin/knevee.ts test/fixtures/greeting-passthrough.ts
  save_and_compare_snapshot "greeting-passthrough-ts" deno-default-missing-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-passthrough-ts-deno-default-valid-args" {
  run deno run -A ./src/bin/knevee.ts test/fixtures/greeting-passthrough.ts "John"
  save_and_compare_snapshot "greeting-passthrough-ts" deno-default-valid-args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-passthrough-ts-deno-default-extra-args" {
  run deno run -A ./src/bin/knevee.ts test/fixtures/greeting-passthrough.ts "John" "extra"
  save_and_compare_snapshot "greeting-passthrough-ts" deno-default-extra-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-passthrough-ts-deno-deno-help" {
  run deno run -A ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-passthrough.ts "--help"
  save_and_compare_snapshot "greeting-passthrough-ts" deno-deno-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-passthrough-ts-deno-deno-missing-args" {
  run deno run -A ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-passthrough.ts
  save_and_compare_snapshot "greeting-passthrough-ts" deno-deno-missing-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-passthrough-ts-deno-deno-valid-args" {
  run deno run -A ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-passthrough.ts "John"
  save_and_compare_snapshot "greeting-passthrough-ts" deno-deno-valid-args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-passthrough-ts-deno-deno-extra-args" {
  run deno run -A ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-passthrough.ts "John" "extra"
  save_and_compare_snapshot "greeting-passthrough-ts" deno-deno-extra-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-passthrough-ts-deno-tsx-help" {
  run deno run -A ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-passthrough.ts "--help"
  save_and_compare_snapshot "greeting-passthrough-ts" deno-tsx-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-passthrough-ts-deno-tsx-missing-args" {
  run deno run -A ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-passthrough.ts
  save_and_compare_snapshot "greeting-passthrough-ts" deno-tsx-missing-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-passthrough-ts-deno-tsx-valid-args" {
  run deno run -A ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-passthrough.ts "John"
  save_and_compare_snapshot "greeting-passthrough-ts" deno-tsx-valid-args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-passthrough-ts-deno-tsx-extra-args" {
  run deno run -A ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-passthrough.ts "John" "extra"
  save_and_compare_snapshot "greeting-passthrough-ts" deno-tsx-extra-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-passthrough-ts-deno-node-ts-help" {
  run deno run -A ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/greeting-passthrough.ts "--help"
  save_and_compare_snapshot "greeting-passthrough-ts" deno-node-ts-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-passthrough-ts-deno-node-ts-missing-args" {
  run deno run -A ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/greeting-passthrough.ts
  save_and_compare_snapshot "greeting-passthrough-ts" deno-node-ts-missing-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-passthrough-ts-deno-node-ts-valid-args" {
  run deno run -A ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/greeting-passthrough.ts "John"
  save_and_compare_snapshot "greeting-passthrough-ts" deno-node-ts-valid-args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-passthrough-ts-deno-node-ts-extra-args" {
  run deno run -A ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/greeting-passthrough.ts "John" "extra"
  save_and_compare_snapshot "greeting-passthrough-ts" deno-node-ts-extra-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-passthrough-ts-node-ts-default-help" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts test/fixtures/greeting-passthrough.ts "--help"
  save_and_compare_snapshot "greeting-passthrough-ts" node-ts-default-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-passthrough-ts-node-ts-default-missing-args" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts test/fixtures/greeting-passthrough.ts
  save_and_compare_snapshot "greeting-passthrough-ts" node-ts-default-missing-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-passthrough-ts-node-ts-default-valid-args" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts test/fixtures/greeting-passthrough.ts "John"
  save_and_compare_snapshot "greeting-passthrough-ts" node-ts-default-valid-args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-passthrough-ts-node-ts-default-extra-args" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts test/fixtures/greeting-passthrough.ts "John" "extra"
  save_and_compare_snapshot "greeting-passthrough-ts" node-ts-default-extra-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-passthrough-ts-node-ts-deno-help" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-passthrough.ts "--help"
  save_and_compare_snapshot "greeting-passthrough-ts" node-ts-deno-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-passthrough-ts-node-ts-deno-missing-args" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-passthrough.ts
  save_and_compare_snapshot "greeting-passthrough-ts" node-ts-deno-missing-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-passthrough-ts-node-ts-deno-valid-args" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-passthrough.ts "John"
  save_and_compare_snapshot "greeting-passthrough-ts" node-ts-deno-valid-args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-passthrough-ts-node-ts-deno-extra-args" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-passthrough.ts "John" "extra"
  save_and_compare_snapshot "greeting-passthrough-ts" node-ts-deno-extra-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-passthrough-ts-node-ts-tsx-help" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-passthrough.ts "--help"
  save_and_compare_snapshot "greeting-passthrough-ts" node-ts-tsx-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-passthrough-ts-node-ts-tsx-missing-args" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-passthrough.ts
  save_and_compare_snapshot "greeting-passthrough-ts" node-ts-tsx-missing-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-passthrough-ts-node-ts-tsx-valid-args" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-passthrough.ts "John"
  save_and_compare_snapshot "greeting-passthrough-ts" node-ts-tsx-valid-args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-passthrough-ts-node-ts-tsx-extra-args" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-passthrough.ts "John" "extra"
  save_and_compare_snapshot "greeting-passthrough-ts" node-ts-tsx-extra-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-passthrough-ts-node-ts-node-ts-help" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/greeting-passthrough.ts "--help"
  save_and_compare_snapshot "greeting-passthrough-ts" node-ts-node-ts-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-passthrough-ts-node-ts-node-ts-missing-args" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/greeting-passthrough.ts
  save_and_compare_snapshot "greeting-passthrough-ts" node-ts-node-ts-missing-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-passthrough-ts-node-ts-node-ts-valid-args" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/greeting-passthrough.ts "John"
  save_and_compare_snapshot "greeting-passthrough-ts" node-ts-node-ts-valid-args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-passthrough-ts-node-ts-node-ts-extra-args" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/greeting-passthrough.ts "John" "extra"
  save_and_compare_snapshot "greeting-passthrough-ts" node-ts-node-ts-extra-args "$output"
  [ "$status" -eq 1 ]
}