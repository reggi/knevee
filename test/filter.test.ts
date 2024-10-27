import {filterAndMatchItems} from '../src/utils/utils.ts'
import {strict as assert} from 'node:assert'
import {describe, it} from 'node:test'

describe('filterAndMatchItems', () => {
  it('Filter items with single exact argv', () => {
    const items = [
      {name: ['hello', 'world']},
      {name: ['hello', 'blue']},
      {name: ['hello']},
      {name: []},
      {name: ['green']},
    ]
    const argv: string[] = ['hello']
    assert.deepEqual(filterAndMatchItems(items, argv), {match: {name: ['hello']}, results: []})
  })

  it('Filter items with single exact argv', () => {
    const items = [{name: ['hello', 'world']}, {name: ['hello', 'blue']}, {name: []}, {name: ['green']}]
    const argv: string[] = ['hello']
    assert.deepEqual(filterAndMatchItems(items, argv), {
      match: undefined,
      results: [{name: ['hello', 'world']}, {name: ['hello', 'blue']}],
    })
  })

  it('Filter items with multiple argv', () => {
    const items = [
      {name: ['hello', 'world']},
      {name: ['hello', 'blue']},
      {name: ['hello']},
      {name: []},
      {name: ['green']},
    ]
    const argv: string[] = ['hello', 'blue']
    assert.deepEqual(filterAndMatchItems(items, argv), {match: {name: ['hello', 'blue']}, results: []})
  })

  it('Filter items with empty argv', () => {
    const items = [
      {name: ['hello', 'world']},
      {name: ['hello', 'blue']},
      {name: ['hello']},
      {name: []},
      {name: ['green']},
    ]
    const argv: string[] = []
    assert.deepEqual(filterAndMatchItems(items, argv), {match: {name: []}, results: []})
  })

  it('Filter items with unrelated argv', () => {
    const items = [
      {name: ['hello', 'world']},
      {name: ['hello', 'blue']},
      {name: ['hello']},
      {name: []},
      {name: ['green']},
    ]
    const argv: string[] = ['green']
    assert.deepEqual(filterAndMatchItems(items, argv), {match: {name: ['green']}, results: []})
  })

  it('Filter items with extra argv not in name', () => {
    const items = [
      {name: ['hello', 'world', 'woof']},
      {name: ['hello', 'world', 'meow']},
      {name: ['hello', 'blue']},
      {name: ['hello']},
      {name: []},
      {name: ['green']},
    ]
    const argv: string[] = ['hello', 'world', '--ducks']
    assert.deepEqual(filterAndMatchItems(items, argv), {
      match: undefined,
      results: [{name: ['hello', 'world', 'woof']}, {name: ['hello', 'world', 'meow']}],
    })
  })

  it('Filter items with extra argv not in name', () => {
    const items = [
      {name: ['hello', 'world', 'woof']},
      {name: ['hello', 'world', 'meow']},
      {name: ['hello', 'blue']},
      {name: ['hello']},
      {name: []},
      {name: ['green']},
    ]
    const argv: string[] = ['hello', 'world', 'ducks']
    assert.deepEqual(filterAndMatchItems(items, argv), {
      match: undefined,
      results: [{name: ['hello', 'world', 'woof']}, {name: ['hello', 'world', 'meow']}],
    })
  })

  it('Filter items with extra argv not in name', () => {
    const items = [{name: ['thailand', 'food', 'padthai']}, {name: ['thailand', 'moo-deng', 'date']}]
    const argv: string[] = ['thailand', 'moo-deng']
    assert.deepEqual(filterAndMatchItems(items, argv), {
      match: undefined,
      results: [{name: ['thailand', 'moo-deng', 'date']}],
    })
  })
})
