local M = {}

M.diagnostics = {
  update_in_insert = false,
  underline = {
    severity = { min = vim.diagnostic.severity.HINT },
  },
  virtual_text = {
    source = true,
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
    source = true,
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
}
return M
