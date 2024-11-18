import assert from 'node:assert'
import {describe, it} from 'node:test'
import {stdStrings} from '../../src/utils/std-strings.ts'

describe('stdStrings', () => {
  it('should normalize an array of strings', () => {
    const input = ['  foo  ', 'bar', '  baz ']
    const expected = ['foo', 'bar', 'baz']
    assert.deepEqual(stdStrings(input), expected)
  })

  it('should normalize a single string', () => {
    const input = '  foo  bar   baz '
    const expected = ['foo', 'bar', 'baz']
    assert.deepEqual(stdStrings(input), expected)
  })

  it('should return an empty array for an empty array input', () => {
    const input: string[] = []
    const expected: string[] = []
    assert.deepEqual(stdStrings(input), expected)
  })

  it('should return an empty array for an empty string input', () => {
    const input = ''
    const expected: string[] = []
    assert.deepEqual(stdStrings(input), expected)
  })

  it('should split string', () => {
    const input = 'xxx yyy '
    const expected: string[] = ['xxx', 'yyy']
    assert.deepEqual(stdStrings(input), expected)
  })

  it('should throw an error for non-string values in the array', () => {
    const input = ['foo', 123, 'bar']
    assert.throws(() => stdStrings(input as any), /All items in the array must be strings/)
  })

  it('should throw an error for non-string and non-array input', () => {
    const input = 123
    assert.throws(() => stdStrings(input as any), /Unable to normalize array/)
  })
})
