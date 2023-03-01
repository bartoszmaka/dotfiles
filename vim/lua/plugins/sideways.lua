return {
  'AndrewRadev/sideways.vim',
  config = function()
    local nnoremap = require('config_helper').nnoremap
    nnoremap('g9', ':SidewaysJumpLeft<CR>')
    nnoremap('g0', ':SidewaysJumpRight<CR>')
    nnoremap('g(', ':SidewaysLeft<CR>')
    nnoremap('g)', ':SidewaysRight<CR>')
  end,
}
