export default {
  tsx: ['tsx', '-e'],
  deno: ['deno', 'eval'],
  node: [
    'node',
    '--experimental-strip-types',
    '--experimental-detect-module',
    '--disable-warning=MODULE_TYPELESS_PACKAGE_JSON',
    '--disable-warning=ExperimentalWarning',
    '-e',
  ],
}
