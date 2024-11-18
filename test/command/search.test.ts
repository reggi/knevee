import assert from 'node:assert'
import {describe, it} from 'node:test'
import {search} from '../../src/command/search.ts'

describe('search', () => {
  it('Filter items with single exact argv', () => {
    const items = [
      {name: ['hello', 'world']},
      {name: ['hello', 'blue']},
      {name: ['hello']},
      {name: []},
      {name: ['green']},
    ]
    const argv: string[] = ['hello']
    assert.deepEqual(
      search(items, argv, v => v.name),
      {match: {name: ['hello']}, results: []},
    )
  })

  it('Filter items with single exact argv', () => {
    const items = [{name: ['hello', 'world']}, {name: ['hello', 'blue']}, {name: []}, {name: ['green']}]
    const argv: string[] = ['hello']
    assert.deepEqual(
      search(items, argv, v => v.name),
      {
        match: undefined,
        results: [{name: ['hello', 'world']}, {name: ['hello', 'blue']}],
      },
    )
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
    assert.deepEqual(
      search(items, argv, v => v.name),
      {match: {name: ['hello', 'blue']}, results: []},
    )
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
    assert.deepEqual(
      search(items, argv, v => v.name),
      {match: {name: []}, results: []},
    )
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
    assert.deepEqual(
      search(items, argv, v => v.name),
      {match: {name: ['green']}, results: []},
    )
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
    assert.deepEqual(
      search(items, argv, v => v.name),
      {
        match: undefined,
        results: [{name: ['hello', 'world', 'woof']}, {name: ['hello', 'world', 'meow']}],
      },
    )
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
    assert.deepEqual(
      search(items, argv, v => v.name),
      {
        match: undefined,
        results: [{name: ['hello', 'world', 'woof']}, {name: ['hello', 'world', 'meow']}],
      },
    )
  })

  it('Filter items with extra argv not in name', () => {
    const items = [{name: ['thailand', 'food', 'padthai']}, {name: ['thailand', 'moo-deng', 'date']}]
    const argv: string[] = ['thailand', 'moo-deng']
    assert.deepEqual(
      search(items, argv, v => v.name),
      {
        match: undefined,
        results: [{name: ['thailand', 'moo-deng', 'date']}],
      },
    )
  })
})
