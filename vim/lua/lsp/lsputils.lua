local function compatibility_fix(nightly_fn)
	return function(err, method, params, client_id, bufnr, config)
		nightly_fn(err, params, { method = method, client_id = client_id, bufnr = bufnr }, config)
	end
end

-- local function compatibility_fix(stable_fn)
-- 	return function(err, result, ctx, config)
-- 		stable_fn(err, ctx.method, result, ctx.client_id, ctx.bufnr, config)
-- 	end
-- end

vim.lsp.handlers['textDocument/definition'] = compatibility_fix(require'lsputil.locations'.definition_handler)
vim.lsp.handlers['textDocument/declaration'] = compatibility_fix(require'lsputil.locations'.declaration_handler)
vim.lsp.handlers['textDocument/implementation'] = compatibility_fix(require'lsputil.locations'.implementation_handler)

vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
vim.lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler
