import util from 'node:util'

function stringToColorCode(str) {
  // Hash function to convert string to a number
  let hash = 0
  for (let i = 0; i < str.length; i++) {
    hash = str.charCodeAt(i) + ((hash << 5) - hash)
  }

  // Reduce hash to the range 16 to 231 for ANSI colors
  const color = (Math.abs(hash) % 216) + 16

  // Return the ANSI escape code for the color
  return `\x1b[38;5;${color}m${str}\x1b[0m`
}

export function debug(namespace: string) {
  return function (message: string, ...args: any[]) {
    if (process.env.DEBUG && namespace.startsWith(process.env.DEBUG)) {
      process.stdout.write(`${stringToColorCode(namespace)} ${util.format(message, ...args)}\n`)
    }
  }
}
