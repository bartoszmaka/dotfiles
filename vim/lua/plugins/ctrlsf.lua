vim.cmd[[
  let mapleader="\<Space>"
  let g:ctrlsf_context = '-B 2 -A 2'
  let g:ctrlsf_indent = 2
  let g:ctrlsf_winsize = '80'
  nnoremap <silent><C-k><C-f> :CtrlSFToggle<CR>
  nmap     <leader>f <Plug>CtrlSFPrompt
  vmap     <leader>f <Plug>CtrlSFVwordPath
  vmap     <leader>F <Plug>CtrlSFVwordExec

  augroup ctrlsf_config
    autocmd!

    autocmd FileType ctrlsf nnoremap <leader>S :CtrlSFUpdate<CR>
  augroup END
]]
