return {
  'AndrewRadev/splitjoin.vim',
  -- Load eagerly: splitjoin registers its filetype-specific split/join
  -- callbacks via ftplugin/ files, which only run on FileType events *while
  -- the plugin is already in the runtimepath*. Lazy-loading on keys/cmd misses
  -- the FileType event for already-open buffers, so :SplitjoinSplit becomes a
  -- silent no-op. The plugin is a tiny vimscript plugin, so eager load is cheap.
  lazy = false,
  init = function()
    vim.g.splitjoin_split_mapping     = ''
    vim.g.splitjoin_join_mapping      = ''
    vim.g.splitjoin_ruby_curly_braces = 0
    vim.g.splitjoin_ruby_hanging_args = 0
  end,
  config = function()
    local map = vim.keymap.set
    map('n', '<C-m><C-d>', '<cmd>SplitjoinJoin<CR>',  { desc = 'Splitjoin: join' })
    map('n', '<C-m><C-s>', '<cmd>SplitjoinSplit<CR>', { desc = 'Splitjoin: split' })
    map('n', '<CR><C-d>',  '<cmd>SplitjoinJoin<CR>',  { desc = 'Splitjoin: join' })
    map('n', '<CR><C-s>',  '<cmd>SplitjoinSplit<CR>', { desc = 'Splitjoin: split' })
    map('n', '<leader>md', '<cmd>SplitjoinJoin<CR>',  { desc = 'Splitjoin: join' })
    map('n', '<leader>ms', '<cmd>SplitjoinSplit<CR>', { desc = 'Splitjoin: split' })
  end,
}
