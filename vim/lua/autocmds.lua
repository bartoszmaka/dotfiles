vim.cmd [[
  filetype plugin on
  command! CopyPath execute 'let @+ = expand("%")'

  function! ClearRegisters()
    let regs='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-="*+'
    let i=0
    while (i<strlen(regs))
        exec 'let @'.regs[i].'=""'
        let i=i+1
    endwhile
  endfunction
  command! ClearRegisters call ClearRegisters()

  autocmd BufEnter,BufNewFile,BufWritePost * call system("tmux rename-window " . expand("%"))
  autocmd VimLeave * call system("tmux rename-window `pwd`")

  augroup remember_cursor_position
    autocmd!
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  augroup END

  augroup color_current_line_in_insert
    autocmd!
    autocmd InsertEnter * highlight! CursorLine   guibg=#512121
    autocmd InsertEnter * highlight! CursorLineNR guibg=#512121
    autocmd InsertLeave * highlight! CursorLine   guibg=#21283b
    autocmd InsertLeave * highlight! CursorLineNR guibg=#21283b
  augroup END
]]
