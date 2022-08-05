vim.cmd [[filetype plugin on]]
vim.cmd [[command! CopyPath execute 'let @+ = expand("%")']]
vim.cmd [[
augroup remember_cursor_position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END
]]

vim.cmd [[
augroup color_scheme_tweaks
  autocmd!

  highlight! DiffChange      guibg=#2e2e1a guifg=NONE gui=NONE
  highlight! DiffText        guibg=#3e3e23 guifg=NONE gui=NONE
  highlight! DiffAdd         guibg=#1a2e1b guifg=NONE gui=NONE
  highlight! DiffDelete      guibg=#2e201a guifg=NONE gui=NONE
  highlight! CursorLine      guibg=#21283b
  highlight! CursorLineNR    guibg=#21283b gui=bold
  highlight! CursorColumn    guibg=#21283b
  highlight! ColorColumn     guibg=#21283b
  highlight! Comment         gui=italic
  highlight! Warning         guibg=#443333
  highlight! Error           guibg=#512121
  highlight! Visual          guibg=#401437
  highlight! IncSearch       guifg=#FF0000 guibg=NONE gui=bold,nocombine
  highlight! Search          guifg=#FFFFFF guibg=NONE gui=bold,nocombine

  highlight! DiagnosticVirtualTextHint guifg=#1b6a73 guibg=NONE
  highlight! DiagnosticVirtualTextInfo guifg=#1b6a73 guibg=NONE

  highlight! DiagnosticUnderlineError  guibg=#512121 gui=NONE
  highlight! DiagnosticUnderlineWarn   guibg=#443333 gui=NONE
  highlight! DiagnosticUnderlineInfo   guibg=NONE gui=NONE
  highlight! DiagnosticUnderlineHint   guibg=NONE gui=NONE

  highlight! CmpItemAbbr guifg=#6c7d9c
  highlight! CmpItemAbbrMatch guifg=#f2cc81
  highlight! CmpItemAbbrMatchFuzzy guifg=#f2cc81 gui=NONE
  highlight! CmpItemKindDefault guifg=#dd9046
  highlight! CmpItemKindSnippet guifg=#f65866
  " highlight! CmpItemKindConstant guifg=#efbd5d
  " highlight! CmpItemKindModule guifg=#efbd5d
  " highlight! CmpItemKindClass guifg=#efbd5d
  highlight! CmpItemKindKeyword guifg=#bfbd5d
  highlight! CmpItemAbbrDeprecated guifg=#455574
  " highlight! CmpItemKindFunction guifg=#41a7fc
  " highlight! CmpItemKindMethod guifg=#41a7fc
  highlight! CmpItemKindText guifg=#93a4c3
  " highlight! link cmpItemKindArgs CmpItemKindInterface

  autocmd InsertEnter * highlight! CursorLine   guibg=#512121
  autocmd InsertEnter * highlight! CursorLineNR guibg=#512121
  autocmd InsertLeave * highlight! CursorLine   guibg=#21283b
  autocmd InsertLeave * highlight! CursorLineNR guibg=#21283b
 
augroup END
]]

vim.cmd [[
augroup treesitter_overrides
  autocmd!

  highlight! TSKeywordFunction gui=NONE
  highlight! TSConstructor     gui=NONE
  highlight! TSInclude         gui=italic
  highlight! TSKeyword         gui=italic
  highlight! TSKeywordFunction gui=italic
  highlight! TSVariableBuiltin gui=italic
  highlight! TSConditional     gui=italic
  highlight! link vueTSMethod TSBoolean
  highlight! link TSTagAttribute TSBoolean
  highlight! link htmlBold Normal
  highlight! link htmlBoldItalic Normal
  highlight! link htmlBoldItalicUnderline Normal
augroup END
]]

-- Set tmux window name to edited path
vim.cmd [[
  autocmd BufEnter,BufNewFile,BufWritePost * call system("tmux rename-window " . expand("%"))
  autocmd VimLeave * call system("tmux rename-window `pwd`")
]]

vim.cmd [[
function! ClearRegisters()
  let regs='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-="*+'
  let i=0
  while (i<strlen(regs))
      exec 'let @'.regs[i].'=""'
      let i=i+1
  endwhile
endfunction

command! ClearRegisters call ClearRegisters()
]]

vim.cmd [[
augroup filetype_tweaks
  autocmd!

  autocmd FileType NvimTree setlocal statusline="NvimTree"
  autocmd FileType css set omnifunc=csscomplete#CompleteCSS
augroup END
]]

-- vim.cmd [[
-- augroup highlight_yank
--   autocmd!

--   augroup TextYankPost * silent! lua vim.highlight.on_yank(timeout=2000})
-- augroup END
-- ]]
--
