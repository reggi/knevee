import {stdinAsync} from '../../src/evaluate/stdin-async.ts'
import assert from 'node:assert'
import {PassThrough} from 'node:stream'
import {test, describe, beforeEach, afterEach} from 'node:test'

// Define a MockStdin class that extends PassThrough and includes the isTTY property
class MockStdin extends PassThrough {
  private _isTTY: boolean

  constructor(isTTY: boolean) {
    super()
    this._isTTY = isTTY
  }

  get isTTY() {
    return this._isTTY
  }

  set isTTY(value: boolean) {
    this._isTTY = value
  }
}

describe('stdinAsync', () => {
  let mockStdin: MockStdin

  beforeEach(() => {
    // Initialize a new MockStdin before each test
    mockStdin = new MockStdin(false)
  })

  afterEach(() => {
    // Clean up the MockStdin after each test to prevent hanging
    mockStdin.destroy()
  })

  test('resolves to null when stdin is a TTY', async () => {
    mockStdin.isTTY = true

    const result = await stdinAsync(mockStdin)
    assert.strictEqual(result, null, 'Expected stdinAsync to resolve to null when stdin is a TTY')
  })

  test('resolves with trimmed input when stdin is not a TTY and receives data', async () => {
    mockStdin.isTTY = false

    const stdinPromise = stdinAsync(mockStdin)

    // Simulate writing data to stdin
    mockStdin.write('  Hello, World!  ')
    mockStdin.end()

    const result = await stdinPromise
    assert.strictEqual(result, 'Hello, World!', 'Expected stdinAsync to resolve with trimmed input')
  })

  test('resolves to null when stdin is not a TTY and receives no data', async () => {
    mockStdin.isTTY = false

    const stdinPromise = stdinAsync(mockStdin)

    // Simulate ending stdin without writing any data
    mockStdin.end()

    const result = await stdinPromise
    assert.strictEqual(result, null, 'Expected stdinAsync to resolve to null when no data is received')
  })

  test('rejects when stdin emits an error', async () => {
    mockStdin.isTTY = false

    const stdinPromise = stdinAsync(mockStdin)

    // Simulate an error event on stdin
    const testError = new Error('Test Error')
    mockStdin.emit('error', testError)

    await assert.rejects(
      stdinPromise,
      {
        message: 'Test Error',
      },
      'Expected stdinAsync to reject with the emitted error',
    )
  })

  test('resolves to null when no data is received within the timeout', async () => {
    mockStdin.isTTY = false

    const stdinPromise = stdinAsync(mockStdin)

    // Wait longer than the timeout to trigger the timeout resolution
    await new Promise(resolve => setTimeout(resolve, 1100))

    const result = await stdinPromise
    assert.strictEqual(result, null, 'Expected stdinAsync to resolve to null after timeout')
  })
})
