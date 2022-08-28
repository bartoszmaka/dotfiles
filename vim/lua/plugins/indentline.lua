function ToggleIndentMarks()
  if vim.g.indent_highlight_toggled_visible == 1 then
    vim.g.indent_highlight_toggled_visible = 0
    vim.cmd [[
      highlight! IndentBlanklineChar guifg=#283347
      highlight! IndentBlanklineContextChar guifg=#455574 gui=nocombine
      ]]
  else
    vim.g.indent_highlight_toggled_visible = 1
    vim.cmd [[
      highlight! IndentBlanklineChar guifg=#1a212e
      highlight! IndentBlanklineContextChar guifg=#455574 gui=nocombine
      ]]
  end
end

vim.cmd[[
  highlight! IndentBlanklineChar guifg=#1a212e
  highlight! IndentBlanklineContextChar guifg=#455574 gui=nocombine

  nnoremap <leader>iT :IndentBlanklineToggle<CR>
  nnoremap <leader>it :lua ToggleIndentMarks()<CR>
]]

require("indent_blankline").setup {
  char = ' ',
  context_char = '│',
  show_current_context = true,
  show_current_context_start = false,
  use_treesitter = true,
  filetype_exclude = { 'fzf' }
}
