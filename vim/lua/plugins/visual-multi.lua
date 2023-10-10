return {
  'mg979/vim-visual-multi',
  lazy=false,
  config = function()
    local nmap = require('helper').nmap

    vim.g.VM_theme = 'purplegray'
    vim.g.VM_mouse_mappings = 1
    vim.g.VM_maps = {
      ["Skip Region"]        = '<C-x>',
      ["Add Cursor At Pos"]  = '<leader>gm',
      -- ["Select Cursor Down"] = [[∆]], -- Option+J,
      -- ["Select Cursor Up"]   = [[Ż]], -- Option+K
      ["Add Cursor Down"] = [[∆]], -- Option+J,
      ["Add Cursor Up"]   = [[Ż]], -- Option+K

    }
    -- nmap('∆', [[\\\∆]])
    -- nmap('Ż', [[\\\Ż]])
  end,
}
