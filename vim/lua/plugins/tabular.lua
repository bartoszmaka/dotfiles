return {
  'godlygeek/tabular',
  config = function()
    local vnoremap = require('config_helper').vnoremap

    vnoremap('<C-m><C-t>', ':Tabularize /')
    vnoremap('<CR><C-t>', ':Tabularize /')
  end,
}
