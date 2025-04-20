local M = {}

local eslint = {
  lintCommand = "./node_modules/.bin/eslint -f unix --stdin --stdin-filename ${INPUT}",
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = {"%f:%l:%c: %m"},
}

local prettier = {
  formatCommand = "npx prettier --stdin-filepath ${INPUT}",
  formatStdin = true
}

local prettier_d = {
  formatCommand = 'prettierd "${INPUT}"',
  formatStdin = true,
  env = {
    string.format('PRETTIERD_DEFAULT_CONFIG=%s', vim.fn.expand('~/.config/nvim/utils/linter-config/.prettierrc.json')),
  },
}

local rubocop = {
  lintStdin = true,
  lintCommand = "bundle exec rubocop --format emacs --force-exclusion --stdin ${INPUT}",
  lintIgnoreExitCode = true,
  lintFormats = { '%f:%l:%c: %m' },
  formatStdin = true,
  formatCommand = "bundle exec rubocop -A -f quiet --stderr -s ${INPUT}",
}

local standardrb = {
  lintStdin = true,
  lintCommand = "bundle exec standardrb --format emacs --force-exclusion --stdin ${INPUT}",
  lintIgnoreExitCode = true,
  lintFormats = {'%f:%l:%c: %m'},
  formatStdin = true,
  formatCommand = "bundle exec standardrb -A -f quiet --stderr -s ${INPUT}",
}

local stylelint = {
  lintCommand = 'stylelint --stdin --stdin-filename ${INPUT} --formatter compact --syntax sass --custom-syntax sass',
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = {
    '%f: line %l, col %c, %tarning - %m',
    '%f: line %l, col %c, %trror - %m',
  },
  formatCommand = 'stylelint --fix --stdin --stdin-filename ${INPUT}',
  formatStdin = true,
}

local html_beautifier = {
  lintCommand = 'erb -x -T - | ruby -c',
  lintStdin = true,
  lintOffset = 1,
  formatCommand = 'htmlbeautifier',
}

local computeLanguages = function()
  local languages = {
    typescript = { prettier, eslint },
    javascript = { prettier, eslint },
    typescriptreact = { prettier, eslint },
    javascriptreact = { prettier, eslint },
    -- yaml = { prettier },
    html = { prettier },
    sass = { stylelint, prettier },
    less = { stylelint, prettier },
    scss = { stylelint, prettier },
    css = { stylelint, prettier },
    markdown = { prettier },
    graphql = { prettier },
    vue = { prettier },
    -- eruby = { html_beautifier },
    -- ruby = { rubocop },
  }

  -- local project = vim.fn.getcwd()
  -- if string.match(project, 'DevQAHub') then
  --   languages.ruby = { standardrb }
  -- end

  return languages
end

M.languages = computeLanguages()

return M
