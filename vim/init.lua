local loaded, impatient = pcall(require, 'impatient')
if loaded then
  impatient.enable_profile()
end

vim.cmd [[
  let g:python3_host_prog = '/Users/bartoszmaka/.asdf/shims/python3'
  let g:python2_host_prog = '/Users/bartoszmaka/.asdf/shims/python2'
]]

require('disable_builtin')
require('setup_packer')
require('plugins')
require('options')
require('mappings')
require('abbrevations')
require('autocmds')
require('gui')
