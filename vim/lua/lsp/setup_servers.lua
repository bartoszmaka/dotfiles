-- local helper = require('helper')
local native_capabilities = vim.lsp.protocol.make_client_capabilities()
local loaded_cmp, capabilities = pcall(require, "cmp_nvim_lsp")
local navic = require('nvim-navic')

if loaded_cmp then
  capabilities = capabilities.default_capabilities(native_capabilities)
else
  print("cmp_nvim_lsp not installed")
  capabilities = native_capabilities
end

capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

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
  "tsserver",
  "vimls",
  "vuels",
  "yamlls",
  'cssls',
  'ruby_ls',
  'solargraph',
  'lua_ls',
  'efm',
  'emmet_language_server',
  'prismals',
  'pyright',
}

local on_attach = function(client, bufnr)
  require('lsp-status').on_attach(client)

  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end
end

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = servers,
  automatic_installation = true,
})
local lspconfig = require("lspconfig")

local ls_shared_options = {
  capabilities = capabilities,
  on_attach = on_attach,
  root_dir = vim.loop.cwd,
}
local ls_specific_options = require('lsp/ls_specific_options')

require("typescript").setup({
  disable_commands = false, -- prevent the plugin from creating Vim commands
  debug = false,            -- enable debug logging for commands
  server = {
    capabilities = capabilities,
    on_attach = on_attach,
    root_dir = vim.loop.cwd,
    flags = {
      debounce_text_changes = 150,
    },
  },
})

for _, server_name in ipairs(servers) do
  local opts = vim.tbl_extend("force", ls_shared_options, ls_specific_options[server_name] or {})

  if server_name ~= "tsserver" then
    lspconfig[server_name].setup(opts)
  end
end
