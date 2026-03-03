return {
	{
		"Saghen/blink.cmp",
		version = "1.*",
		dependencies = {
			"echasnovski/mini.icons",
		},
		opts = {
      enabled = function()
        local disabled_filetypes = { "NvimTree", 'neo-tree'} -- Add extra fileypes you do not want blink enabled.
        return not vim.tbl_contains(disabled_filetypes, vim.bo.filetype)
      end,
			snippets = { preset = "luasnip" },
			fuzzy = {
				implementation = "prefer_rust_with_warning",
				sorts = { "exact", "score", "sort_text" },
			},
			keymap = {
				preset = "default",
				["<C-h>"] = {
					function(cmp)
						cmp.show({ providers = { "cmp_tabnine" } })
					end,
				},
				["<C-j>"] = { "show", "fallback" },
				["<Tab>"] = { "snippet_forward", "accept", "fallback" },
				["<S-Tab>"] = { "snippet_backward", "accept", "fallback" },
				["<CR>"] = { "accept", "fallback" },
			},
			signature = {
				enabled = true,
				window = {
					direction_priority = { "n", "s" },
					border = "rounded",
				},
			},
			completion = {
				list = { selection = { preselect = true, auto_insert = false } },
				trigger = {
					show_on_insert = true,
					show_on_blocked_trigger_characters = {},
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 100,
					treesitter_highlighting = true,
					window = {
						winhighlight = "Pmenu:NormalDarker,Normal:NormalDarker,SignColumn:SignColumnDarker,EndOfBuffer:EndOfBufferDarker,WinSeparator:WinSeparatorDarker",
						border = "solid",
						min_width = 40,
						direction_priority = {
							menu_north = { "e", "w" },
							menu_south = { "e", "w" },
						},
					},
				},
				menu = {
					scrollbar = false,
					border = "none",
					winhighlight = "Pmenu:NormalDarker,Normal:NormalDarker,SignColumn:SignColumnDarker,EndOfBuffer:EndOfBufferDarker,WinSeparator:WinSeparatorDarker",
				},
				ghost_text = { enabled = true },
			},
			sources = {
				default = { "lsp", "path", "snippets", "cmp_tabnine", "buffer" },
				providers = {
					lsp = {
						override = {
							get_trigger_characters = function(self)
								local trigger_characters = self:get_trigger_characters()
								vim.list_extend(trigger_characters, { "\n", "\t", " " })
								return trigger_characters
							end,
						},
					},
					cmp_tabnine = {
						name = "cmp_tabnine",
						module = "blink.compat.source",
					},
				},
			},
		},
		config = function(_, opts)
			local tabnine = require("cmp_tabnine.config")

			tabnine:setup({
				max_lines = 1000,
				max_num_results = 20,
				sort = true,
				run_on_every_keystroke = true,
				snippet_placeholder = "..",
				ignored_file_types = {
					-- default is not to ignore
					-- uncomment to ignore in lua:
					-- lua = true
				},
				show_prediction_strength = true,
				min_percent = 0,
			})
			require("blink.cmp").setup(opts)
		end,
	},
	-- add blink.compat
	{
		"saghen/blink.compat",
		-- use v2.* for blink.cmp v1.*
		version = "2.*",
		-- lazy.nvim will automatically load the plugin when it's required by blink.cmp
		lazy = true,
		-- make sure to set opts so that lazy.nvim calls blink.compat's setup
		opts = {},
	},
	{ "tzachar/cmp-tabnine", build = "./install.sh", dependencies = 'hrsh7th/nvim-cmp' },
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function(_, opts)
			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip").filetype_extend("javascript", { "javascriptreact" })
			require("luasnip").filetype_extend("javascript", { "jsdoc" })
			require("luasnip").filetype_extend("javascript", { "next" })
			require("luasnip").filetype_extend("javascript", { "react-es7" })
			require("luasnip").filetype_extend("javascript", { "react-native" })
			require("luasnip").filetype_extend("typescript", { "tsdoc" })
			require("luasnip").filetype_extend("typescript", { "next-ts" })
			require("luasnip").filetype_extend("typescript", { "react-ts" })
			require("luasnip").filetype_extend("typescript", { "react-native-ts" })

			-- vim.api.nvim_create_autocmd("User", {
			--   pattern = "BlinkCmpMenuOpen",
			--   callback = function()
			--     require("copilot.suggestion").dismiss()
			--     vim.b.copilot_suggestion_hidden = true
			--   end,
			-- })
			--
			-- vim.api.nvim_create_autocmd("User", {
			--   pattern = "BlinkCmpMenuClose",
			--   callback = function()
			--     vim.b.copilot_suggestion_hidden = false
			--   end,
			-- })
		end,
	},
}
