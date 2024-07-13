return {
  'petertriho/nvim-scrollbar',
  lazy=false,
  config = function()
    local colors = require('helper/colors').onedark

    require("scrollbar").setup({
      handle = {
        text = " ",
        color = colors.bg3
      },
      excluded_filetypes = { 'neo-tree' },
      handlers = {
        cursor = true,
        diagnostic = true,
        gitsigns = true,
        handle = true,
        search = true,
      },
      marks = {
        Cursor = { text = "•", priority = 0, highlight = "Normal", },
        Search = { text = { "-", "=" }, priority = 1, highlight = "Search", },
        Error = { text = { "-", "=" }, priority = 2, highlight = "DiagnosticVirtualTextError", },
        Warn = { text = { "-", "=" }, priority = 3, highlight = "DiagnosticVirtualTextWarn", },
        Info = { text = { "-", "=" }, priority = 4, highlight = "DiagnosticVirtualTextInfo", },
        Hint = { text = { "-", "=" }, priority = 5, highlight = "DiagnosticVirtualTextHint", },
        Misc = { text = { "-", "=" }, priority = 6, highlight = "Normal", },
        GitAdd = { text = "▒", priority = 7, highlight = "GitSignsAdd", },
        GitChange = { text = "▒", priority = 7, highlight = "GitSignsChange", },
        GitDelete = { text = "▒", priority = 7, highlight = "GitSignsDelete", },
      }
    })
  end
}
