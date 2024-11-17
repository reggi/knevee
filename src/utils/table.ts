type TableOptsObject = {
  gap?: number | number[]
  truncate?: number | number[]
}

type TableOpts = TableOptsObject | ((columnLengths: number[]) => TableOptsObject)

export function table(array, opts: TableOpts = {}) {
  // Calculate the length of the longest item in each column
  const columnLengths = array[0].map((_, colIndex) => Math.max(...array.map(row => row[colIndex].toString().length)))

  opts = typeof opts === 'function' ? opts(columnLengths) : opts

  const padCharacter = ' '
  const gap = Array.isArray(opts.gap) ? opts.gap : Array(array[0].length).fill(opts.gap || 1)
  const truncate = Array.isArray(opts.truncate) ? opts.truncate : [opts.truncate]

  // Adjust column lengths based on truncate option
  const adjustedColumnLengths = columnLengths.map((length, colIndex) =>
    Math.min(length, truncate[colIndex] || truncate[0] || Infinity),
  )

  // Create the table string
  const tableString = array
    .map(row =>
      row
        .map((item, colIndex) => {
          const truncatedItem =
            item.toString().length > adjustedColumnLengths[colIndex]
              ? item.toString().slice(0, adjustedColumnLengths[colIndex] - 3) + '...'
              : item.toString()
          return truncatedItem.padEnd(adjustedColumnLengths[colIndex] + (gap[colIndex] || 1), padCharacter)
        })
        .join(''),
    )
    .join('\n')
  return tableString
}
