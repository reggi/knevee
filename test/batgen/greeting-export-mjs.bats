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

@test "greeting-export-mjs-deno-default-help" {
  run deno run -A ./src/bin/knevee.ts test/fixtures/greeting-export.mjs --help
  save_and_compare_snapshot "greeting-export-mjs" deno-default-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-mjs-deno-default-missing-args" {
  run deno run -A ./src/bin/knevee.ts test/fixtures/greeting-export.mjs
  save_and_compare_snapshot "greeting-export-mjs" deno-default-missing-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-mjs-deno-default-valid-args" {
  run deno run -A ./src/bin/knevee.ts test/fixtures/greeting-export.mjs John
  save_and_compare_snapshot "greeting-export-mjs" deno-default-valid-args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-mjs-deno-deno-help" {
  run deno run -A ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-export.mjs --help
  save_and_compare_snapshot "greeting-export-mjs" deno-deno-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-mjs-deno-deno-missing-args" {
  run deno run -A ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-export.mjs
  save_and_compare_snapshot "greeting-export-mjs" deno-deno-missing-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-mjs-deno-deno-valid-args" {
  run deno run -A ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-export.mjs John
  save_and_compare_snapshot "greeting-export-mjs" deno-deno-valid-args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-mjs-deno-tsx-help" {
  run deno run -A ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-export.mjs --help
  save_and_compare_snapshot "greeting-export-mjs" deno-tsx-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-mjs-deno-tsx-missing-args" {
  run deno run -A ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-export.mjs
  save_and_compare_snapshot "greeting-export-mjs" deno-tsx-missing-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-mjs-deno-tsx-valid-args" {
  run deno run -A ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-export.mjs John
  save_and_compare_snapshot "greeting-export-mjs" deno-tsx-valid-args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-mjs-deno-node-help" {
  run deno run -A ./src/bin/knevee.ts node -e -- test/fixtures/greeting-export.mjs --help
  save_and_compare_snapshot "greeting-export-mjs" deno-node-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-mjs-deno-node-missing-args" {
  run deno run -A ./src/bin/knevee.ts node -e -- test/fixtures/greeting-export.mjs
  save_and_compare_snapshot "greeting-export-mjs" deno-node-missing-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-mjs-deno-node-valid-args" {
  run deno run -A ./src/bin/knevee.ts node -e -- test/fixtures/greeting-export.mjs John
  save_and_compare_snapshot "greeting-export-mjs" deno-node-valid-args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-mjs-tsx-default-help" {
  run tsx ./src/bin/knevee.ts test/fixtures/greeting-export.mjs --help
  save_and_compare_snapshot "greeting-export-mjs" tsx-default-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-mjs-tsx-default-missing-args" {
  run tsx ./src/bin/knevee.ts test/fixtures/greeting-export.mjs
  save_and_compare_snapshot "greeting-export-mjs" tsx-default-missing-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-mjs-tsx-default-valid-args" {
  run tsx ./src/bin/knevee.ts test/fixtures/greeting-export.mjs John
  save_and_compare_snapshot "greeting-export-mjs" tsx-default-valid-args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-mjs-tsx-deno-help" {
  run tsx ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-export.mjs --help
  save_and_compare_snapshot "greeting-export-mjs" tsx-deno-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-mjs-tsx-deno-missing-args" {
  run tsx ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-export.mjs
  save_and_compare_snapshot "greeting-export-mjs" tsx-deno-missing-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-mjs-tsx-deno-valid-args" {
  run tsx ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-export.mjs John
  save_and_compare_snapshot "greeting-export-mjs" tsx-deno-valid-args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-mjs-tsx-tsx-help" {
  run tsx ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-export.mjs --help
  save_and_compare_snapshot "greeting-export-mjs" tsx-tsx-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-mjs-tsx-tsx-missing-args" {
  run tsx ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-export.mjs
  save_and_compare_snapshot "greeting-export-mjs" tsx-tsx-missing-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-mjs-tsx-tsx-valid-args" {
  run tsx ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-export.mjs John
  save_and_compare_snapshot "greeting-export-mjs" tsx-tsx-valid-args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-mjs-tsx-node-help" {
  run tsx ./src/bin/knevee.ts node -e -- test/fixtures/greeting-export.mjs --help
  save_and_compare_snapshot "greeting-export-mjs" tsx-node-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-mjs-tsx-node-missing-args" {
  run tsx ./src/bin/knevee.ts node -e -- test/fixtures/greeting-export.mjs
  save_and_compare_snapshot "greeting-export-mjs" tsx-node-missing-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-mjs-tsx-node-valid-args" {
  run tsx ./src/bin/knevee.ts node -e -- test/fixtures/greeting-export.mjs John
  save_and_compare_snapshot "greeting-export-mjs" tsx-node-valid-args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-mjs-node-build-esm-default-help" {
  run node ./dist/bin/knevee.js test/fixtures/greeting-export.mjs --help
  save_and_compare_snapshot "greeting-export-mjs" node-build-esm-default-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-mjs-node-build-esm-default-missing-args" {
  run node ./dist/bin/knevee.js test/fixtures/greeting-export.mjs
  save_and_compare_snapshot "greeting-export-mjs" node-build-esm-default-missing-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-mjs-node-build-esm-default-valid-args" {
  run node ./dist/bin/knevee.js test/fixtures/greeting-export.mjs John
  save_and_compare_snapshot "greeting-export-mjs" node-build-esm-default-valid-args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-mjs-node-build-esm-deno-help" {
  run node ./dist/bin/knevee.js deno eval -- test/fixtures/greeting-export.mjs --help
  save_and_compare_snapshot "greeting-export-mjs" node-build-esm-deno-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-mjs-node-build-esm-deno-missing-args" {
  run node ./dist/bin/knevee.js deno eval -- test/fixtures/greeting-export.mjs
  save_and_compare_snapshot "greeting-export-mjs" node-build-esm-deno-missing-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-mjs-node-build-esm-deno-valid-args" {
  run node ./dist/bin/knevee.js deno eval -- test/fixtures/greeting-export.mjs John
  save_and_compare_snapshot "greeting-export-mjs" node-build-esm-deno-valid-args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-mjs-node-build-esm-tsx-help" {
  run node ./dist/bin/knevee.js tsx -e -- test/fixtures/greeting-export.mjs --help
  save_and_compare_snapshot "greeting-export-mjs" node-build-esm-tsx-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-mjs-node-build-esm-tsx-missing-args" {
  run node ./dist/bin/knevee.js tsx -e -- test/fixtures/greeting-export.mjs
  save_and_compare_snapshot "greeting-export-mjs" node-build-esm-tsx-missing-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-mjs-node-build-esm-tsx-valid-args" {
  run node ./dist/bin/knevee.js tsx -e -- test/fixtures/greeting-export.mjs John
  save_and_compare_snapshot "greeting-export-mjs" node-build-esm-tsx-valid-args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-mjs-node-build-esm-node-help" {
  run node ./dist/bin/knevee.js node -e -- test/fixtures/greeting-export.mjs --help
  save_and_compare_snapshot "greeting-export-mjs" node-build-esm-node-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-mjs-node-build-esm-node-missing-args" {
  run node ./dist/bin/knevee.js node -e -- test/fixtures/greeting-export.mjs
  save_and_compare_snapshot "greeting-export-mjs" node-build-esm-node-missing-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-mjs-node-build-esm-node-valid-args" {
  run node ./dist/bin/knevee.js node -e -- test/fixtures/greeting-export.mjs John
  save_and_compare_snapshot "greeting-export-mjs" node-build-esm-node-valid-args "$output"
  [ "$status" -eq 0 ]
}