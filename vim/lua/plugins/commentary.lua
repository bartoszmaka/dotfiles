return {
  'tpope/vim-commentary',
  config = function()
    local nmap = require('helper').nmap

    nmap('gj', 'yypkgccj')
  end,
}
