local setup_servers = require('lsp.setup_servers').setup_servers
local setup_lsp_signature = require('lsp.setup_lsp_signature').setup_lsp_signature
local setup_diagnostics = require('lsp.diagnostics').setup_diagnostics
local setup_lsp_status = require('lsp.lsp-status').setup_lsp_status
local nnoremap = require('config_helper').nnoremap

-- local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
-- buf_set_keymap("n", "<C-m><C-f>", "echomsg 'formatters missing'", opts)

-- if pcall(require, 'lsputil.locations') then
--   vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
--   vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
--   vim.lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
--   vim.lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
--   vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
--   vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
--   vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
--   vim.lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler
-- else
--   print('lsputil not installed')
-- end
local lsp_handlers_hover = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'single'
})

vim.lsp.handlers["textDocument/hover"] = function(err, result, ctx, config)
  local bufnr, winnr = lsp_handlers_hover(err, result, ctx, config)
  if winnr ~= nil then
    vim.api.nvim_win_set_option(winnr, "winblend", 20)  -- opacity for hover
  end
  return bufnr, winnr
end


local function preview_location_callback(_, result)
  if result == nil or vim.tbl_isempty(result) then
    return nil
  end
  vim.lsp.util.preview_location(result[1])
end

function PeekDefinition()
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, 'textDocument/definition', params, preview_location_callback)
end

vim.g.mapleader = ' '
-- nnoremap("<leader>gh", ":PeekDefinition<CR>")

setup_servers()
setup_diagnostics()
setup_lsp_signature()
setup_lsp_status()
