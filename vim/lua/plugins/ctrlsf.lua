return {
  'dyng/ctrlsf.vim',
  config = function()
    vim.cmd [[
      let mapleader="\<Space>"
      let g:ctrlsf_context = '-B 2 -A 2'
      let g:ctrlsf_indent = 2
      let g:ctrlsf_winsize = '80'

      function CtrlSF_syntax_hi()
        let s:syntx = &syntax
        execute ':CtrlSF'
        windo if &ft == 'ctrlsf' | execute 'set syntax='.s:syntx | endif
      endfunction

      nnoremap <silent><C-k><C-f> :CtrlSFToggle<CR>
      nnoremap <leader>f <Plug>CtrlSFPrompt
      vmap     <leader>f <Plug>CtrlSFVwordPath
      vmap     <leader>F <Plug>CtrlSFVwordExec

      augroup ctrlsf_config
        autocmd!
        autocmd FileType ctrlsf nnoremap <leader>S :CtrlSFUpdate<CR>
        autocmd FileType ctrlsf nnoremap <leader>sf :call CtrlSF_syntax_hi()<CR>
      augroup END
    ]]

  end
}
