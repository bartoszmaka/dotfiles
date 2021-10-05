local M = {}

local on_attach = require('lsp/on_attach')
local prettier = require("efm/prettier")
local eslint = require("efm/eslint")
local rubocop = require("efm/rubocop")
local standardrb = require("efm/standardrb")
-- local rubocop_legacy = require("efm/rubocop_legacy")

local computeLanguages = function()
  local languages = {
    typescript = {prettier, eslint},
    javascript = {prettier, eslint},
    typescriptreact = {prettier, eslint},
    javascriptreact = {prettier, eslint},
    yaml = {prettier},
    json = {prettier},
    html = {prettier},
    scss = {prettier},
    css = {prettier},
    markdown = {prettier},
    sass = { prettier },
    less = { prettier },
    graphql = { prettier },
    vue = { prettier },
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
