return {
	{
		"navarasu/onedark.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			local colors = require("helper.colors").onedark

			vim.o.termguicolors = true
			vim.o.background = "dark"

			require("onedark").setup({
				style = "deep",
				term_colors = false,
				colors = colors,
				code_style = {
					comments = "italic",
					keywords = "italic",
					functions = "none",
					strings = "none",
					variables = "none",
				},
				highlights = {
					DiffChange = { bg = colors.diff_change, fg = "none" },
					DiffText = { bg = colors.diff_text, fg = "none" },
					DiffAdd = { bg = colors.diff_add, fg = "none" },
					DiffDelete = { bg = colors.diff_delete, fg = "none" },
					MsgArea = { bg = colors.bg_d },
					["@boolean"] = { fmt = "italic" },
					["@constant.builtin"] = { fmt = "italic", fg = colors.red },
					["@include"] = { fmt = "italic" },
					["@keyword"] = { fmt = "italic" },
					["@keyword.function"] = { fmt = "italic" },
					["@variable.builtin"] = { fmt = "italic" },
					["@conditional"] = { fmt = "none" },
					["@constructor"] = { fmt = "none" },
					["@lsp.type.variable"] = { fmt = "none" },
					["BlinkCmpLabelMatch"] = { fg = colors.bg_yellow },
					["CmpItemAbbr"] = { fg = "#6c7d9c" },
					["CmpItemAbbrMatch"] = { fg = colors.bg_yellow },
					["CmpItemAbbrMatchFuzzy"] = { fg = colors.bg_yellow, fmt = "none" },
					["CmpItemAbbrDeprecated"] = { fg = "#455574" },
					["CmpItemKindDefault"] = { fg = colors.orange },
					["CmpItemKindSnippet"] = { fg = colors.red },
					["CmpItemKindKeyword"] = { fg = "#bfbd5d" },
					["CmpItemKindText"] = { fg = colors.fg },
					["CmpItemKindCopilot"] = { fg = "#6CC644" },
					["RainbowParenBlue"] = { fg = colors.blue },
					["RainbowParenCyan"] = { fg = colors.cyan },
					["RainbowParenGreen"] = { fg = colors.green },
					["RainbowParenOrange"] = { fg = colors.orange },
					["RainbowParenRed"] = { fg = colors.red },
					["RainbowParenPurple"] = { fg = colors.purple },
					["RainbowParenYellow"] = { fg = colors.yellow },
					["RainbowIndentBlue"] = { fg = colors.dimmed_blue },
					["RainbowIndentCyan"] = { fg = colors.dimmed_cyan },
					["RainbowIndentGreen"] = { fg = colors.dimmed_green },
					["RainbowIndentOrange"] = { fg = colors.dimmed_orange },
					["RainbowIndentRed"] = { fg = colors.dimmed_red },
					["RainbowIndentPurple"] = { fg = colors.dimmed_purple },
					["RainbowIndentYellow"] = { fg = colors.dimmed_yellow },
					["Winbar"] = { fmt = "none" },
					["NormalDarker"] = { bg = colors.bg_d, fg = colors.fg },
					["SignColumnDarker"] = { bg = colors.bg_d, fg = colors.fg },
					["EndOfBufferDarker"] = { bg = colors.bg_d, fg = colors.bg_d },
					["WinSeparatorDarker"] = { bg = colors.bg_d, fg = colors.bg3 },
					["CursorLine"] = { bg = colors.bg1 },
					["CursorLineNR"] = { bg = colors.bg1, fmt = "bold" },
					["CursorColumn"] = { bg = colors.bg1 },
					["ColorColumn"] = { bg = colors.bg1 },
					["Warning"] = { bg = "#443333" },
					["Error"] = { bg = "#512121" },
					["Visual"] = { bg = "#401437" },
					["DiagnosticVirtualTextHint"] = { fg = colors.dark_cyan, bg = "NONE" },
					["DiagnosticVirtualTextInfo"] = { fg = colors.dark_cyan, bg = "NONE" },
					["DiagnosticUnderlineError"] = { bg = "#512121", fmt = "NONE" },
					["DiagnosticUnderlineWarn"] = { bg = "#443333", fmt = "NONE" },
					["DiagnosticUnderlineInfo"] = { bg = "NONE", fmt = "NONE" },
					["DiagnosticUnderlineHint"] = { bg = "NONE", fmt = "NONE" },
					["FoldColumn"] = { bg = colors.bg0, fg = colors.grey },
					["SignColumn"] = { fg = colors.bg1 },
					["TreesitterContext"] = { bg = colors.bg_d },
					["TreesitterContextLineNumber"] = { bg = colors.bg_d },
					["CursorLineSign"] = { fg = colors.bg1 },
					["IncSearch"] = { fg = "#FF0000", bg = "NONE", fmt = "bold,nocombine" },
					["CurSearch"] = { fg = "#FF0000", bg = "NONE", fmt = "bold,nocombine" },
					["Search"] = { fg = colors.white, bg = "NONE", fmt = "bold,nocombine" },
				},
			})
			require("onedark").load()

			vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
			vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" })
			vim.api.nvim_set_hl(0, "NormalDarker", { bg = colors.bg_d, fg = colors.fg })
			vim.api.nvim_set_hl(0, "SignColumnDarker", { bg = colors.bg_d, fg = colors.fg })
			vim.api.nvim_set_hl(0, "EndOfBufferDarker", { bg = colors.bg_d, fg = colors.bg_d })
			vim.api.nvim_set_hl(0, "WinSeparatorDarker", { bg = colors.bg_d, fg = colors.bg3 })
			vim.api.nvim_set_hl(0, "WhichKeyNormal", { link = "NormalDarker" })
			vim.api.nvim_set_hl(0, "WhichKeyBorder", { link = "NormalDarker" })
			vim.api.nvim_set_hl(0, "LazyNormal", { link = "NormalDarker" })

			vim.cmd([[
        augroup make_panels_darker
          autocmd!
          autocmd FileType Mundo setlocal winhighlight=Normal:NormalDarker,SignColumn:SignColumnDarker,EndOfBuffer:EndOfBufferDarker,WinSeparator:WinSeparatorDarker
          autocmd FileType MundoDiff setlocal winhighlight=Normal:NormalDarker,SignColumn:SignColumnDarker,EndOfBuffer:EndOfBufferDarker,WinSeparator:WinSeparatorDarker
          autocmd FileType floaterm setlocal winhighlight=Normal:NormalDarker,SignColumn:SignColumnDarker,EndOfBuffer:EndOfBufferDarker,WinSeparator:WinSeparatorDarker
          autocmd FileType help setlocal winhighlight=Normal:NormalDarker,SignColumn:SignColumnDarker,EndOfBuffer:EndOfBufferDarker,WinSeparator:WinSeparatorDarker
          autocmd FileType lspinfo setlocal winhighlight=Normal:NormalDarker,SignColumn:SignColumnDarker,EndOfBuffer:EndOfBufferDarker,WinSeparator:WinSeparatorDarker
          autocmd FileType mason setlocal winhighlight=Normal:NormalDarker,SignColumn:SignColumnDarker,EndOfBuffer:EndOfBufferDarker,WinSeparator:WinSeparatorDarker
          autocmd FileType Trouble setlocal colorcolumn=
        augroup END

        augroup treesitter_hl_overrides
          autocmd!
          highlight! @error.ruby guibg=NONE guifg=NONE gui=NONE
          highlight! link @function.builtin.ruby @keyword
          highlight! link @keyword.function @keyword
          highlight! link @lsp.type.comment @comment
          highlight! link @lsp.type.function @function
          highlight! link @lsp.type.macro @macro
          highlight! link @lsp.type.method @method
          highlight! link @lsp.type.namespace @namespace
          highlight! link @lsp.type.parameter @parameter
          highlight! link @lsp.type.property @property
          highlight! link @lsp.type.type @type
          highlight! link @lsp.type.variable.javascript Special
          highlight! link @lsp.type.variable.typescriptreact Special
          highlight! link @lsp.typemod.function.declaration.typescriptreact @type
          highlight! link @lsp.typemod.function.declaration.typescriptreact @type
          highlight! link @lsp.typemod.function.readonly.typescriptreact @type
          highlight! link @lsp.typemod.variable.readonly.javascript @type
          highlight! link @parameter @variable.builtin
          highlight! link @string.special.symbol.ruby Constant
          highlight! link @string.special.url.html Normal
          highlight! link @tag Special
          highlight! link @tag.attribute @boolean
          highlight! link @tag.delimiter Special
          highlight! link @tag.delimiter.javascript Normal
          highlight! link @tag.delimiter.tsx Normal
          highlight! link @tag.javascript @type
          highlight! link @tag.tsx Type
          highlight! link @variable.member.ruby Special
          highlight! link @variable.parameter.ruby Special
          highlight! link TSTagAttribute TSBoolean
          highlight! link htmlBold Normal
          highlight! link htmlBold Normal
          highlight! link htmlBoldItalic Normal
          highlight! link htmlBoldItalicUnderline Normal
          highlight! link vueTSMethod TSBoolean
        augroup END
      ]])
		end,
	},
}
