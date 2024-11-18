import assert from 'node:assert'
import {it, describe} from 'node:test'
import {table} from '../../src/utils/table.ts'

describe('table', function () {
  it('should generate a simple table without any options', function () {
    const input = [
      ['Name', 'Age'],
      ['Alice', '30'],
      ['Bob', '25'],
    ]
    const expected = 'Name  Age \nAlice 30  \nBob   25  '
    const result = table(input)
    // console.log(result);
    assert.strictEqual(result, expected)
  })

  it('should handle gap options as a single number', function () {
    const input = [
      ['Name', 'Age'],
      ['Alice', '30'],
      ['Bob', '25'],
    ]
    const opts = {gap: 3}
    const expected = 'Name    Age   \nAlice   30    \nBob     25    '
    const result = table(input, opts)
    // console.log(result);
    assert.strictEqual(result, expected)
  })

  it('should handle gap options as an array', function () {
    const input = [
      ['Name', 'Age'],
      ['Alice', '30'],
      ['Bob', '25'],
    ]
    const opts = {gap: [3, 0]}
    const expected = 'Name    Age \nAlice   30  \nBob     25  ' // Ensure no trailing spaces
    const result = table(input, opts)
    // console.log(result);
    assert.strictEqual(result, expected)
  })

  it('should apply truncation to items longer than specified', function () {
    const input = [
      ['Name', 'Location'],
      ['Alice', 'Wonderland'],
      ['Bob', 'Builderland'],
    ]
    const opts = {truncate: [4, 5]}
    const expected = 'Name Lo... \nA... Wo... \nBob  Bu... ' // Ensure ellipses are correctly placed
    const result = table(input, opts)
    // console.log(result);
    assert.strictEqual(result, expected)
  })

  it('should properly handle opts as a function', function () {
    const input = [
      ['Name', 'Age'],
      ['Alice', '30'],
      ['Bob', '25'],
    ]
    const optsFunction = () => ({
      gap: [2, 3],
      truncate: [4, 2],
    })
    const expected = 'Name  Ag...\nA...  30   \nBob   25   ' // Match function-generated options
    const result = table(input, optsFunction)
    // console.log(result);
    assert.strictEqual(result, expected)
  })
})
