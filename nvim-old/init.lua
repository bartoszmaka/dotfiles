-- " already defined in opts"
-- vim.g.mapleader = ' '
-- vim.g.maplocalleader = '\\'
-- vim.o.termguicolors = true 

-- require('disable_builtin')
require('options')
require('setup_lazy')

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require('mappings')
    require('abbrevations')
    require('autocmds')
    require('gui')
  end,
})
