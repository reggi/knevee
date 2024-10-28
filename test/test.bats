
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


@test "greeting-executablePassthrough-ts-c8-default-help" {
  run npx -s c8 --reporter=none --clean=false tsx ./src/bin/knevee.ts test/fixtures/greeting-executablePassthrough.ts --help
  save_and_compare_snapshot "greeting-executablePassthrough-ts" c8-default-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-ts-c8-default-missing_args" {
  run npx -s c8 --reporter=none --clean=false tsx ./src/bin/knevee.ts test/fixtures/greeting-executablePassthrough.ts
  save_and_compare_snapshot "greeting-executablePassthrough-ts" c8-default-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-executablePassthrough-ts-c8-default-valid_args" {
  run npx -s c8 --reporter=none --clean=false tsx ./src/bin/knevee.ts test/fixtures/greeting-executablePassthrough.ts John
  save_and_compare_snapshot "greeting-executablePassthrough-ts" c8-default-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-ts-c8-deno-help" {
  run npx -s c8 --reporter=none --clean=false tsx ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-executablePassthrough.ts --help
  save_and_compare_snapshot "greeting-executablePassthrough-ts" c8-deno-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-ts-c8-deno-missing_args" {
  run npx -s c8 --reporter=none --clean=false tsx ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-executablePassthrough.ts
  save_and_compare_snapshot "greeting-executablePassthrough-ts" c8-deno-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-executablePassthrough-ts-c8-deno-valid_args" {
  run npx -s c8 --reporter=none --clean=false tsx ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-executablePassthrough.ts John
  save_and_compare_snapshot "greeting-executablePassthrough-ts" c8-deno-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-ts-c8-tsx-help" {
  run npx -s c8 --reporter=none --clean=false tsx ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-executablePassthrough.ts --help
  save_and_compare_snapshot "greeting-executablePassthrough-ts" c8-tsx-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-ts-c8-tsx-missing_args" {
  run npx -s c8 --reporter=none --clean=false tsx ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-executablePassthrough.ts
  save_and_compare_snapshot "greeting-executablePassthrough-ts" c8-tsx-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-executablePassthrough-ts-c8-tsx-valid_args" {
  run npx -s c8 --reporter=none --clean=false tsx ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-executablePassthrough.ts John
  save_and_compare_snapshot "greeting-executablePassthrough-ts" c8-tsx-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-ts-c8-node_ts-help" {
  run npx -s c8 --reporter=none --clean=false tsx ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/greeting-executablePassthrough.ts --help
  save_and_compare_snapshot "greeting-executablePassthrough-ts" c8-node_ts-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-ts-c8-node_ts-missing_args" {
  run npx -s c8 --reporter=none --clean=false tsx ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/greeting-executablePassthrough.ts
  save_and_compare_snapshot "greeting-executablePassthrough-ts" c8-node_ts-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-executablePassthrough-ts-c8-node_ts-valid_args" {
  run npx -s c8 --reporter=none --clean=false tsx ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/greeting-executablePassthrough.ts John
  save_and_compare_snapshot "greeting-executablePassthrough-ts" c8-node_ts-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-ts-deno-default-help" {
  run deno run -A ./src/bin/knevee.ts test/fixtures/greeting-executablePassthrough.ts --help
  save_and_compare_snapshot "greeting-executablePassthrough-ts" deno-default-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-ts-deno-default-missing_args" {
  run deno run -A ./src/bin/knevee.ts test/fixtures/greeting-executablePassthrough.ts
  save_and_compare_snapshot "greeting-executablePassthrough-ts" deno-default-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-executablePassthrough-ts-deno-default-valid_args" {
  run deno run -A ./src/bin/knevee.ts test/fixtures/greeting-executablePassthrough.ts John
  save_and_compare_snapshot "greeting-executablePassthrough-ts" deno-default-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-ts-deno-deno-help" {
  run deno run -A ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-executablePassthrough.ts --help
  save_and_compare_snapshot "greeting-executablePassthrough-ts" deno-deno-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-ts-deno-deno-missing_args" {
  run deno run -A ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-executablePassthrough.ts
  save_and_compare_snapshot "greeting-executablePassthrough-ts" deno-deno-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-executablePassthrough-ts-deno-deno-valid_args" {
  run deno run -A ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-executablePassthrough.ts John
  save_and_compare_snapshot "greeting-executablePassthrough-ts" deno-deno-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-ts-deno-tsx-help" {
  run deno run -A ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-executablePassthrough.ts --help
  save_and_compare_snapshot "greeting-executablePassthrough-ts" deno-tsx-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-ts-deno-tsx-missing_args" {
  run deno run -A ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-executablePassthrough.ts
  save_and_compare_snapshot "greeting-executablePassthrough-ts" deno-tsx-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-executablePassthrough-ts-deno-tsx-valid_args" {
  run deno run -A ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-executablePassthrough.ts John
  save_and_compare_snapshot "greeting-executablePassthrough-ts" deno-tsx-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-ts-deno-node_ts-help" {
  run deno run -A ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/greeting-executablePassthrough.ts --help
  save_and_compare_snapshot "greeting-executablePassthrough-ts" deno-node_ts-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-ts-deno-node_ts-missing_args" {
  run deno run -A ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/greeting-executablePassthrough.ts
  save_and_compare_snapshot "greeting-executablePassthrough-ts" deno-node_ts-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-executablePassthrough-ts-deno-node_ts-valid_args" {
  run deno run -A ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/greeting-executablePassthrough.ts John
  save_and_compare_snapshot "greeting-executablePassthrough-ts" deno-node_ts-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-ts-node_ts-default-help" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts test/fixtures/greeting-executablePassthrough.ts --help
  save_and_compare_snapshot "greeting-executablePassthrough-ts" node_ts-default-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-ts-node_ts-default-missing_args" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts test/fixtures/greeting-executablePassthrough.ts
  save_and_compare_snapshot "greeting-executablePassthrough-ts" node_ts-default-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-executablePassthrough-ts-node_ts-default-valid_args" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts test/fixtures/greeting-executablePassthrough.ts John
  save_and_compare_snapshot "greeting-executablePassthrough-ts" node_ts-default-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-ts-node_ts-deno-help" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-executablePassthrough.ts --help
  save_and_compare_snapshot "greeting-executablePassthrough-ts" node_ts-deno-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-ts-node_ts-deno-missing_args" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-executablePassthrough.ts
  save_and_compare_snapshot "greeting-executablePassthrough-ts" node_ts-deno-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-executablePassthrough-ts-node_ts-deno-valid_args" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-executablePassthrough.ts John
  save_and_compare_snapshot "greeting-executablePassthrough-ts" node_ts-deno-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-ts-node_ts-tsx-help" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-executablePassthrough.ts --help
  save_and_compare_snapshot "greeting-executablePassthrough-ts" node_ts-tsx-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-ts-node_ts-tsx-missing_args" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-executablePassthrough.ts
  save_and_compare_snapshot "greeting-executablePassthrough-ts" node_ts-tsx-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-executablePassthrough-ts-node_ts-tsx-valid_args" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-executablePassthrough.ts John
  save_and_compare_snapshot "greeting-executablePassthrough-ts" node_ts-tsx-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-ts-node_ts-node_ts-help" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/greeting-executablePassthrough.ts --help
  save_and_compare_snapshot "greeting-executablePassthrough-ts" node_ts-node_ts-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-ts-node_ts-node_ts-missing_args" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/greeting-executablePassthrough.ts
  save_and_compare_snapshot "greeting-executablePassthrough-ts" node_ts-node_ts-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-executablePassthrough-ts-node_ts-node_ts-valid_args" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/greeting-executablePassthrough.ts John
  save_and_compare_snapshot "greeting-executablePassthrough-ts" node_ts-node_ts-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-mjs-deno-default-help" {
  run deno run -A ./src/bin/knevee.ts test/fixtures/greeting-executablePassthrough.mjs --help
  save_and_compare_snapshot "greeting-executablePassthrough-mjs" deno-default-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-mjs-deno-default-missing_args" {
  run deno run -A ./src/bin/knevee.ts test/fixtures/greeting-executablePassthrough.mjs
  save_and_compare_snapshot "greeting-executablePassthrough-mjs" deno-default-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-executablePassthrough-mjs-deno-default-valid_args" {
  run deno run -A ./src/bin/knevee.ts test/fixtures/greeting-executablePassthrough.mjs John
  save_and_compare_snapshot "greeting-executablePassthrough-mjs" deno-default-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-mjs-deno-deno-help" {
  run deno run -A ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-executablePassthrough.mjs --help
  save_and_compare_snapshot "greeting-executablePassthrough-mjs" deno-deno-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-mjs-deno-deno-missing_args" {
  run deno run -A ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-executablePassthrough.mjs
  save_and_compare_snapshot "greeting-executablePassthrough-mjs" deno-deno-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-executablePassthrough-mjs-deno-deno-valid_args" {
  run deno run -A ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-executablePassthrough.mjs John
  save_and_compare_snapshot "greeting-executablePassthrough-mjs" deno-deno-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-mjs-deno-tsx-help" {
  run deno run -A ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-executablePassthrough.mjs --help
  save_and_compare_snapshot "greeting-executablePassthrough-mjs" deno-tsx-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-mjs-deno-tsx-missing_args" {
  run deno run -A ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-executablePassthrough.mjs
  save_and_compare_snapshot "greeting-executablePassthrough-mjs" deno-tsx-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-executablePassthrough-mjs-deno-tsx-valid_args" {
  run deno run -A ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-executablePassthrough.mjs John
  save_and_compare_snapshot "greeting-executablePassthrough-mjs" deno-tsx-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-mjs-deno-node-help" {
  run deno run -A ./src/bin/knevee.ts node -e -- test/fixtures/greeting-executablePassthrough.mjs --help
  save_and_compare_snapshot "greeting-executablePassthrough-mjs" deno-node-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-mjs-deno-node-missing_args" {
  run deno run -A ./src/bin/knevee.ts node -e -- test/fixtures/greeting-executablePassthrough.mjs
  save_and_compare_snapshot "greeting-executablePassthrough-mjs" deno-node-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-executablePassthrough-mjs-deno-node-valid_args" {
  run deno run -A ./src/bin/knevee.ts node -e -- test/fixtures/greeting-executablePassthrough.mjs John
  save_and_compare_snapshot "greeting-executablePassthrough-mjs" deno-node-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-mjs-tsx-default-help" {
  run tsx ./src/bin/knevee.ts test/fixtures/greeting-executablePassthrough.mjs --help
  save_and_compare_snapshot "greeting-executablePassthrough-mjs" tsx-default-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-mjs-tsx-default-missing_args" {
  run tsx ./src/bin/knevee.ts test/fixtures/greeting-executablePassthrough.mjs
  save_and_compare_snapshot "greeting-executablePassthrough-mjs" tsx-default-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-executablePassthrough-mjs-tsx-default-valid_args" {
  run tsx ./src/bin/knevee.ts test/fixtures/greeting-executablePassthrough.mjs John
  save_and_compare_snapshot "greeting-executablePassthrough-mjs" tsx-default-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-mjs-tsx-deno-help" {
  run tsx ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-executablePassthrough.mjs --help
  save_and_compare_snapshot "greeting-executablePassthrough-mjs" tsx-deno-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-mjs-tsx-deno-missing_args" {
  run tsx ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-executablePassthrough.mjs
  save_and_compare_snapshot "greeting-executablePassthrough-mjs" tsx-deno-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-executablePassthrough-mjs-tsx-deno-valid_args" {
  run tsx ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-executablePassthrough.mjs John
  save_and_compare_snapshot "greeting-executablePassthrough-mjs" tsx-deno-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-mjs-tsx-tsx-help" {
  run tsx ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-executablePassthrough.mjs --help
  save_and_compare_snapshot "greeting-executablePassthrough-mjs" tsx-tsx-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-mjs-tsx-tsx-missing_args" {
  run tsx ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-executablePassthrough.mjs
  save_and_compare_snapshot "greeting-executablePassthrough-mjs" tsx-tsx-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-executablePassthrough-mjs-tsx-tsx-valid_args" {
  run tsx ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-executablePassthrough.mjs John
  save_and_compare_snapshot "greeting-executablePassthrough-mjs" tsx-tsx-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-mjs-tsx-node-help" {
  run tsx ./src/bin/knevee.ts node -e -- test/fixtures/greeting-executablePassthrough.mjs --help
  save_and_compare_snapshot "greeting-executablePassthrough-mjs" tsx-node-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-mjs-tsx-node-missing_args" {
  run tsx ./src/bin/knevee.ts node -e -- test/fixtures/greeting-executablePassthrough.mjs
  save_and_compare_snapshot "greeting-executablePassthrough-mjs" tsx-node-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-executablePassthrough-mjs-tsx-node-valid_args" {
  run tsx ./src/bin/knevee.ts node -e -- test/fixtures/greeting-executablePassthrough.mjs John
  save_and_compare_snapshot "greeting-executablePassthrough-mjs" tsx-node-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-mjs-node_build_esm-default-help" {
  run node ./dist/bin/knevee.js test/fixtures/greeting-executablePassthrough.mjs --help
  save_and_compare_snapshot "greeting-executablePassthrough-mjs" node_build_esm-default-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-mjs-node_build_esm-default-missing_args" {
  run node ./dist/bin/knevee.js test/fixtures/greeting-executablePassthrough.mjs
  save_and_compare_snapshot "greeting-executablePassthrough-mjs" node_build_esm-default-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-executablePassthrough-mjs-node_build_esm-default-valid_args" {
  run node ./dist/bin/knevee.js test/fixtures/greeting-executablePassthrough.mjs John
  save_and_compare_snapshot "greeting-executablePassthrough-mjs" node_build_esm-default-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-mjs-node_build_esm-deno-help" {
  run node ./dist/bin/knevee.js deno eval -- test/fixtures/greeting-executablePassthrough.mjs --help
  save_and_compare_snapshot "greeting-executablePassthrough-mjs" node_build_esm-deno-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-mjs-node_build_esm-deno-missing_args" {
  run node ./dist/bin/knevee.js deno eval -- test/fixtures/greeting-executablePassthrough.mjs
  save_and_compare_snapshot "greeting-executablePassthrough-mjs" node_build_esm-deno-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-executablePassthrough-mjs-node_build_esm-deno-valid_args" {
  run node ./dist/bin/knevee.js deno eval -- test/fixtures/greeting-executablePassthrough.mjs John
  save_and_compare_snapshot "greeting-executablePassthrough-mjs" node_build_esm-deno-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-mjs-node_build_esm-tsx-help" {
  run node ./dist/bin/knevee.js tsx -e -- test/fixtures/greeting-executablePassthrough.mjs --help
  save_and_compare_snapshot "greeting-executablePassthrough-mjs" node_build_esm-tsx-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-mjs-node_build_esm-tsx-missing_args" {
  run node ./dist/bin/knevee.js tsx -e -- test/fixtures/greeting-executablePassthrough.mjs
  save_and_compare_snapshot "greeting-executablePassthrough-mjs" node_build_esm-tsx-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-executablePassthrough-mjs-node_build_esm-tsx-valid_args" {
  run node ./dist/bin/knevee.js tsx -e -- test/fixtures/greeting-executablePassthrough.mjs John
  save_and_compare_snapshot "greeting-executablePassthrough-mjs" node_build_esm-tsx-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-mjs-node_build_esm-node-help" {
  run node ./dist/bin/knevee.js node -e -- test/fixtures/greeting-executablePassthrough.mjs --help
  save_and_compare_snapshot "greeting-executablePassthrough-mjs" node_build_esm-node-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-mjs-node_build_esm-node-missing_args" {
  run node ./dist/bin/knevee.js node -e -- test/fixtures/greeting-executablePassthrough.mjs
  save_and_compare_snapshot "greeting-executablePassthrough-mjs" node_build_esm-node-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-executablePassthrough-mjs-node_build_esm-node-valid_args" {
  run node ./dist/bin/knevee.js node -e -- test/fixtures/greeting-executablePassthrough.mjs John
  save_and_compare_snapshot "greeting-executablePassthrough-mjs" node_build_esm-node-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-cjs-deno-default-help" {
  run deno run -A ./src/bin/knevee.ts test/fixtures/greeting-executablePassthrough.cjs --help
  save_and_compare_snapshot "greeting-executablePassthrough-cjs" deno-default-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-cjs-deno-default-missing_args" {
  run deno run -A ./src/bin/knevee.ts test/fixtures/greeting-executablePassthrough.cjs
  save_and_compare_snapshot "greeting-executablePassthrough-cjs" deno-default-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-executablePassthrough-cjs-deno-default-valid_args" {
  run deno run -A ./src/bin/knevee.ts test/fixtures/greeting-executablePassthrough.cjs John
  save_and_compare_snapshot "greeting-executablePassthrough-cjs" deno-default-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-cjs-deno-deno-help" {
  run deno run -A ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-executablePassthrough.cjs --help
  save_and_compare_snapshot "greeting-executablePassthrough-cjs" deno-deno-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-cjs-deno-deno-missing_args" {
  run deno run -A ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-executablePassthrough.cjs
  save_and_compare_snapshot "greeting-executablePassthrough-cjs" deno-deno-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-executablePassthrough-cjs-deno-deno-valid_args" {
  run deno run -A ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-executablePassthrough.cjs John
  save_and_compare_snapshot "greeting-executablePassthrough-cjs" deno-deno-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-cjs-deno-tsx-help" {
  run deno run -A ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-executablePassthrough.cjs --help
  save_and_compare_snapshot "greeting-executablePassthrough-cjs" deno-tsx-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-cjs-deno-tsx-missing_args" {
  run deno run -A ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-executablePassthrough.cjs
  save_and_compare_snapshot "greeting-executablePassthrough-cjs" deno-tsx-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-executablePassthrough-cjs-deno-tsx-valid_args" {
  run deno run -A ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-executablePassthrough.cjs John
  save_and_compare_snapshot "greeting-executablePassthrough-cjs" deno-tsx-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-cjs-deno-node-help" {
  run deno run -A ./src/bin/knevee.ts node -e -- test/fixtures/greeting-executablePassthrough.cjs --help
  save_and_compare_snapshot "greeting-executablePassthrough-cjs" deno-node-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-cjs-deno-node-missing_args" {
  run deno run -A ./src/bin/knevee.ts node -e -- test/fixtures/greeting-executablePassthrough.cjs
  save_and_compare_snapshot "greeting-executablePassthrough-cjs" deno-node-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-executablePassthrough-cjs-deno-node-valid_args" {
  run deno run -A ./src/bin/knevee.ts node -e -- test/fixtures/greeting-executablePassthrough.cjs John
  save_and_compare_snapshot "greeting-executablePassthrough-cjs" deno-node-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-cjs-tsx-default-help" {
  run tsx ./src/bin/knevee.ts test/fixtures/greeting-executablePassthrough.cjs --help
  save_and_compare_snapshot "greeting-executablePassthrough-cjs" tsx-default-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-cjs-tsx-default-missing_args" {
  run tsx ./src/bin/knevee.ts test/fixtures/greeting-executablePassthrough.cjs
  save_and_compare_snapshot "greeting-executablePassthrough-cjs" tsx-default-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-executablePassthrough-cjs-tsx-default-valid_args" {
  run tsx ./src/bin/knevee.ts test/fixtures/greeting-executablePassthrough.cjs John
  save_and_compare_snapshot "greeting-executablePassthrough-cjs" tsx-default-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-cjs-tsx-deno-help" {
  run tsx ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-executablePassthrough.cjs --help
  save_and_compare_snapshot "greeting-executablePassthrough-cjs" tsx-deno-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-cjs-tsx-deno-missing_args" {
  run tsx ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-executablePassthrough.cjs
  save_and_compare_snapshot "greeting-executablePassthrough-cjs" tsx-deno-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-executablePassthrough-cjs-tsx-deno-valid_args" {
  run tsx ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-executablePassthrough.cjs John
  save_and_compare_snapshot "greeting-executablePassthrough-cjs" tsx-deno-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-cjs-tsx-tsx-help" {
  run tsx ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-executablePassthrough.cjs --help
  save_and_compare_snapshot "greeting-executablePassthrough-cjs" tsx-tsx-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-cjs-tsx-tsx-missing_args" {
  run tsx ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-executablePassthrough.cjs
  save_and_compare_snapshot "greeting-executablePassthrough-cjs" tsx-tsx-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-executablePassthrough-cjs-tsx-tsx-valid_args" {
  run tsx ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-executablePassthrough.cjs John
  save_and_compare_snapshot "greeting-executablePassthrough-cjs" tsx-tsx-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-cjs-tsx-node-help" {
  run tsx ./src/bin/knevee.ts node -e -- test/fixtures/greeting-executablePassthrough.cjs --help
  save_and_compare_snapshot "greeting-executablePassthrough-cjs" tsx-node-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-cjs-tsx-node-missing_args" {
  run tsx ./src/bin/knevee.ts node -e -- test/fixtures/greeting-executablePassthrough.cjs
  save_and_compare_snapshot "greeting-executablePassthrough-cjs" tsx-node-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-executablePassthrough-cjs-tsx-node-valid_args" {
  run tsx ./src/bin/knevee.ts node -e -- test/fixtures/greeting-executablePassthrough.cjs John
  save_and_compare_snapshot "greeting-executablePassthrough-cjs" tsx-node-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-cjs-node_build_cjs-default-help" {
  run node ./dist/bin/knevee.cjs test/fixtures/greeting-executablePassthrough.cjs --help
  save_and_compare_snapshot "greeting-executablePassthrough-cjs" node_build_cjs-default-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-cjs-node_build_cjs-default-missing_args" {
  run node ./dist/bin/knevee.cjs test/fixtures/greeting-executablePassthrough.cjs
  save_and_compare_snapshot "greeting-executablePassthrough-cjs" node_build_cjs-default-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-executablePassthrough-cjs-node_build_cjs-default-valid_args" {
  run node ./dist/bin/knevee.cjs test/fixtures/greeting-executablePassthrough.cjs John
  save_and_compare_snapshot "greeting-executablePassthrough-cjs" node_build_cjs-default-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-cjs-node_build_cjs-deno-help" {
  run node ./dist/bin/knevee.cjs deno eval -- test/fixtures/greeting-executablePassthrough.cjs --help
  save_and_compare_snapshot "greeting-executablePassthrough-cjs" node_build_cjs-deno-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-cjs-node_build_cjs-deno-missing_args" {
  run node ./dist/bin/knevee.cjs deno eval -- test/fixtures/greeting-executablePassthrough.cjs
  save_and_compare_snapshot "greeting-executablePassthrough-cjs" node_build_cjs-deno-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-executablePassthrough-cjs-node_build_cjs-deno-valid_args" {
  run node ./dist/bin/knevee.cjs deno eval -- test/fixtures/greeting-executablePassthrough.cjs John
  save_and_compare_snapshot "greeting-executablePassthrough-cjs" node_build_cjs-deno-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-cjs-node_build_cjs-tsx-help" {
  run node ./dist/bin/knevee.cjs tsx -e -- test/fixtures/greeting-executablePassthrough.cjs --help
  save_and_compare_snapshot "greeting-executablePassthrough-cjs" node_build_cjs-tsx-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-cjs-node_build_cjs-tsx-missing_args" {
  run node ./dist/bin/knevee.cjs tsx -e -- test/fixtures/greeting-executablePassthrough.cjs
  save_and_compare_snapshot "greeting-executablePassthrough-cjs" node_build_cjs-tsx-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-executablePassthrough-cjs-node_build_cjs-tsx-valid_args" {
  run node ./dist/bin/knevee.cjs tsx -e -- test/fixtures/greeting-executablePassthrough.cjs John
  save_and_compare_snapshot "greeting-executablePassthrough-cjs" node_build_cjs-tsx-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-cjs-node_build_cjs-node-help" {
  run node ./dist/bin/knevee.cjs node -e -- test/fixtures/greeting-executablePassthrough.cjs --help
  save_and_compare_snapshot "greeting-executablePassthrough-cjs" node_build_cjs-node-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-executablePassthrough-cjs-node_build_cjs-node-missing_args" {
  run node ./dist/bin/knevee.cjs node -e -- test/fixtures/greeting-executablePassthrough.cjs
  save_and_compare_snapshot "greeting-executablePassthrough-cjs" node_build_cjs-node-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-executablePassthrough-cjs-node_build_cjs-node-valid_args" {
  run node ./dist/bin/knevee.cjs node -e -- test/fixtures/greeting-executablePassthrough.cjs John
  save_and_compare_snapshot "greeting-executablePassthrough-cjs" node_build_cjs-node-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-ts-c8-default-help" {
  run npx -s c8 --reporter=none --clean=false tsx ./src/bin/knevee.ts test/fixtures/greeting-export.ts --help
  save_and_compare_snapshot "greeting-export-ts" c8-default-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-ts-c8-default-missing_args" {
  run npx -s c8 --reporter=none --clean=false tsx ./src/bin/knevee.ts test/fixtures/greeting-export.ts
  save_and_compare_snapshot "greeting-export-ts" c8-default-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-ts-c8-default-valid_args" {
  run npx -s c8 --reporter=none --clean=false tsx ./src/bin/knevee.ts test/fixtures/greeting-export.ts John
  save_and_compare_snapshot "greeting-export-ts" c8-default-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-ts-c8-deno-help" {
  run npx -s c8 --reporter=none --clean=false tsx ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-export.ts --help
  save_and_compare_snapshot "greeting-export-ts" c8-deno-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-ts-c8-deno-missing_args" {
  run npx -s c8 --reporter=none --clean=false tsx ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-export.ts
  save_and_compare_snapshot "greeting-export-ts" c8-deno-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-ts-c8-deno-valid_args" {
  run npx -s c8 --reporter=none --clean=false tsx ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-export.ts John
  save_and_compare_snapshot "greeting-export-ts" c8-deno-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-ts-c8-tsx-help" {
  run npx -s c8 --reporter=none --clean=false tsx ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-export.ts --help
  save_and_compare_snapshot "greeting-export-ts" c8-tsx-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-ts-c8-tsx-missing_args" {
  run npx -s c8 --reporter=none --clean=false tsx ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-export.ts
  save_and_compare_snapshot "greeting-export-ts" c8-tsx-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-ts-c8-tsx-valid_args" {
  run npx -s c8 --reporter=none --clean=false tsx ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-export.ts John
  save_and_compare_snapshot "greeting-export-ts" c8-tsx-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-ts-c8-node_ts-help" {
  run npx -s c8 --reporter=none --clean=false tsx ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/greeting-export.ts --help
  save_and_compare_snapshot "greeting-export-ts" c8-node_ts-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-ts-c8-node_ts-missing_args" {
  run npx -s c8 --reporter=none --clean=false tsx ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/greeting-export.ts
  save_and_compare_snapshot "greeting-export-ts" c8-node_ts-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-ts-c8-node_ts-valid_args" {
  run npx -s c8 --reporter=none --clean=false tsx ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/greeting-export.ts John
  save_and_compare_snapshot "greeting-export-ts" c8-node_ts-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-ts-deno-default-help" {
  run deno run -A ./src/bin/knevee.ts test/fixtures/greeting-export.ts --help
  save_and_compare_snapshot "greeting-export-ts" deno-default-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-ts-deno-default-missing_args" {
  run deno run -A ./src/bin/knevee.ts test/fixtures/greeting-export.ts
  save_and_compare_snapshot "greeting-export-ts" deno-default-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-ts-deno-default-valid_args" {
  run deno run -A ./src/bin/knevee.ts test/fixtures/greeting-export.ts John
  save_and_compare_snapshot "greeting-export-ts" deno-default-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-ts-deno-deno-help" {
  run deno run -A ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-export.ts --help
  save_and_compare_snapshot "greeting-export-ts" deno-deno-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-ts-deno-deno-missing_args" {
  run deno run -A ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-export.ts
  save_and_compare_snapshot "greeting-export-ts" deno-deno-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-ts-deno-deno-valid_args" {
  run deno run -A ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-export.ts John
  save_and_compare_snapshot "greeting-export-ts" deno-deno-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-ts-deno-tsx-help" {
  run deno run -A ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-export.ts --help
  save_and_compare_snapshot "greeting-export-ts" deno-tsx-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-ts-deno-tsx-missing_args" {
  run deno run -A ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-export.ts
  save_and_compare_snapshot "greeting-export-ts" deno-tsx-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-ts-deno-tsx-valid_args" {
  run deno run -A ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-export.ts John
  save_and_compare_snapshot "greeting-export-ts" deno-tsx-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-ts-deno-node_ts-help" {
  run deno run -A ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/greeting-export.ts --help
  save_and_compare_snapshot "greeting-export-ts" deno-node_ts-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-ts-deno-node_ts-missing_args" {
  run deno run -A ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/greeting-export.ts
  save_and_compare_snapshot "greeting-export-ts" deno-node_ts-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-ts-deno-node_ts-valid_args" {
  run deno run -A ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/greeting-export.ts John
  save_and_compare_snapshot "greeting-export-ts" deno-node_ts-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-ts-node_ts-default-help" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts test/fixtures/greeting-export.ts --help
  save_and_compare_snapshot "greeting-export-ts" node_ts-default-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-ts-node_ts-default-missing_args" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts test/fixtures/greeting-export.ts
  save_and_compare_snapshot "greeting-export-ts" node_ts-default-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-ts-node_ts-default-valid_args" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts test/fixtures/greeting-export.ts John
  save_and_compare_snapshot "greeting-export-ts" node_ts-default-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-ts-node_ts-deno-help" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-export.ts --help
  save_and_compare_snapshot "greeting-export-ts" node_ts-deno-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-ts-node_ts-deno-missing_args" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-export.ts
  save_and_compare_snapshot "greeting-export-ts" node_ts-deno-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-ts-node_ts-deno-valid_args" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-export.ts John
  save_and_compare_snapshot "greeting-export-ts" node_ts-deno-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-ts-node_ts-tsx-help" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-export.ts --help
  save_and_compare_snapshot "greeting-export-ts" node_ts-tsx-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-ts-node_ts-tsx-missing_args" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-export.ts
  save_and_compare_snapshot "greeting-export-ts" node_ts-tsx-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-ts-node_ts-tsx-valid_args" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-export.ts John
  save_and_compare_snapshot "greeting-export-ts" node_ts-tsx-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-ts-node_ts-node_ts-help" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/greeting-export.ts --help
  save_and_compare_snapshot "greeting-export-ts" node_ts-node_ts-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-ts-node_ts-node_ts-missing_args" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/greeting-export.ts
  save_and_compare_snapshot "greeting-export-ts" node_ts-node_ts-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-ts-node_ts-node_ts-valid_args" {
  run node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin/knevee.ts node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -e -- test/fixtures/greeting-export.ts John
  save_and_compare_snapshot "greeting-export-ts" node_ts-node_ts-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-mjs-deno-default-help" {
  run deno run -A ./src/bin/knevee.ts test/fixtures/greeting-export.mjs --help
  save_and_compare_snapshot "greeting-export-mjs" deno-default-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-mjs-deno-default-missing_args" {
  run deno run -A ./src/bin/knevee.ts test/fixtures/greeting-export.mjs
  save_and_compare_snapshot "greeting-export-mjs" deno-default-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-mjs-deno-default-valid_args" {
  run deno run -A ./src/bin/knevee.ts test/fixtures/greeting-export.mjs John
  save_and_compare_snapshot "greeting-export-mjs" deno-default-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-mjs-deno-deno-help" {
  run deno run -A ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-export.mjs --help
  save_and_compare_snapshot "greeting-export-mjs" deno-deno-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-mjs-deno-deno-missing_args" {
  run deno run -A ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-export.mjs
  save_and_compare_snapshot "greeting-export-mjs" deno-deno-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-mjs-deno-deno-valid_args" {
  run deno run -A ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-export.mjs John
  save_and_compare_snapshot "greeting-export-mjs" deno-deno-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-mjs-deno-tsx-help" {
  run deno run -A ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-export.mjs --help
  save_and_compare_snapshot "greeting-export-mjs" deno-tsx-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-mjs-deno-tsx-missing_args" {
  run deno run -A ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-export.mjs
  save_and_compare_snapshot "greeting-export-mjs" deno-tsx-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-mjs-deno-tsx-valid_args" {
  run deno run -A ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-export.mjs John
  save_and_compare_snapshot "greeting-export-mjs" deno-tsx-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-mjs-deno-node-help" {
  run deno run -A ./src/bin/knevee.ts node -e -- test/fixtures/greeting-export.mjs --help
  save_and_compare_snapshot "greeting-export-mjs" deno-node-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-mjs-deno-node-missing_args" {
  run deno run -A ./src/bin/knevee.ts node -e -- test/fixtures/greeting-export.mjs
  save_and_compare_snapshot "greeting-export-mjs" deno-node-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-mjs-deno-node-valid_args" {
  run deno run -A ./src/bin/knevee.ts node -e -- test/fixtures/greeting-export.mjs John
  save_and_compare_snapshot "greeting-export-mjs" deno-node-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-mjs-tsx-default-help" {
  run tsx ./src/bin/knevee.ts test/fixtures/greeting-export.mjs --help
  save_and_compare_snapshot "greeting-export-mjs" tsx-default-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-mjs-tsx-default-missing_args" {
  run tsx ./src/bin/knevee.ts test/fixtures/greeting-export.mjs
  save_and_compare_snapshot "greeting-export-mjs" tsx-default-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-mjs-tsx-default-valid_args" {
  run tsx ./src/bin/knevee.ts test/fixtures/greeting-export.mjs John
  save_and_compare_snapshot "greeting-export-mjs" tsx-default-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-mjs-tsx-deno-help" {
  run tsx ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-export.mjs --help
  save_and_compare_snapshot "greeting-export-mjs" tsx-deno-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-mjs-tsx-deno-missing_args" {
  run tsx ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-export.mjs
  save_and_compare_snapshot "greeting-export-mjs" tsx-deno-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-mjs-tsx-deno-valid_args" {
  run tsx ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-export.mjs John
  save_and_compare_snapshot "greeting-export-mjs" tsx-deno-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-mjs-tsx-tsx-help" {
  run tsx ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-export.mjs --help
  save_and_compare_snapshot "greeting-export-mjs" tsx-tsx-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-mjs-tsx-tsx-missing_args" {
  run tsx ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-export.mjs
  save_and_compare_snapshot "greeting-export-mjs" tsx-tsx-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-mjs-tsx-tsx-valid_args" {
  run tsx ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-export.mjs John
  save_and_compare_snapshot "greeting-export-mjs" tsx-tsx-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-mjs-tsx-node-help" {
  run tsx ./src/bin/knevee.ts node -e -- test/fixtures/greeting-export.mjs --help
  save_and_compare_snapshot "greeting-export-mjs" tsx-node-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-mjs-tsx-node-missing_args" {
  run tsx ./src/bin/knevee.ts node -e -- test/fixtures/greeting-export.mjs
  save_and_compare_snapshot "greeting-export-mjs" tsx-node-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-mjs-tsx-node-valid_args" {
  run tsx ./src/bin/knevee.ts node -e -- test/fixtures/greeting-export.mjs John
  save_and_compare_snapshot "greeting-export-mjs" tsx-node-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-mjs-node_build_esm-default-help" {
  run node ./dist/bin/knevee.js test/fixtures/greeting-export.mjs --help
  save_and_compare_snapshot "greeting-export-mjs" node_build_esm-default-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-mjs-node_build_esm-default-missing_args" {
  run node ./dist/bin/knevee.js test/fixtures/greeting-export.mjs
  save_and_compare_snapshot "greeting-export-mjs" node_build_esm-default-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-mjs-node_build_esm-default-valid_args" {
  run node ./dist/bin/knevee.js test/fixtures/greeting-export.mjs John
  save_and_compare_snapshot "greeting-export-mjs" node_build_esm-default-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-mjs-node_build_esm-deno-help" {
  run node ./dist/bin/knevee.js deno eval -- test/fixtures/greeting-export.mjs --help
  save_and_compare_snapshot "greeting-export-mjs" node_build_esm-deno-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-mjs-node_build_esm-deno-missing_args" {
  run node ./dist/bin/knevee.js deno eval -- test/fixtures/greeting-export.mjs
  save_and_compare_snapshot "greeting-export-mjs" node_build_esm-deno-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-mjs-node_build_esm-deno-valid_args" {
  run node ./dist/bin/knevee.js deno eval -- test/fixtures/greeting-export.mjs John
  save_and_compare_snapshot "greeting-export-mjs" node_build_esm-deno-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-mjs-node_build_esm-tsx-help" {
  run node ./dist/bin/knevee.js tsx -e -- test/fixtures/greeting-export.mjs --help
  save_and_compare_snapshot "greeting-export-mjs" node_build_esm-tsx-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-mjs-node_build_esm-tsx-missing_args" {
  run node ./dist/bin/knevee.js tsx -e -- test/fixtures/greeting-export.mjs
  save_and_compare_snapshot "greeting-export-mjs" node_build_esm-tsx-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-mjs-node_build_esm-tsx-valid_args" {
  run node ./dist/bin/knevee.js tsx -e -- test/fixtures/greeting-export.mjs John
  save_and_compare_snapshot "greeting-export-mjs" node_build_esm-tsx-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-mjs-node_build_esm-node-help" {
  run node ./dist/bin/knevee.js node -e -- test/fixtures/greeting-export.mjs --help
  save_and_compare_snapshot "greeting-export-mjs" node_build_esm-node-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-mjs-node_build_esm-node-missing_args" {
  run node ./dist/bin/knevee.js node -e -- test/fixtures/greeting-export.mjs
  save_and_compare_snapshot "greeting-export-mjs" node_build_esm-node-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-mjs-node_build_esm-node-valid_args" {
  run node ./dist/bin/knevee.js node -e -- test/fixtures/greeting-export.mjs John
  save_and_compare_snapshot "greeting-export-mjs" node_build_esm-node-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-cjs-deno-default-help" {
  run deno run -A ./src/bin/knevee.ts test/fixtures/greeting-export.cjs --help
  save_and_compare_snapshot "greeting-export-cjs" deno-default-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-cjs-deno-default-missing_args" {
  run deno run -A ./src/bin/knevee.ts test/fixtures/greeting-export.cjs
  save_and_compare_snapshot "greeting-export-cjs" deno-default-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-cjs-deno-default-valid_args" {
  run deno run -A ./src/bin/knevee.ts test/fixtures/greeting-export.cjs John
  save_and_compare_snapshot "greeting-export-cjs" deno-default-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-cjs-deno-deno-help" {
  run deno run -A ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-export.cjs --help
  save_and_compare_snapshot "greeting-export-cjs" deno-deno-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-cjs-deno-deno-missing_args" {
  run deno run -A ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-export.cjs
  save_and_compare_snapshot "greeting-export-cjs" deno-deno-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-cjs-deno-deno-valid_args" {
  run deno run -A ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-export.cjs John
  save_and_compare_snapshot "greeting-export-cjs" deno-deno-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-cjs-deno-tsx-help" {
  run deno run -A ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-export.cjs --help
  save_and_compare_snapshot "greeting-export-cjs" deno-tsx-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-cjs-deno-tsx-missing_args" {
  run deno run -A ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-export.cjs
  save_and_compare_snapshot "greeting-export-cjs" deno-tsx-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-cjs-deno-tsx-valid_args" {
  run deno run -A ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-export.cjs John
  save_and_compare_snapshot "greeting-export-cjs" deno-tsx-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-cjs-deno-node-help" {
  run deno run -A ./src/bin/knevee.ts node -e -- test/fixtures/greeting-export.cjs --help
  save_and_compare_snapshot "greeting-export-cjs" deno-node-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-cjs-deno-node-missing_args" {
  run deno run -A ./src/bin/knevee.ts node -e -- test/fixtures/greeting-export.cjs
  save_and_compare_snapshot "greeting-export-cjs" deno-node-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-cjs-deno-node-valid_args" {
  run deno run -A ./src/bin/knevee.ts node -e -- test/fixtures/greeting-export.cjs John
  save_and_compare_snapshot "greeting-export-cjs" deno-node-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-cjs-tsx-default-help" {
  run tsx ./src/bin/knevee.ts test/fixtures/greeting-export.cjs --help
  save_and_compare_snapshot "greeting-export-cjs" tsx-default-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-cjs-tsx-default-missing_args" {
  run tsx ./src/bin/knevee.ts test/fixtures/greeting-export.cjs
  save_and_compare_snapshot "greeting-export-cjs" tsx-default-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-cjs-tsx-default-valid_args" {
  run tsx ./src/bin/knevee.ts test/fixtures/greeting-export.cjs John
  save_and_compare_snapshot "greeting-export-cjs" tsx-default-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-cjs-tsx-deno-help" {
  run tsx ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-export.cjs --help
  save_and_compare_snapshot "greeting-export-cjs" tsx-deno-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-cjs-tsx-deno-missing_args" {
  run tsx ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-export.cjs
  save_and_compare_snapshot "greeting-export-cjs" tsx-deno-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-cjs-tsx-deno-valid_args" {
  run tsx ./src/bin/knevee.ts deno eval -- test/fixtures/greeting-export.cjs John
  save_and_compare_snapshot "greeting-export-cjs" tsx-deno-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-cjs-tsx-tsx-help" {
  run tsx ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-export.cjs --help
  save_and_compare_snapshot "greeting-export-cjs" tsx-tsx-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-cjs-tsx-tsx-missing_args" {
  run tsx ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-export.cjs
  save_and_compare_snapshot "greeting-export-cjs" tsx-tsx-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-cjs-tsx-tsx-valid_args" {
  run tsx ./src/bin/knevee.ts tsx -e -- test/fixtures/greeting-export.cjs John
  save_and_compare_snapshot "greeting-export-cjs" tsx-tsx-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-cjs-tsx-node-help" {
  run tsx ./src/bin/knevee.ts node -e -- test/fixtures/greeting-export.cjs --help
  save_and_compare_snapshot "greeting-export-cjs" tsx-node-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-cjs-tsx-node-missing_args" {
  run tsx ./src/bin/knevee.ts node -e -- test/fixtures/greeting-export.cjs
  save_and_compare_snapshot "greeting-export-cjs" tsx-node-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-cjs-tsx-node-valid_args" {
  run tsx ./src/bin/knevee.ts node -e -- test/fixtures/greeting-export.cjs John
  save_and_compare_snapshot "greeting-export-cjs" tsx-node-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-cjs-node_build_cjs-default-help" {
  run node ./dist/bin/knevee.cjs test/fixtures/greeting-export.cjs --help
  save_and_compare_snapshot "greeting-export-cjs" node_build_cjs-default-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-cjs-node_build_cjs-default-missing_args" {
  run node ./dist/bin/knevee.cjs test/fixtures/greeting-export.cjs
  save_and_compare_snapshot "greeting-export-cjs" node_build_cjs-default-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-cjs-node_build_cjs-default-valid_args" {
  run node ./dist/bin/knevee.cjs test/fixtures/greeting-export.cjs John
  save_and_compare_snapshot "greeting-export-cjs" node_build_cjs-default-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-cjs-node_build_cjs-deno-help" {
  run node ./dist/bin/knevee.cjs deno eval -- test/fixtures/greeting-export.cjs --help
  save_and_compare_snapshot "greeting-export-cjs" node_build_cjs-deno-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-cjs-node_build_cjs-deno-missing_args" {
  run node ./dist/bin/knevee.cjs deno eval -- test/fixtures/greeting-export.cjs
  save_and_compare_snapshot "greeting-export-cjs" node_build_cjs-deno-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-cjs-node_build_cjs-deno-valid_args" {
  run node ./dist/bin/knevee.cjs deno eval -- test/fixtures/greeting-export.cjs John
  save_and_compare_snapshot "greeting-export-cjs" node_build_cjs-deno-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-cjs-node_build_cjs-tsx-help" {
  run node ./dist/bin/knevee.cjs tsx -e -- test/fixtures/greeting-export.cjs --help
  save_and_compare_snapshot "greeting-export-cjs" node_build_cjs-tsx-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-cjs-node_build_cjs-tsx-missing_args" {
  run node ./dist/bin/knevee.cjs tsx -e -- test/fixtures/greeting-export.cjs
  save_and_compare_snapshot "greeting-export-cjs" node_build_cjs-tsx-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-cjs-node_build_cjs-tsx-valid_args" {
  run node ./dist/bin/knevee.cjs tsx -e -- test/fixtures/greeting-export.cjs John
  save_and_compare_snapshot "greeting-export-cjs" node_build_cjs-tsx-valid_args "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-cjs-node_build_cjs-node-help" {
  run node ./dist/bin/knevee.cjs node -e -- test/fixtures/greeting-export.cjs --help
  save_and_compare_snapshot "greeting-export-cjs" node_build_cjs-node-help "$output"
  [ "$status" -eq 0 ]
}

@test "greeting-export-cjs-node_build_cjs-node-missing_args" {
  run node ./dist/bin/knevee.cjs node -e -- test/fixtures/greeting-export.cjs
  save_and_compare_snapshot "greeting-export-cjs" node_build_cjs-node-missing_args "$output"
  [ "$status" -eq 1 ]
}

@test "greeting-export-cjs-node_build_cjs-node-valid_args" {
  run node ./dist/bin/knevee.cjs node -e -- test/fixtures/greeting-export.cjs John
  save_and_compare_snapshot "greeting-export-cjs" node_build_cjs-node-valid_args "$output"
  [ "$status" -eq 0 ]
}
