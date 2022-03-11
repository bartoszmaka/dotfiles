local setup_servers = require('lsp.setup_servers').setup_servers
local setup_lsp_signature = require('lsp.setup_lsp_signature').setup_lsp_signature
local setup_diagnostics = require('lsp.diagnostics').setup_diagnostics

-- local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
-- buf_set_keymap("n", "<C-m><C-f>", "echomsg 'formatters missing'", opts)

if pcall(require, 'lsputil.locations') then
  vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
  vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
  vim.lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
  vim.lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
  vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
  vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
  vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
  vim.lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler
else
  print('lsputil not installed')
end


setup_servers()
setup_diagnostics()
setup_lsp_signature()
