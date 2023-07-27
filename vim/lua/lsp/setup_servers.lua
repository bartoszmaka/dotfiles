local helper = require('helper')
local native_capabilities = vim.lsp.protocol.make_client_capabilities()
local loaded_cmp, capabilities = pcall(require, "cmp_nvim_lsp")

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
  -- 'ruby_ls',
  -- 'solargraph',
  'lua_ls',
}

-- local navic_loaded, navic = pcall(require, "nvim-navic")

local on_attach = function(client, bufnr)
  -- if not navic_loaded then
  --   print "Error while loading nvim-navic"
  -- else
  --   navic.attach(client, bufnr)
  -- end
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  require('lsp-status').on_attach(client)

  if helper.set_contains({ 'css', 'scss', 'sass' }, vim.bo.filetype) then
    buf_set_option('omnifunc', 'csscomplete#CompleteCSS')
  else
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  end
  -- Mappings.
  local opts = { noremap = true, silent = true }

  helper.set_default_formatter_for_filetypes('solargraph', { 'ruby' })
  helper.set_default_formatter_for_filetypes('null-ls', { 'javascript', 'vue' })
  helper.set_default_formatter_for_filetypes('sumneko_lua', { 'lua' })
end

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = servers,
  automatic_installation = { exclude = { "solargraph", "ruby_ls" } },
})
local lspconfig = require("lspconfig")

local M = {}

M.setup_servers = function()
  lspconfig["ruby_ls"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    root_dir = vim.loop.cwd,
    flags = {
      debounce_text_changes = 150,
    },
    -- cmd = { "bundle", "exec", "ruby-lsp" }
  })

  lspconfig["solargraph"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    root_dir = vim.loop.cwd,
    flags = {
      debounce_text_changes = 150,
    },
    settings = {
      solargraph = {
        diagnostics = true,
      },
    },
  })
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
    local opts = {
      capabilities = capabilities,
      on_attach = on_attach,
      root_dir = vim.loop.cwd,
      flags = {
        debounce_text_changes = 150,
      },
    }

    --     if server_name == "solargraph" then
    --       opts.settings = {
    --         solargraph = {
    --           diagnostics = true
    --         }
    --       }
    --     end

    if server_name == "lua_ls" then
      opts.root_dir = function()
        return vim.loop.cwd()
      end
      opts.settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
            },
          },
          telemetry = {
            enable = false,
          },
        },
      }
    elseif server_name == "jsonls" then
      opts.on_new_config = function(new_config)
        new_config.settings.json.schemas = new_config.settings.json.schemas or {}
        vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
      end
      opts.settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
          format = { enable = true }
        },
      }
    elseif server_name == "yamlls" then
      opts.settings = {
        yaml = {
          keyOrdering = false,
        },
      }
    end

    if server_name ~= "tsserver" then
      lspconfig[server_name].setup(opts)
    end
  end
  vim.cmd([[ do User LspAttach Buffers ]])
end

return M
