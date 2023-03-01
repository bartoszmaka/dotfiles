require('hlslens').setup({})
local nnoremap = require('config_helper').nnoremap

nnoremap('n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]])
nnoremap('N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]])
nnoremap('*', [[*<Cmd>lua require('hlslens').start()<CR>]])
nnoremap('#', [[#<Cmd>lua require('hlslens').start()<CR>]])
nnoremap('g*', [[g*<Cmd>lua require('hlslens').start()<CR>]])
nnoremap('g#', [[g#<Cmd>lua require('hlslens').start()<CR>]])

vim.cmd[[
  highlight! default link HlSearchNear IncSearch
  highlight! default link HlSearchLens Comment
  highlight! default link HlSearchLensNear IncSearch
  highlight! default link HlSearchFloat IncSearch
]]
