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

@test "without-positionals-ts-c8node-default-success" {
  run npx -s c8 --reporter=none --clean=false node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning  ./src/bin/knevee.ts test/fixtures/without-positionals.ts
  save_and_compare_snapshot "without-positionals-ts" c8node-default-success "$output"
  [ "$status" -eq 0 ]
}

@test "without-positionals-ts-c8node-deno-success" {
  run npx -s c8 --reporter=none --clean=false node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning  ./src/bin/knevee.ts deno eval -- test/fixtures/without-positionals.ts
  save_and_compare_snapshot "without-positionals-ts" c8node-deno-success "$output"
  [ "$status" -eq 0 ]
}

@test "without-positionals-ts-c8node-tsx-success" {
  run npx -s c8 --reporter=none --clean=false node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning  ./src/bin/knevee.ts tsx -e -- test/fixtures/without-positionals.ts
  save_and_compare_snapshot "without-positionals-ts" c8node-tsx-success "$output"
  [ "$status" -eq 0 ]
}

@test "without-positionals-ts-c8node-node-ts-success" {
  run npx -s c8 --reporter=none --clean=false node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning  ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/without-positionals.ts
  save_and_compare_snapshot "without-positionals-ts" c8node-node-ts-success "$output"
  [ "$status" -eq 0 ]
}

@test "without-positionals-ts-deno-default-success" {
  run deno run -A ./src/bin/knevee.ts test/fixtures/without-positionals.ts
  save_and_compare_snapshot "without-positionals-ts" deno-default-success "$output"
  [ "$status" -eq 0 ]
}

@test "without-positionals-ts-deno-deno-success" {
  run deno run -A ./src/bin/knevee.ts deno eval -- test/fixtures/without-positionals.ts
  save_and_compare_snapshot "without-positionals-ts" deno-deno-success "$output"
  [ "$status" -eq 0 ]
}

@test "without-positionals-ts-deno-tsx-success" {
  run deno run -A ./src/bin/knevee.ts tsx -e -- test/fixtures/without-positionals.ts
  save_and_compare_snapshot "without-positionals-ts" deno-tsx-success "$output"
  [ "$status" -eq 0 ]
}

@test "without-positionals-ts-deno-node-ts-success" {
  run deno run -A ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/without-positionals.ts
  save_and_compare_snapshot "without-positionals-ts" deno-node-ts-success "$output"
  [ "$status" -eq 0 ]
}

@test "without-positionals-ts-node-ts-default-success" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts test/fixtures/without-positionals.ts
  save_and_compare_snapshot "without-positionals-ts" node-ts-default-success "$output"
  [ "$status" -eq 0 ]
}

@test "without-positionals-ts-node-ts-deno-success" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts deno eval -- test/fixtures/without-positionals.ts
  save_and_compare_snapshot "without-positionals-ts" node-ts-deno-success "$output"
  [ "$status" -eq 0 ]
}

@test "without-positionals-ts-node-ts-tsx-success" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts tsx -e -- test/fixtures/without-positionals.ts
  save_and_compare_snapshot "without-positionals-ts" node-ts-tsx-success "$output"
  [ "$status" -eq 0 ]
}

@test "without-positionals-ts-node-ts-node-ts-success" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/without-positionals.ts
  save_and_compare_snapshot "without-positionals-ts" node-ts-node-ts-success "$output"
  [ "$status" -eq 0 ]
}