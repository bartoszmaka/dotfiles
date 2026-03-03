return {
  'lukas-reineke/indent-blankline.nvim',
  main = "ibl",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local ibl = require('ibl')
    local hooks = require("ibl.hooks")
    local symbols = require('helper.symbols')

    local rainbow_colors = {
      "RainbowDelimiterRed",
      "RainbowDelimiterYellow",
      "RainbowDelimiterBlue",
      "RainbowDelimiterOrange",
      "RainbowDelimiterGreen",
      "RainbowDelimiterViolet",
      "RainbowDelimiterCyan",
    }

    function ToggleIndentMarks()
      if vim.g.indent_config_index == 0 then
        vim.g.indent_config_index = 1
        ibl.update({ scope = { highlight = rainbow_colors } })
      else
        vim.g.indent_config_index = 0
        ibl.update({ scope = { highlight = 'IblScope' } })
      end
    end

    vim.cmd [[
      nnoremap <leader>uI :IBLToggle<CR>
      nnoremap <leader>ui :lua ToggleIndentMarks()<CR>

      augroup indent_blankline_overrides
        autocmd!
        highlight! IblIndent guifg=#283347
        highlight! IblScope guifg=#2a324a gui=nocombine
      augroup END
    ]]

    vim.g.indent_config_index = 0
    ibl.setup({
      scope = {
        show_start = false,
        show_end = false,
        char = symbols.bar,
        include = { node_type = { ["*"] = { "*" } } },
        highlight = 'IblScope',
      },
      indent = {
        char = ' ',
        highlight = 'IblIndent',
      },
      exclude = {
        filetypes = { "fzf", "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
      },
    })
    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
  end,
}
