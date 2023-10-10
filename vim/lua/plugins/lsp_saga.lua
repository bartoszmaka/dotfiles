return {
  "glepnir/lspsaga.nvim",
  event = "LspAttach",
  config = function()
    require("lspsaga").setup({
      ui = {
        theme = 'round',
        title = true,
        -- border type can be single,double,rounded,solid,shadow.
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
      highlight! link SagaBorder NormalDarker
    ]]

    -- local keymap = vim.keymap.set
    -- keymap("n", "gr", "<cmd>Lspsaga finder<CR>")
    -- keymap({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>")
    -- keymap("n", "<leader>gh", "<cmd>Lspsaga peek_definition<CR>")
    -- keymap("n", "<leader>gr", "<cmd>Lspsaga rename<CR>")
    -- keymap("n", "gd", "<cmd>Lspsaga goto_definition<CR>")
    -- keymap("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>")
    -- keymap("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>")
    -- keymap("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>")
    -- keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
    -- keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")
    -- keymap("n", "[E", function()
    --   require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
    -- end)
    -- keymap("n", "]E", function()
    --   require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
    -- end)
    -- keymap("n", "<C-k><C-v>", "<cmd>Lspsaga outline<CR>")
    -- keymap("n", "<leader>K", "<cmd>Lspsaga hover_doc<CR>")
    -- -- keymap("n", "K", "<cmd>Lspsaga hover_doc ++keep<CR>")
    -- keymap("n", "<leader><C-k>", "<Cmd>Lspsaga signature_help<CR>")
    -- keymap("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
    -- keymap("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>")
    -- -- keymap({"n", "t"}, "<A-d>", "<cmd>Lspsaga term_toggle<CR>")
  end,
  dependencies = {
    -- { "nvim-tree/nvim-web-devicons" },
    { "nvim-treesitter/nvim-treesitter" } -- Please make sure you install markdown and markdown_inline parser
  }
}
