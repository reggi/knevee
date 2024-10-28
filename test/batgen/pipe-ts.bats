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

@test "pipe-ts-c8node-default-stdin" {
  output=$(echo "Hello World" | npx -s c8 --reporter=none --clean=false node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning  ./src/bin/knevee.ts test/fixtures/pipe.ts)
  status=$?
  save_and_compare_snapshot "pipe-ts" c8node-default-stdin "$output"
  [ "$status" -eq 0 ]
}

@test "pipe-ts-c8node-deno-stdin" {
  output=$(echo "Hello World" | npx -s c8 --reporter=none --clean=false node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning  ./src/bin/knevee.ts deno eval -- test/fixtures/pipe.ts)
  status=$?
  save_and_compare_snapshot "pipe-ts" c8node-deno-stdin "$output"
  [ "$status" -eq 0 ]
}

@test "pipe-ts-c8node-tsx-stdin" {
  output=$(echo "Hello World" | npx -s c8 --reporter=none --clean=false node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning  ./src/bin/knevee.ts tsx -e -- test/fixtures/pipe.ts)
  status=$?
  save_and_compare_snapshot "pipe-ts" c8node-tsx-stdin "$output"
  [ "$status" -eq 0 ]
}

@test "pipe-ts-c8node-node-ts-stdin" {
  output=$(echo "Hello World" | npx -s c8 --reporter=none --clean=false node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning  ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/pipe.ts)
  status=$?
  save_and_compare_snapshot "pipe-ts" c8node-node-ts-stdin "$output"
  [ "$status" -eq 0 ]
}

@test "pipe-ts-deno-default-stdin" {
  output=$(echo "Hello World" | deno run -A ./src/bin/knevee.ts test/fixtures/pipe.ts)
  status=$?
  save_and_compare_snapshot "pipe-ts" deno-default-stdin "$output"
  [ "$status" -eq 0 ]
}

@test "pipe-ts-deno-deno-stdin" {
  output=$(echo "Hello World" | deno run -A ./src/bin/knevee.ts deno eval -- test/fixtures/pipe.ts)
  status=$?
  save_and_compare_snapshot "pipe-ts" deno-deno-stdin "$output"
  [ "$status" -eq 0 ]
}

@test "pipe-ts-deno-tsx-stdin" {
  output=$(echo "Hello World" | deno run -A ./src/bin/knevee.ts tsx -e -- test/fixtures/pipe.ts)
  status=$?
  save_and_compare_snapshot "pipe-ts" deno-tsx-stdin "$output"
  [ "$status" -eq 0 ]
}

@test "pipe-ts-deno-node-ts-stdin" {
  output=$(echo "Hello World" | deno run -A ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/pipe.ts)
  status=$?
  save_and_compare_snapshot "pipe-ts" deno-node-ts-stdin "$output"
  [ "$status" -eq 0 ]
}

@test "pipe-ts-node-ts-default-stdin" {
  output=$(echo "Hello World" | node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts test/fixtures/pipe.ts)
  status=$?
  save_and_compare_snapshot "pipe-ts" node-ts-default-stdin "$output"
  [ "$status" -eq 0 ]
}

@test "pipe-ts-node-ts-deno-stdin" {
  output=$(echo "Hello World" | node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts deno eval -- test/fixtures/pipe.ts)
  status=$?
  save_and_compare_snapshot "pipe-ts" node-ts-deno-stdin "$output"
  [ "$status" -eq 0 ]
}

@test "pipe-ts-node-ts-tsx-stdin" {
  output=$(echo "Hello World" | node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts tsx -e -- test/fixtures/pipe.ts)
  status=$?
  save_and_compare_snapshot "pipe-ts" node-ts-tsx-stdin "$output"
  [ "$status" -eq 0 ]
}

@test "pipe-ts-node-ts-node-ts-stdin" {
  output=$(echo "Hello World" | node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/pipe.ts)
  status=$?
  save_and_compare_snapshot "pipe-ts" node-ts-node-ts-stdin "$output"
  [ "$status" -eq 0 ]
}