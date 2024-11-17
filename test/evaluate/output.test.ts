import assert from 'node:assert'
import {test, describe} from 'node:test'
import {handleOutput} from '../../src/evaluate/output.ts'

describe('handleOutput function', () => {
  test('should log boolean as emoji (true case)', async t => {
    const consoleLogSpy = t.mock.method(console, 'log')
    await handleOutput('bool', true, {emoji: true})
    assert.strictEqual(consoleLogSpy.mock.calls.length, 1)
    assert.strictEqual(consoleLogSpy.mock.calls[0].arguments[0], '✅')
  })

  test('should log boolean as emoji (false case)', async t => {
    const consoleLogSpy = t.mock.method(console, 'log')
    await handleOutput('bool', false, {emoji: true})
    assert.strictEqual(consoleLogSpy.mock.calls.length, 1)
    assert.strictEqual(consoleLogSpy.mock.calls[0].arguments[0], '❌')
  })

  test('should log boolean as integer (true case)', async t => {
    const consoleLogSpy = t.mock.method(console, 'log')
    await handleOutput('bool', true, {int: true})
    assert.strictEqual(consoleLogSpy.mock.calls.length, 1)
    assert.strictEqual(consoleLogSpy.mock.calls[0].arguments[0], 1)
  })

  test('should log boolean as integer (false case)', async t => {
    const consoleLogSpy = t.mock.method(console, 'log')
    await handleOutput('bool', false, {int: true})
    assert.strictEqual(consoleLogSpy.mock.calls.length, 1)
    assert.strictEqual(consoleLogSpy.mock.calls[0].arguments[0], 0)
  })

  test('should log true value', async t => {
    const consoleLogSpy = t.mock.method(console, 'log')
    await handleOutput('bool', true, {})
    assert.strictEqual(consoleLogSpy.mock.calls.length, 1)
    assert.strictEqual(consoleLogSpy.mock.calls[0].arguments[0], true)
  })

  test('should join array elements and log them for "lines"', async t => {
    const consoleLogSpy = t.mock.method(console, 'log')
    await handleOutput('lines', ['one', 'two'], {})
    assert.strictEqual(consoleLogSpy.mock.calls.length, 1)
    assert.strictEqual(consoleLogSpy.mock.calls[0].arguments[0], 'one\ntwo')
  })

  test('should log value as is for "lines"', async t => {
    const consoleLogSpy = t.mock.method(console, 'log')
    await handleOutput('lines', 'single', {})
    assert.strictEqual(consoleLogSpy.mock.calls.length, 1)
    assert.strictEqual(consoleLogSpy.mock.calls[0].arguments[0], 'single')
  })

  test('should log value for "log"', async t => {
    const consoleLogSpy = t.mock.method(console, 'log')
    await handleOutput('log', 'log this', {})
    assert.strictEqual(consoleLogSpy.mock.calls.length, 1)
    assert.strictEqual(consoleLogSpy.mock.calls[0].arguments[0], 'log this')
  })

  test('should write to stdout for "stdout"', async t => {
    const stdoutSpy = t.mock.method(process.stdout, 'write')
    await handleOutput('stdout', 'output to stdout', {})
    assert.strictEqual(stdoutSpy.mock.calls.length, 1)
    assert.strictEqual(stdoutSpy.mock.calls[0].arguments[0], 'output to stdout')
  })

  test('should log JSON stringified value', async t => {
    const consoleLogSpy = t.mock.method(console, 'log')
    const obj = {a: 1, b: 'test'}
    await handleOutput('json', obj, {})
    assert.strictEqual(consoleLogSpy.mock.calls.length, 1)
    assert.strictEqual(consoleLogSpy.mock.calls[0].arguments[0], JSON.stringify(obj, null, 2))
  })

  test('should print bash code when flag is set', async t => {
    const consoleLogSpy = t.mock.method(console, 'log')
    await handleOutput('bash', 'echo "Print this"', {print: true})
    assert.strictEqual(consoleLogSpy.mock.calls.length, 1)
    assert.strictEqual(consoleLogSpy.mock.calls[0].arguments[0], 'echo "Print this"')
  })

  // You cannot test execSync directly with node:test due to lack of import mocking
  // You would normally ensure your function calls execSync with the right parameters
  // Here you could only test the logic up to the point of the dynamic import
  test('should prepare to execute bash code without print flag', async t => {
    const consoleLogSpy = t.mock.method(console, 'log')
    await handleOutput('bash', 'echo "Hello"', {print: false})
    assert.strictEqual(consoleLogSpy.mock.calls.length, 0) // Ensure no log was made
  })
})
