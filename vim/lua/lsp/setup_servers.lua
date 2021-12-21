local efm = require('lsp/efm')
local on_attach = require('lsp/on_attach')
local native_capabilities = vim.lsp.protocol.make_client_capabilities()
local loaded_cmp, capabilities = pcall(require, 'cmp_nvim_lsp')

if loaded_cmp then
  capabilities = capabilities.update_capabilities(native_capabilities)
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

-- { "solargraph", "efm", "yamlls", "json", "css", "graphql", "typescript", "html", "lua" }
local M = {}

M.setup_servers = function()
  local loaded_installer, lsp_installer = pcall(require, "nvim-lsp-installer")
  if not loaded_installer then
    print('nvim-lsp-installer not installed')
    return
  end

  lsp_installer.on_server_ready(function(server)
    local opts = {
      capabilities = capabilities,
      on_attach = on_attach,
      root_dir = vim.loop.cwd,
      flags = {
        debounce_text_changes = 150,
      }
    }

    if server.name == "solargraph" then
      -- opts.cmd = { "solargraph", "stdio" }
      opts.settings = {
        solargraph = {
          diagnostics = true
        }
      }

    elseif server.name == "sumneko_lua" then
      opts.root_dir = function()
        return vim.loop.cwd()
      end
      opts.settings = {
        Lua = {
          diagnostics = {
            globals = {"vim"}
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

    elseif server.name == "efm" then
      opts.filetypes = vim.tbl_keys(efm.languages)
      opts.init_options = {documentFormatting = true, codeAction = true}
      opts.settings = {
        rootMarkers = {".git/"},
        languages = efm.languages
      }
    end

    if server.name == "solargraph" then
      -- use gem installed solargraph
      require('lspconfig')['solargraph'].setup(opts)
    else
      -- otherwise use nvim-lsp-installer LSPs
      server:setup(opts)
    end
    vim.cmd([[ do User LspAttach Buffers ]])
  end)

end

return M
