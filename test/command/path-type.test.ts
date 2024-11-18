import assert from 'node:assert'
import {describe, it, beforeEach, afterEach} from 'node:test'
import mock from 'mock-fs'
import {pathType} from '../../src/command/path-type.ts'
import {startSocketServer} from '../fixtures/socket.ts'

beforeEach(() => {
  mock({
    '/test': {
      'file.txt': 'This is a file',
      directory: {}, // Empty directory
      symlinkToFile: mock.symlink({
        path: '/test/file.txt',
      }),
      symlinkToDir: mock.symlink({
        path: '/test/directory',
      }),
    },
  })
})

afterEach(() => {
  mock.restore()
})

describe('pathType Function', () => {
  it('should identify a file', async () => {
    const result = await pathType('/test/file.txt')
    assert.deepStrictEqual(result, {file: '/test/file.txt'})
  })

  it('should identify a directory', async () => {
    const result = await pathType('/test/directory')
    assert.deepStrictEqual(result, {dir: '/test/directory'})
  })

  it('should return an empty object for a non-existent path', async () => {
    const result = await pathType('/test/nonexistent')
    assert.deepStrictEqual(result, {})
  })

  // Test for a symbolic link to a file
  it('should return an empty object for a symbolic link to a file', async () => {
    const result = await pathType('/test/symlinkToFile')
    assert.deepStrictEqual(result, {file: '/test/symlinkToFile'}) // Modify this if your function needs to handle symlinks differently
  })

  // Test for a symbolic link to a directory
  it('should return an empty object for a symbolic link to a directory', async () => {
    const result = await pathType('/test/symlinkToDir')
    assert.deepStrictEqual(result, {dir: '/test/symlinkToDir'}) // Modify this if your function needs to handle symlinks differently
  })

  it('should handle socket', async () => {
    await startSocketServer('/tmp/knevee-test-socket', async socket => {
      const value = await pathType(socket)
      assert.deepStrictEqual(value, {})
    })
  })
})
