return {
  lintStdin = true,
  lintCommand = "bundle exec standardrb --format emacs --force-exclusion --stdin ${INPUT}",
  lintIgnoreExitCode = true,
  lintFormats = {'%f:%l:%c: %m'},
  formatStdin = true,
  formatCommand = "bundle exec standardrb -A -f quiet --stderr -s ${INPUT}",
}
