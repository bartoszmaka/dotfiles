local setup_servers = require('lsp.setup_servers').setup_servers
local setup_lsp_signature = require('lsp.setup_lsp_signature').setup_lsp_signature
local setup_diagnostics = require('lsp.diagnostics').setup_diagnostics
local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = {
    source = "always",  -- Or "if_many"
  }
})

setup_servers()
setup_diagnostics()
setup_lsp_signature()

vim.cmd[[
highlight! LspDiagnosticsUnderlineInformation guibg=NONE gui=NONE
highlight! LspDiagnosticsUnderlineHint guibg=NONE gui=NONE
highlight! LspDiagnosticsUnderlineWarning guibg=#443333 gui=NONE
highlight! LspDiagnosticsUnderlineError guibg=#512121 gui=NONE
]]
