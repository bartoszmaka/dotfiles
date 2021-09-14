local symbols = require('config_helper/symbols')

require("nvim-gps").setup({
  icons = {
    ["class-name"] = symbols.Class,
    ["function-name"] = symbols.Method,
    ["method-name"] = symbols.Method,
  },
  separator = ' > ',
})
