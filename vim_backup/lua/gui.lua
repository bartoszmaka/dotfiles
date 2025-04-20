vim.cmd [[
  set guifont=Hasklug\ Nerd\ Font\ Mono:h20
  nnoremap <D-h> <C-w>h
  nnoremap <D-j> <C-w>j
  nnoremap <D-k> <C-w>k
  nnoremap <D-l> <C-w>l
  nnoremap <D-w> <leader>w
  nnoremap <D-v> p
  inoremap <D-v> <esc>pa
  nnoremap <D-s> <esc>:w<CR>
  nnoremap <D-[> :BufferPrevious<CR>
  nnoremap <D-]> :BufferNext<CR>
  nnoremap <D-S-{> :BufferMovePrevious<CR>
  nnoremap <D-S-}> :BufferMoveNext<CR>
  nnoremap <D-1> :BufferGoto 1<CR>
  nnoremap <D-2> :BufferGoto 2<CR>
  nnoremap <D-3> :BufferGoto 3<CR>
  nnoremap <D-4> :BufferGoto 4<CR>
  nnoremap <D-5> :BufferGoto 5<CR>
  nnoremap <D-6> :BufferGoto 6<CR>
  nnoremap <D-7> :BufferGoto 7<CR>
  nnoremap <D-8> :BufferGoto 8<CR>
  nnoremap <D-9> :BufferLast<CR>
  nnoremap <D-q> :close<CR>
  nnoremap <D-w> :BufferClose<CR>
]]
