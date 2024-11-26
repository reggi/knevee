import {describe, it} from 'node:test'
import assert from 'node:assert'
import {fixArgv} from '../../src/utils/fix-argv.ts'

describe('fixArgv', () => {
  it('should correctly parse arguments with single quotes', () => {
    const argv = ['--runtime="node', '-e"', './some-script.js']
    const result = fixArgv(argv)
    assert.deepStrictEqual(result, ['--runtime="node -e"', './some-script.js'])
  })

  it('should correctly dangle', () => {
    const argv = ['--runtime="node']
    const result = fixArgv(argv)
    assert.deepStrictEqual(result, ['--runtime="node'])
  })

  it('should correctly parse arguments with quotes', () => {
    const argv = [`--runtime='node`, `-e'`, './some-script.js']
    const result = fixArgv(argv)
    assert.deepStrictEqual(result, [`--runtime='node -e'`, './some-script.js'])
  })

  it('should handle regular arguments without quotes', () => {
    const argv = ['--port=3000', '--verbose', './script.js']
    const result = fixArgv(argv)
    assert.deepStrictEqual(result, ['--port=3000', '--verbose', './script.js'])
  })

  it('should handle mixed quoted and regular arguments', () => {
    const argv = ['--name="John Doe"', '--age=30', 'start', '--config="debug true"']
    const result = fixArgv(argv)
    assert.deepStrictEqual(result, ['--name="John Doe"', '--age=30', 'start', '--config="debug true"'])
  })

  it('should handle arguments that include spaces within quotes', () => {
    const argv = ['--message="Hello', 'world!"', 'run']
    const result = fixArgv(argv)
    assert.deepStrictEqual(result, ['--message="Hello world!"', 'run'])
  })
})
