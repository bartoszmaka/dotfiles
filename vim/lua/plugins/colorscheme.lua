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
          DiffChange                = { bg = colors.diff_change, fg = "none" },
          DiffText                  = { bg = colors.diff_text, fg = "none" },
          DiffAdd                   = { bg = colors.diff_add, fg = "none" },
          DiffDelete                = { bg = colors.diff_delete, fg = "none" },
          ['@boolean']              = { fmt = 'italic' },
          ['@constant.builtin']     = { fmt = 'italic', fg = colors.red },
          ['@include']              = { fmt = 'italic' },
          ['@keyword']              = { fmt = 'italic' },
          ['@keyword.function']     = { fmt = 'italic' },
          ['@variable.builtin']     = { fmt = 'italic' },
          ['@conditional']          = { fmt = 'none' },
          ['@constructor']          = { fmt = 'none' },
          ['@lsp.type.variable']    = { fmt = 'none' },
          ['CmpItemAbbr']           = { fg = '#6c7d9c' },
          ['CmpItemAbbrMatch']      = { fg = '#f2cc81' },
          ['CmpItemAbbrMatchFuzzy'] = { fg = '#f2cc81', fmt = 'none' },
          ['CmpItemKindDefault']    = { fg = '#dd9046' },
          ['CmpItemKindSnippet']    = { fg = '#f65866' },
          ['CmpItemKindKeyword']    = { fg = '#bfbd5d' },
          ['CmpItemAbbrDeprecated'] = { fg = '#455574' },
          ['CmpItemKindText']       = { fg = '#93a4c3' },
          ['CmpItemKindCopilot']    = { fg = '#6CC644' },
          ['IlluminatedWordText']   = { fmt = 'none', bg = colors.bg3 },
          ['IlluminatedWordRead']   = { fmt = 'none', bg = colors.bg2 },
          ['illuminatedwordwrite']  = { fmt = 'none', bg = colors.diff_add },
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
