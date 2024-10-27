#!/usr/bin/env bats

setup() {
    snapshot_dir="./snapshots"
    mkdir -p "$snapshot_dir"
}

save_and_compare_snapshot() {
    snapshot="$snapshot_dir/$1.txt"
    if [ ! -f "$snapshot" ]; then
        echo "$2" > "$snapshot"
    fi

    diff -u "$snapshot" <(echo "$2")
}

harness() {
    file=$1
    shift
    c8 --reporter=none --clean=false tsx ./test/fixtures/${file}.ts "$@"
}

@test "hello-world" {
    run harness hello-world
    save_and_compare_snapshot "$BATS_TEST_DESCRIPTION" "$output"
}

@test "hello-world-help" {
    run harness hello-world --help
    save_and_compare_snapshot "$BATS_TEST_DESCRIPTION" "$output"
}

@test "greeting" {
    run harness greeting "Mr. Meowzies"
    save_and_compare_snapshot "$BATS_TEST_DESCRIPTION" "$output"
}

@test "greeting-stdout" {
    run bash -c "c8 --reporter=none --clean=false echo \"Mr. Echo\" | tsx ./test/fixtures/greeting.ts"
    save_and_compare_snapshot "$BATS_TEST_DESCRIPTION" "$output"
}

@test "greeting-extra-param" {
    run harness greeting alpha beta
    save_and_compare_snapshot "$BATS_TEST_DESCRIPTION" "$output"
    [ "$status" -ne 0 ]
}

@test "greeting-missing-param" {
    run harness greeting
    save_and_compare_snapshot "$BATS_TEST_DESCRIPTION" "$output"
    [ "$status" -ne 0 ]
}

@test "greeting-optional-param" {
    run harness greeting-optional tea Greeting
    save_and_compare_snapshot "$BATS_TEST_DESCRIPTION" "$output"
}

@test "greeting-missing-optional-param" {
    run harness greeting-optional tea
    save_and_compare_snapshot "$BATS_TEST_DESCRIPTION" "$output"
}

@test "greeting-fails-without-name" {
    run harness greeting
    save_and_compare_snapshot "$BATS_TEST_DESCRIPTION" "$output"
    [ "$status" -ne 0 ]
}

@test "starts-with-t-true" {
    run harness starts-with-t tea
    save_and_compare_snapshot "$BATS_TEST_DESCRIPTION" "$output"
}

@test "starts-with-t-false" {
    run harness starts-with-t coffee
    save_and_compare_snapshot "$BATS_TEST_DESCRIPTION" "$output"
}

@test "starts-with-t-true-emoji" {
    run harness starts-with-t tea --emoji
    save_and_compare_snapshot "$BATS_TEST_DESCRIPTION" "$output"
}

@test "starts-with-t-false-emoji" {
    run harness starts-with-t coffee --emoji
    save_and_compare_snapshot "$BATS_TEST_DESCRIPTION" "$output"
}

@test "starts-with-t-true-int" {
    run harness starts-with-t tea --int
    save_and_compare_snapshot "$BATS_TEST_DESCRIPTION" "$output"
}

@test "starts-with-t-false-int" {
    run harness starts-with-t coffee --int
    save_and_compare_snapshot "$BATS_TEST_DESCRIPTION" "$output"
}

@test "starts-with-t-lines" {
    run bash -c "c8 --reporter=none --clean=false echo \"tea\ncoffee\" | tsx ./test/fixtures/starts-with-t.ts"
    save_and_compare_snapshot "$BATS_TEST_DESCRIPTION" "$output"
}

@test "invalid-positional" {
    run harness "$BATS_TEST_DESCRIPTION"
    [ "$status" -ne 0 ]
}

@test "invalid-rest-positional" {
    run harness "$BATS_TEST_DESCRIPTION"
    [ "$status" -ne 0 ]
}

@test "invalid-optional-b4-required-positional" {
    run harness "$BATS_TEST_DESCRIPTION"
    [ "$status" -ne 0 ]
}

@test "double-dash" {
    run harness "$BATS_TEST_DESCRIPTION" meow -- woof
    save_and_compare_snapshot "$BATS_TEST_DESCRIPTION" "$output"
}