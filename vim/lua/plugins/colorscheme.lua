vim.o.termguicolors = true
vim.o.background = "dark"
vim.cmd "syntax on"
require('onedark').setup({
  style = 'deep',
  term_colors = 'false',
  highlights = {
    DiffChange = { bg="#2e2e1a", fg="none" },
    DiffText   = { bg="#3e3e23", fg="none" },
    DiffAdd    = { bg="#1a2e1b", fg="none" },
    DiffDelete = { bg="#2e201a", fg="none" },
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
