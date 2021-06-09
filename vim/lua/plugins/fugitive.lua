vim.cmd[[
  let mapleader="\<Space>"
  nnoremap <C-g><C-b> :Git blame<CR>
  nnoremap <leader>gb :Git blame<CR>
  nnoremap <C-g><C-d> :Gdiffsplit<CR>
  nnoremap <leader>gd :Gdiffsplit!<CR>

  augroup diff_color_tweaks
    autocmd!
    highlight! DiffChange  guibg=#3c3c34 guifg=NONE gui=NONE
    highlight! DiffText    guibg=#525200 guifg=NONE gui=NONE
    highlight! DiffAdd     guibg=#283c34 guifg=NONE gui=NONE
    highlight! DiffDelete  guibg=#382c34 guifg=NONE gui=NONE
  augroup END
]]
