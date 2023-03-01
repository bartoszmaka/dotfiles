local nnoremap = require('config_helper').nnoremap
local tnoremap = require('config_helper').tnoremap
local tmap = require('config_helper').tmap

require('nvim-terminal').setup({
  disable_default_keymaps = true,
  toggle_keymap = '<C-l><C-n>',
  height = 25,
})
vim.cmd[[
augroup neovim_terminal
  autocmd!
  autocmd TermOpen * startinsert
  autocmd TermOpen * :set nonumber norelativenumber
  autocmd TermOpen * nnoremap <buffer> <C-c> i<C-c>
augroup END
]]

nnoremap('<C-l><C-n>', ':lua NTGlobal["terminal"]:toggle()<cr>')
tmap('<C-l><C-n>', '<esc>:lua NTGlobal["terminal"]:toggle()<cr>')
