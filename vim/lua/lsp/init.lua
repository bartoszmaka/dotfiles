local helper = require('helper')
local nnoremap = helper.nnoremap
local vnoremap = helper.vnoremap
local symbols = helper.symbols
local setup_servers = require('lsp.setup_servers').setup_servers
local setup_lsp_status = require('lsp.plugins.lsp-status').setup_lsp_status

local lsp_handlers_hover = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'single'
})

setup_lsp_status()

vim.diagnostic.config({
  update_in_insert = false,
  underline = {
    severity = { min = vim.diagnostic.severity.INFO },
  },
  virtual_text = {
    source = "always",
    severity = { min = vim.diagnostic.severity.INFO },
    spacing = 4,
    prefix = "●",
  },
  signs = true,
  severity_sort = true,
  float = {
    show_header = false,
    border = "rounded",
    focusable = false,
    source = "always",
    format = function(diagnostic)
      -- See null-ls.nvim#632, neovim#17222 for how to pick up `code`
      local user_data
      user_data = diagnostic.user_data or {}
      user_data = user_data.lsp or user_data.null_ls or user_data
      local code = (
      -- TODO: symbol is specific to pylint (will be removed)
      diagnostic.symbol
      or diagnostic.code
      or user_data.symbol
      or user_data.code
    )
      if code then
        return string.format("%s (%s)", diagnostic.message, code)
      else
        return diagnostic.message
      end
    end,
  },
})

vim.fn.sign_define("DiagnosticSignError", { text = symbols.error, texthl = "DiagnosticError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = symbols.warning, texthl = "DiagnosticWarning" })
vim.fn.sign_define("DiagnosticSignInfo", { text = symbols.information, texthl = "DiagnosticInformation" })
vim.fn.sign_define("DiagnosticSignHint", { text = symbols.hint, texthl = "DiagnosticHint" })

vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
vim.cmd("command! LspDiagPrev lua vim.diagnostic.goto_prev()")
vim.cmd("command! LspDiagNext lua vim.diagnostic.goto_next()")
vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")

local opts = { noremap = true, silent = true }
-- some are defined in vim/lua/plugins/lspsaga.lua
-- buf_set_keymap('n', '<leader>K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
-- buf_set_keymap('n', '<leader><C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
-- buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
-- buf_set_keymap('n', '[e', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
-- buf_set_keymap('n', ']e', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
-- buf_set_keymap("n", "gh", "<cmd>lua require('lsp.functions').PeekDefinition()<CR>", opts)
-- buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
-- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
-- set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
nnoremap('gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
nnoremap('<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
vnoremap("<C-m><C-f>", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
vnoremap("<CR><C-f>", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
nnoremap("<C-m><C-f>", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)
nnoremap("<CR><C-f>", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)
nnoremap("<leader>mf", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)
nnoremap("<CR>f", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
nnoremap("<C-m>f", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
nnoremap("<leader>mF", "<cmd>lua vim.lsp.buf.format()<CR>", opts)

setup_servers()
