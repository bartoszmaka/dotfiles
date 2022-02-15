local colors = require('config_helper.colors').onedark

vim.o.termguicolors = true
vim.o.background = "dark"
vim.cmd "syntax on"
require('onedark').setup({
  style = 'deep',
  term_colors = 'false',
  highlights = {
    DiffChange = { bg=colors.diff_change, fg="none" },
    DiffText   = { bg=colors.diff_text, fg="none" },
    DiffAdd    = { bg=colors.diff_add, fg="none" },
    DiffDelete = { bg=colors.diff_delete, fg="none" },
  },
})
require('onedark').load()

vim.cmd[[
  augroup graphql_syntax_fix
    autocmd!
  
    autocmd FileType javascript highlight! link graphqlStructure Constant
    autocmd FileType javascript highlight! link graphqlVariable Type
    autocmd FileType javascript highlight! link graphqlName String
    autocmd FileType javascript highlight! link graphqlType Constant
    autocmd FileType javascript highlight! link graphqlStructure Label
  augroup END
]]
