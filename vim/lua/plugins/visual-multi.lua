return {
  'mg979/vim-visual-multi',
  lazy=false,
  config = function()
    vim.g.VM_maps = {
      ["Skip Region"]        = '<C-x>',
      ["Select Cursor Down"] = [[∆]], -- Option+J,
      ["Select Cursor Up"]   = [[Ż]], -- Option+K
    }
    vim.g.VM_theme = 'purplegray'
  end,
}
