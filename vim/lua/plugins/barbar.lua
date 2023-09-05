return {
  'romgrk/barbar.nvim',
  dependencies = {
    'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
    { "nvim-tree/nvim-web-devicons", name = "tree-nvim-web-devicons" }, -- OPTIONAL: for file icons
  },
  init = function() vim.g.barbar_auto_setup = false end,
  opts = {
    animation = true,
    auto_hide = false,
    tabpages = true,
    maximum_padding = 2,
    minimum_padding = 2,
    maximum_length = 50,
    no_name_title = ' - ',
    icons = {
      button = '',
    }
  },
  config = function(_, opts)
    local nnoremap = require('helper').nnoremap
    vim.g.mapleader = ' '

    require('barbar').setup(opts)

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
      augroup barbar_overrides
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
  end
}
