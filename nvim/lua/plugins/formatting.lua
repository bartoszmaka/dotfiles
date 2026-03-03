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
          zig = { "zigfmt" },
        },
        format_on_save = false,
      })

      vim.keymap.set("n", "<C-m><C-f>", function()
        conform.format({ async = true })
      end, { desc = "Format buffer" })

      vim.api.nvim_create_user_command("FormatConform", function(_)
        vim.lsp.buf.format()
      end, { desc = "Format current buffer with LSP" })
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
