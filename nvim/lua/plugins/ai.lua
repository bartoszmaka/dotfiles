return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false,
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "echasnovski/mini.icons",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = { file_types = { "markdown", "Avante" } },
        ft = { "markdown", "Avante" },
      },
    },
    opts = function()
      local colors = require("helper.colors").onedark

      vim.api.nvim_set_hl(0, "AvanteInlineHint", { fg = colors.grey, bg = colors.bg_d })

      return {
        provider = "openai",
        providers = {
          claude = {
            endpoint = "https://api.anthropic.com",
            model = "claude-sonnet-4-20250514",
            extra_request_body = {
              max_tokens = 4096,
            },
          },
          openai = {
            endpoint = "https://api.openai.com/v1",
            model = "gpt-4o-mini",
            extra_request_body = {
              max_tokens = 4096,
            },
          },
        },
        behaviour = {
          auto_suggestions = false,
          auto_set_highlight_group = true,
          auto_set_keymaps = true,
          auto_apply_diff_after_generation = false,
          support_paste_from_clipboard = false,
        },
        input = {
          provider = "dressing",
        },
        mappings = {
          ask = "<leader>Aa",
          edit = "<leader>Ae",
          refresh = "<leader>Ar",
          toggle = {
            default = "<leader>At",
            debug = "<leader>Ad",
            hint = "<leader>Ah",
            suggestion = "<leader>As",
          },
        },
        windows = {
          position = "right",
          wrap = true,
          width = 40,
          sidebar_header = {
            align = "center",
            rounded = true,
          },
        },
      }
    end,
  },
}
