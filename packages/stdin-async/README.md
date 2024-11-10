# `stdin-async`

```ts
echo meow | tsx -e "import('./src/index.ts').then(({ stdinAsync }) => stdinAsync()).then(console.log)"
```
