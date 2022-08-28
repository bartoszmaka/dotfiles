vim.g.Illuminate_delay = 400
vim.cmd[[
  highlight! illuminatedWord guibg=#314365
  highlight! illuminatedCurWord guibg=#314365 gui=bold
  highlight! link illuminatedWordRead illuminatedWord
  highlight! link illuminatedWordWrite illuminatedWord
  highlight! link illuminatedWordText None
]]
