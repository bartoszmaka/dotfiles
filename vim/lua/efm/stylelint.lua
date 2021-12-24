return {
  lintCommand = 'stylelint --stdin --stdin-filename ${INPUT} --formatter compact --syntax sass',
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = {
    '%f: line %l, col %c, %tarning - %m',
    '%f: line %l, col %c, %trror - %m',
  },
  formatCommand = 'stylelint --fix --stdin --stdin-filename ${INPUT}',
  formatStdin = true,
}
