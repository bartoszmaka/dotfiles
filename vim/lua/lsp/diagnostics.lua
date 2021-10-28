local symbols = require('config_helper/symbols')

local M = {}

local setup_symbols = function()
  -- >= 0.6
  vim.fn.sign_define("DiagnosticSignError", { text = symbols.error,       numhl = "DiagnosticError" })
  vim.fn.sign_define("DiagnosticSignWarn",  { text = symbols.warning,     numhl = "DiagnosticWarning" })
  vim.fn.sign_define("DiagnosticSignInfo",  { text = symbols.information, numhl = "DiagnosticInformation" })
  vim.fn.sign_define("DiagnosticSignHint",  { text = symbols.information, numhl = "DiagnosticHint" })
end

local setup_legacy_symbols = function()
  -- <= 0.5.1
  vim.fn.sign_define("LspDiagnosticsSignError",       { text = symbols.error,       numhl = "LspDiagnosticsDefaultError" })
  vim.fn.sign_define("LspDiagnosticsSignWarning",     { text = symbols.warning,     numhl = "LspDiagnosticsDefaultWarning" })
  vim.fn.sign_define("LspDiagnosticsSignInformation", { text = symbols.information, numhl = "LspDiagnosticsDefaultInformation" })
  vim.fn.sign_define("LspDiagnosticsSignHint",        { text = symbols.information, numhl = "LspDiagnosticsDefaultHint" })
end

M.setup_diagnostics = function()
  vim.diagnostic.config({
    underline = false,
    update_in_insert = false,
    virtual_text = {
      spacing = 4,
      source = 'always',
      severity = {
        min = vim.diagnostic.severity.HINT,
      },
      format = function(error)
        return string.format("%s: %s", error.source, error.message)
      end
    },
    signs = true,
    severity_sort = true,
    float = {
      show_header = false,
      source = 'always',
      border = 'single',
      format = function(error)
        -- print(vim.inspect(error))
        return string.format("%s: %s", error.source, error.message)
      end
    },
  })

  setup_symbols()
  setup_legacy_symbols()
end

return M
