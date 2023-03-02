return {
  'mg979/vim-visual-multi',
  lazy=false,
  config = function()
    local nmap = require('config_helper').nmap
    vim.g.VM_maps = {
      ["Skip Region"]        = '<C-x>',
      -- ["Select Cursor Down"] = [[∆]], -- Option+J,
      -- ["Select Cursor Up"]   = [[Ż]], -- Option+K
      ["Add Cursor Down"] = [[∆]], -- Option+J,
      ["Add Cursor Up"]   = [[Ż]], -- Option+K
    }
    vim.g.VM_theme = 'purplegray'
    nmap('∆', [[\\\∆]])
    nmap('Ż', [[\\\Ż]])
  end,
}
