return {
  'NvChad/nvim-colorizer.lua',
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    filetypes = { "*" },
    user_default_options = {
      RGB = true,
      RRGGBB = true,
      names = false,
      RRGGBBAA = true,
      css = true,
      css_fn = true,
      mode = "background",
      tailwind = true,
    },
  },
}
