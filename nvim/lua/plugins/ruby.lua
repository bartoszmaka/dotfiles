return {
  { 'tpope/vim-bundler', ft = { 'ruby', 'eruby' } },
  { 'tpope/vim-endwise', ft = { 'ruby', 'eruby' } },
  {
    'tpope/vim-rails',
    ft = { 'ruby', 'eruby' },
    keys = {
      { '<leader>s',  ':A<cr>',           desc = 'Toggle test and code files' },
      { '<leader>ev', ':Eview<cr>',       desc = 'Go to corresponding rails view' },
      { '<leader>ec', ':Econtroller<cr>', desc = 'Go to corresponding rails view' },
    },
  },
}
