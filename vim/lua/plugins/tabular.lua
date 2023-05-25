return {
  'godlygeek/tabular',
  config = function()
    local vnoremap = require('helper').vnoremap

    vnoremap('<C-m><C-t>', ':Tabularize /')
    vnoremap('<CR><C-t>', ':Tabularize /')
  end,
}
