# knevee

**knevee** simplifies running JavaScript directly from the terminal. It enables users to execute scripts efficiently, providing intuitive CLI interactions.

## Overview

knevee allows you to craft lightweight, customizable command-line tools using JavaScript. Define a module, specify the positional arguments and options, and you're ready to run your script with ease.

## Example

Here’s a quick example of how a simple greeting command could be implemented:

```js
#!/usr/bin/env knevee
export const description = "Greetings earthling";
export const positionals = "<name>";

export default async (name) => {
  return `hello ${name}`;
};
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

knevee supports a robust set of configuration options to tailor your scripts. Here's what you can customize:

<!-- start run cat src/artifacts/options-table.md -->
| name | type | doc |
| --- | --- | --- |
| name | string \| string[] | The name of the module. (__Defaults to the name of the file__) |
| description | string | A description of what the module does. |
| dependencies | string \| string[] | A list of dependencies required by the module. |
| positionals | string[] \| string | Positional arguments that the module accepts. Can be specified as an array or a space-separated string. |
| flags | FlagOptions | A mapping of command line flags to their settings. [parseArgs](https://nodejs.org/api/util.html#utilparseargsconfig) |
| default | null \|  | The function that executes when the command is run. |
| useStrictFlags | boolean | Specifies if the flags should be strictly validated against the provided flags definitions. (Defaults to `true`) |
| useUnshiftStdin | boolean | Determines if stdin should be unshifted into args. (__Defaults to `true`__) |
| useLoopMethod | string \| allSettled \| all \| for-await | When iterating stdin loop uses `Promise.allSettled` instead of `Promise.all`. (__Defaults to `false`__) |
| output | string \| boolean | The type of output that the module should produce. (__Defaults to `log`__) |
|  |  | - `bool` - Outputs the result as a boolean value, adds `--emoji`, `--int` flags to command. |
|  |  | - `json` - Outputs the result as a JSON string, pretty prints the result. |
|  |  | - `lines` - Expects an array, and will output each item on a line. |
|  |  | - `log` - Prints the value. |
|  |  | - `stdout` - Prints the value. |
|  |  | - `bash` - Expects function to return string, and executes, adds `--print` flag to the command, which prints the string. |
|  |  | - `false` - Disables output. |
| positionalType | PositionalType \| undefined | Describes how positional rules translate to function arguments. (__Defaults to `positionalAsObject`__) |
|  |  | - `positionalNamedObject` - Uses name in positionals as key in args. |
|  |  | - `positionalAsArray` - Uses escalating `_` as the key separating `--` in positionals. |
| stdin | StdinLoopType \| boolean | Determines if the module should read from stdin and how. (__Defaults to `false`__) |
|  |  | - `false` - Disables stdin. |
|  |  | - `true` - Reads from stdin |
|  |  | - `loopJson` - Reads from stdin as a JSON array and loops over each item. |
|  |  | - `loopLines` - Reads from stdin as a string and loops over each line. |
|  |  | - `loop` - Reads stdin and does `loopJson` with backup to `loopLines`. |
| runtime | undefined \| string \| string[] | Set the javscript runtime to evaluate subprocesses under, must expect appending js string. |
|  |  | `node` |
|  |  | `--experimental-strip-types` |
|  |  | `--experimental-detect-module` |
|  |  | `--disable-warning=MODULE_TYPELESS_PACKAGE_JSON` |
|  |  | `--disable-warning=ExperimentalWarning` |
|  |  | `-e` |
| runtimeKey | string \| node \| deno |  |
| path | undefined \| string | path to dir or file |
| __filename | undefined \| string | path to dir or file |
| importMeta | undefined \| ImportMeta |  |
| cwd | string \| undefined | current working directory |
| argv | string[] \| undefined | command arguments |
| subprocess | boolean | runs the command as a subprocess |
<!-- end run -->

<!-- start run ./src/build/json2md.ts ./envdef.json -->
| var | type | description |
| --- | --- | --- |
| KNEVE_THROW | boolean | Throws Kneve errors instead of just logging the message |
<!-- end run -->