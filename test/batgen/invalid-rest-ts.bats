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

@test "invalid-rest-ts-c8node-default-spread" {
  run npx -s c8 --reporter=none --clean=false node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning  ./src/bin/knevee.ts test/fixtures/invalid-rest.ts
  save_and_compare_snapshot "invalid-rest-ts" c8node-default-spread "$output"
  [ "$status" -eq 1 ]
}

@test "invalid-rest-ts-c8node-deno-spread" {
  run npx -s c8 --reporter=none --clean=false node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning  ./src/bin/knevee.ts deno eval -- test/fixtures/invalid-rest.ts
  save_and_compare_snapshot "invalid-rest-ts" c8node-deno-spread "$output"
  [ "$status" -eq 1 ]
}

@test "invalid-rest-ts-c8node-tsx-spread" {
  run npx -s c8 --reporter=none --clean=false node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning  ./src/bin/knevee.ts tsx -e -- test/fixtures/invalid-rest.ts
  save_and_compare_snapshot "invalid-rest-ts" c8node-tsx-spread "$output"
  [ "$status" -eq 1 ]
}

@test "invalid-rest-ts-c8node-node-ts-spread" {
  run npx -s c8 --reporter=none --clean=false node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning  ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/invalid-rest.ts
  save_and_compare_snapshot "invalid-rest-ts" c8node-node-ts-spread "$output"
  [ "$status" -eq 1 ]
}

@test "invalid-rest-ts-deno-default-spread" {
  run deno run -A ./src/bin/knevee.ts test/fixtures/invalid-rest.ts
  save_and_compare_snapshot "invalid-rest-ts" deno-default-spread "$output"
  [ "$status" -eq 1 ]
}

@test "invalid-rest-ts-deno-deno-spread" {
  run deno run -A ./src/bin/knevee.ts deno eval -- test/fixtures/invalid-rest.ts
  save_and_compare_snapshot "invalid-rest-ts" deno-deno-spread "$output"
  [ "$status" -eq 1 ]
}

@test "invalid-rest-ts-deno-tsx-spread" {
  run deno run -A ./src/bin/knevee.ts tsx -e -- test/fixtures/invalid-rest.ts
  save_and_compare_snapshot "invalid-rest-ts" deno-tsx-spread "$output"
  [ "$status" -eq 1 ]
}

@test "invalid-rest-ts-deno-node-ts-spread" {
  run deno run -A ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/invalid-rest.ts
  save_and_compare_snapshot "invalid-rest-ts" deno-node-ts-spread "$output"
  [ "$status" -eq 1 ]
}

@test "invalid-rest-ts-node-ts-default-spread" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts test/fixtures/invalid-rest.ts
  save_and_compare_snapshot "invalid-rest-ts" node-ts-default-spread "$output"
  [ "$status" -eq 1 ]
}

@test "invalid-rest-ts-node-ts-deno-spread" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts deno eval -- test/fixtures/invalid-rest.ts
  save_and_compare_snapshot "invalid-rest-ts" node-ts-deno-spread "$output"
  [ "$status" -eq 1 ]
}

@test "invalid-rest-ts-node-ts-tsx-spread" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts tsx -e -- test/fixtures/invalid-rest.ts
  save_and_compare_snapshot "invalid-rest-ts" node-ts-tsx-spread "$output"
  [ "$status" -eq 1 ]
}

@test "invalid-rest-ts-node-ts-node-ts-spread" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/invalid-rest.ts
  save_and_compare_snapshot "invalid-rest-ts" node-ts-node-ts-spread "$output"
  [ "$status" -eq 1 ]
}