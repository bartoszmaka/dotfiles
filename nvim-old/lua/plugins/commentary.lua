-- To be removed once comments are native in neovim?
return {
  'tpope/vim-commentary',
  config = function()

    vim.cmd [[
      nmap gj yygccp
      vmap gj ygvgcgv<esc>p
    ]]
  end,
}
