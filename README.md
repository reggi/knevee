# knevee

**knevee** simplifies running JavaScript directly from the terminal. It enables
users to execute scripts efficiently, providing intuitive CLI interactions.

## Overview

knevee allows you to craft lightweight, customizable command-line tools using
JavaScript. Define a module, specify the positional arguments and options, and
you're ready to run your script with ease.

## Example

Here’s a quick example of how a simple greeting command could be implemented:

```js
#!/usr/bin/env knevee
export const description = 'Greetings earthling'
export const positionals = '<name>'

export default async name => {
  return `hello ${name}`
}
```

## Usage

You can execute the script directly, view help, and handle various command-line
inputs:

```bash
$ greeting --help
Usage: greeting <name>
Greetings earthling
    --help Prints command help message

$ greeting michael
hello michael

$ greeting
Missing required positional arguments: <name>

$ greeting michael jordan
Extra positional arguments: jordan

$ greeting "michael jordan"
hello michael jordan
```

## Installation

Install knevee globally using npm to use it from anywhere on your system:

```bash
npm install knevee -g
```

Alternativley you can execute a single file like this

```bash
npx knevee ./file.js
```

## Configuration Options

knevee supports a robust set of configuration options to tailor your scripts.
Here's what you can customize:

<!-- start run npm -s run doc-options-md -->

| name            | type               | doc                                                                                                                      |
| --------------- | ------------------ | ------------------------------------------------------------------------------------------------------------------------ |
| name            | string \| string[] | The name of the module. (**Defaults to the name of the file**)                                                           |
| description     | string             | A description of what the module does.                                                                                   |
| dependencies    | string \| string[] | A list of dependencies required by the module.                                                                           |
| positionals     | string[] \| string | Positional arguments that the module accepts. Can be specified as an array or a space-separated string.                  |
| flags           | FlagOptions        | Definition for flags that the module accepts. [parseArgs](https://nodejs.org/api/util.html#utilparseargsconfig)          |
| default         | Function           | The default export function in a module ethat executes when the module is run.                                           |
| useStrictFlags  | boolean            | Specifies if the flags should be strictly validated against the provided flags definitions. (Defaults to `true`)         |
| useUnshiftStdin | boolean            | Determines if stdin should be unshifted into args. (**Defaults to `true`**)                                              |
| useAllSettled   | boolean            | When iterating stdin loop uses `Promise.allSettled` instead of `Promise.all`. (**Defaults to `false`**)                  |
| useArgsObject   | boolean            | Args to function is as single object. (**Defaults to `false`**)                                                          |
| output          | OutputType         | The type of output that the module should produce. (**Defaults to `log`**)                                               |
|                 |                    | - `bool` - Outputs the result as a boolean value, adds `--emoji`, `--int` flags to command.                              |
|                 |                    | - `json` - Outputs the result as a JSON string, pretty prints the result.                                                |
|                 |                    | - `lines` - Expects an array, and will output each item on a line.                                                       |
|                 |                    | - `log` - Prints the value.                                                                                              |
|                 |                    | - `stdout` - Prints the value.                                                                                           |
|                 |                    | - `bash` - Expects function to return string, and executes, adds `--print` flag to the command, which prints the string. |
|                 |                    | - `false` - Disables output.                                                                                             |
| positionalType  | PositionalType     | Describes how positional rules translate to function arguments. (**Defaults to `positionalAsObject`**)                   |
|                 |                    | - `positionalNamedObject` - Uses name in positionals as key in args.                                                     |
|                 |                    | - `positionalAsArray` - Uses escalating `_` as the key separating `--` in positionals.                                   |
| stdin           | StdinLoopType      | Determines if the module should read from stdin and how. (**Defaults to `false`**)                                       |
|                 |                    | - `false` - Disables stdin.                                                                                              |
|                 |                    | - `true` - Reads from stdin                                                                                              |
|                 |                    | - `loopJson` - Reads from stdin as a JSON array and loops over each item.                                                |
|                 |                    | - `loopLines` - Reads from stdin as a string and loops over each line.                                                   |
|                 |                    | - `loop` - Reads stdin and does `loopJson` with backup to `loopLines`.                                                   |

<!-- end run -->

# Environment Variables

<!-- start run cat ./env-options.json | tsx ./scripts/json2markdown.ts -->

| var         | type    | description                                             |
| ----------- | ------- | ------------------------------------------------------- |
| KNEVE_THROW | boolean | Throws Kneve errors instead of just logging the message |

<!-- end run -->

# Binary uses

<!-- #!/usr/bin/env node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning -->

#!/usr/bin/env knevee-file deno run - --
