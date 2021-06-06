require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    disable = { "javascript", "javascript.jsx", "javascriptreact" }
  },
  indent = {
    enable = true
  },
  rainbow = {
    enable = true
  }
}
