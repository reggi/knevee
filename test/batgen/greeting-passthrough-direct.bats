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

@test "greeting-passthrough-direct-c8tsx-direct-default-help" {
  run npx -s c8 --reporter=none --clean=false npx -s tsx test/fixtures/greeting-passthrough.ts "--help"
  save_and_compare_snapshot "greeting-passthrough-direct" c8tsx-direct-default-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-passthrough-direct-c8tsx-direct-default-missing-args" {
  run npx -s c8 --reporter=none --clean=false npx -s tsx test/fixtures/greeting-passthrough.ts
  save_and_compare_snapshot "greeting-passthrough-direct" c8tsx-direct-default-missing-args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-passthrough-direct-c8tsx-direct-default-valid-args" {
  run npx -s c8 --reporter=none --clean=false npx -s tsx test/fixtures/greeting-passthrough.ts "John"
  save_and_compare_snapshot "greeting-passthrough-direct" c8tsx-direct-default-valid-args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-passthrough-direct-c8tsx-direct-default-extra-args" {
  run npx -s c8 --reporter=none --clean=false npx -s tsx test/fixtures/greeting-passthrough.ts "John" "extra"
  save_and_compare_snapshot "greeting-passthrough-direct" c8tsx-direct-default-extra-args "$output"
  [ "$status" -eq 1 ]
}