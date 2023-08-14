local helper = require('helper')
local nnoremap = helper.nnoremap
local vnoremap = helper.vnoremap

local M = {}

M.setup_mappings = function()
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

  -- nnoremap('gd', ":lua require('telescope.builtin').lsp_definitions({})<CR>")
  -- nnoremap('gr', ":lua require('telescope.builtin').lsp_references({})<CR>")
  -- nnoremap('gic', ":lua require('telescope.builtin').lsp_incoming_calls({})<CR>")
  -- nnoremap('goc', ":lua require('telescope.builtin').lsp_outgoing_calls({})<CR>")
end

return M
