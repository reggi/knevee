#!/usr/bin/env tsx ./src/bin/knevee.ts
import test from 'node:test'
import {executablePassthrough} from '../src/index.ts'

const prefix = `
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
`

function generateBatsTest(opts) {
  const {command, exitcode, folder, testName} = opts
  const escapedCommand = command.replace(/\$/g, '\\$')
  return `
@test "${folder}-${testName}" {
  run ${escapedCommand}
  save_and_compare_snapshot "${folder}" ${testName} "$output"
  [ "$status" -eq ${exitcode} ]
}
`.trim()
}

const handle = async (json: string) => {
  const file = JSON.parse(json)
  const results: any[] = [prefix]

  const {
    profiles: globalProfiles,
    fixtures: globalFixtures,
    runtimes: globalRuntimes,
    executables: globalExecutables,
  } = file

  for (let [fixtureKey, fixtureValue] of Object.entries(globalFixtures)) {
    const {tests, profiles} = fixtureValue as any

    for (const [profileKey, path] of Object.entries(profiles)) {
      const profile = globalProfiles[profileKey]
      const {executables, runtimes} = profile as any
      for (const executableKey in executables) {
        const executableId = executables[executableKey]
        const executableValue = globalExecutables[executableId]
        for (const runtimeKey in runtimes) {
          const runtimeId = runtimes[runtimeKey]
          const runtimeValue = globalRuntimes[runtimeId]
          for (const [testKey, testValue] of Object.entries(tests)) {
            const [exitcode, ...args] = testValue as any
            const command = [executableValue, runtimeValue, path, ...args].filter(Boolean).join(' ')
            const folder = [fixtureKey, profileKey].join('-')
            const testName = [executableId, runtimeId, testKey].join('-')
            results.push(generateBatsTest({command, exitcode, folder, testName}))
          }
        }
      }
    }
  }
  return results.join('\n\n')
}

export const command = executablePassthrough({
  filename: import.meta.filename,
  name: 'batgen',
  description: 'Builds the bat test file.',
  stdin: true,
  positionals: '<json>',
  output: 'log',
  default: handle,
})

// for (const [executableKey, executableValue] of Object.entries(file.executables)) {
//   for (const [fixtureKey, fixtureValue] of Object.entries(file.fixtures)) {
//     for (const [testKey, testValue] of Object.entries((fixtureValue as any).tests)) {
//       const [exitcode, ...args] = (testValue as any)
//       const id = `${executableKey}-${fixtureKey}-${testKey}`
//       const command = [executableValue, (fixtureValue as any).path, ...args].join(' ')
//       tests.push(generateBatsTest({command, exitcode, id}))
//     }
//   }
// }
