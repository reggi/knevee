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

@test "greeting-passthrough-cjs-deno-default-help" {
  run deno run -A ./src/bin/knevee.ts test/fixtures/greeting-passthrough.cjs "--help"
  save_and_compare_snapshot "greeting-passthrough-cjs" deno-default-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-passthrough-cjs-deno-default-missing-args" {
  run deno run -A ./src/bin/knevee.ts test/fixtures/greeting-passthrough.cjs
  save_and_compare_snapshot "greeting-passthrough-cjs" deno-default-missing-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-passthrough-cjs-deno-default-valid-args" {
  run deno run -A ./src/bin/knevee.ts test/fixtures/greeting-passthrough.cjs "John"
  save_and_compare_snapshot "greeting-passthrough-cjs" deno-default-valid-args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-passthrough-cjs-deno-default-extra-args" {
  run deno run -A ./src/bin/knevee.ts test/fixtures/greeting-passthrough.cjs "John" "extra"
  save_and_compare_snapshot "greeting-passthrough-cjs" deno-default-extra-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-passthrough-cjs-deno-deno-help" {
  run deno run -A ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-passthrough.cjs "--help"
  save_and_compare_snapshot "greeting-passthrough-cjs" deno-deno-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-passthrough-cjs-deno-deno-missing-args" {
  run deno run -A ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-passthrough.cjs
  save_and_compare_snapshot "greeting-passthrough-cjs" deno-deno-missing-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-passthrough-cjs-deno-deno-valid-args" {
  run deno run -A ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-passthrough.cjs "John"
  save_and_compare_snapshot "greeting-passthrough-cjs" deno-deno-valid-args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-passthrough-cjs-deno-deno-extra-args" {
  run deno run -A ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-passthrough.cjs "John" "extra"
  save_and_compare_snapshot "greeting-passthrough-cjs" deno-deno-extra-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-passthrough-cjs-deno-tsx-help" {
  run deno run -A ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-passthrough.cjs "--help"
  save_and_compare_snapshot "greeting-passthrough-cjs" deno-tsx-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-passthrough-cjs-deno-tsx-missing-args" {
  run deno run -A ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-passthrough.cjs
  save_and_compare_snapshot "greeting-passthrough-cjs" deno-tsx-missing-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-passthrough-cjs-deno-tsx-valid-args" {
  run deno run -A ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-passthrough.cjs "John"
  save_and_compare_snapshot "greeting-passthrough-cjs" deno-tsx-valid-args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-passthrough-cjs-deno-tsx-extra-args" {
  run deno run -A ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-passthrough.cjs "John" "extra"
  save_and_compare_snapshot "greeting-passthrough-cjs" deno-tsx-extra-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-passthrough-cjs-deno-node-help" {
  run deno run -A ./src/bin/knevee.ts node -e -- test/fixtures/greeting-passthrough.cjs "--help"
  save_and_compare_snapshot "greeting-passthrough-cjs" deno-node-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-passthrough-cjs-deno-node-missing-args" {
  run deno run -A ./src/bin/knevee.ts node -e -- test/fixtures/greeting-passthrough.cjs
  save_and_compare_snapshot "greeting-passthrough-cjs" deno-node-missing-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-passthrough-cjs-deno-node-valid-args" {
  run deno run -A ./src/bin/knevee.ts node -e -- test/fixtures/greeting-passthrough.cjs "John"
  save_and_compare_snapshot "greeting-passthrough-cjs" deno-node-valid-args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-passthrough-cjs-deno-node-extra-args" {
  run deno run -A ./src/bin/knevee.ts node -e -- test/fixtures/greeting-passthrough.cjs "John" "extra"
  save_and_compare_snapshot "greeting-passthrough-cjs" deno-node-extra-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-passthrough-cjs-tsx-default-help" {
  run tsx ./src/bin/knevee.ts test/fixtures/greeting-passthrough.cjs "--help"
  save_and_compare_snapshot "greeting-passthrough-cjs" tsx-default-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-passthrough-cjs-tsx-default-missing-args" {
  run tsx ./src/bin/knevee.ts test/fixtures/greeting-passthrough.cjs
  save_and_compare_snapshot "greeting-passthrough-cjs" tsx-default-missing-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-passthrough-cjs-tsx-default-valid-args" {
  run tsx ./src/bin/knevee.ts test/fixtures/greeting-passthrough.cjs "John"
  save_and_compare_snapshot "greeting-passthrough-cjs" tsx-default-valid-args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-passthrough-cjs-tsx-default-extra-args" {
  run tsx ./src/bin/knevee.ts test/fixtures/greeting-passthrough.cjs "John" "extra"
  save_and_compare_snapshot "greeting-passthrough-cjs" tsx-default-extra-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-passthrough-cjs-tsx-deno-help" {
  run tsx ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-passthrough.cjs "--help"
  save_and_compare_snapshot "greeting-passthrough-cjs" tsx-deno-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-passthrough-cjs-tsx-deno-missing-args" {
  run tsx ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-passthrough.cjs
  save_and_compare_snapshot "greeting-passthrough-cjs" tsx-deno-missing-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-passthrough-cjs-tsx-deno-valid-args" {
  run tsx ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-passthrough.cjs "John"
  save_and_compare_snapshot "greeting-passthrough-cjs" tsx-deno-valid-args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-passthrough-cjs-tsx-deno-extra-args" {
  run tsx ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-passthrough.cjs "John" "extra"
  save_and_compare_snapshot "greeting-passthrough-cjs" tsx-deno-extra-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-passthrough-cjs-tsx-tsx-help" {
  run tsx ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-passthrough.cjs "--help"
  save_and_compare_snapshot "greeting-passthrough-cjs" tsx-tsx-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-passthrough-cjs-tsx-tsx-missing-args" {
  run tsx ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-passthrough.cjs
  save_and_compare_snapshot "greeting-passthrough-cjs" tsx-tsx-missing-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-passthrough-cjs-tsx-tsx-valid-args" {
  run tsx ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-passthrough.cjs "John"
  save_and_compare_snapshot "greeting-passthrough-cjs" tsx-tsx-valid-args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-passthrough-cjs-tsx-tsx-extra-args" {
  run tsx ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-passthrough.cjs "John" "extra"
  save_and_compare_snapshot "greeting-passthrough-cjs" tsx-tsx-extra-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-passthrough-cjs-tsx-node-help" {
  run tsx ./src/bin/knevee.ts node -e -- test/fixtures/greeting-passthrough.cjs "--help"
  save_and_compare_snapshot "greeting-passthrough-cjs" tsx-node-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-passthrough-cjs-tsx-node-missing-args" {
  run tsx ./src/bin/knevee.ts node -e -- test/fixtures/greeting-passthrough.cjs
  save_and_compare_snapshot "greeting-passthrough-cjs" tsx-node-missing-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-passthrough-cjs-tsx-node-valid-args" {
  run tsx ./src/bin/knevee.ts node -e -- test/fixtures/greeting-passthrough.cjs "John"
  save_and_compare_snapshot "greeting-passthrough-cjs" tsx-node-valid-args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-passthrough-cjs-tsx-node-extra-args" {
  run tsx ./src/bin/knevee.ts node -e -- test/fixtures/greeting-passthrough.cjs "John" "extra"
  save_and_compare_snapshot "greeting-passthrough-cjs" tsx-node-extra-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-passthrough-cjs-node-build-cjs-default-help" {
  run node ./dist/bin/knevee.cjs test/fixtures/greeting-passthrough.cjs "--help"
  save_and_compare_snapshot "greeting-passthrough-cjs" node-build-cjs-default-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-passthrough-cjs-node-build-cjs-default-missing-args" {
  run node ./dist/bin/knevee.cjs test/fixtures/greeting-passthrough.cjs
  save_and_compare_snapshot "greeting-passthrough-cjs" node-build-cjs-default-missing-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-passthrough-cjs-node-build-cjs-default-valid-args" {
  run node ./dist/bin/knevee.cjs test/fixtures/greeting-passthrough.cjs "John"
  save_and_compare_snapshot "greeting-passthrough-cjs" node-build-cjs-default-valid-args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-passthrough-cjs-node-build-cjs-default-extra-args" {
  run node ./dist/bin/knevee.cjs test/fixtures/greeting-passthrough.cjs "John" "extra"
  save_and_compare_snapshot "greeting-passthrough-cjs" node-build-cjs-default-extra-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-passthrough-cjs-node-build-cjs-deno-help" {
  run node ./dist/bin/knevee.cjs deno eval -- test/fixtures/greeting-passthrough.cjs "--help"
  save_and_compare_snapshot "greeting-passthrough-cjs" node-build-cjs-deno-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-passthrough-cjs-node-build-cjs-deno-missing-args" {
  run node ./dist/bin/knevee.cjs deno eval -- test/fixtures/greeting-passthrough.cjs
  save_and_compare_snapshot "greeting-passthrough-cjs" node-build-cjs-deno-missing-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-passthrough-cjs-node-build-cjs-deno-valid-args" {
  run node ./dist/bin/knevee.cjs deno eval -- test/fixtures/greeting-passthrough.cjs "John"
  save_and_compare_snapshot "greeting-passthrough-cjs" node-build-cjs-deno-valid-args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-passthrough-cjs-node-build-cjs-deno-extra-args" {
  run node ./dist/bin/knevee.cjs deno eval -- test/fixtures/greeting-passthrough.cjs "John" "extra"
  save_and_compare_snapshot "greeting-passthrough-cjs" node-build-cjs-deno-extra-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-passthrough-cjs-node-build-cjs-tsx-help" {
  run node ./dist/bin/knevee.cjs tsx -e -- test/fixtures/greeting-passthrough.cjs "--help"
  save_and_compare_snapshot "greeting-passthrough-cjs" node-build-cjs-tsx-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-passthrough-cjs-node-build-cjs-tsx-missing-args" {
  run node ./dist/bin/knevee.cjs tsx -e -- test/fixtures/greeting-passthrough.cjs
  save_and_compare_snapshot "greeting-passthrough-cjs" node-build-cjs-tsx-missing-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-passthrough-cjs-node-build-cjs-tsx-valid-args" {
  run node ./dist/bin/knevee.cjs tsx -e -- test/fixtures/greeting-passthrough.cjs "John"
  save_and_compare_snapshot "greeting-passthrough-cjs" node-build-cjs-tsx-valid-args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-passthrough-cjs-node-build-cjs-tsx-extra-args" {
  run node ./dist/bin/knevee.cjs tsx -e -- test/fixtures/greeting-passthrough.cjs "John" "extra"
  save_and_compare_snapshot "greeting-passthrough-cjs" node-build-cjs-tsx-extra-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-passthrough-cjs-node-build-cjs-node-help" {
  run node ./dist/bin/knevee.cjs node -e -- test/fixtures/greeting-passthrough.cjs "--help"
  save_and_compare_snapshot "greeting-passthrough-cjs" node-build-cjs-node-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-passthrough-cjs-node-build-cjs-node-missing-args" {
  run node ./dist/bin/knevee.cjs node -e -- test/fixtures/greeting-passthrough.cjs
  save_and_compare_snapshot "greeting-passthrough-cjs" node-build-cjs-node-missing-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-passthrough-cjs-node-build-cjs-node-valid-args" {
  run node ./dist/bin/knevee.cjs node -e -- test/fixtures/greeting-passthrough.cjs "John"
  save_and_compare_snapshot "greeting-passthrough-cjs" node-build-cjs-node-valid-args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-passthrough-cjs-node-build-cjs-node-extra-args" {
  run node ./dist/bin/knevee.cjs node -e -- test/fixtures/greeting-passthrough.cjs "John" "extra"
  save_and_compare_snapshot "greeting-passthrough-cjs" node-build-cjs-node-extra-args "$output"
  [ "$status" -eq 1 ]
}