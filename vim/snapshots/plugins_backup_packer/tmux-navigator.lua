if vim.fn.exists('$TMUX') ~= 1 then
  vim.g.tmux_navigator_no_mappings = 1
  return
end

vim.cmd[[
  let g:tmux_navigator_no_mappings = 1
  nnoremap <silent><C-w>h :TmuxNavigateLeft<CR>
  nnoremap <silent><C-w>j :TmuxNavigateDown<CR>
  nnoremap <silent><C-w>k :TmuxNavigateUp<CR>
  nnoremap <silent><C-w>l :TmuxNavigateRight<CR>
]]
