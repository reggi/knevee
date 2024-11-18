import {strict as assert} from 'node:assert'
import {describe, it} from 'node:test'
import {spawnJsRuntime} from '../../src/evaluate/eval.ts'

describe('spawnJsRuntime', () => {
  it('should throw an error if no runtime is provided', async () => {
    await assert.rejects(() => spawnJsRuntime([], 'console.log("test");'), {
      message: 'No runtime provided',
    })
  })

  it('should execute JavaScript code and return exit code 0 on success', async () => {
    const exitCode = await spawnJsRuntime(['node', '-e'], 'console.log("test");')
    assert.strictEqual(exitCode, 0)
  })

  it('should return a non-zero exit code on script error', async () => {
    const exitCode = await spawnJsRuntime(['node', '-e'], 'process.exit(1);')
    assert.strictEqual(exitCode, 1)
  })

  it('should handle runtime errors by rejecting the promise', async () => {
    await assert.rejects(() => spawnJsRuntime(['wrongcommand'], 'console.log("test");'))
  })

  it('should show exit 1', async t => {
    const code = await spawnJsRuntime(['node', '-e'], 'process.exit(1)')
    assert.strictEqual(code, 1)
  })

  it('should show exit 0', async t => {
    const code = await spawnJsRuntime(['node', '-e'], 'process.exit(0)')
    assert.strictEqual(code, 0)
  })
})
