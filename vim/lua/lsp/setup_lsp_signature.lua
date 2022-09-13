local loaded, lsp_signature = pcall(require, 'lsp_signature')

local M = {}

M.setup_lsp_signature = function()
  if not loaded then
    print('lsp_signature not installed. Run PackerInstall / PackerSync')
    return
  end

  lsp_signature.setup({
    bind = false,
    doc_lines = 0,
    hint_prefix = "",
    hint_scheme = "",
    hi_parameter = "LspSignatureActiveParameter",
    max_height = 4,
    max_width = 1000,
    handler_opts = {
      border = "single"
    },
    toggle_key = '<leader>hs'
  })
end

return M
