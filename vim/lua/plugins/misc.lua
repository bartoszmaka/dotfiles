local config_helper = require('config_helper')

local nmap = config_helper.nmap
local cmd = vim.cmd
local let = config_helper.let

vim.cmd [[autocmd BufWritePost init.lua PackerCompile]]

nmap('gj', 'yypkgccj') -- depends on comment plugin

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

cmd [[
  augroup filetype_fixes
    autocmd!

    autocmd WinEnter, BufEnter set tabstop=2 | set shiftwidth=2
  augroup END
]]

-- vim.g.VM_maps = {}
-- vim.g.VM_maps["Skip Region"] = '<C-x>'
-- vim.g.VM_maps["Select Cursor Down"] = '∆'
-- vim.g.VM_maps["Select Cursor Up"]   = 'Ż'
-- vim.g.VM_theme = 'purplegray'

require('nvim-autopairs').setup()
