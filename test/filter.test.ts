import {filterItems} from '../src/filter.ts'
import {strict as assert} from 'node:assert'
import {describe, it} from 'node:test'

// Tests
describe('filterItems', () => {
  it('Filter items with single exact argv', () => {
    const items = [
      {keys: ['hello', 'world']},
      {keys: ['hello', 'blue']},
      {keys: ['hello']},
      {keys: []},
      {keys: ['green']},
    ]
    const argv: string[] = ['hello']
    assert.deepEqual(filterItems(items, argv), {match: {keys: ['hello']}, results: []})
  })

  it('Filter items with single exact argv', () => {
    const items = [{keys: ['hello', 'world']}, {keys: ['hello', 'blue']}, {keys: []}, {keys: ['green']}]
    const argv: string[] = ['hello']
    assert.deepEqual(filterItems(items, argv), {
      match: undefined,
      results: [{keys: ['hello', 'world']}, {keys: ['hello', 'blue']}],
    })
  })

  it('Filter items with multiple argv', () => {
    const items = [
      {keys: ['hello', 'world']},
      {keys: ['hello', 'blue']},
      {keys: ['hello']},
      {keys: []},
      {keys: ['green']},
    ]
    const argv: string[] = ['hello', 'blue']
    assert.deepEqual(filterItems(items, argv), {match: {keys: ['hello', 'blue']}, results: []})
  })

  it('Filter items with empty argv', () => {
    const items = [
      {keys: ['hello', 'world']},
      {keys: ['hello', 'blue']},
      {keys: ['hello']},
      {keys: []},
      {keys: ['green']},
    ]
    const argv: string[] = []
    assert.deepEqual(filterItems(items, argv), {match: {keys: []}, results: []})
  })

  it('Filter items with unrelated argv', () => {
    const items = [
      {keys: ['hello', 'world']},
      {keys: ['hello', 'blue']},
      {keys: ['hello']},
      {keys: []},
      {keys: ['green']},
    ]
    const argv: string[] = ['green']
    assert.deepEqual(filterItems(items, argv), {match: {keys: ['green']}, results: []})
  })

  it('Filter items with extra argv not in keys', () => {
    const items = [
      {keys: ['hello', 'world', 'woof']},
      {keys: ['hello', 'world', 'meow']},
      {keys: ['hello', 'blue']},
      {keys: ['hello']},
      {keys: []},
      {keys: ['green']},
    ]
    const argv: string[] = ['hello', 'world', '--ducks']
    assert.deepEqual(filterItems(items, argv), {
      match: undefined,
      results: [{keys: ['hello', 'world', 'woof']}, {keys: ['hello', 'world', 'meow']}],
    })
  })

  it('Filter items with extra argv not in keys', () => {
    const items = [
      {keys: ['hello', 'world', 'woof']},
      {keys: ['hello', 'world', 'meow']},
      {keys: ['hello', 'blue']},
      {keys: ['hello']},
      {keys: []},
      {keys: ['green']},
    ]
    const argv: string[] = ['hello', 'world', 'ducks']
    assert.deepEqual(filterItems(items, argv), {
      match: undefined,
      results: [{keys: ['hello', 'world', 'woof']}, {keys: ['hello', 'world', 'meow']}],
    })
  })

  it('Filter items with extra argv not in keys', () => {
    const items = [{keys: ['thailand', 'food', 'padthai']}, {keys: ['thailand', 'moo-deng', 'date']}]
    const argv: string[] = ['thailand', 'moo-deng']
    assert.deepEqual(filterItems(items, argv), {match: undefined, results: [{keys: ['thailand', 'moo-deng', 'date']}]})
  })
})
