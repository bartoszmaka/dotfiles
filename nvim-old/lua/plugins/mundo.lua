return {
  'simnalamburt/vim-mundo',
  keys = { { "<C-k><C-u>", "<cmd>MundoToggle<CR>" } },
  config = function()
    vim.g.mundo_right = 1
  end,
}
