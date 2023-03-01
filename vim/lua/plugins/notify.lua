return {
  'rcarriga/nvim-notify',
  config = function()
    local symbols = require('config_helper.symbols')

    require('notify').setup({
      symbols = {
        ERROR = symbols.error,
        WARN = symbols.warning,
        INFO = symbols.information,
        DEBUG = symbols.Constructor,
        TRACE = symbols.trace,
      },
    })

    vim.notify = require('notify')
  end
}
