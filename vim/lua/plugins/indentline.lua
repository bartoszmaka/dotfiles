vim.g.indentline_char = '│'
vim.g.indent_blankline_show_current_context = true
vim.g.indent_blankline_use_treesitter = true
vim.cmd[[
highlight! IndentBlanklineChar guifg=#283347
highlight! IndentBlanklineContextChar guifg=#455574 gui=nocombine
  nnoremap <leader>it :IndentBlanklineToggle<CR>
]]
