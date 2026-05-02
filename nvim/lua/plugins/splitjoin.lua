return {
  'AndrewRadev/splitjoin.vim',
  keys = {
    { '<C-m><C-d>', '<cmd>SplitjoinJoin<CR>',  desc = 'Splitjoin: join' },
    { '<C-m><C-s>', '<cmd>SplitjoinSplit<CR>', desc = 'Splitjoin: split' },
    { '<CR><C-d>',  '<cmd>SplitjoinJoin<CR>',  desc = 'Splitjoin: join' },
    { '<CR><C-s>',  '<cmd>SplitjoinSplit<CR>', desc = 'Splitjoin: split' },
    { '<leader>md', '<cmd>SplitjoinJoin<CR>',  desc = 'Splitjoin: join' },
    { '<leader>ms', '<cmd>SplitjoinSplit<CR>', desc = 'Splitjoin: split' },
  },
  init = function()
    vim.g.splitjoin_split_mapping     = ''
    vim.g.splitjoin_join_mapping      = ''
    vim.g.splitjoin_ruby_curly_braces = 0
    vim.g.splitjoin_ruby_hanging_args = 0
  end,
}
