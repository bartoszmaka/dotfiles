return {
  "glepnir/lspsaga.nvim",
  event = "LspAttach",
  config = function()
    local colors = require('helper.colors').onedark

    require("lspsaga").setup({
      ui = {
        theme = 'round',
        title = true,
        border = 'single',
        winblend = 0,
        expand = '',
        collapse = '',
        preview = ' ',
        code_action = '💡',
        diagnostic = '🐞',
        incoming = ' ',
        outgoing = ' ',
        colors = {
          --float window normal background color
          normal_bg = '#1d1536',
          --title background color
          title_bg = '#afd700',
          red = '#e95678',
          magenta = '#b33076',
          orange = '#FF8700',
          yellow = '#f7bb3b',
          green = '#afd700',
          cyan = '#36d0e0',
          blue = '#61afef',
          purple = '#CBA6F7',
          white = '#d1d4cf',
          black = '#1c1c19',
        },
        kind = {},
      },
      symbol_in_winbar = {
        enable = false,
        show_file = true,
        separator = ' > ',
        hide_keyword = true,
        folder_level = 2,
        respect_root = true,
        color_mode = false,
        -- in_custom = true,
        -- click_support = false,
      },
      outline = {
        win_position = 'right',
        win_with = '',
        win_width = 45,
        show_detail = true,
        auto_preview = true,
        auto_refresh = true,
        auto_close = true,
        custom_sort = nil,
        keys = {
          jump = 'o',
          expand_collapse = 'u',
          quit = 'q',
        },
      },
    })

      vim.cmd [[
        autocmd FileType saga_codeaction nnoremap <buffer> <esc> <esc>
        autocmd FileType saga_codeaction inoremap <buffer> <esc> <esc>
      ]]


    -- vim.cmd [[ highlight! link SagaBorder NormalDarker ]]
  end,
  dependencies = {
    -- { "nvim-tree/nvim-web-devicons" },
    { "nvim-treesitter/nvim-treesitter" } -- Please make sure you install markdown and markdown_inline parser
  }
}
