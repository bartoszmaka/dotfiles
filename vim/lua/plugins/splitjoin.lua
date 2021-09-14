vim.cmd[[
  let mapleader="\<Space>"
  let g:splitjoin_split_mapping     = ''
  let g:splitjoin_join_mapping      = ''
  let g:splitjoin_ruby_curly_braces = 0
  let g:splitjoin_ruby_hanging_args = 0
  nmap <C-m><C-d> :SplitjoinJoin<cr>
  nmap <C-m><C-s> :SplitjoinSplit<cr>
  nmap <leader>md :SplitjoinJoin<cr>
  nmap <leader>ms :SplitjoinSplit<cr>
]]
