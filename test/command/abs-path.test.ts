import assert from 'node:assert'
import {absPath} from '../../src/command/abs-path.ts' // Adjust the import path as necessary
import {describe, it} from 'node:test'
import path from 'node:path'

describe('absPath', () => {
  it('should throw an error if no filePath is provided', () => {
    assert.throws(() => {
      absPath('')
    }, /A file path must be provided./)
  })

  it('should resolve a path starting with ~ to the user home directory', () => {
    const homePath = process.env.HOME || process.env.USERPROFILE // fallback for Windows
    if (homePath) assert.strictEqual(absPath('~/test'), path.join(homePath, 'test'))
  })

  it('should return the same path if it is already absolute', () => {
    const absolutePath = '/etc/passwd'
    assert.strictEqual(absPath(absolutePath), path.normalize(absolutePath))
  })

  it('should resolve a relative path using the provided cwd', () => {
    const cwd = '/usr'
    const relativePath = 'bin'
    assert.strictEqual(absPath(relativePath, cwd), path.resolve(cwd, relativePath))
  })

  it('should resolve a relative path based on the current working directory if no cwd is provided', () => {
    const relativePath = 'src'
    assert.strictEqual(absPath(relativePath), path.resolve(relativePath))
  })
})
