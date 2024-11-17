import {describe, it, before} from 'node:test'
import {exec} from 'node:child_process'
import {promisify} from 'node:util'
import {strict as assert} from 'node:assert'
import {spawnAsync} from './fixtures/spawn.ts'

const execPromise = promisify(exec)

function withStdin(command: string, stdin: string[]) {
  return {command, stdin}
}

function removeDebugFromStdout(stdout: string) {
  return stdout
    .split('\n')
    .filter(v => !v.match(/\x1b\[[0-9;]*m/))
    .join('\n')
}

export const valid = (commands: (string | {command: string; stdin: string[]})[]) =>
  describe(`Command output consistency tests`, () => {
    const out: string[] = []
    const serialzier = {serializers: [v => v.replaceAll('\\n|\n', /\n/)]}

    before(async () => {
      await Promise.all(
        commands.map(async command => {
          const commandString = typeof command === 'string' ? command : command.command
          const stdin = typeof command === 'string' ? '' : command.stdin.join('\n')
          const {stdout, stderr} = await spawnAsync(commandString, {
            input: stdin,
            env: {
              ...process.env,
              DEBUG: 'knevee',
            },
          })
          assert.strictEqual(stderr, '', 'No errors should be present in stderr')
          const core = removeDebugFromStdout(stdout)
          out.push(core)
        }),
      )
    })

    it(`should match snapshot`, t => {
      out.forEach(value => {
        t.assert.snapshot(value, serialzier)
      })
    })

    it('all stripped outputs should be identical', () => {
      out.forEach((output, index) => {
        assert.deepStrictEqual(output, out[0])
      })
    })
  })

export const invalid = (commands: string[]) =>
  describe(`Commands throw`, () => {
    it('should throw', async () => {
      await Promise.all(
        commands.map(async command => {
          try {
            await spawnAsync(command)
            assert.fail(`Command "${command}" should have thrown an error`)
          } catch (error) {
            assert(error instanceof Error, 'An error should have been thrown')
          }
        }),
      )
    })
  })

await invalid([
  'tsx ./src/bin.ts ./examples/dep-check-invalid.ts tea 32', // dep-check
])

await valid([
  'tsx ./src/bin.ts ./examples stdin-uppercase woof',
  'tsx ./src/bin.ts ./examples/stdin-uppercase.ts woof',
  './examples/stdin-uppercase.ts woof',
])

await valid([
  withStdin('tsx ./src/bin.ts ./examples stdin-uppercase', ['meow', 'woof']),
  withStdin('tsx ./src/bin.ts ./examples/stdin-uppercase.ts', ['meow', 'woof']),
  withStdin('./examples/stdin-uppercase.ts', ['meow', 'woof']),
])

// help example
await valid(['tsx ./src/bin.ts ./examples/no-index'])

// no target
await invalid(['tsx ./src/bin.ts'])

// no command found
await invalid([`tsx ./src/bin.ts ./examples/empty-dir`])

// subcommand match
await valid([
  'tsx ./src/bin.ts ./examples/no-index',
  'tsx ./src/bin.ts ./examples/no-index xxx',
  'tsx ./src/bin.ts --cwd=examples/no-index',
  'tsx ./src/bin.ts --cwd=examples/no-index xxx',
])

// UserError
await invalid(['tsx ./src/bin.ts ./examples/throws.ts xxx 111', 'tsx ./examples/throws-functional.ts xxx 111'])

// knevee error
await invalid([`KNEVEE_THROW=true tsx ./src/bin.ts ./examples/exports.ts`])

// normal kneve error
await invalid([
  // ----- esm -----
  // command
  'tsx ./src/bin.ts ./examples command tea',
  'tsx ./src/bin.ts ./examples/command.ts tea',
  './examples/command.ts tea',
  // functional
  'tsx ./src/bin.ts ./examples functional tea',
  'tsx ./src/bin.ts ./examples/functional.ts tea',
  'tsx ./examples/functional.ts tea',
  './examples/functional.ts tea',
  // proxy
  'tsx ./src/bin.ts ./examples proxy tea',
  'tsx ./src/bin.ts ./examples/proxy.ts tea',
  './examples/proxy.ts tea',
  // exports
  'tsx ./src/bin.ts ./examples exports tea',
  'tsx ./src/bin.ts ./examples/exports.ts tea',
  './examples/exports.ts tea',
  // extra
  'tsx ./src/bin.ts ./examples tea', // index
  'tsx ./src/bin.ts ./examples/dep-check.ts tea', // dep-check
  // ----- cjs -----
  // command-cjs
  'tsx ./src/bin.ts ./examples command-cjs tea',
  'tsx ./src/bin.ts ./examples/command-cjs.cjs tea',
  './examples/command-cjs.cjs tea',
  // proxy-cjs
  'tsx ./src/bin.ts ./examples proxy-cjs tea',
  'tsx ./src/bin.ts ./examples/proxy-cjs.cjs tea',
  './examples/proxy-cjs.cjs tea',
  // exports-cjs
  'tsx ./src/bin.ts ./examples exports-cjs tea',
  'tsx ./src/bin.ts ./examples/exports-cjs.cjs tea',
  './examples/exports-cjs.cjs tea',
  // functional-cjs
  'tsx ./src/bin.ts ./examples functional-cjs tea',
  'tsx ./src/bin.ts ./examples/functional-cjs.cjs tea',
  'tsx ./examples/functional-cjs.cjs tea', // extra functional call
  './examples/functional-cjs.cjs tea',
])

await valid([
  // ----- esm -----
  // command
  'tsx ./src/bin.ts ./examples command tea 32',
  'tsx ./src/bin.ts ./examples/command.ts tea 32',
  './examples/command.ts tea 32',
  // functional
  'tsx ./src/bin.ts ./examples functional tea 32',
  'tsx ./src/bin.ts ./examples/functional.ts tea 32',
  'tsx ./examples/functional.ts tea 32',
  './examples/functional.ts tea 32',
  // proxy
  'tsx ./src/bin.ts ./examples proxy tea 32',
  'tsx ./src/bin.ts ./examples/proxy.ts tea 32',
  './examples/proxy.ts tea 32',
  // exports
  'tsx ./src/bin.ts ./examples exports tea 32',
  'tsx ./src/bin.ts ./examples/exports.ts tea 32',
  './examples/exports.ts tea 32',
  // extra
  'tsx ./src/bin.ts ./examples tea 32', // index
  'tsx ./src/bin.ts ./examples/dep-check.ts tea 32', // dep-check
  // ----- cjs -----
  // command-cjs
  'tsx ./src/bin.ts ./examples command-cjs tea 32',
  'tsx ./src/bin.ts ./examples/command-cjs.cjs tea 32',
  './examples/command-cjs.cjs tea 32',
  // proxy-cjs
  'tsx ./src/bin.ts ./examples proxy-cjs tea 32',
  'tsx ./src/bin.ts ./examples/proxy-cjs.cjs tea 32',
  './examples/proxy-cjs.cjs tea 32',
  // exports-cjs
  'tsx ./src/bin.ts ./examples exports-cjs tea 32',
  'tsx ./src/bin.ts ./examples/exports-cjs.cjs tea 32',
  './examples/exports-cjs.cjs tea 32',
  // functional-cjs
  'tsx ./src/bin.ts ./examples functional-cjs tea 32',
  'tsx ./src/bin.ts ./examples/functional-cjs.cjs tea 32',
  'tsx ./examples/functional-cjs.cjs tea 32', // extra functional call
  './examples/functional-cjs.cjs tea 32',
])
