return {
  'rcarriga/nvim-notify',
  event = "VeryLazy",
  keys = {
    {
      "<leader>un",
      function()
        require("notify").dismiss({ silent = true, pending = true })
      end,
      desc = "Dismiss all Notifications",
    },
  },
  config = function()
    local symbols = require('helper.symbols')

    require('notify').setup({
      symbols = {
        ERROR = symbols.error,
        WARN = symbols.warning,
        INFO = symbols.information,
        DEBUG = symbols.Constructor,
        TRACE = symbols.trace,
      },
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
    })

    vim.notify = require('notify')
  end
}
