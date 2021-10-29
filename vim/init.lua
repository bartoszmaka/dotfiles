require('disable_builtin')
vim.cmd [[
  set tabstop=2
  set shiftwidth=2
  set expandtab
  set softtabstop=2
]]
require('packer_setup')
require('plugins')
require('options')
require('mappings')
require('abbrevations')
require('autocmds')
require('gui')

-- vim.cmd[[
--   exe "source " . expand('$DOTFILES_PATH/vim/lua/auto.vim')
-- ]]
vim.cmd [[
  set tabstop=2
  set shiftwidth=2
  set expandtab
  set softtabstop=2
]]
