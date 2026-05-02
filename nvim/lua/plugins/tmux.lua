return {
  {
    'christoomey/vim-tmux-navigator',
    event = 'VeryLazy',
    dependencies = {
      'roxma/vim-tmux-clipboard',
      'preservim/vimux',
    },
    cond = function() return vim.fn.exists('$TMUX') == 1 end,
    config = function()
      vim.g.tmux_navigator_no_mappings = 1
      local map = vim.keymap.set
      map('n', '<C-w>h', '<cmd>TmuxNavigateLeft<CR>', { silent = true })
      map('n', '<C-w>j', '<cmd>TmuxNavigateDown<CR>', { silent = true })
      map('n', '<C-w>k', '<cmd>TmuxNavigateUp<CR>', { silent = true })
      map('n', '<C-w>l', '<cmd>TmuxNavigateRight<CR>', { silent = true })
    end,
  },
}
