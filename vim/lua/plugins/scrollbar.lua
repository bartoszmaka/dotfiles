return {
  'petertriho/nvim-scrollbar',
  lazy=false,
  config = function()
    local colors = require('helper.colors').onedark
    local symbols = require('helper.symbols')

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
        Cursor = { text = symbols.bar_right_big, priority = 0, highlight = "Normal", },
        Search = { text = { symbols.bar_right_big, symbols.bar_full }, priority = 1, highlight = "Search", },
        Error = { text = { symbols.bar_right_big, symbols.bar_full }, priority = 2, highlight = "DiagnosticVirtualTextError", },
        Warn = { text = { symbols.bar_right_big, symbols.bar_full }, priority = 3, highlight = "DiagnosticVirtualTextWarn", },
        Info = { text = { symbols.bar_right_big, symbols.bar_full }, priority = 4, highlight = "DiagnosticVirtualTextInfo", },
        Hint = { text = { symbols.bar_right_big, symbols.bar_full }, priority = 5, highlight = "DiagnosticVirtualTextHint", },
        Misc = { text = { symbols.bar_right_big, symbols.bar_full }, priority = 6, highlight = "Normal", },
        GitAdd = { text = symbols.bar_right_big, priority = 7, highlight = "GitSignsAdd", },
        GitChange = { text = symbols.bar_right_big, priority = 7, highlight = "GitSignsChange", },
        GitDelete = { text = symbols.bar_right_big, priority = 7, highlight = "GitSignsDelete", },
      }
    })

    vim.cmd [[
      highlight! ScrollBarGitAdd guifg=#284414
      highlight! ScrollBarGitChange guifg=#5a3e08
      highlight! ScrollBarGitDelete guifg=#5f050d
      highlight! ScrollBarGitAddHandle guifg=#284414
      highlight! ScrollBarGitChangeHandle guifg=#5a3e08
      highlight! ScrollBarGitDeleteHandle guifg=#5f050d
    ]]
  end
}
