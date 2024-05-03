return {
  'simnalamburt/vim-mundo',
  keys = { { "<C-k><C-u>", "<cmd>MundoToggle<CR>", desc = { "Undo tree" } } },
  config = function()
    vim.g.mundo_right = 1
  end,
}
