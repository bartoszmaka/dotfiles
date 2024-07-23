local helper = require('helper')
local navic = require('nvim-navic')
local capabilities = require('lsp.setup_capabilities').setup_capabilities()

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
  'ruby_lsp',
  'solargraph',
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

    if callback then
      callback(client, bufnr)
    end

    if client.server_capabilities.documentSymbolProvider then
      navic.attach(client, bufnr)
    end
  end
end


local servers_with_custom_config = { 'tsserver', 'ruby_lsp' }

for _, server_name in ipairs(servers) do
  local ls_shared_options = {
    capabilities = capabilities,
    on_attach = build_on_attach(),
    root_dir = vim.loop.cwd,
  }
  local ls_specific_options = require('lsp/ls_specific_options')
  local opts = vim.tbl_extend("force", vim.deepcopy(ls_shared_options), ls_specific_options[server_name] or {})

  -- if server_name == "ruby_lsp" then
  --   local solargraphq_opts = {
  --     capabilities = capabilities,
  --     on_attach = build_on_attach(
  --       function(client, _bufnr)
  --         -- client.server_capabilities.completionProvider = false
  --         -- client.server_capabilities.definitionProvider = false
  --         -- client.server_capabilities.documentLinkProvider = false
  --       end
  --     ),
  --     root_dir = vim.loop.cwd,
  --   }
  --   lspconfig[server_name].setup(solargraphq_opts)
  -- end

  if server_name == "ruby_lsp" then
    local ruby_lsp_opts = {
      capabilities = capabilities,
      on_attach = build_on_attach(
        function(client, _bufnr)
          client.server_capabilities.completionProvider = false
          client.server_capabilities.definitionProvider = false
          client.server_capabilities.documentLinkProvider = false
        end
      ),
      root_dir = vim.loop.cwd,
    }
    lspconfig[server_name].setup(ruby_lsp_opts)
  end

  if not helper.set_contains(servers_with_custom_config, server_name) then
    lspconfig[server_name].setup(opts)
  end
end
