return {
  lintStdin = true,
  lintCommand = "bundle exec rubocop --format emacs --force-exclusion --stdin ${INPUT}",
  lintIgnoreExitCode = true,
  lintFormats = {'%f:%l:%c: %m'},
  formatStdin = true,
  formatCommand = "bundle exec rubocop -A -f quiet --stderr -s ${INPUT}",
}
