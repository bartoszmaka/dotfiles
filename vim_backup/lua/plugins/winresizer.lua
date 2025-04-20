return {
  'simeji/winresizer',
  keys = {
    { "<C-w>m", "<cmd>MaximizerToggle<CR>", desc = "Maximize" },
    { "<C-w>e", "<cmd>WinResizerStartResize<CR>", desc = "Resize" }
  },
  config = function()
    vim.g.winresizer_start_key = ''
  end,
}
