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

@test "greeting-export-ts-c8-default-help" {
  run npx -s c8 --reporter=none --clean=false tsx ./src/bin/knevee.ts test/fixtures/greeting-export.ts --help
  save_and_compare_snapshot "greeting-export-ts" c8-default-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-ts-c8-default-missing-args" {
  run npx -s c8 --reporter=none --clean=false tsx ./src/bin/knevee.ts test/fixtures/greeting-export.ts
  save_and_compare_snapshot "greeting-export-ts" c8-default-missing-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-ts-c8-default-valid-args" {
  run npx -s c8 --reporter=none --clean=false tsx ./src/bin/knevee.ts test/fixtures/greeting-export.ts John
  save_and_compare_snapshot "greeting-export-ts" c8-default-valid-args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-ts-c8-deno-help" {
  run npx -s c8 --reporter=none --clean=false tsx ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-export.ts --help
  save_and_compare_snapshot "greeting-export-ts" c8-deno-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-ts-c8-deno-missing-args" {
  run npx -s c8 --reporter=none --clean=false tsx ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-export.ts
  save_and_compare_snapshot "greeting-export-ts" c8-deno-missing-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-ts-c8-deno-valid-args" {
  run npx -s c8 --reporter=none --clean=false tsx ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-export.ts John
  save_and_compare_snapshot "greeting-export-ts" c8-deno-valid-args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-ts-c8-tsx-help" {
  run npx -s c8 --reporter=none --clean=false tsx ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-export.ts --help
  save_and_compare_snapshot "greeting-export-ts" c8-tsx-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-ts-c8-tsx-missing-args" {
  run npx -s c8 --reporter=none --clean=false tsx ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-export.ts
  save_and_compare_snapshot "greeting-export-ts" c8-tsx-missing-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-ts-c8-tsx-valid-args" {
  run npx -s c8 --reporter=none --clean=false tsx ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-export.ts John
  save_and_compare_snapshot "greeting-export-ts" c8-tsx-valid-args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-ts-c8-node-ts-help" {
  run npx -s c8 --reporter=none --clean=false tsx ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/greeting-export.ts --help
  save_and_compare_snapshot "greeting-export-ts" c8-node-ts-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-ts-c8-node-ts-missing-args" {
  run npx -s c8 --reporter=none --clean=false tsx ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/greeting-export.ts
  save_and_compare_snapshot "greeting-export-ts" c8-node-ts-missing-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-ts-c8-node-ts-valid-args" {
  run npx -s c8 --reporter=none --clean=false tsx ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/greeting-export.ts John
  save_and_compare_snapshot "greeting-export-ts" c8-node-ts-valid-args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-ts-deno-default-help" {
  run deno run -A ./src/bin/knevee.ts test/fixtures/greeting-export.ts --help
  save_and_compare_snapshot "greeting-export-ts" deno-default-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-ts-deno-default-missing-args" {
  run deno run -A ./src/bin/knevee.ts test/fixtures/greeting-export.ts
  save_and_compare_snapshot "greeting-export-ts" deno-default-missing-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-ts-deno-default-valid-args" {
  run deno run -A ./src/bin/knevee.ts test/fixtures/greeting-export.ts John
  save_and_compare_snapshot "greeting-export-ts" deno-default-valid-args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-ts-deno-deno-help" {
  run deno run -A ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-export.ts --help
  save_and_compare_snapshot "greeting-export-ts" deno-deno-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-ts-deno-deno-missing-args" {
  run deno run -A ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-export.ts
  save_and_compare_snapshot "greeting-export-ts" deno-deno-missing-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-ts-deno-deno-valid-args" {
  run deno run -A ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-export.ts John
  save_and_compare_snapshot "greeting-export-ts" deno-deno-valid-args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-ts-deno-tsx-help" {
  run deno run -A ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-export.ts --help
  save_and_compare_snapshot "greeting-export-ts" deno-tsx-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-ts-deno-tsx-missing-args" {
  run deno run -A ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-export.ts
  save_and_compare_snapshot "greeting-export-ts" deno-tsx-missing-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-ts-deno-tsx-valid-args" {
  run deno run -A ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-export.ts John
  save_and_compare_snapshot "greeting-export-ts" deno-tsx-valid-args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-ts-deno-node-ts-help" {
  run deno run -A ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/greeting-export.ts --help
  save_and_compare_snapshot "greeting-export-ts" deno-node-ts-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-ts-deno-node-ts-missing-args" {
  run deno run -A ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/greeting-export.ts
  save_and_compare_snapshot "greeting-export-ts" deno-node-ts-missing-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-ts-deno-node-ts-valid-args" {
  run deno run -A ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/greeting-export.ts John
  save_and_compare_snapshot "greeting-export-ts" deno-node-ts-valid-args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-ts-node-ts-default-help" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts test/fixtures/greeting-export.ts --help
  save_and_compare_snapshot "greeting-export-ts" node-ts-default-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-ts-node-ts-default-missing-args" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts test/fixtures/greeting-export.ts
  save_and_compare_snapshot "greeting-export-ts" node-ts-default-missing-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-ts-node-ts-default-valid-args" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts test/fixtures/greeting-export.ts John
  save_and_compare_snapshot "greeting-export-ts" node-ts-default-valid-args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-ts-node-ts-deno-help" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-export.ts --help
  save_and_compare_snapshot "greeting-export-ts" node-ts-deno-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-ts-node-ts-deno-missing-args" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-export.ts
  save_and_compare_snapshot "greeting-export-ts" node-ts-deno-missing-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-ts-node-ts-deno-valid-args" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-export.ts John
  save_and_compare_snapshot "greeting-export-ts" node-ts-deno-valid-args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-ts-node-ts-tsx-help" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-export.ts --help
  save_and_compare_snapshot "greeting-export-ts" node-ts-tsx-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-ts-node-ts-tsx-missing-args" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-export.ts
  save_and_compare_snapshot "greeting-export-ts" node-ts-tsx-missing-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-ts-node-ts-tsx-valid-args" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-export.ts John
  save_and_compare_snapshot "greeting-export-ts" node-ts-tsx-valid-args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-ts-node-ts-node-ts-help" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/greeting-export.ts --help
  save_and_compare_snapshot "greeting-export-ts" node-ts-node-ts-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-ts-node-ts-node-ts-missing-args" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/greeting-export.ts
  save_and_compare_snapshot "greeting-export-ts" node-ts-node-ts-missing-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-ts-node-ts-node-ts-valid-args" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/greeting-export.ts John
  save_and_compare_snapshot "greeting-export-ts" node-ts-node-ts-valid-args "$output"
  [ "$status" -eq 0 ]
}