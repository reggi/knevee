import {assemblePositials, parseArgsBeforePositional} from '../../src/utils/parse-args.ts'
import {describe, it} from 'node:test'
import assert from 'node:assert'

describe('assemblePositials Function', () => {
  it('should correctly process tokens into strings', () => {
    const tokens = [
      {kind: 'positional', value: 'file.txt'},
      {kind: 'option', value: '-v'},
      {kind: 'option-terminator'},
      {kind: 'positional', value: 'log.txt'},
    ]

    const expected = ['file.txt', '--', 'log.txt']
    const result = assemblePositials(tokens)

    assert.deepStrictEqual(result, expected)
  })
})

describe('parseArgsBeforePositional', () => {
  it('parses flags before the first positional argument', () => {
    const result = parseArgsBeforePositional({
      args: ['--env', 'production', 'script.js', '--debug'],
      options: {
        env: {type: 'string', description: 'Environment'},
        debug: {type: 'boolean', description: 'Enable debug mode'},
      },
    })
    assert.deepStrictEqual(result, {values: {env: 'production'}, positionals: ['script.js', '--debug']})
  })

  it('returns only flags before the first positional argument', () => {
    const result = parseArgsBeforePositional({
      args: ['--config', 'config.json', 'start', '--verbose'],
      options: {
        config: {type: 'string', description: 'Config file'},
        verbose: {type: 'boolean', description: 'Verbose output'},
      },
    })
    assert.deepStrictEqual(result, {values: {config: 'config.json'}, positionals: ['start', '--verbose']})
  })

  it('handles no positional arguments correctly', () => {
    const result = parseArgsBeforePositional({
      args: ['--mode', 'test', '--silent'],
      options: {
        mode: {type: 'string', description: 'Mode'},
        silent: {type: 'boolean', description: 'Silent mode'},
      },
    })
    assert.deepStrictEqual(result, {values: {mode: 'test', silent: true}, positionals: []})
  })

  it('handles multiple positional arguments correctly', () => {
    const result = parseArgsBeforePositional({
      args: ['--env', 'development', 'run', 'script.js', '--watch'],
      options: {
        env: {type: 'string', description: 'Environment'},
        watch: {type: 'boolean', description: 'Watch mode'},
      },
    })
    assert.deepStrictEqual(result, {values: {env: 'development'}, positionals: ['run', 'script.js', '--watch']})
  })

  it('returns empty flags if no flags are provided', () => {
    const result = parseArgsBeforePositional({
      args: ['script.js', '--debug'],
    })
    assert.deepStrictEqual(result, {values: {}, positionals: ['script.js', '--debug']})
  })

  it('throws when pre-positional flags are not defined and strict is true', () => {
    assert.throws(() => {
      parseArgsBeforePositional({
        args: ['--love', 'script.js', '--debug'],
        strict: true,
      })
    })
  })

  it('handles no args passed in', () => {
    const result = parseArgsBeforePositional()
    assert.deepStrictEqual(result, {values: {}, positionals: []})
  })

  it('handles empty args array', () => {
    const result = parseArgsBeforePositional({args: []})
    assert.deepStrictEqual(result, {values: {}, positionals: []})
  })

  it('handles only positional arguments', () => {
    const result = parseArgsBeforePositional({
      args: ['script.js', 'run', 'test'],
    })
    assert.deepStrictEqual(result, {values: {}, positionals: ['script.js', 'run', 'test']})
  })

  it('handles flags after positional arguments', () => {
    const result = parseArgsBeforePositional({
      args: ['script.js', '--env', 'production'],
      options: {
        env: {type: 'string', description: 'Environment'},
      },
    })
    assert.deepStrictEqual(result, {values: {}, positionals: ['script.js', '--env', 'production']})
  })

  it('handles flag with string value', () => {
    const result = parseArgsBeforePositional({
      args: ['--runtime', 'node -e', 'script.js'],
      allowPositionals: true,
      options: {
        runtime: {type: 'string'},
      },
    })
    assert.deepStrictEqual(result, {
      values: {
        runtime: 'node -e',
      },
      positionals: ['script.js'],
    })
  })
})
