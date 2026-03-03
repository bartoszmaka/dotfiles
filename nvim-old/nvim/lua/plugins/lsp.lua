return {
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		dependencies = {
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
			local border = "rounded"
			local lsps = {
				"ruby_lsp",
				-- "solargraph",
				"dockerls",
				"pyright",
				"bashls",
				"graphql",
				"jsonls",
				"vtsls",
				"lua_ls",
				"yamlls",
				"tailwindcss",
				"emmet_language_server",
				"cssls",
			}
			vim.lsp.enable(lsps)
			-- vim.o.winborder = 'rounded'
      capabilities = require("blink.cmp").get_lsp_capabilities(nil, true)
      capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true
    }
			vim.lsp.config("*", {
				capabilities = capabilities,
				root_markers = { ".git" },
			})
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" }, -- ← this line tells lua_ls to accept `vim` as global
						},
					},
				},
			})
			-- vim.lsp.config("ruby_lsp", {
			--      cmd_env = {
			--        BUNDLE_GEMFILE = '$HOME/.ruby-lsp-tools-3-3-3/Gemfile'
			--      }
			-- })
      -- "rubyLsp.bundleGemfile": "",

			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = lsps,
				automatic_installation = true,
			})

			vim.diagnostic.config({
				severity_sort = true,
				underline = true,
				-- underline = { severity = vim.diagnostic.severity.ERROR }
				virtual_lines = false,
				virtual_text = true,
				update_in_insert = true,
				float = {
					show_header = true,
					border = border,
					focusable = true,
					-- style = "minimal",
				},
				signs = {
					priority = 10,
					text = {
						[vim.diagnostic.severity.ERROR] = " ", -- 󰅚
						[vim.diagnostic.severity.WARN] = " ", -- 󰀪
						[vim.diagnostic.severity.INFO] = " ", -- 󰋽
						[vim.diagnostic.severity.HINT] = "󰠠 ", -- 󰌶
					},
				},
			})
			vim.keymap.set("n", "[e", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
			vim.keymap.set("n", "]e", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
			vim.keymap.set("n", "<leader>E", vim.diagnostic.open_float, { desc = "Show diagnostics" })
			vim.keymap.set("n", "<leader>K", vim.lsp.buf.hover, { desc = "Show hover documentation" })
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
			vim.keymap.set("n", "<C-m><C-e>", vim.diagnostic.setloclist, { desc = "Diagnostics to loclist" })
			vim.api.nvim_create_user_command("Format", function(_)
				vim.lsp.buf.format()
			end, { desc = "Format current buffer with LSP" })

      vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = true })
      vim.cmd [[
        hi! LspReferenceRead  guibg=#283347
        hi! LspReferenceText  guibg=#2a324a
        hi! LspReferenceWrite guibg=#1a2e1b

      ]]
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					local bufnr = args.buf

					if client.server_capabilities.documentHighlightProvider then
						vim.api.nvim_create_autocmd("CursorHold", {
							group = "LspDocumentHighlight",
							buffer = bufnr,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd("CursorMoved", {
							group = "LspDocumentHighlight",
							buffer = bufnr,
							callback = vim.lsp.buf.clear_references,
						})
					end
				end,
			})
		end,
		keys = {
			{ "<leader>cl", ":LspInfo<CR>", desc = "Lsp Info" },
			{ "<leader>cm", ":Mason<CR>", desc = "Mason Info" },
      -- { "gd", ":lua vim.lsp.buf.definition({ on_list = on_list })<CR>", desc = "Definition" },
      -- { "gr", ":lua vim.lsp.buf.references(nil, { on_list = on_list })<CR>", desc = "References" }
		},
	},
}
