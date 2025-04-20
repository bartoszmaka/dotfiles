return {
  { "tpope/vim-bundler", ft = { "ruby", "eruby" } },
  { "tpope/vim-endwise", ft = { "ruby", "eruby" } },
  -- { "vim-ruby/vim-ruby", event = { "BufReadPost", "BufNewFile" } },
  {
    "tpope/vim-rails",
    keys = {
      { "<leader>s", ":A<cr>", desc = "Toggle test and code files" },
    },
  },
}
