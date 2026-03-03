return {
  'tpope/vim-surround',
  event = "VeryLazy",
  config = function()
    vim.schedule(function()
      pcall(vim.cmd, 'unmap yS')
    end)
  end,
}
