local symbols = require('config_helper/symbols')
-- require('lsp/lspkind')
local efm = require('lsp/efm')
local on_attach = require('lsp/on_attach')

local function compatibility_fix(nightly_fn)
	return function(err, method, params, client_id, bufnr, config)
		nightly_fn(err, params, { method = method, client_id = client_id, bufnr = bufnr }, config)
	end
end

vim.lsp.handlers['textDocument/definition'] = compatibility_fix(require'lsputil.locations'.definition_handler)
vim.lsp.handlers['textDocument/declaration'] = compatibility_fix(require'lsputil.locations'.declaration_handler)
vim.lsp.handlers['textDocument/implementation'] = compatibility_fix(require'lsputil.locations'.implementation_handler)

vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
vim.lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local function setup_servers()
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

setup_servers()

vim.fn.sign_define("LspDiagnosticsSignError", {text = symbols.error, numhl = "LspDiagnosticsDefaultError"})
vim.fn.sign_define("LspDiagnosticsSignWarning", {text = symbols.warning, numhl = "LspDiagnosticsDefaultWarning"})
vim.fn.sign_define("LspDiagnosticsSignInformation", {text = symbols.information, numhl = "LspDiagnosticsDefaultInformation"})
vim.fn.sign_define("LspDiagnosticsSignHint", {text = symbols.information, numhl = "LspDiagnosticsDefaultHint"})

vim.cmd[[
highlight! LspDiagnosticsUnderlineInformation guibg=NONE gui=NONE
highlight! LspDiagnosticsUnderlineHint guibg=NONE gui=NONE
highlight! LspDiagnosticsUnderlineWarning guibg=#443333 gui=NONE
highlight! LspDiagnosticsUnderlineError guibg=#512121 gui=NONE
]]
