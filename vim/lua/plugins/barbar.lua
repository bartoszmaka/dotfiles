return {
  'romgrk/barbar.nvim',
  lazy=false,
  config = function()
    local nnoremap = require('config_helper').nnoremap
    vim.g.mapleader = ' '
    vim.g.bufferline = {
      animation = true,
      auto_hide = false,
      tabpages = true,
      closable = false,
      maximum_padding = 1,
      maximum_length = 100,
      no_name_title = ' - '
    }

    nnoremap('<leader>[', ':BufferPrevious<CR>')
    nnoremap('<leader>]', ':BufferNext<CR>')
    nnoremap('<leader>{', ':BufferMovePrevious<CR>')
    nnoremap('<leader>}', ':BufferMoveNext<CR>')
    nnoremap('<leader>1', ':BufferGoto 1<CR>')
    nnoremap('<leader>2', ':BufferGoto 2<CR>')
    nnoremap('<leader>3', ':BufferGoto 3<CR>')
    nnoremap('<leader>4', ':BufferGoto 4<CR>')
    nnoremap('<leader>5', ':BufferGoto 5<CR>')
    nnoremap('<leader>6', ':BufferGoto 6<CR>')
    nnoremap('<leader>7', ':BufferGoto 7<CR>')
    nnoremap('<leader>8', ':BufferGoto 8<CR>')
    nnoremap('<leader>9', ':BufferLast<CR>')
    nnoremap('<leader>q', ':close<CR>')
    nnoremap('<leader>w', ':BufferClose<CR>')
    nnoremap('<leader><leader>!', ':BufferCloseAllButCurrent<CR>')
  end
}
