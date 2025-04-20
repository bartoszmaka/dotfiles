return {
  'tpope/vim-repeat',
  config = function()
    vim.cmd [[
      call repeat#set("\<plug>.", v:count)
    ]]
  end
}
