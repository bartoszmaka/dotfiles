return {
  'knubie/vim-kitty-navigator',
  cond = function() return vim.fn.exists('$KITTY_WINDOW_ID') == 1 end,
  build = 'cp ./*.py ~/.config/kitty/',
  config = function()
    vim.cmd [[
      let g:kitty_navigator_no_mappings = 1
      nnoremap <silent><C-w>h :KittyNavigateLeft<CR>
      nnoremap <silent><C-w>j :KittyNavigateDown<CR>
      nnoremap <silent><C-w>k :KittyNavigateUp<CR>
      nnoremap <silent><C-w>l :KittyNavigateRight<CR>
    ]]
  end
}