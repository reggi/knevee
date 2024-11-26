import assert from 'node:assert'
import {describe, it} from 'node:test'
import {splitArgv} from '../../src/positional/split-argv.ts'

describe('splitArgv', () => {
  it('should split arguments by --', function () {
    const argv = ['arg1', 'arg2', '--', 'arg3', 'arg4']
    const result = splitArgv(argv)
    assert.deepStrictEqual(result, [
      ['arg1', 'arg2'],
      ['arg3', 'arg4'],
    ])
  })

  it('should handle no -- in arguments', function () {
    const argv = ['arg1', 'arg2', 'arg3']
    const result = splitArgv(argv)
    assert.deepStrictEqual(result, [['arg1', 'arg2', 'arg3']])
  })

  it('should split arguments by -- multiple times', function () {
    const argv = ['arg1', '--', 'arg2', '--', 'arg3']
    const result = splitArgv(argv, 2)
    assert.deepStrictEqual(result, [['arg1'], ['arg2'], ['arg3']])
  })

  it('should handle splitCount greater than number of --', function () {
    const argv = ['arg1', '--', 'arg2']
    const result = splitArgv(argv, 3)
    assert.deepStrictEqual(result, [['arg1'], ['arg2']])
  })

  it('should handle empty arguments', function () {
    const argv: string[] = []
    const result = splitArgv(argv)
    assert.deepStrictEqual(result, [[]])
  })
})
