local M = {}

local on_attach = require('lsp/on_attach')
local prettier = require("efm/prettier")
local eslint = require("efm/eslint")
-- local rubocop = require("efm/rubocop")
local standardrb = require("efm/standardrb")

M.languages = {
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
}

local project = vim.fn.getcwd()
if string.match(project, 'DevQAHub') then
  M.languages.ruby = { standardrb }
end

-- M.setup = {
--   settings = {
--     rootMarkers = {".git/"},
--     languages = languages
--   },
--   filetypes = vim.tbl_keys(languages),
--   init_options = {documentFormatting = true, codeAction = true},
--   on_attach = on_attach,
--   root_dir = vim.loop.cwd
-- }

return M
