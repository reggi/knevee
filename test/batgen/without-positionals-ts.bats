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

@test "without-positionals-ts-c8tsx-default-success" {
  run npx -s c8 --reporter=none --clean=false npx -s tsx ./src/bin/knevee.ts test/fixtures/without-positionals.ts
  save_and_compare_snapshot "without-positionals-ts" c8tsx-default-success "$output"
  [ "$status" -eq 0 ]
}