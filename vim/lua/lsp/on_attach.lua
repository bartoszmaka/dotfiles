local set_contains = require('config_helper.set_contains').set_contains
local set_default_formatter_for_filetypes = require('lsp.functions').set_default_formatter_for_filetypes
-- local navic_loaded, navic = pcall(require, "nvim-navic")

local on_attach = function(client, bufnr)
  -- if not navic_loaded then
  --   print "Error while loading nvim-navic"
  -- else
  --   navic.attach(client, bufnr)
  -- end
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  require('lsp-status').on_attach(client)

  if set_contains({ 'css', 'scss', 'sass' }, vim.bo.filetype) then
    buf_set_option('omnifunc', 'csscomplete#CompleteCSS')
  else
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  end
  -- Mappings.
  local opts = { noremap = true, silent = true }

  set_default_formatter_for_filetypes('solargraph', { 'ruby' })
  set_default_formatter_for_filetypes('null-ls', { 'javascript', 'vue' })
  set_default_formatter_for_filetypes('sumneko_lua', { 'lua' })

end

return on_attach
