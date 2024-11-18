import fs from 'node:fs/promises'
import {createServer} from 'node:net'

export async function startSocketServer(socketPath: string, handler: (socket: string) => Promise<void>) {
  const server = createServer(socket => {
    socket.on('data', data => {
      console.log('Received data:', data.toString())
    })
    socket.end('Hello from server')
  })

  server.listen(socketPath, async () => {
    console.log('Server is listening on', socketPath)

    await handler(socketPath)

    // Cleanup the socket file after use
    server.close(() => {
      fs.unlink(socketPath).catch(console.error)
    })
  })
}
