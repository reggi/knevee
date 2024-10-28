import {Positionals} from '../src/Positionals.ts'
import assert from 'node:assert'
import {test} from 'node:test'

test('positionals', () => {
  assert.deepStrictEqual(new Positionals('').asObject([]), {_: []})
  assert.deepStrictEqual(new Positionals([]).asObject([]), {_: []})
  assert.throws(() => new Positionals('<name'))
  assert.throws(() => new Positionals('[name] <required>'))
  assert.throws(() => new Positionals('<required...> [name] '))
  assert.deepStrictEqual(new Positionals('<name>').asObject(['john']), {_: ['john']})
  assert.throws(() => new Positionals('<name>').asObject([]))
  assert.deepStrictEqual(new Positionals('<name> [age]').asObject(['john', '23']), {_: ['john', '23']})
  assert.deepStrictEqual(new Positionals('<name> [age]').asObject(['john']), {_: ['john', undefined]})
  assert.throws(() => new Positionals('<name> [age]').asObject(['john', '23', 'meow']))
  assert.deepStrictEqual(new Positionals('<name> [age]').asNamedObject(['john', '23']), {name: 'john', age: '23'})
  assert.deepStrictEqual(new Positionals('<name> <ages...>').asNamedObject(['john', '23', '43']), {
    name: 'john',
    ages: ['23', '43'],
  })
  assert.throws(() => new Positionals('<name> <ages...>').asNamedObject(['--']))
  assert.throws(() => new Positionals('<name> <name>').asNamedObject(['john', 'mary']))
  assert.throws(() => new Positionals('<name> -- <name>').asNamedObject(['john', '--', 'mary']))
  assert.equal(Positionals.validatePositionalType(1), false)
  assert.equal(Positionals.validatePositionalType('positionalAsNamedObject'), true)
  assert.deepStrictEqual(
    new Positionals('<name> <ages...>').positionalType('positionalAsNamedObject', ['john', '23', '43']),
    {name: 'john', ages: ['23', '43']},
  )
  assert.deepStrictEqual(new Positionals('<name> [age]').positionalType('positionalAsObject', ['john', '23']), {
    _: ['john', '23'],
  })
  assert.throws(() => new Positionals('<name> [age]').positionalType('x' as any, ['john', '23']))
})
