import type {StdinLoopType} from '../evaluate/stdin-loop.ts'
import type {PositionalType} from '../positional/index.ts'
import type {FlagOptions} from './flag-options.ts'

export class Options {
  /** The name of the module. (__Defaults to the name of the file__) */
  name: string | string[] = []

  /** A description of what the module does. */
  description: string = ''

  /** A list of dependencies required by the module. */
  dependencies: string | string[] = []

  /** Positional arguments that the module accepts. Can be specified as an array or a space-separated string. */
  positionals: string[] | string = []

  /** A mapping of command line flags to their settings. [parseArgs](https://nodejs.org/api/util.html#utilparseargsconfig) */
  flags: FlagOptions = {}

  /** The function that executes when the command is run. */
  default: null | ((...args: any) => any) = null

  // ----- args -----

  /** Specifies if the flags should be strictly validated against the provided flags definitions. (Defaults to `true`) */
  useStrictFlags: boolean = true
  /** Determines if stdin should be unshifted into args. (__Defaults to `true`__) */
  useUnshiftStdin: boolean = true
  /** When iterating stdin loop uses `Promise.allSettled` instead of `Promise.all`. (__Defaults to `false`__) */
  useLoopMethod: string | 'allSettled' | 'all' | 'for-await' = 'for-await'

  /**
   * The type of output that the module should produce. (__Defaults to `log`__)
   * - `bool` - Outputs the result as a boolean value, adds `--emoji`, `--int` flags to command.
   * - `json` - Outputs the result as a JSON string, pretty prints the result.
   * - `lines` - Expects an array, and will output each item on a line.
   * - `log` - Prints the value.
   * - `stdout` - Prints the value.
   * - `bash` - Expects function to return string, and executes, adds `--print` flag to the command, which prints the string.
   * - `false` - Disables output.
   */
  output: string | boolean = 'log'

  /**
   * Describes how positional rules translate to function arguments. (__Defaults to `positionalAsObject`__)
   * - `positionalNamedObject` - Uses name in positionals as key in args.
   * - `positionalAsArray` - Uses escalating `_` as the key separating `--` in positionals.
   */
  positionalType: PositionalType | undefined = undefined

  /**
   * Determines if the module should read from stdin and how. (__Defaults to `false`__)
   * - `false` - Disables stdin.
   * - `true` - Reads from stdin
   * - `loopJson` - Reads from stdin as a JSON array and loops over each item.
   * - `loopLines` - Reads from stdin as a string and loops over each line.
   * - `loop` - Reads stdin and does `loopJson` with backup to `loopLines`.
   */
  stdin: StdinLoopType | boolean = false

  /**
   * Set the javscript runtime to evaluate subprocesses under, must expect appending js string.
   * `node`
   * `--experimental-strip-types`
   * `--experimental-detect-module`
   * `--disable-warning=MODULE_TYPELESS_PACKAGE_JSON`
   * `--disable-warning=ExperimentalWarning`
   * `-e`
   */
  runtime: undefined | string | string[] = undefined

  runtimeKey: string | 'node' | 'deno' = 'node'

  /** path to dir or file */
  path: undefined | string = undefined

  /** path to dir or file */
  __filename: undefined | string = undefined

  importMeta: undefined | ImportMeta = undefined

  /** current working directory */
  cwd: string | undefined = undefined

  /** command arguments */
  argv: string[] | undefined = undefined

  /** runs the command as a subprocess */
  subprocess: boolean = false
}
