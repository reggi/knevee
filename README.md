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

knevee supports a robust set of configuration options to tailor your scripts.
Here's what you can customize:

| option       | required | type                                                                | description                                                                                                                 |
| ------------ | -------- | ------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| name         | No       | string                                                              | The name of the module. (defaults to filename)                                                                              |
| description  | No       | string                                                              | A description of what the module does.                                                                                      |
| dependencies | No       | strings[]                                                           | A list of dependencies required by the module.                                                                              |
| positionals  | No       | strings \| string[]                                                 | Positional arguments that the module accepts. Can be specified as an array or a space-separated string.                     |
| flags        | No       | [FlagsOption](https://nodejs.org/api/util.html#utilparseargsconfig) | A mapping of command line flags to their settings.                                                                          |
| default      | Yes      | function                                                            | The default function that executes when the module is run.                                                                  |
| strictFlags  | No       | boolean                                                             | Specifies if the flags should be strictly validated against the provided flags definitions.                                 |
| stdin        | No       | `loop`, `loopJson`, `loopLines`, `true`, `false`                    | Defines how the stdin should be handled. (defaults to `loop`)                                                               |
|              |          | `loop`                                                              | Enables `stdin` and both `loopJson` and `loopLines`                                                                         |
|              |          | `loopJson`                                                          | Reads from stdin if JSON input is array loops over each item executing the script multiple times.                           |
|              |          | `loopLines`                                                         | Reads from stdin and splits it at `\n` and loops over each item executing the script multiple times.                        |
|              |          | `true`                                                              | Reads from stdin and passes all of it as one arg.                                                                           |
|              |          | `false`                                                             | Disables reading from stdin.                                                                                                |
| output       | No       | `bool`, `json`, `lines`, `stdout`, `bash`, `false`                  | Specifies the output mode of the module. (defaults to `stdout`)                                                             |
|              |          | `bool`                                                              | Expects function to return `boolean` value, adds `--emoji`, `--int` flags to command.                                       |
|              |          | `json`                                                              | Outputs the result as a JSON string, pretty prints the result.                                                              |
|              |          | `lines`                                                             | Expects array, and will output each item on a line.                                                                         |
|              |          | `stdout`                                                            | Prints the value.                                                                                                           |
|              |          | `bash`                                                              | Expects function to return string, and executes it using `zx`, adds `--print` flag to the command, which prints the string. |
|              |          | `false`                                                             | Disables output.                                                                                                            |
| unshiftStdin | No       | boolean                                                             | Determines if stdin should be unshifted into args. (defaults to `true`)                                                     |
