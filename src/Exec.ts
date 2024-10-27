import {Command} from './Command.ts'
import {ExecAbstract} from './ExecAbstract.ts'
import {UserError} from './utils/utils.ts'
import {handleValue} from './utils/value.ts'

export class Exec extends ExecAbstract {
  constructor(cmd: Command) {
    super(cmd)
  }

  async handler(args: any[], flags: any) {
    const cmd = this.cmd
    let value
    try {
      value = await cmd.default(...args)
    } catch (e) {
      throw new UserError(e)
    }
    return await handleValue(cmd.output, value, flags)
  }
}
