local symbols = require('config_helper/symbols')

local M = {}

local setup_symbols = function()
  -- >= 0.6
  vim.fn.sign_define("DiagnosticSignError", { text = symbols.error,       texthl = "DiagnosticError" })
  vim.fn.sign_define("DiagnosticSignWarn",  { text = symbols.warning,     texthl = "DiagnosticWarning" })
  vim.fn.sign_define("DiagnosticSignInfo",  { text = symbols.information, texthl = "DiagnosticInformation" })
  vim.fn.sign_define("DiagnosticSignHint",  { text = symbols.information, texthl = "DiagnosticHint" })
end

local setup_legacy_symbols = function()
  -- <= 0.5.1
  vim.fn.sign_define("LspDiagnosticsSignError",       { text = symbols.error,       numhl = "LspDiagnosticsDefaultError" })
  vim.fn.sign_define("LspDiagnosticsSignWarning",     { text = symbols.warning,     numhl = "LspDiagnosticsDefaultWarning" })
  vim.fn.sign_define("LspDiagnosticsSignInformation", { text = symbols.information, numhl = "LspDiagnosticsDefaultInformation" })
  vim.fn.sign_define("LspDiagnosticsSignHint",        { text = symbols.information, numhl = "LspDiagnosticsDefaultHint" })
end

M.setup_diagnostics = function()
  if (vim.fn.has('nvim-0.6') == 0) then
    setup_legacy_symbols()
    return
  end

  vim.diagnostic.config({
    underline = false,
    update_in_insert = false,
    virtual_text = {
      source = 'always',
      severity = {
        min = vim.diagnostic.severity.ERROR,
      },
      -- format = function(diagnostic)
      --   if diagnostic.severity == vim.diagnostic.severity.ERROR then
      --     return string.format("E: %s", diagnostic.message)
      --   end
      --   return diagnostic.message
      -- end
    },
    signs = true,
    severity_sort = true,
    float = {
      show_header = false,
      source = 'always',
      border = false,
      -- format = function(error)
      --   return string.format("%s", error.message)
      -- end
    },
  })

  setup_symbols()
end

return M
