vim.g.mapleader = ' '
vim.o.termguicolors = true

vim.cmd [[
  let g:python3_host_prog = '/Users/bartoszmaka/.asdf/shims/python3'
  let g:python2_host_prog = '/Users/bartoszmaka/.asdf/shims/python2'
]]

require('disable_builtin')
require('setup_lazy')

require('lazy').setup('plugins')

local loadedLsp, _ = pcall(require, 'lsp')
local loadedAutopairs, _ = pcall(require, 'plugins_config.autopairs')
local loadedCompletion, _ = pcall(require, 'plugins_config.completion')
if not loadedLsp then print('Error in lsp config') end
if not loadedAutopairs then print('Error in autoparis config') end
if not loadedCompletion then print('Error in completion config') end

require('options')
require('mappings')
require('abbrevations')
require('autocmds')
require('colorscheme_overrides')
require('gui')
