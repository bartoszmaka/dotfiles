vim.g.mapleader = ' '
vim.o.termguicolors = true

vim.cmd [[
  let g:python3_host_prog = '/Users/bartoszmaka/.asdf/shims/python3'
  let g:python2_host_prog = '/Users/bartoszmaka/.asdf/shims/python2'
]]

require('disable_builtin')
require('setup_lazy')
require('lazy').setup({
  spec = { import = 'plugins'},
  install = {
    colorscheme = { 'onedark' },
  },
})

require('options')
require('mappings')
require('abbrevations')
require('autocmds')
require('colorscheme_overrides')
require('gui')
require('lsp')
-- local loadedLsp, _ = pcall(require, 'lsp')
-- if not loadedLsp then print('Error in lsp config') end
