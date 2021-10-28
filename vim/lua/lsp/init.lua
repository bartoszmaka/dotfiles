local setup_servers = require('lsp.setup_servers').setup_servers
local setup_diagnostics = require('lsp.diagnostics').setup_diagnostics
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- local function compatibility_fix(nightly_fn)
-- 	return function(err, method, params, client_id, bufnr, config)
-- 		nightly_fn(err, params, { method = method, client_id = client_id, bufnr = bufnr }, config)
-- 	end
-- end

vim.lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
vim.lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
vim.lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler

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

vim.cmd[[
highlight! LspDiagnosticsUnderlineInformation guibg=NONE gui=NONE
highlight! LspDiagnosticsUnderlineHint guibg=NONE gui=NONE
highlight! LspDiagnosticsUnderlineWarning guibg=#443333 gui=NONE
highlight! LspDiagnosticsUnderlineError guibg=#512121 gui=NONE
]]
