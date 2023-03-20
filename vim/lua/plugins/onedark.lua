return {
  'navarasu/onedark.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    local colors = require('config_helper.colors').onedark

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
        DiffChange = { bg = colors.diff_change, fg = "none" },
        DiffText   = { bg = colors.diff_text, fg = "none" },
        DiffAdd    = { bg = colors.diff_add, fg = "none" },
        DiffDelete = { bg = colors.diff_delete, fg = "none" },
      },
    })
    require('onedark').load()
  end
}
