export function fixArgv(argv: string[]): string[] {
  const fixedArgs: string[] = []
  let currentArg: string = ''
  let quoteChar: string = '' // This will store the type of quote that opened the current argument

  argv.forEach(arg => {
    const hasDoubleQuote = arg.includes('"')
    const hasSingleQuote = arg.includes("'")
    const hasAnyQuote = hasDoubleQuote || hasSingleQuote

    // Determine if a new quoted argument should start
    if (!quoteChar && hasAnyQuote) {
      quoteChar = hasDoubleQuote ? '"' : "'" // Set the type of quote that opened the argument
    }

    if (quoteChar) {
      currentArg += currentArg ? ' ' + arg : arg
      // Check if the argument closes with the same type of quote that opened it
      if (arg.endsWith(quoteChar)) {
        fixedArgs.push(currentArg)
        currentArg = ''
        quoteChar = '' // Reset the quote tracker since the argument is closed
      }
    } else {
      // If no quote is open, handle as normal argument
      fixedArgs.push(arg)
    }
  })

  // Handle any unclosed quoted argument
  if (quoteChar && currentArg) {
    fixedArgs.push(currentArg)
  }

  return fixedArgs
}
