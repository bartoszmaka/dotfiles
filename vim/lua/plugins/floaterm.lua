local config_helper = require('config_helper')
local nnoremap = config_helper.nnoremap
local tnoremap = config_helper.tnoremap

vim.g.floaterm_height = 0.3
vim.g.floaterm_wintype = 'split'
vim.g.floaterm_position = 'botright'
vim.g.floaterm_autoclose = 0

vim.cmd[[
  autocmd User FloatermOpen setlocal nonumber
]]

nnoremap('<C-l><C-n>', ':FloatermToggle<CR>')
tnoremap('<C-l><C-n>', [[<C-\><C-n>:FloatermToggle<CR>]])
