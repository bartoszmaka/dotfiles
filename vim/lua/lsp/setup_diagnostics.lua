local symbols = require('helper').symbols

vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' })
vim.diagnostic.config({
  update_in_insert = false,
  underline = {
    severity = { min = vim.diagnostic.severity.HINT },
  },
  virtual_text = {
    source = "always",
    severity = { min = vim.diagnostic.severity.HINT },
    spacing = 4,
    prefix = "●",
  },
  signs = true,
  severity_sort = true,
  float = {
    show_header = false,
    border = "single",
    focusable = false,
    source = "always",
    format = function(diagnostic)
      -- See null-ls.nvim#632, neovim#17222 for how to pick up `code`
      local user_data
      user_data = diagnostic.user_data or {}
      user_data = user_data.lsp or user_data.null_ls or user_data
      local code = (
      -- TODO: symbol is specific to pylint (will be removed)
      diagnostic.symbol
      or diagnostic.code
      or user_data.symbol
      or user_data.code
    )
      if code then
        return string.format("%s (%s)", diagnostic.message, code)
      else
        return diagnostic.message
      end
    end,
  },
})
vim.fn.sign_define("DiagnosticSignError", { text = symbols.error, texthl = "DiagnosticError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = symbols.warning, texthl = "DiagnosticWarning" })
vim.fn.sign_define("DiagnosticSignInfo", { text = symbols.information, texthl = "DiagnosticInformation" })
vim.fn.sign_define("DiagnosticSignHint", { text = symbols.hint, texthl = "DiagnosticHint" })
