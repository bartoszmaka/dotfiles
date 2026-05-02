return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  event = { 'BufReadPost', 'BufNewFile' },
  config = function()
    local ibl = require('ibl')
    local hooks = require('ibl.hooks')
    local symbols = require('helper.symbols')
    local colors = require('helper.colors').onedark

    local rainbow_colors = {
      'RainbowDelimiterRed',
      'RainbowDelimiterYellow',
      'RainbowDelimiterBlue',
      'RainbowDelimiterOrange',
      'RainbowDelimiterGreen',
      'RainbowDelimiterViolet',
      'RainbowDelimiterCyan',
    }

    local function toggle_indent_marks()
      if vim.g.indent_config_index == 0 then
        vim.g.indent_config_index = 1
        ibl.update({ scope = { highlight = rainbow_colors } })
      else
        vim.g.indent_config_index = 0
        ibl.update({ scope = { highlight = 'IblScope' } })
      end
    end

    vim.api.nvim_set_hl(0, 'IblIndent', { fg = colors.bg2 })
    vim.api.nvim_set_hl(0, 'IblScope', { fg = colors.bg3, nocombine = true })

    vim.keymap.set('n', '<leader>uI', '<cmd>IBLToggle<CR>', { desc = 'Toggle indent guides' })
    vim.keymap.set('n', '<leader>ui', toggle_indent_marks, { desc = 'Toggle indent scope colors' })

    vim.g.indent_config_index = 0
    ibl.setup({
      scope = {
        show_start = false,
        show_end = false,
        char = symbols.bar,
        include = { node_type = { ['*'] = { '*' } } },
        highlight = 'IblScope',
      },
      indent = {
        char = ' ',
        highlight = 'IblIndent',
      },
      exclude = {
        filetypes = { 'fzf', 'help', 'alpha', 'dashboard', 'neo-tree', 'Trouble', 'lazy', 'mason' },
      },
    })
    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
  end,
}
