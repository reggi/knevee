#!/usr/bin/env tsx ./src/bin/knevee.ts
import {executablePassthrough} from '../src/index.ts'
import fs from 'node:fs/promises'
import nodePath from 'node:path'

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
`.trim()

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

  await fs.mkdir('./test/batgen/', { recursive: true })

  type Fixture = {
    tests: { [key: string]: [number, ...string[]] };
    profiles: {
      profile: string;
      path: string
    }[]
  }
  const file = JSON.parse(json) as {
    profiles: { [key: string]: {
      runtimes: string[];
      executables: string[];
    } };
    fixtures: Fixture[];
    runtimes: { [key: string]: string };
    executables: { [key: string]: string };
  };

  const getProfile = (profile: string) => {
    const result = file.profiles[profile]
    const runtimes = getRuntimes(result.runtimes)
    const executables = getExecutables(result.executables)
    return { runtimes, executables }
  }

  const getExecutable = (executable: string) => {
    return file.executables[executable]
  }

  const getExecutables = (executable: string[]) => {
    return executable.map(key => {
      return { key, value: getExecutable(key) }
    })
  }

  const getRuntime = (runtime: string) => {
    return file.runtimes[runtime]
  }

  const getRuntimes = (runtimes: string[]) => {
    return runtimes.map(key => {
      return { key, value: getRuntime(key) }
    })
  }

  const getTest = (opt: {
    id: string,
    path: string,
    tests: { key: string, value: [number, ...string[]] }[],
    executables: {key: string, value: string}[],
    runtimes: {key: string, value: string}[],
  }) => {
    const { id, path, tests, executables, runtimes } = opt;
    return executables.map(executable => {
      return runtimes.map(runtime => {
        return tests.map(test => {
          const [exitcode, ...args] = test.value;
          const command = [executable.value, runtime.value, path, ...args].filter(Boolean).join(' ');
          const testName = [executable.key, runtime.key, test.key].join('-');
          const bat = generateBatsTest({ command, exitcode, folder: id, testName })
          return bat
        }).flat()
      }).flat()
    }).flat()
  }

  const getFixture = (fixture: Fixture) => {
    const { tests, profiles } = fixture;
    return profiles.map(v => {
      const profile = getProfile(v.profile)
      const basename = nodePath.basename(v.path, nodePath.extname(v.path))
      const id = `${basename}-${v.profile}`
      const reformatTests = Object.entries(tests).map(([key, value]) => ({key, value}))
      const saveLocation = nodePath.join('./test/batgen/', `${id}.bats`)
      const bats = getTest({
        id,
        path: v.path,
        tests: reformatTests,
        executables: profile.executables,
        runtimes: profile.runtimes,
      })
      return { ...v, tests, ...profile, basename, id, bats, saveLocation }
    })
  }

  const getFixtures = (fixtures: Fixture[]) => {
    return fixtures.map(getFixture).flat()
  }

  const fixtures = getFixtures(file.fixtures)

  await Promise.all(fixtures.map(async fixture => {
    const { saveLocation, bats } = fixture
    bats.unshift(prefix)
    await fs.writeFile(saveLocation, bats.join('\n\n'));
  }))
}

export const command = executablePassthrough({
  filename: import.meta.filename,
  name: 'batgen',
  description: 'Builds the bat test file.',
  stdin: true,
  positionals: '<json>',
  output: false,
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
