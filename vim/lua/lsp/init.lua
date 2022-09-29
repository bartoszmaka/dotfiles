local setup_servers = require('lsp.setup_servers').setup_servers
local setup_lsp_signature = require('lsp.setup_lsp_signature').setup_lsp_signature
local setup_diagnostics = require('lsp.setup_diagnostics').setup_diagnostics
local setup_lsp_status = require('lsp.plugins.lsp-status').setup_lsp_status

local lsp_handlers_hover = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'single'
})

vim.lsp.handlers['textDocument/hover'] = function(err, result, ctx, config)
  local bufnr, winnr = lsp_handlers_hover(err, result, ctx, config)
  if winnr ~= nil then
    vim.api.nvim_win_set_option(winnr, 'winblend', 20)  -- opacity for hover
  end
  return bufnr, winnr
end

setup_servers()
setup_diagnostics()
setup_lsp_signature()
setup_lsp_status()
