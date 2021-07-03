-- require("nvim-ale-diagnostic")

-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics, {
--     underline = true,
--     virtual_text = true,
--     signs = true,
--     update_in_insert = false,
--   }
-- )

require'fzf_lsp'.setup()

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<leader>K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<leader><C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap("n", "<C-l><C-f>", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

  buf_set_keymap('n', '[e', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']e', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

  buf_set_keymap("n", "<C-m><C-f>", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  buf_set_keymap("n", "<C-m><C-f>", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

  -- Set autocommands conditional on server_capabilities
  -- if client.resolved_capabilities.document_highlight then
  --   require('lspconfig').util.nvim_multiline_command [[
  --     :hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
  --     :hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
  --     :hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
  --     augroup lsp_document_highlight
  --       autocmd!
  --       autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
  --       autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
  --     augroup END
  --   ]]
  -- end
end

require('lspkind').init({
  with_text = true,
  preset = 'codicons',
  symbol_map = {
    Text = '',
    Method = 'ƒ',
    Function = 'ƒ',
    Constructor = '',
    Variable = '',
    Class = 'C',
    Interface = 'i',
    Module = '',
    Property = '',
    Unit = '',
    Value = '',
    Enum = 'e',
    Keyword = 'k',
    Snippet = 's',
    Color = '',
    File = '',
    Folder = '',
    EnumMember = '',
    Constant = '',
    Struct = ''
  },
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}
-- Formatting via efm
local prettier = require "efm/prettier"
local eslint = require "efm/eslint"
-- local luafmt = require "efm/luafmt"
-- local rustfmt = require "efm/rustfmt"
-- local autopep = require "efm/autopep8"

local languages = {
    -- lua = {luafmt},
    typescript = {prettier, eslint},
    javascript = {prettier, eslint},
    typescriptreact = {prettier, eslint},
    javascriptreact = {prettier, eslint},
    yaml = {prettier},
    json = {prettier},
    html = {prettier},
    scss = {prettier},
    css = {prettier},
    markdown = {prettier},
    -- rust = {rustfmt}
    -- python = {autopep}
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
    elseif lang == "emf" then
      lspconf[lang].setup {
        root_dir = lspconf.util.root_pattern("yarn.lock", "lerna.json", ".git"),
        filetypes = vim.tbl_keys(languages),
        init_options = {documentFormatting = true, codeAction = true},
        settings = {languages = languages, log_level = 1, log_file = '/tmp/efm.log'},
        on_attach = on_attach
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
