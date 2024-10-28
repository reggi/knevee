import {Command} from './Command.ts'

export abstract class ExecAbstract {
  abstract handler(args: any[], flags: any): Promise<any>

  cmd: Command
  constructor(cmd: Command) {
    this.cmd = cmd
  }

  async run(argv: string[]) {
    return await this.cmd.run(argv, (args, flags) => {
      return this.handler(args, flags)
    })
  }
}
