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

@test "starts-with-a-ts-c8tsx-default-true" {
  run npx -s c8 --reporter=none --clean=false npx -s tsx ./src/bin/knevee.ts test/fixtures/starts-with-a.ts "alpha"
  save_and_compare_snapshot "starts-with-a-ts" c8tsx-default-true "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-c8tsx-default-false" {
  run npx -s c8 --reporter=none --clean=false npx -s tsx ./src/bin/knevee.ts test/fixtures/starts-with-a.ts "beta"
  save_and_compare_snapshot "starts-with-a-ts" c8tsx-default-false "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-c8tsx-default-true-emoji" {
  run npx -s c8 --reporter=none --clean=false npx -s tsx ./src/bin/knevee.ts test/fixtures/starts-with-a.ts "alpha" "--emoji"
  save_and_compare_snapshot "starts-with-a-ts" c8tsx-default-true-emoji "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-c8tsx-default-false-emoji" {
  run npx -s c8 --reporter=none --clean=false npx -s tsx ./src/bin/knevee.ts test/fixtures/starts-with-a.ts "beta" "--emoji"
  save_and_compare_snapshot "starts-with-a-ts" c8tsx-default-false-emoji "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-c8tsx-default-true-int" {
  run npx -s c8 --reporter=none --clean=false npx -s tsx ./src/bin/knevee.ts test/fixtures/starts-with-a.ts "alpha" "--int"
  save_and_compare_snapshot "starts-with-a-ts" c8tsx-default-true-int "$output"
  [ "$status" -eq 0 ]
}

@test "starts-with-a-ts-c8tsx-default-false-int" {
  run npx -s c8 --reporter=none --clean=false npx -s tsx ./src/bin/knevee.ts test/fixtures/starts-with-a.ts "beta" "--int"
  save_and_compare_snapshot "starts-with-a-ts" c8tsx-default-false-int "$output"
  [ "$status" -eq 0 ]
}