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

@test "greeting-export-ts-c8tsx-default-help" {
  run npx -s c8 --reporter=none --clean=false npx -s tsx ./src/bin/knevee.ts test/fixtures/greeting-export.ts "--help"
  save_and_compare_snapshot "greeting-export-ts" c8tsx-default-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-ts-c8tsx-default-missing-args" {
  run npx -s c8 --reporter=none --clean=false npx -s tsx ./src/bin/knevee.ts test/fixtures/greeting-export.ts
  save_and_compare_snapshot "greeting-export-ts" c8tsx-default-missing-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-ts-c8tsx-default-valid-args" {
  run npx -s c8 --reporter=none --clean=false npx -s tsx ./src/bin/knevee.ts test/fixtures/greeting-export.ts "John"
  save_and_compare_snapshot "greeting-export-ts" c8tsx-default-valid-args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-ts-c8tsx-default-extra-args" {
  run npx -s c8 --reporter=none --clean=false npx -s tsx ./src/bin/knevee.ts test/fixtures/greeting-export.ts "John" "extra"
  save_and_compare_snapshot "greeting-export-ts" c8tsx-default-extra-args "$output"
  [ "$status" -eq 1 ]
}