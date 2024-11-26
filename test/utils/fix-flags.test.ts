import {describe, it} from 'node:test'
import assert from 'node:assert'
import {fixFlags} from '../../src/utils/fix-flags.ts'

describe('fixFlags', () => {
  it('removes surrounding double quotes from string values', () => {
    const input = {flag1: '"value"', flag2: 'value2', flag3: '"anotherValue"'}
    const expected = {flag1: 'value', flag2: 'value2', flag3: 'anotherValue'}
    assert.deepStrictEqual(fixFlags(input), expected)
  })

  it('removes surrounding single quotes from string values', () => {
    const input = {flag1: "'value'", flag2: 'value2', flag3: "'anotherValue'"}
    const expected = {flag1: 'value', flag2: 'value2', flag3: 'anotherValue'}
    assert.deepStrictEqual(fixFlags(input), expected)
  })

  it('leaves strings without surrounding quotes unchanged', () => {
    const input = {flag1: 'value', flag2: 'value2', flag3: 'anotherValue'}
    const expected = {flag1: 'value', flag2: 'value2', flag3: 'anotherValue'}
    assert.deepStrictEqual(fixFlags(input), expected)
  })

  it('leaves non-string values unchanged', () => {
    const input = {flag1: 100, flag2: true, flag3: null}
    const expected = {flag1: 100, flag2: true, flag3: null}
    assert.deepStrictEqual(fixFlags(input), expected)
  })

  it('handles mixed types correctly', () => {
    const input = {flag1: "'value'", flag2: 100, flag3: '"true"', flag4: false}
    const expected = {flag1: 'value', flag2: 100, flag3: 'true', flag4: false}
    assert.deepStrictEqual(fixFlags(input), expected)
  })
})
