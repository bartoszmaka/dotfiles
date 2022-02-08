require('hlslens').setup({})

vim.cmd[[
  noremap <silent> n <Cmd>execute('normal! ' . v:count1 . 'n')<CR>
              \<Cmd>lua require('hlslens').start()<CR>
  noremap <silent> N <Cmd>execute('normal! ' . v:count1 . 'N')<CR>
              \<Cmd>lua require('hlslens').start()<CR>
  noremap * *<Cmd>lua require('hlslens').start()<CR>
  noremap # #<Cmd>lua require('hlslens').start()<CR>
  noremap g* g*<Cmd>lua require('hlslens').start()<CR>
  noremap g# g#<Cmd>lua require('hlslens').start()<CR>

  " aug VMlens
  "   au!
  "   au User visual_multi_start lua require('vmlens').start()
  "   au User visual_multi_exit lua require('vmlens').exit()
  " aug END

  hi default link HlSearchNear IncSearch
  hi default link HlSearchLens Comment
  hi default link HlSearchLensNear IncSearch
  hi default link HlSearchFloat IncSearch
]]
