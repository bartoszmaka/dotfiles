return {
  'tpope/vim-commentary',
  config = function()
    local nnoremap = require('helper').nnoremap
    local vnoremap = require('helper').vnoremap

    nnoremap('gj', 'yygccp')
    vnoremap('gj', 'ygvgcgv<esc>p')
  end,
}
