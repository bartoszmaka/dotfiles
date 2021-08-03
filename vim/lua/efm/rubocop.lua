return {
  lintStdin = true,
  lintCommand = "bundle exec rubocop --format emacs --force-exclusion --stdin ${INPUT}",
  lintIgnoreExitCode = true,
  lintFormats = {'%f:%l:%c: %m'},
  formatStdin = false,
  formatCommand = "bundle exec rubocop -a -f quiet",
}
-- for rubocop 0.7
  -- formatCommand = "bundle exec rubocop -a -f quiet -s ${INPUT}",
-- for rubocop 1.4
  -- formatCommand = "bundle exec rubocop -A -f quiet --stderr -s ${INPUT}",
