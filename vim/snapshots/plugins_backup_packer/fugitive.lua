vim.cmd[[
  let mapleader="\<Space>"
  nnoremap <C-g><C-b> :Git blame<CR>
  nnoremap <leader>gb :Git blame<CR>
  nnoremap <C-g><C-d> :Gvdiffsplit!<CR>
  nnoremap <leader>gd :Gvdiffsplit!<CR>
]]
