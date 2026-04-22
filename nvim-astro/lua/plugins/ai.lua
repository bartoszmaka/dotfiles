return {
  {
    "olimorris/codecompanion.nvim",
    tag = "v18.3.2",
    cmd = {
      "CodeCompanion",
      "CodeCompanionActions",
      "CodeCompanionChat",
      "CodeCompanionCmd",
    },
    keys = {
      {
        "<C-k><C-o>",
        "<cmd>CodeCompanionChat Toggle<cr>",
        desc = "Toggle CodeCompanion chat",
        mode = { "n", "v" },
      },
      {
        "<leader>Aa",
        "<cmd>CodeCompanionChat Toggle<cr>",
        desc = "AI chat",
        mode = { "n", "v" },
      },
      {
        "<leader>Ae",
        "<cmd>CodeCompanionActions<cr>",
        desc = "AI actions",
        mode = { "n", "v" },
      },
      {
        "<leader>Ar",
        "<cmd>CodeCompanionCmd<cr>",
        desc = "AI command",
        mode = { "n", "v" },
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "MunifTanjim/nui.nvim",
      "echasnovski/mini.icons",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = { file_types = { "markdown", "codecompanion" } },
        ft = { "markdown", "codecompanion" },
      },
    },
    opts = {
      adapters = {
        http = {
          openai_responses = function()
            return require("codecompanion.adapters").extend("openai_responses", {
              env = {
                api_key = "AVANTE_OPENAI_API_KEY",
              },
              schema = {
                model = {
                  default = "codex",
                },
              },
            })
          end,
        },
      },
      interactions = {
        chat = {
          adapter = "openai_responses",
        },
        inline = {
          adapter = "openai_responses",
        },
        cmd = {
          adapter = "openai_responses",
        },
      },
    },
  },
}
