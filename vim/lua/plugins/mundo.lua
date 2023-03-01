return {
  'simnalamburt/vim-mundo',
  config = function()
    vim.cmd [[
      let g:mundo_right = 1
      nnoremap <C-k><C-u> :MundoToggle<CR>
    ]]
  end,
}
