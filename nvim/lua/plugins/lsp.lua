return {
	{
		"neovim/nvim-lspconfig",
		lazy = false,

		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			{
				"j-hui/fidget.nvim",
				event = "LspAttach",
				opts = {
					progress = {
						display = {
							progress_icon = { pattern = "dots", period = 1 },
						},
					},
				},
			},
		},
		config = function()
			local lsps = {
				"ruby_lsp",
				"ts_ls",
				"dockerls",
				"graphql",
				"jsonls",
				"vtsls",
				"lua_ls",
				"yamlls",
				"tailwindcss",
			}
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			require("mason").setup()
			local mason_lspconfig = require("mason-lspconfig")
			mason_lspconfig.setup({
				ensure_installed = lsps,
				automatic_installation = true,
			})
			mason_lspconfig.setup_handlers({
				function(server_name)
					local opts = {
						capabilities = capabilities,
					}

					if server_name == "lua_ls" then
						opts.settings = {
							Lua = {
								diagnostics = {
									globals = { "vim" }, -- ← this line tells lua_ls to accept `vim` as global
								},
							},
						}
					end

					lspconfig[server_name].setup(opts)
				end,
			})

			local diagnostic = vim.diagnostic
			vim.keymap.set("n", "[e", diagnostic.goto_prev, { desc = "Prev diagnostic" })
			vim.keymap.set("n", "]e", diagnostic.goto_next, { desc = "Next diagnostic" })
			vim.keymap.set("n", "<leader>E", diagnostic.open_float, { desc = "Show diagnostics" })
			vim.keymap.set("n", "<C-m><C-e>", diagnostic.setloclist, { desc = "Diagnostics to loclist" })

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(_args)
					print("Attached")
				end,
			})
		end,
		keys = {
			{ "<leader>cl", ":LspInfo<CR>", desc = "Lsp Info" },
		},
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				mapping = cmp.mapping.preset.insert({
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "buffer" },
				},
			})
		end,
	},
}
