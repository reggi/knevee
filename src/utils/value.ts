export async function handleValue(output: string | boolean, value: any, flags: any) {
  if (output === 'bool') {
    if (flags.emoji) {
      console.log(value ? '✅' : '❌')
    } else if (flags.int) {
      console.log(value ? 1 : 0)
    } else if (value) {
      console.log(value)
    }
  } else if (output === 'lines') {
    if (Array.isArray(value)) {
      console.log(value.join('\n'))
    } else {
      console.log(value)
    }
  } else if (output === 'log') {
    console.log(value)
  } else if (output === 'stdout') {
    process.stdout.write(value)
  } else if (output === 'json') {
    console.log(JSON.stringify(value, null, 2))
  } else if (output === 'bash') {
    const code = [value].flat(Infinity).join('\n')
    if (flags.print) {
      console.log(code)
    } else {
      import('node:child_process').then(({execSync}) => {
        execSync(code, {stdio: 'inherit'})
      })
    }
  }
}
