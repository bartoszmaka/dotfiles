return {
  'dyng/ctrlsf.vim',
  -- cmd = { "CtrlSF", "CtrlSFPrompt", "CtrlSFVwordPath", "CtrlSFVwordExec", "CtrlSFToggle" },
  -- keys = {
  --   { "<C-k><C-f>", ":CtrlSFToggle<CR>" },
  --   { "<leader>ff", "<Plug>CtrlSFPrompt" },
  --   { "v",          "<leader>f",         "<Plug>CtrlSFVwordPath" },
  --   { "v",          "<leader>F",         "<Plug>CtrlSFVwordExec" }
  -- },
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
      nnoremap <leader>ff <Plug>CtrlSFPrompt
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
