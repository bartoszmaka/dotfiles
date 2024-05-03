-- To be removed once comments are native in neovim?
return {
  'tpope/vim-commentary',
  config = function()
    -- local nmap = require('helper').nmap
    -- local vmap = require('helper').vmap

    vim.cmd [[
      nmap gj yygccp
      vmap gj ygvgcgv<esc>p
    ]]
  end,
}
