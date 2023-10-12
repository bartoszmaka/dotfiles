local helper = require('helper')
local nnoremap = helper.nnoremap
local vnoremap = helper.vnoremap

local opts = { noremap = true, silent = true }
nnoremap("gd", "<cmd>Lspsaga goto_definition<CR>")
nnoremap("gr", "<cmd>Lspsaga finder<CR>")
nnoremap("<leader>ca", "<cmd>Lspsaga code_action<CR>")

vnoremap("<C-m><C-f>", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
nnoremap("<C-m><C-f>", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)

nnoremap('gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
nnoremap('<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)

nnoremap("<leader>gh", "<cmd>Lspsaga peek_definition<CR>")

nnoremap("<leader>gr", "<cmd>Lspsaga rename<CR>")
nnoremap("<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>")
nnoremap("<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>")
nnoremap("<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>")
nnoremap("[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
nnoremap("]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")
nnoremap("[E", function() require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR }) end)
nnoremap("]E", function() require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR }) end)
nnoremap("<C-k><C-v>", "<cmd>Lspsaga outline<CR>")
nnoremap("<leader>K", "<cmd>Lspsaga hover_doc<CR>")
nnoremap("<leader><C-k>", "<Cmd>Lspsaga signature_help<CR>")
nnoremap("<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
nnoremap("<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>")

-- nnoremap('gd', ":lua require('telescope.builtin').lsp_definitions({})<CR>")
-- nnoremap('gr', ":lua require('telescope.builtin').lsp_references({})<CR>")
-- nnoremap('gic', ":lua require('telescope.builtin').lsp_incoming_calls({})<CR>")
-- nnoremap('goc', ":lua require('telescope.builtin').lsp_outgoing_calls({})<CR>")
--
-- buf_set_keymap('n', '<leader>K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
-- buf_set_keymap('n', '<leader><C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
-- buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
-- buf_set_keymap('n', '[e', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
-- buf_set_keymap('n', ']e', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
-- buf_set_keymap("n", "gh", "<cmd>lua require('lsp.functions').PeekDefinition()<CR>", opts)
-- buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
-- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
-- set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)

-- vim.lsp.buf.hover()
-- vim.lsp.buf.code_action()

-- nnoremap("gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
-- nnoremap("gr", "<cmd>lua vim.lsp.buf.references()<CR>")
-- nnoremap("<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
-- vnoremap("<CR><C-f>", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
-- nnoremap("<CR><C-f>", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)
-- nnoremap("K", "<cmd>Lspsaga hover_doc ++keep<CR>")
