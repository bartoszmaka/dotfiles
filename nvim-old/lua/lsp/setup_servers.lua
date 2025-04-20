-- local capabilities = require('lsp.setup_capabilities').setup_capabilities()

local servers = {
  "bashls",
  "dockerls",
  "graphql",
  "html",
  "jsonls",
  "rust_analyzer",
  "sqlls",
  "stylelint_lsp",
  "tailwindcss",
  "terraformls",
  "vimls",
  "vuels",
  "yamlls",
  'cssls',
  'ruby_lsp',
  'lua_ls',
  'efm',
  'emmet_language_server',
  'prismals',
  'pyright',
  'lemminx',
  'vtsls'
}


require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = servers,
  automatic_installation = true,
})
local lspconfig = require("lspconfig")

local build_on_attach = function(callback)
  return function(client, bufnr)
    require('lsp-status').on_attach(client)

    if client.supports_method "textDocument/codeLens" then
      vim.lsp.codelens.refresh { bufnr = bufnr }
    end

    if callback then
      callback(client, bufnr)
    end
  end
end


for _, server_name in ipairs(servers) do
  local ls_shared_options = {
    capabilities = capabilities,
    on_attach = build_on_attach(),
    root_dir = vim.loop.cwd,
  }
  local ls_specific_options = require('lsp/ls_specific_options')
  local opts = vim.tbl_extend("force", vim.deepcopy(ls_shared_options), ls_specific_options[server_name] or {})

    lspconfig[server_name].setup(opts)
end
