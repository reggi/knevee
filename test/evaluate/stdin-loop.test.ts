import {strict as assert} from 'node:assert'
import {describe, it} from 'node:test'
import {validateStdinType, stdinLoop} from '../../src/evaluate/stdin-loop.ts'

describe('validateStdinType', () => {
  it('should validate standard input types', () => {
    assert.ok(validateStdinType('loop'))
    assert.ok(validateStdinType('loopJson'))
    assert.ok(validateStdinType('loopLines'))
    assert.ok(validateStdinType(true))
    assert.ok(validateStdinType(false))
    assert.ok(validateStdinType(undefined))
    assert.ok(!validateStdinType('invalid'))
    assert.ok(!validateStdinType(null))
    assert.ok(!validateStdinType(123))
  })

  it('should return true for valid types, false otherwise', () => {
    const validTypes = ['loop', 'loopJson', 'loopLines', true, false, undefined]
    validTypes.forEach(type => assert.ok(validateStdinType(type)))
    const invalidTypes = ['test', 0, {}, [], null]
    invalidTypes.forEach(type => assert.ok(!validateStdinType(type)))
  })
})

describe('stdinLoop', () => {
  it('should throw an error for invalid stdin type', async () => {
    await assert.rejects(() => stdinLoop('invalid' as any, async () => 'test'))
  })

  it('should return [null] if null', async () => {
    const result = await stdinLoop(false, async () => null)
    assert.deepEqual(result, [null])
  })

  it('should return [null] if type is falsy', async () => {
    const result = await stdinLoop(false, async () => 'test')
    assert.deepEqual(result, [null])
  })

  it('should process JSON input for loopJson', async () => {
    const jsonInput = '[1, 2, 3]'
    const result = await stdinLoop('loopJson', async () => jsonInput)
    assert.deepEqual(result, [1, 2, 3])
  })

  it('should return throw if JSON is invalid', async () => {
    const jsonInput = '{not: "json"}'
    await assert.rejects(async () => await stdinLoop('loopJson', async () => jsonInput))
  })

  it('should return throw  if not JSON aray', async () => {
    const jsonInput = '{"not": "json"}'
    await assert.rejects(async () => await stdinLoop('loopJson', async () => jsonInput))
  })

  it('should split lines for loopLines', async () => {
    const linesInput = 'line1\nline2'
    const result = await stdinLoop('loopLines', async () => linesInput)
    assert.deepEqual(result, ['line1', 'line2'])
  })

  it('should return single-element array if type is true', async () => {
    const input = 'just text'
    const result = await stdinLoop(true, async () => input)
    assert.deepEqual(result, [input])
  })
})
