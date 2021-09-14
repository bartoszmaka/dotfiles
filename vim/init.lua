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
-- vim.cmd [[
--   let home = expand('~')
--   exec 'source' home . '/.repos/dotfiles/vim/lua/auto.vim'
-- ]]
vim.cmd [[
  set tabstop=2
  set shiftwidth=2
  set expandtab
  set softtabstop=2
]]
