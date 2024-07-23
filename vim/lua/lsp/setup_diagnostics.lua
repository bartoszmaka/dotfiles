local symbols = require('helper').symbols
local diagnostics_config = require('lsp.config').diagnostics

vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' })
vim.diagnostic.config(diagnostics_config)
vim.fn.sign_define("DiagnosticSignError", { text = symbols.error, texthl = "DiagnosticError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = symbols.warning, texthl = "DiagnosticWarning" })
vim.fn.sign_define("DiagnosticSignInfo", { text = symbols.information, texthl = "DiagnosticInformation" })
vim.fn.sign_define("DiagnosticSignHint", { text = symbols.hint, texthl = "DiagnosticHint" })

-- vim.api.nvim_create_autocmd('DiagnosticChanged', {
--   callback = function(args)
--     -- vim.print("DiagnosticChanged")
--     local diagnostics = args.data.diagnostics
--     -- vim.print(diagnostics)
--   end,
-- })
