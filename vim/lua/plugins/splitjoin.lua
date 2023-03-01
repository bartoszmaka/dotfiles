return {
  'AndrewRadev/splitjoin.vim',
  config = function()
    vim.cmd [[
      let mapleader="\<Space>"
      let g:splitjoin_split_mapping     = ''
      let g:splitjoin_join_mapping      = ''
      let g:splitjoin_ruby_curly_braces = 0
      let g:splitjoin_ruby_hanging_args = 0
      nnoremap <C-m><C-d> :SplitjoinJoin<cr>
      nnoremap <C-m><C-s> :SplitjoinSplit<cr>
      nnoremap <CR><C-d> :SplitjoinJoin<cr>
      nnoremap <CR><C-s> :SplitjoinSplit<cr>
      nnoremap <leader>md :SplitjoinJoin<cr>
      nnoremap <leader>ms :SplitjoinSplit<cr>
    ]]
  end
}
