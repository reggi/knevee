import assert from 'node:assert'
import {afterEach, beforeEach, describe, it} from 'node:test'
import mockFs from 'mock-fs'
import {dirscan} from '../../src/command/dirscan.ts'

describe('dirscan', () => {
  beforeEach(() => {
    // Setup a mock file system before each test
    mockFs({
      '/test': {
        '.knevee': '',
        'file.ts': 'file content here',
        'anotherfile.ts': 'more content here',
        '.dotfile': 'should be ignored',
        nested: {
          'fileInNested.ts': 'nested file content',
        },
      },
    })
  })

  afterEach(() => {
    // Restore the file system after each test
    mockFs.restore()
  })

  it('should handle negative depth', async () => {
    const result = await dirscan('/test', -1)
    assert.deepEqual(result.sort(), [].sort())
  })

  it('should list all files in a directory excluding dotfiles and include nested files', async () => {
    const expected = ['/test/file.ts', '/test/anotherfile.ts', '/test/nested/fileInNested.ts']
    const result = await dirscan('/test')
    assert.deepEqual(result.sort(), expected.sort())
  })

  it('should handle an empty directory', async () => {
    await mockFs({'/empty': {}})
    await assert.rejects(async () => {
      await dirscan('/empty')
    })
  })
})
