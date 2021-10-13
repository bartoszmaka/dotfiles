vim.o.termguicolors = true
vim.o.background = "dark"
vim.cmd "syntax on"
vim.g.onedark_style = 'deep'
vim.g.onedark_disable_toggle_style = true
vim.g.onedark_italic_comment = true
vim.g.onedark_disable_terminal_colors = true
require('onedark').setup()

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
