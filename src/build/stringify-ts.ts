#!/usr/bin/env -S npx tsx ./src/bin.ts
import type {KneveeOptions} from '../index.ts'
import ts from 'typescript'
import fs from 'node:fs/promises'
import path from 'node:path'

/**
 * because knevee can run scripts as child processes we create an on-the-fly importing and wrapping the userscript
 * with some code that is in knevee. in order to do this we need stringified javscript code which this function provides.
 */
export async function stringifyTypescript(filePath: string) {
  const code = await fs.readFile(path.isAbsolute(filePath) ? filePath : path.join(process.cwd(), filePath), 'utf8')
  const sourceFile: ts.SourceFile = ts.createSourceFile(
    filePath,
    code,
    ts.ScriptTarget.Latest,
    true, // Keep comments in the AST
  )

  let exportName: string | null = null
  let exportCount: number = 0

  const transformer: ts.TransformerFactory<ts.SourceFile> = (context: ts.TransformationContext) => {
    return (rootNode: ts.SourceFile) => {
      function visit(node: ts.Node): ts.VisitResult<ts.Node> | undefined {
        // Skip type nodes like interfaces or type aliases
        if (ts.isTypeAliasDeclaration(node) || ts.isInterfaceDeclaration(node)) {
          return undefined
        }

        if (ts.isExportAssignment(node) && !node.isExportEquals) {
          throw new Error('Default exports are not allowed.')
        }

        if (
          (ts.isFunctionDeclaration(node) || ts.isClassDeclaration(node)) &&
          node.name &&
          node.modifiers?.some(mod => mod.kind === ts.SyntaxKind.ExportKeyword)
        ) {
          if (exportName) {
            throw new Error('Only one function or class can be exported.')
          }
          exportName = node.name.text
          exportCount++

          if (ts.isFunctionDeclaration(node)) {
            return ts.factory.updateFunctionDeclaration(
              node,
              node.modifiers,
              node.asteriskToken,
              node.name,
              node.typeParameters,
              node.parameters.map(param =>
                ts.factory.updateParameterDeclaration(
                  param,
                  undefined, // Remove decorators
                  param.dotDotDotToken,
                  param.name, // Correct position for the spread token
                  param.questionToken, // Add question token
                  undefined, // Remove type annotations
                  param.initializer,
                ),
              ),
              undefined, // Remove the return type annotation to exclude types from output
              node.body,
            )
          } else if (ts.isClassDeclaration(node)) {
            return ts.factory.updateClassDeclaration(
              node,
              node.modifiers,
              node.name,
              node.typeParameters,
              node.heritageClauses,
              node.members,
            )
          }
        }

        if (
          ts.isVariableStatement(node) &&
          node.declarationList.flags === ts.NodeFlags.Const &&
          node.parent === sourceFile
        ) {
          throw new Error('Top-level const declarations are not allowed.')
        }

        return ts.visitEachChild(node, visit, context)
      }
      return ts.visitEachChild(rootNode, visit, context)
    }
  }

  const result: ts.TransformationResult<ts.SourceFile> = ts.transform(sourceFile, [transformer])
  if (exportCount !== 1) {
    throw new Error('The file must contain exactly one exported function or class.')
  }
  const transformedSourceFile: ts.SourceFile = result.transformed[0]
  const printer: ts.Printer = ts.createPrinter({newLine: ts.NewLineKind.LineFeed, removeComments: true})

  const transformedCode: string = printer.printFile(transformedSourceFile) // Ensure no additional arguments
  const value = {name: exportName, code: transformedCode}

  result.dispose()
  return value
}

export const command: KneveeOptions = {
  name: 'stringify-ts',
  description: 'Stringifies a typescript file into JS, returns object { name, code }',
  output: 'json',
  positionals: '<file.ts>',
  default: stringifyTypescript,
}
