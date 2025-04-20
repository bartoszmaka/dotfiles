return {
  'mg979/vim-visual-multi',
  lazy=false,
  config = function()
    local nnoremap = require('helper').nnoremap

    vim.g.VM_theme = 'purplegray'
    vim.g.VM_mouse_mappings = 1
    vim.g.VM_maps = {
      ["Skip Region"]        = '<C-x>',
      ["Add Cursor At Pos"]  = '<leader>gm',
      -- ["Select Cursor Down"] = [[<M-j>]], -- Option+J,
      -- ["Select Cursor Up"]   = [[<M-k>]], -- Option+K
      -- ["Add Cursor Down"] = [[<M-j>]], -- Option+J,
      -- ["Add Cursor Up"]   = [[<M-k>]], -- Option+K
    }
    nnoremap([[<M-j>]], [[<Plug>(VM-Add-Cursor-Down)]])
    nnoremap([[<M-k>]], [[<Plug>(VM-Add-Cursor-Up)]])
  end,
}
