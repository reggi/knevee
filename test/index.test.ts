import {describe, it} from 'node:test'
import {strict as assert} from 'node:assert'
import {knevee} from '../src'

describe('index', () => {
  it('should handle directly running knevee', async t => {
    const consoleLogSpy = t.mock.method(console, 'log')
    const result = await knevee({argv: ['examples/exports.ts', 'john', '33']}).executable({nullifyRuntime: true})
    assert.deepStrictEqual(result, [undefined])
    assert.strictEqual(consoleLogSpy.mock.calls.length, 1)
    assert.strictEqual(consoleLogSpy.mock.calls[0].arguments[0], 'gamma')
  })
})
