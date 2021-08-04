-- require("nvim-ale-diagnostic")
require('lsp/lspkind')
require('fzf_lsp').setup()
local efm = require('lsp/efm')
local on_attach = require('lsp/on_attach')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

local function setup_servers()
  local lspinstall = require "lspinstall"
  lspinstall.setup()

  local lspconf = require("lspconfig")
  local servers = lspinstall.installed_servers()

  for _, lang in pairs(servers) do
    if lang == "ruby" then
      lspconf[lang].setup {
        cmd = { "solargraph", "stdio" },
        flags = { debounce_text_changes = 150, },
        on_attach = on_attach,
        root_dir = vim.loop.cwd,
        capabilities = capabilities,
      }
    elseif lang == "lua" then
      lspconf[lang].setup {
        on_attach = on_attach,
        root_dir = function()
          return vim.loop.cwd()
        end,
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
        settings = {
          rootMarkers = {".git/"},
          languages = efm.languages
        },
        filetypes = vim.tbl_keys(efm.languages),
        init_options = {documentFormatting = true, codeAction = true},
        on_attach = on_attach,
        root_dir = vim.loop.cwd
      }
    else
      lspconf[lang].setup {
        on_attach = on_attach,
        root_dir = vim.loop.cwd
      }
    end
  end
end

setup_servers()

vim.fn.sign_define("LspDiagnosticsSignError", {text = "", numhl = "LspDiagnosticsDefaultError"})
vim.fn.sign_define("LspDiagnosticsSignWarning", {text = "", numhl = "LspDiagnosticsDefaultWarning"})
vim.fn.sign_define("LspDiagnosticsSignInformation", {text = "", numhl = "LspDiagnosticsDefaultInformation"})
vim.fn.sign_define("LspDiagnosticsSignHint", {text = "", numhl = "LspDiagnosticsDefaultHint"})
vim.cmd[[
highlight! LspDiagnosticsUnderlineInformation guibg=NONE gui=NONE
highlight! LspDiagnosticsUnderlineHint guibg=NONE gui=NONE
highlight! LspDiagnosticsUnderlineWarning guibg=#443333 gui=NONE
highlight! LspDiagnosticsUnderlineError guibg=#512121 gui=NONE
]]
