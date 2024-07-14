set foldcolumn=0

augroup force-neotree-settings
  autocmd!
  autocmd BufEnter * if index(['neo-tree'], &ft) < 0 | setlocal foldcolumn=0 | endif
augroup END
