return {
  {
    "stevearc/conform.nvim",
    config = function()
      local conform = require("conform")
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

      conform.setup({
        formatters_by_ft = {
          ["*"] = { "trim_whitespace", "codespell" },
          ruby = { "rubocop" },
          javascript = { "prettierd", "prettier" },
          typescript = { "prettierd", "prettier" },
          javascriptreact = { "prettierd", "prettier" },
          typescriptreact = { "prettierd", "prettier" },
          css = { "prettierd", "prettier" },
          html = { "prettierd", "prettier" },
          json = { "prettierd", "prettier" },
          jsonc = { "prettierd", "prettier" },
          yaml = { "prettierd", "prettier" },
          markdown = { "prettierd", "prettier", "injected" },
          graphql = { "prettierd", "prettier" },
          lua = { "stylua" },
          sh = { "beautysh" },
        },
        format_on_save = false,
      })

      vim.keymap.set("n", "<C-m><C-f>", function()
        conform.format({ async = true })
      end, { desc = "Format buffer" })
    end,
  },
  {
    "zapling/mason-conform.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "stevearc/conform.nvim",
    },
    config = function()
      require("mason-conform").setup({
        ensure_installed = {
          "rubocop",
          "prettierd",
          "prettier",
          "stylua",
        },
      })
    end,
  },
}
