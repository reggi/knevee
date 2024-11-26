import {parsePositionals} from '../../src/positional/index.ts'
import assert, {deepStrictEqual} from 'node:assert'
import {test} from 'node:test'

test('parsePositionals', () => {
  assert.equal(parsePositionals('').hasRules, false)
  assert.equal(parsePositionals('<name>').hasRules, true)
  deepStrictEqual(parsePositionals('').validate([]), [[], {}])
  deepStrictEqual(parsePositionals([]).validate([]), [[], {}])
  deepStrictEqual(parsePositionals('<name>').validate(['john']), [['john'], {}])
  deepStrictEqual(parsePositionals('<name> [age]').validate(['john', '23']), [['john', '23'], {}])
  deepStrictEqual(parsePositionals('<name> [age]').validate(['john']), [['john', undefined], {}])

  deepStrictEqual(parsePositionals('<name> [age]', 'positionalAsNamedObject').validate(['john', '23']), [
    [],
    {
      name: 'john',
      age: '23',
    },
  ])

  deepStrictEqual(parsePositionals('<name> <ages...>', 'positionalAsNamedObject').validate(['john', '23', '43']), [
    [],
    {
      name: 'john',
      ages: ['23', '43'],
    },
  ])

  deepStrictEqual(parsePositionals('<name> <ages...>', 'positionalAsNamedObject').validate(['john', '23', '43']), [
    [],
    {name: 'john', ages: ['23', '43']},
  ])

  deepStrictEqual(parsePositionals('<name> [age]', 'positionalAsObject').validate(['john', '23']), [
    [],
    {
      _: ['john', '23'],
    },
  ])

  assert.throws(() => parsePositionals('<name'))
  assert.throws(() => parsePositionals('[name] <required>'))
  assert.throws(() => parsePositionals('<required...> [name] '))
  assert.throws(() => parsePositionals('<name>').validate([]))
  assert.throws(() => parsePositionals('<name> [age]').validate(['john', '23', 'meow']))
  assert.throws(() => parsePositionals('<name> <ages...>', 'positionalAsNamedObject').validate(['--']))
  assert.throws(() => parsePositionals('<name> <name>', 'positionalAsNamedObject').validate(['john', 'mary']))
  assert.throws(() => parsePositionals('<name> -- <name>', 'positionalAsNamedObject').validate(['john', '--', 'mary']))
  assert.throws(() => parsePositionals('<name> [age]', 'x' as any).validate(['john', '23']))
  assert.throws(() => parsePositionals('<name> <age>').validate(['john', '23', '--']))
})
