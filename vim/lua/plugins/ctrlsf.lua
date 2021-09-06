vim.cmd[[
  let mapleader="\<Space>"
  let g:ctrlsf_context = '-B 2 -A 2'
  let g:ctrlsf_indent = 2
  let g:ctrlsf_winsize = '80'
  nmap <leader>F <Plug>CtrlSFPrompt
  nnoremap <silent><C-k><C-f> :CtrlSFToggle<CR>

  augroup ctrlsf_config
    autocmd!

    autocmd FileType ruby vnoremap <leader>d y:CtrlSF "def <C-r>""
    autocmd FileType ruby nnoremap <leader>d yiw:CtrlSF "def <C-r>""
    autocmd FileType ctrlsf nnoremap <leader>S :CtrlSFUpdate<CR>
  augroup END
]]
