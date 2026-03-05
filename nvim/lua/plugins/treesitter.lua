return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		config = function(_, opts)
			local ts = require("nvim-treesitter")

			-- State tracking for async parser loading
			local parsers_loaded = {}
			local parsers_pending = {}
			local parsers_failed = {}

			local ns = vim.api.nvim_create_namespace("treesitter.async")

			-- Helper to start highlighting and indentation
			local function start(buf, lang)
				local ok = pcall(vim.treesitter.start, buf, lang)
				if ok then
					vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
				return ok
			end

			-- Install core parsers after lazy.nvim finishes loading all plugins
			vim.api.nvim_create_autocmd("User", {
				pattern = "LazyDone",
				once = true,
				callback = function()
					ts.install({
						"bash",
						"comment",
						"css",
						"diff",
						"fish",
						"git_config",
						"git_rebase",
						"gitcommit",
						"gitignore",
						"html",
						"javascript",
						"json",
						"latex",
						"lua",
						"luadoc",
						"make",
						"markdown",
						"markdown_inline",
						"norg",
						"python",
						"query",
						"regex",
						"scss",
						"svelte",
						"toml",
						"tsx",
						"typescript",
						"typst",
						"vim",
						"vimdoc",
						"vue",
            "ruby",
						"xml",
					}, {
						max_jobs = 8,
					})
				end,
			})

			-- Decoration provider for async parser loading
			vim.api.nvim_set_decoration_provider(ns, {
				on_start = vim.schedule_wrap(function()
					if #parsers_pending == 0 then
						return false
					end
					for _, data in ipairs(parsers_pending) do
						if vim.api.nvim_buf_is_valid(data.buf) then
							if start(data.buf, data.lang) then
								parsers_loaded[data.lang] = true
							else
								parsers_failed[data.lang] = true
							end
						end
					end
					parsers_pending = {}
				end),
			})

			local group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true })

			local ignore_filetypes = {
				"checkhealth",
				"lazy",
				"mason",
				"snacks_dashboard",
				"snacks_notif",
				"snacks_win",
			}

			-- Auto-install parsers and enable highlighting on FileType
			vim.api.nvim_create_autocmd("FileType", {
				group = group,
				desc = "Enable treesitter highlighting and indentation (non-blocking)",
				callback = function(event)
					if vim.tbl_contains(ignore_filetypes, event.match) then
						return
					end

					local lang = vim.treesitter.language.get_lang(event.match) or event.match
					local buf = event.buf

					if parsers_failed[lang] then
						return
					end

					if parsers_loaded[lang] then
						-- Parser already loaded, start immediately (fast path)
						start(buf, lang)
					else
						-- Queue for async loading
						table.insert(parsers_pending, { buf = buf, lang = lang })
					end

					-- Auto-install missing parsers (async, no-op if already installed)
					ts.install({ lang })
				end,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-treesitter-textobjects").setup({
				select = {
					lookahead = true,
					include_surrounding_whitespace = false,
				},
				move = { set_jumps = true },
			})

			local select = require("nvim-treesitter-textobjects.select")
			vim.keymap.set({ "x", "o" }, "af", function()
				select.select_textobject("@function.outer", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "if", function()
				select.select_textobject("@function.inner", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "aC", function()
				select.select_textobject("@class.outer", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "iC", function()
				select.select_textobject("@class.inner", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "ac", function()
				select.select_textobject("@conditional.outer", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "ic", function()
				select.select_textobject("@conditional.inner", "textobjects")
			end)

			local move = require("nvim-treesitter-textobjects.move")
			vim.keymap.set({ "n", "x", "o" }, "]f", function()
				move.goto_next_start("@function.outer", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "]C", function()
				move.goto_next_start("@class.outer", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "[f", function()
				move.goto_previous_start("@function.outer", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "[C", function()
				move.goto_previous_start("@class.outer", "textobjects")
			end)
		end,
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		lazy = true,
		init = function()
			vim.g.skip_ts_context_commentstring_module = true
		end,
		opts = {
			javascript = {
				__default = "// %s",
				jsx_element = "{/* %s */}",
				jsx_fragment = "{/* %s */}",
				jsx_attribute = "// %s",
				comment = "// %s",
			},
			typescriptreact = {
				__default = "// %s",
				jsx_element = "{/* %s */}",
				jsx_fragment = "{/* %s */}",
				jsx_attribute = "// %s",
				comment = "// %s",
			},
			toml = { __default = "# %s" },
		},
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		opts = {
			max_lines = 4,
			multiline_threshold = 2,
		},
	},
	{ "windwp/nvim-ts-autotag", event = "InsertEnter", opts = {} },
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			local npairs = require("nvim-autopairs")
			local Rule = require("nvim-autopairs.rule")

			npairs.setup({ check_ts = true, ts_config = { lua = { "string" } } })

			npairs.add_rules({
				Rule(" ", " "):with_pair(function(opts)
					return vim.tbl_contains({ "()", "[]", "{}" }, opts.line:sub(opts.col - 1, opts.col))
				end),
			})
			npairs.add_rules({
				Rule("( ", " )")
					:with_pair(function()
						return false
					end)
					:with_move(function()
						return true
					end)
					:use_key(")"),
			})
			npairs.add_rules({ Rule("<%", " %>", "eruby") })
			npairs.add_rules(require("nvim-autopairs.rules.endwise-lua"))
			npairs.add_rules(require("nvim-autopairs.rules.endwise-ruby"))
		end,
	},
	{
		"m-demare/hlargs.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("hlargs").setup()
			vim.api.nvim_set_hl(0, "Hlargs", { italic = true })
		end,
	},
}
