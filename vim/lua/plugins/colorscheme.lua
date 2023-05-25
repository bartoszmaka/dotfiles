return {
  {
    'navarasu/onedark.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      local colors = require('helper.colors').onedark

      vim.o.termguicolors = true
      vim.o.background = "dark"

      require('onedark').setup({
        style = 'deep',
        term_colors = 'false',
        colors = colors,
        code_style = {
          comments = 'italic',
          keywords = 'italic',
          functions = 'none',
          strings = 'none',
          variables = 'none'
        },
        highlights = {
          DiffChange             = { bg = colors.diff_change, fg = "none" },
          DiffText               = { bg = colors.diff_text, fg = "none" },
          DiffAdd                = { bg = colors.diff_add, fg = "none" },
          DiffDelete             = { bg = colors.diff_delete, fg = "none" },
          ['@boolean']           = { fmt = 'italic' },
          ['@constant.builtin']  = { fmt = 'italic', fg = colors.red },
          ['@include']           = { fmt = 'italic' },
          ['@keyword']           = { fmt = 'italic' },
          ['@keyword.function']  = { fmt = 'italic' },
          ['@variable.builtin']  = { fmt = 'italic' },
          ['@conditional']       = { fmt = 'none' },
          ['@constructor']       = { fmt = 'none' },
          ['@lsp.type.variable'] = { fmt = 'none' },
        },
      })
      require('onedark').load()
    end
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = { style = "moon" },
  },
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
  },
}
