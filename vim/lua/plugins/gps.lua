local symbols = require('config_helper/symbols')

local icons_for_match_groups = {
  ["class-name"] = symbols.Class .. ' ',
  ["function-name"] = symbols.Method .. ' ',
  ["method-name"] = symbols.Method .. ' ',
  ["tag-name"] = symbols.Tag .. ' ',
  ["container-name"] = symbols.Object .. ' ',
  ["array-name"] = symbols.Array .. ' ',
  ["object-name"] = symbols.Object .. ' ',
  ["null-name"] = symbols.Null .. ' ',
  ["boolean-name"] = symbols.Boolean .. ' ',
  ["number-name"] = symbols.Number .. ' ',
  ["string-name"] = symbols.String .. ' ',
  ["table-name"] = symbols.Array .. ' ',
  ["date-name"] = symbols.Time .. ' ',
  ["date-time-name"] = symbols.Time .. ' ',
  ["float-name"] = symbols.Number .. ' ',
  ["inline-table-name"] = symbols.Array .. ' ',
  ["integer-name"] = symbols.Number .. ' ',
  ["time-name"] = symbols.Time .. ' '
}

require("nvim-gps").setup({
  icons = {
    ["class-name"] = symbols.Class .. ' ',
    ["function-name"] = symbols.Method .. ' ',
    ["method-name"] = symbols.Method .. ' ',
    ["tag-name"] = symbols.Tag .. ' ',
    ["container-name"] = symbols.Object .. ' ',

  },
  languages = {
    ["json"] = { icons = icons_for_match_groups },
    ["toml"] = { icons = icons_for_match_groups }
  },
  separator = ' > ',
})
