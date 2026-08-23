return {
  'NvChad/nvim-colorizer.lua',
  event = { 'BufReadPost', 'BufNewFile' },
  opts = {
    -- Scoped rather than '*': colorizer rescans the visible range on every
    -- scroll, and `tailwind` adds keyword matching on top. Only attach where
    -- color literals or tailwind classes actually appear.
    filetypes = {
      'css', 'scss', 'sass', 'less',
      'html', 'eruby', 'vue', 'svelte',
      'javascript', 'javascriptreact', 'typescript', 'typescriptreact',
      'lua', 'conf', 'toml', 'yaml', 'json',
    },
    user_default_options = {
      RGB = true,
      RRGGBB = true,
      names = false,
      RRGGBBAA = true,
      css = true,
      css_fn = true,
      mode = 'background',
      tailwind = true,
    },
  },
}
