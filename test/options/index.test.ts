import {strict as assert} from 'node:assert'
import {describe, it} from 'node:test'
import {parseOptions} from '../../src/options/index.ts'
import {bashFlags, boolFlags, helpFlags} from '../../src/options/flag-options.ts'
import runtimes from '../../src/options/runtimes.ts'

describe('options', () => {
  it('should pass runtime', () => {
    const opts = parseOptions({
      runtime: 'node -e',
    })
    assert.deepStrictEqual(opts.runtime, ['node', '-e'])
  })

  it('should pass bash flags', () => {
    const opts = parseOptions({
      output: 'bash',
    })
    assert.deepStrictEqual(opts.flags, {...helpFlags, ...bashFlags})
  })

  it('should pass bool flags', () => {
    const opts = parseOptions({
      output: 'bool',
    })
    assert.deepStrictEqual(opts.flags, {...helpFlags, ...boolFlags})
  })

  it('should pass runtimeKey', () => {
    const opts = parseOptions({
      runtimeKey: 'deno',
    })
    assert.deepStrictEqual(opts.runtime, runtimes.deno)
  })

  it('should pass unknown runtimeKey', () => {
    const opts = parseOptions({
      runtimeKey: 'unknown',
    })
    assert.deepStrictEqual(opts.runtime, undefined)
  })
})
