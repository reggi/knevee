import {test, describe} from 'node:test'
import {evalString} from '../../src/evaluate/eval-string.ts'
import assert from 'node:assert'

describe('evalString', () => {
  test('should throw', () => {
    assert.throws(() => evalString({path: '', outputType: 'json', flags: {}, args: []}))
  })
})
