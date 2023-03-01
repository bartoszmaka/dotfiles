return {
  'tpope/vim-commentary',
  config = function()
    local nmap = require('config_helper').nmap

    nmap('gj', 'yypkgccj')
  end,
}
