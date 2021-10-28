local M = {}

local on_attach = require('lsp/on_attach')
local prettier = require("efm/prettier")
local prettier_d = require("efm/prettier_d")
local eslint = require("efm/eslint")
local rubocop = require("efm/rubocop")
local standardrb = require("efm/standardrb")
-- local rubocop_legacy = require("efm/rubocop_legacy")

local computeLanguages = function()
  local languages = {
    typescript = { prettier_d, eslint },
    javascript = { prettier_d, eslint },
    typescriptreact = { prettier_d, eslint },
    javascriptreact = { prettier_d, eslint },
    yaml = { prettier_d },
    json = { prettier_d },
    html = { prettier_d },
    scss = { prettier_d },
    css = { prettier_d },
    markdown = { prettier_d },
    sass = { prettier_d },
    less = { prettier_d },
    graphql = { prettier_d },
    vue = { prettier_d },
    ruby = { rubocop }
  }

  local project = vim.fn.getcwd()
  if string.match(project, 'DevQAHub') then
    languages.ruby = { standardrb }
  end

  return languages
end

M.languages = computeLanguages()

return M
