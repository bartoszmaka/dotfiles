local efm = require('lsp/efm')
local on_attach = require('lsp/on_attach')
local capabilities = vim.lsp.protocol.make_client_capabilities()

local M = {}

M.setup_servers = function()
  local lspinstall = require "lspinstall"
  lspinstall.setup()

  local lspconf = require("lspconfig")
  local servers = lspinstall.installed_servers()
  -- { "ruby", "efm", "yaml", "json", "css", "graphql", "typescript", "html", "lua" }

  for _, lang in pairs(servers) do
    if lang == "ruby" then
      lspconf[lang].setup {
        cmd = { "solargraph", "stdio" },
        flags = { debounce_text_changes = 150, },
        on_attach = on_attach,
        root_dir = vim.loop.cwd,
        capabilities = capabilities,
        settings = {
          solargraph = {
            diagnostics = true
          }
        }
      }
    elseif lang == "lua" then
      lspconf[lang].setup {
        on_attach = on_attach,
        capabilities = capabilities,
        root_dir = function()
          return vim.loop.cwd()
        end,
        flags = {
          debounce_text_changes = 150,
        },
        settings = {
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
      }
    elseif lang == "efm" then
      lspconf[lang].setup {
        capabilities = capabilities,
        settings = {
          rootMarkers = {".git/"},
          languages = efm.languages
        },
        filetypes = vim.tbl_keys(efm.languages),
        init_options = {documentFormatting = true, codeAction = true},
        on_attach = on_attach,
        root_dir = vim.loop.cwd,
        flags = {
          debounce_text_changes = 150,
        }
      }
    else
      lspconf[lang].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        root_dir = vim.loop.cwd,
        flags = {
          debounce_text_changes = 150,
        }
      }
    end
  end
end

return M
