local M = {}
M.setup_capabilities = function()
  local native_capabilities = vim.lsp.protocol.make_client_capabilities()
  local loaded_cmp, cmp_capabilities = pcall(require, "cmp_nvim_lsp")
  local capabilities = nil

  if loaded_cmp then
    capabilities = cmp_capabilities.default_capabilities(native_capabilities)
    capabilities.textDocument.completion.completionItem = {
      documentationFormat = { "markdown", "plaintext" },
      snippetSupport = true,
      preselectSupport = true,
      insertReplaceSupport = true,
      labelDetailsSupport = true,
      deprecatedSupport = true,
      commitCharactersSupport = true,
      tagSupport = { valueSet = { 1 } },
      resolveSupport = { properties = { "documentation", "detail", "additionalTextEdits" } },
    }
  else
    print("cmp_nvim_lsp not installed")
    capabilities = native_capabilities
  end

  -- capabilities.textDocument.foldingRange = {
  --   dynamicRegistration = false,
  --   lineFoldingOnly = true
  -- }

end

return M
