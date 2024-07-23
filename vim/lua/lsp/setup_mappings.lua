local helper = require('helper')
local nnoremap = helper.nnoremap
local vnoremap = helper.vnoremap
local actions = require('helper.actions')

local opts = { noremap = true, silent = true }

nnoremap("<leader>uH", function() actions.toggle_inlay_hints() end)
nnoremap("<leader>ud", function() actions.toggle_diagnostics() end)

-- nnoremap("<leader>ca", "<cmd>Lspsaga code_action<CR>", { desc = "Code Actions" })
nnoremap("<leader>ca", [[:lua require("fzf-lua").lsp_code_actions()<CR>]], { desc = "Code Actions" })
vnoremap("<C-m><C-f>", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", { desc = "Format" })
nnoremap("<C-m><C-f>", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", { desc = "Format" })
nnoremap('<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', { desc = "Go to definition" })
nnoremap("<leader>gh", "<cmd>Lspsaga peek_definition<CR>", { desc = "Peek definition" })
nnoremap("<F2>", "<cmd>Lspsaga rename<CR>", { desc = "Rename" })
-- nnoremap("<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>", { desc = "Line Diagnostics" })
-- nnoremap("<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { desc = "Diagnostics" })
-- nnoremap("<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>", { desc = "File Diagnostics" })
-- nnoremap("[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { desc = "Prev Diagnostics" })
-- nnoremap("]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { desc = "Next Diagnostics" })

nnoremap("[e", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { desc = "Prev Diagnostics" })
nnoremap("]e", "<cmd>lua vim.diagnostic.goto_next()<CR>", { desc = "Next Diagnostics" })
-- nnoremap("[E", function() require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, { desc = "Prev Error" })
-- nnoremap("]E", function() require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR }) end, { desc = "Next Error" })
nnoremap("<C-k><C-v>", "<cmd>Lspsaga outline<CR>", { desc = "Symbols bar" })
nnoremap("<leader>K", "<cmd>Lspsaga hover_doc<CR>", { desc = "Hover" })
-- nnoremap("<leader><C-k>", "<Cmd>Lspsaga signature_help<CR>", { desc = "Signature help" })
-- nnoremap("<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>", { desc = "Incoming calls" })
-- nnoremap("<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>", { desc = "Outgoing calls" })
nnoremap('gd', [[:lua require("fzf-lua").lsp_definitions({ jump_to_single_result = true })<CR>]], { desc = "Definitions" })
nnoremap('gD', function() vim.lsp.buf.definition() end, { desc = "Definitions" })
nnoremap('gF', [[:lua require("fzf-lua").lsp_finder()<CR>]], { desc = "LSP Finder" })
nnoremap('gr', [[:lua require("fzf-lua").lsp_references({ ignore_current_line = true })<CR>]], { desc = "References" })

-- nnoremap('gd', ":lua require('telescope.builtin').lsp_definitions({})<CR>")
-- nnoremap('gr', ":lua require('telescope.builtin').lsp_references({})<CR>")
-- nnoremap('gic', ":lua require('telescope.builtin').lsp_incoming_calls({})<CR>")
-- nnoremap('goc', ":lua require('telescope.builtin').lsp_outgoing_calls({})<CR>")
--
-- buf_set_keymap('n', '<leader>K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
-- buf_set_keymap('n', '<leader><C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
-- buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
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
