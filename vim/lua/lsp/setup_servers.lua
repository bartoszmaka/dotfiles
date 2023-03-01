local on_attach = require('lsp/on_attach')
local lspconfig = require('lspconfig')
local native_capabilities = vim.lsp.protocol.make_client_capabilities()
local loaded_cmp, capabilities = pcall(require, 'cmp_nvim_lsp')

if loaded_cmp then
  capabilities = capabilities.default_capabilities(native_capabilities)
else
  print('cmp_nvim_lsp not installed')
  capabilities = native_capabilities
end

capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

local servers = {
  -- 'bashls',
  'dockerls',
  'graphql',
  'html',
  'jsonls',
  -- 'solargraph', -- install manually
  -- 'solidity_ls',
  'sqlls',
  'sqls',
  'stylelint_lsp',
  'lua_ls',
  'tailwindcss',
  'terraformls',
  'tsserver',
  'vimls',
  'vuels',
  'yamlls',
}

require('mason').setup()
require('mason-lspconfig').setup(
  { ensure_installed = servers }
)


local M = {}

-- local configs = require 'lspconfig.configs'
-- configs['ruby-lsp'] = {
--   default_config = {
--     cmd = { "ruby-lsp" },
--     filetypes = { "ruby" },
--     root_dir = vim.loop.cwd,
--   }
-- }

M.setup_servers = function()

  lspconfig['ruby_ls'].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    root_dir = vim.loop.cwd,
    flags = {
      debounce_text_changes = 150,
    },
    -- cmd = { "bundle", "exec", "ruby-lsp" }
  })

  lspconfig['solargraph'].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    root_dir = vim.loop.cwd,
    flags = {
      debounce_text_changes = 150,
    },
    settings = {
      solargraph = {
        diagnostics = true
      }
    }
  })
  require("typescript").setup({
    disable_commands = false, -- prevent the plugin from creating Vim commands
    debug = false, -- enable debug logging for commands
    server = {
      capabilities = capabilities,
      on_attach = on_attach,
      root_dir = vim.loop.cwd,
      flags = {
        debounce_text_changes = 150,
      }
    },
  })

  for _, server_name in ipairs(servers) do
    local opts = {
      capabilities = capabilities,
      on_attach = on_attach,
      root_dir = vim.loop.cwd,
      flags = {
        debounce_text_changes = 150,
      }
    }

    if server_name == "lua_ls" then
      opts.root_dir = function()
        return vim.loop.cwd()
      end
      opts.settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" }
          },
          workspace = {
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
            }
          },
          telemetry = {
            enable = false
          }
        }
      }
    elseif server_name == "jsonls" then
      opts.settings = {
        json = {
          schemas = require('schemastore').json.schemas(),
          validate = { enable = true },
        },
      }
    end

    if server_name ~= 'tsserver' then
      lspconfig[server_name].setup(opts)
    end
  end
  vim.cmd([[ do User LspAttach Buffers ]])
end

return M
