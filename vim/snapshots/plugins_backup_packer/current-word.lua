local config_helper = require('config_helper')
local let = config_helper.let
local cmd = vim.cmd

let('g', 'vim_current_word#enabled', 1)
let('g', 'vim_current_word#highlight_only_in_focused_window', 1)
let('g', 'vim_current_word#highlight_twins', 1)
let('g', 'vim_current_word#highlight_current_word', 1)
let('g', 'vim_current_word#highlight_delay', 400)
cmd [[
  augroup vim_current_word
    autocmd!

    highlight! CurrentWordTwins guibg=#363636 gui=bold
    highlight! CurrentWord      guibg=#222200 gui=bold
  augroup END
]]
