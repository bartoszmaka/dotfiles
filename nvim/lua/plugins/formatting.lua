return {
	{
		"stevearc/conform.nvim",
		config = function()
			local conform = require("conform")

			conform.setup({
				formatters_by_ft = {
          ["*"] = { "trim_whitespace", "codespell" },
					ruby = { "rubocop" },
					typescript = { "prettier" },
					javascript = { "prettier" },
					lua = { "stylua" },
				},
				format_on_save = false,
				-- format_on_save = {
				-- 	timeout_ms = 1000,
				-- 	lsp_fallback = true,
				-- },
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
					"prettier",
					"stylua",
				},
			})
		end,
	},
}
