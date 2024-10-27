import {Command} from './Command.ts'
import {type UserModuleOptions} from './options.ts'

export type KneveeOptions = UserModuleOptions
export const executablePassthrough = Command.executablePassthrough
export default Command.command
