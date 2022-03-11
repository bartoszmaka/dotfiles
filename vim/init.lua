-- require'impatient'.enable_profile()
local loaded, impatient = pcall(require, 'impatient')
if loaded then
  impatient.enable_profile()
end

require('disable_builtin')
vim.cmd [[
  set tabstop=2
  set shiftwidth=2
  set expandtab
  set softtabstop=2
  let g:python3_host_prog = '/Users/bartoszmaka/.asdf/shims/python3'
  let g:python2_host_prog = '/Users/bartoszmaka/.asdf/shims/python2'
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

  -- let g:node_host_prog = '/Users/bartoszmaka/.asdf/installs/nodejs/17.3.0/bin/node'
