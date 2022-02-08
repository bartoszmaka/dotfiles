local M = {}

local on_attach = require('lsp/on_attach')

local prettier = require("efm/prettier")
local prettier_d = require("efm/prettier_d")
local eslint = require("efm/eslint")
local rubocop = require("efm/rubocop")
local standardrb = require("efm/standardrb")
local stylelint = require("efm/stylelint")

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
    eruby = { rubocop },
    ruby = { rubocop },
  }

  local project = vim.fn.getcwd()
  if string.match(project, 'DevQAHub') then
    languages.ruby = { standardrb }
  end

  return languages
end

M.languages = computeLanguages()

return M
