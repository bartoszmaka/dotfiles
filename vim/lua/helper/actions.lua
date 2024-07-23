local helper = require('helper')
local diagnostics_config = require('lsp.config').diagnostics

local M = {}

function M.inlay_hints()
  if vim.lsp.inlay_hint then
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    vim.notify(("Global inlay hints %s"):format(helper.bool2str(vim.lsp.inlay_hint.is_enabled())))
  end
end

function M.toggle_diagnostics()
  if vim.g.diagnostics_disabled ~= true then
    vim.g.diagnostics_disabled = true
    local config = vim.tbl_deep_extend(
      "force",
      diagnostics_config,
      { underline = false, virtual_text = false, signs = false, update_in_insert = false }
    )
    vim.diagnostic.config(config)
  elseif vim.g.diagnostics_disabled == true then
    vim.g.diagnostics_disabled = false
    vim.diagnostic.config(diagnostics_config)
  end
  vim.notify(("Diagnostics: %s"):format(helper.bool2str(not vim.g.diagnostics_disabled)))
end

return M
