return {}
-- return {
--   'lukas-reineke/indent-blankline.nvim',
--   main = "ibl",
--   event = { "BufReadPost", "BufNewFile" },
--   config = function()
--     local ibl = require('ibl')
--     local hooks = require "ibl.hooks"
--     local symbols = require('helper.symbols')
--     local colors = require('helper.colors').onedark
--
--     local rainbow_colors = {
--       "RainbowDelimiterRed",
--       "RainbowDelimiterYellow",
--       "RainbowDelimiterBlue",
--       "RainbowDelimiterOrange",
--       "RainbowDelimiterGreen",
--       "RainbowDelimiterViolet",
--       "RainbowDelimiterCyan",
--     }
--
--     local rainbow_colors_dimmed = {
--       "RainbowIndentRed",
--       "RainbowIndentYellow",
--       "RainbowIndentBlue",
--       "RainbowIndentOrange",
--       "RainbowIndentGreen",
--       "RainbowIndentPurple",
--       "RainbowIndentCyan",
--     }
--
--     -- hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
--     --   vim.api.nvim_set_hl(0, "RainbowParenBlue", { fg = colors.blue })
--     --   vim.api.nvim_set_hl(0, "RainbowParenCyan", { fg = colors.cyan })
--     --   vim.api.nvim_set_hl(0, "RainbowParenGreen", { fg = colors.green })
--     --   vim.api.nvim_set_hl(0, "RainbowParenOrange", { fg = colors.orange })
--     --   vim.api.nvim_set_hl(0, "RainbowParenRed", { fg = colors.red })
--     --   vim.api.nvim_set_hl(0, "RainbowParenPurple", { fg = colors.purple })
--     --   vim.api.nvim_set_hl(0, "RainbowParenYellow", { fg = colors.yellow })
--     --   vim.api.nvim_set_hl(0, "RainbowIndentBlue", { fg = colors.dimmed_blue })
--     --   vim.api.nvim_set_hl(0, "RainbowIndentCyan", { fg = colors.dimmed_cyan })
--     --   vim.api.nvim_set_hl(0, "RainbowIndentGreen", { fg = colors.dimmed_green })
--     --   vim.api.nvim_set_hl(0, "RainbowIndentOrange", { fg = colors.dimmed_orange })
--     --   vim.api.nvim_set_hl(0, "RainbowIndentRed", { fg = colors.dimmed_red })
--     --   vim.api.nvim_set_hl(0, "RainbowIndentPurple", { fg = colors.dimmed_purple })
--     --   vim.api.nvim_set_hl(0, "RainbowIndentYellow", { fg = colors.dimmed_yellow })
--     -- end)
--
--     function ToggleIndentMarks()
--       if vim.g.indent_config_index == 0 then
--         vim.g.indent_config_index = 1
--         ibl.update({ scope = { highlight = rainbow_colors } })
--       else
--         vim.g.indent_config_index = 0
--         ibl.update({ scope = { highlight = 'IblScope' } })
--       end
--     end
--
--     vim.cmd [[
--       nnoremap <leader>uI :IBLToggle<CR>
--       nnoremap <leader>ui :lua ToggleIndentMarks()<CR>
--
--       augroup indent_blankline_overrides
--       autocmd!
--       highlight! IblIndent guifg=#283347
--       highlight! IblScope guifg=#2a324a gui=nocombine
--       augroup END
--     ]]
--
--     vim.g.rainbow_delimiters = rainbow_colors
--     vim.g.indent_config_index = 0
--     ibl.setup({
--       scope = {
--         show_start = false,
--        show_end = false,
--         char = symbols.bar,
--         include = { node_type = { ["*"] = { "*" } } },
--         highlight = 'IblScope',
--       },
--       indent = {
--         char = ' ',
--         highlight = 'IblIndent',
--       },
--       exclude = {
--         filetypes = { "fzf", "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
--       }
--     })
--     hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
--   end,
-- }