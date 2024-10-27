import {Command} from './Command.ts'
import {ExecAbstract} from './ExecAbstract.ts'
import valueString from './utils/value-string.ts'
import {spawn} from 'node:child_process'

export class ExecSub extends ExecAbstract {
  constructor(cmd: Command) {
    super(cmd)
  }

  private async execString(args: any[], flags: any) {
    const cmd = this.cmd
    if (!cmd.path) throw new Error('No path provided')
    const lines = [
      valueString,
      `const flags = ${JSON.stringify(flags)};`,
      `import('${cmd.path}').then(cmd => {`,
      `  if (typeof cmd.command.default !== 'undefined') {`,
      `    return cmd.command.default(...${JSON.stringify(args)}.map(v => v === null ? undefined : v))`,
      `  }`,
      `  if (typeof cmd.default !== 'undefined') {`,
      `    return cmd.default(...${JSON.stringify(args)}.map(v => v === null ? undefined : v))`,
      `  }`,
      `}).then(value => {`,
      `  return handleValue('${cmd.output}', value, flags)`,
      `})`,
    ]
    return lines.join('\n')
  }

  async handler(args: any[], flags: any) {
    const cmd = this.cmd
    const jsCode = await this.execString(args, flags)
    const runtime = [...cmd.runtime]
    const main = runtime.shift()
    if (!main) throw new Error('No runtime provided')
    const child = spawn(main, [...runtime, jsCode], {stdio: 'inherit'})
    child.on('exit', code => {
      process.exit(code ?? 1)
    })
  }
}
