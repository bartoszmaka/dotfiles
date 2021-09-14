filetype plugin on
command! CopyPath execute 'let @+ = expand("%")'

augroup remember_cursor_position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

augroup color_scheme_tweaks
  autocmd!

  highlight! DiffChange      guibg=#3c3c34 guifg=NONE gui=NONE
  highlight! DiffText        guibg=#525200 guifg=NONE gui=NONE
  highlight! DiffAdd         guibg=#283c34 guifg=NONE gui=NONE
  highlight! DiffDelete      guibg=#382c34 guifg=NONE gui=NONE
  highlight! CursorLine      guibg=#2e3138
  highlight! CursorLineNR    guibg=#2e3138 gui=bold
  highlight! CursorColumn    guibg=#2e3138
  highlight! ColorColumn     guibg=#252a32
  highlight! Comment         gui=italic
  highlight! Warning         guibg=#443333
  highlight! Error           guibg=#512121
  highlight! Visual          guibg=#401437
  highlight! IncSearch       guifg=#FF0000 guibg=NONE gui=bold
  highlight! Search          guifg=#FFFFFF guibg=NONE gui=bold
  highlight! LspDiagnosticsUnderlineInformation guibg=NONE gui=NONE
  highlight! LspDiagnosticsUnderlineHint guibg=NONE gui=NONE
  highlight! LspDiagnosticsUnderlineWarning guibg=#443333 gui=NONE
  highlight! LspDiagnosticsUnderlineError guibg=#512121 gui=NONE
augroup END


autocmd BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window " . expand("%"))
autocmd VimLeave * call system("tmux rename-window  ")

augroup filetype_tweaks
  autocmd!

  autocmd BufNewFile,BufReadPost,BufWritePost *.env.* set filetype=sh
  autocmd TermOpen term://* setlocal nonumber norelativenumber | setfiletype terminal
  autocmd FileType NvimTree setlocal statusline=""
augroup END
