return {
  {
    'rebelot/heirline.nvim',
    event = 'UiEnter',
    dependencies = {
      'navarasu/onedark.nvim',
    },
    config = function()
      local components = require('helper.heirline_components')

      vim.opt.laststatus = 3
      vim.opt.showtabline = 2

      require('heirline').setup({
        statusline = components.statusline,
        tabline = nil,
        statuscolumn = components.statuscolumn,
      })
    end,
  },
}
