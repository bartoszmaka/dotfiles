return {
  'bartoszmaka/nvim-gps',
  dependencies = 'nvim-treesitter/nvim-treesitter',
  config = function()
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
      ["time-name"] = symbols.Time .. ' ',
      ["mapping-name"] = symbols.Object .. ' ',
      ["sequence-name"] = symbols.Array .. ' ',
      ["title-name"] = symbols.Class .. ' ',
      ["label-name"] = symbols.Object .. ' ',
      ["hook-name"] = symbols.Method .. ' ',
      ["scss-name"] = symbols.Tag .. ' ',
      ["scss-mixin-name"] = "@mixin ",
      ["scss-include-name"] = "@include ",
      ["scss-keyframes-name"] = "@keyframes ",
    }
    require("nvim-gps").setup({
      icons = icons_for_match_groups,
      languages = {
        ["javascript"] = { icons = icons_for_match_groups },
        ["json"] = { icons = icons_for_match_groups },
        ["toml"] = { icons = icons_for_match_groups },
        ["latex"] = { icons = icons_for_match_groups },
        ["norg"] = { icons = icons_for_match_groups },
        ["verilog"] = { icons = icons_for_match_groups },
        ["tsx"] = { icons = icons_for_match_groups },
        ["scss"] = { icons = icons_for_match_groups },
        ["yang"] = { icons = icons_for_match_groups },
      },
      separator = ' > ',
    })
  end
}
