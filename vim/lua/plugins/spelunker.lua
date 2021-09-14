vim.cmd[[
  highlight SpelunkerSpellBad gui=underline
  highlight SpelunkerComplexOrCompoundWord gui=underline
  nmap [s <NOP>
  nmap ]s <NOP>
  nnoremap <silent> [s :call spelunker#jump_prev()<CR>
  nnoremap <silent> ]s :call spelunker#jump_next()<CR>
]]
