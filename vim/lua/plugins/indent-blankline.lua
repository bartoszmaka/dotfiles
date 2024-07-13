return {
  'lukas-reineke/indent-blankline.nvim',
  main = "ibl",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local ibl = require('ibl')
    local hooks = require "ibl.hooks"
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
        ibl.update({
          indent = { char = symbols.bar },
          scope = { highlight = rainbow_colors }
        })
      else
        vim.g.indent_config_index = 0
        ibl.update({
          indent = { char = ' ' },
          scope = { highlight = 'IblScope' }
        })
      end
    end

    vim.cmd [[
      nnoremap <leader>uI :IBLToggle<CR>
      nnoremap <leader>ui :lua ToggleIndentMarks()<CR>

      augroup indent_blankline_overrides
      autocmd!
      highlight! IblIndent guifg=#283347
      highlight! IblScope guifg=#2a324a gui=nocombine
      highlight! IblRainbowColOrange guifg=#492b0d
      highlight! IblRainbowColGreen guifg=#284414
      highlight! IblRainbowColViolet guifg=#430b54
      highlight! IblRainbowColCyan guifg=#0e3a3f
      highlight! IblRainbowColRed guifg=#5f050d
      highlight! IblRainbowColYellow guifg=#5a3e08
      highlight! IblRainbowColBlue guifg=#01335d
      augroup END
    ]]

    vim.g.rainbow_delimiters = {}
    vim.g.indent_config_index = 0
    ibl.setup({
      scope = {
        show_start = false,
        show_end = false,
        char = symbols.bar,
        include = {
          node_type = {
            ["*"] = {
              "return_statement",
              "table_constructor",
              "block",
              "chunk",
              "function_call",
              "body_statement",
              "hash",
              "array",
              "singleton_method",
              "method",
              "method_parameters",
              "argument_list",
              "then",
              "else",
            },
          },
        },
        highlight = 'IblScope',
      },
      indent = {
        char = ' ',
        highlight = 'IblIndent',
      },
      exclude = {
        filetypes = { "fzf", "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
      }
    })
    hooks.register(
      hooks.type.SCOPE_HIGHLIGHT,
      hooks.builtin.scope_highlight_from_extmark
    )
  end,
}
