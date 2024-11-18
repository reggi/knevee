import {describe, it} from 'node:test'
import {strict as assert} from 'node:assert'
import {knevee} from '../src/index.ts'
import pkg from '../package.json' with {type: 'json'}

describe('index', () => {
  it('should handle directly running knevee argv', async t => {
    const consoleLogSpy = t.mock.method(console, 'log')
    const result = await knevee({argv: ['examples/exports.ts', 'john', '33']}).executable({nullifyRuntime: true})
    assert.deepStrictEqual(result, [undefined])
    assert.strictEqual(consoleLogSpy.mock.calls.length, 1)
    assert.strictEqual(consoleLogSpy.mock.calls[0].arguments[0], 'gamma')
  })

  it('should handle directly running knevee allSettled', async t => {
    const consoleLogSpy = t.mock.method(console, 'log')
    const result = await knevee({argv: ['examples/exports.ts', 'john', '33'], useLoopMethod: 'allSettled'}).executable({
      nullifyRuntime: true,
    })
    assert.deepStrictEqual(result, [undefined])
    assert.strictEqual(consoleLogSpy.mock.calls.length, 1)
    assert.strictEqual(consoleLogSpy.mock.calls[0].arguments[0], 'gamma')
  })

  it('should handle directly running knevee all', async t => {
    const consoleLogSpy = t.mock.method(console, 'log')
    const result = await knevee({argv: ['examples/exports.ts', 'john', '33'], useLoopMethod: 'all'}).executable({
      nullifyRuntime: true,
    })
    assert.deepStrictEqual(result, [undefined])
    assert.strictEqual(consoleLogSpy.mock.calls.length, 1)
    assert.strictEqual(consoleLogSpy.mock.calls[0].arguments[0], 'gamma')
  })

  it('prints the version', async t => {
    const consoleLogSpy = t.mock.method(console, 'log')
    const result = await knevee({argv: ['--version']}).executable({nullifyRuntime: true})
    assert.strictEqual(consoleLogSpy.mock.calls[0].arguments[0], pkg.version)
  })
})
