local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  spec = {
    { import = 'plugins' },
    { import = 'colorschemes' },
  },
  install = {
    colorscheme = { 'onedark' },
  },
  -- ui = {
  --   custom_keys = {
  --     ["<leader>cL"] = ":Lazy sync<CR>",
  --     ["K"] = false
  --   }
  -- }
})

vim.api.nvim_set_keymap('n', "<leader>cL", ":Lazy<CR>", {})
