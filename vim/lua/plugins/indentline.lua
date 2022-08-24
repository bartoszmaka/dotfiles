vim.cmd[[
highlight! IndentBlanklineChar guifg=#1a212e
highlight! IndentBlanklineContextChar guifg=#455574 gui=nocombine
nnoremap <leader>it :IndentBlanklineToggle<CR>
]]

require("indent_blankline").setup {
  char = ' ',
  context_char = '│',
  show_current_context = true,
  show_current_context_start = true,
  use_treesitter = true,
  filetype_exclude = { 'fzf' }
}
