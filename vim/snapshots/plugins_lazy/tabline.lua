local config_helper = require('config_helper')

local nnoremap = config_helper.nnoremap

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

vim.cmd[[
  augroup tabilne_colors
  autocmd!

  highlight! BufferCurrent        guifg=#f2cc81 guibg=#1a212e
  highlight! BufferCurrentMod     guifg=#8bcd5b guibg=#1a212e
  highlight! BufferVisible        guifg=#93a4c3 guibg=#1a212e
  highlight! BufferVisibleMod     guifg=#1b6a73 guibg=#1a212e
  highlight! BufferVisibleSign    guifg=#93a4c3 guibg=#1a212e
  highlight! BufferInactive       guifg=#93a4c3 guibg=#2a324a
  highlight! BufferInactiveMod    guifg=#34bfd0 guibg=#2a324a
  highlight! BufferInactiveSign   guifg=#93a4c3 guibg=#2a324a
  augroup END
]]

