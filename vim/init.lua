vim.g.mapleader = ' '
vim.o.termguicolors = true

-- vim.cmd [[
--   let g:python3_host_prog = '/Users/bartoszmaka/.asdf/shims/python3'
--   let g:python2_host_prog = '/Users/bartoszmaka/.asdf/shims/python2'
-- ]]

require('disable_builtin')
require('setup_lazy')
require('options')

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require('mappings')
    require('abbrevations')
    require('autocmds')
    require('colorscheme_overrides')
    require('gui')
  end,
})
