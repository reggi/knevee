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

@test "pig-latin-ts-c8tsx-default-spread" {
  run npx -s c8 --reporter=none --clean=false npx -s tsx ./src/bin/knevee.ts test/fixtures/pig-latin.ts "hello" "world"
  save_and_compare_snapshot "pig-latin-ts" c8tsx-default-spread "$output"
  [ "$status" -eq 0 ]
}