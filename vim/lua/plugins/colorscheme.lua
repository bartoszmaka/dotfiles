local o = vim.o
local g = vim.g

o.termguicolors = true
o.background = "dark"
vim.cmd "syntax on"
g.onedark_style = 'deep'
require('onedark').setup()

vim.cmd[[
  augroup color_scheme_tweaks
    autocmd!

    highlight! DiffChange      guibg=#3c3c34 guifg=NONE gui=NONE
    highlight! DiffText        guibg=#525200 guifg=NONE gui=NONE
    highlight! DiffAdd         guibg=#283c34 guifg=NONE gui=NONE
    highlight! DiffDelete      guibg=#382c34 guifg=NONE gui=NONE
    highlight! CursorLine      guibg=#2e3138
    highlight! CursorLineNR    guibg=#2e3138 gui=bold
    highlight! CursorColumn    guibg=#2e3138
    highlight! ColorColumn     guibg=#252a32
    highlight! Comment         gui=italic
    highlight! Warning         guibg=#443333
    highlight! Error           guibg=#512121
    highlight! Visual          guibg=#401437
    highlight! IncSearch       guifg=#FF0000 guibg=NONE gui=bold
    highlight! Search          guifg=#FFFFFF guibg=NONE gui=bold
  augroup END
]]
