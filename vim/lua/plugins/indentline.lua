vim.api.nvim_set_var('indentline_char', '│')
vim.cmd[[
highlight! IndentBlanklineChar guifg=#283347
  nnoremap <leader>it :IndentBlanklineToggle<CR>
]]
