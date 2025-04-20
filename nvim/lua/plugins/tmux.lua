return {
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    dependencies = {
      'roxma/vim-tmux-clipboard',
      'preservim/vimux'
    },
    cond = function() return vim.fn.exists('$TMUX') == 1 end,
    config = function()
      vim.cmd [[
      let g:tmux_navigator_no_mappings = 1
      nnoremap <silent><C-w>h :TmuxNavigateLeft<CR>
      nnoremap <silent><C-w>j :TmuxNavigateDown<CR>
      nnoremap <silent><C-w>k :TmuxNavigateUp<CR>
      nnoremap <silent><C-w>l :TmuxNavigateRight<CR>
      ]]
    end
  },
}
