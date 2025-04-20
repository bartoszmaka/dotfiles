return {
  'tpope/vim-fugitive',
  config = function()
    vim.cmd[[
      let mapleader="\<Space>"
      nnoremap <C-g><C-b> :Git blame<CR>
      nnoremap <C-g><C-d> :Gvdiffsplit!<CR>
    ]]
  end,
}
