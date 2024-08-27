local colors = require('helper.colors').onedark
-- AstroUI provides the basis for configuring the AstroNvim User Interface
-- Configuration documentation can be found with `:h astroui`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    colorscheme = "onedark",
    highlights = {
      init = { -- this table overrides highlights in all themes
        -- Normal = { bg = "#000000" },
      },
    },
    icons = require "helper.symbols",
    status = {
      colors = function(hl)
        local colors = require("helper.colors").onedark

        hl.tabline_bg = colors.bg0
        hl.tabline_fg = "#ffff00"
        hl.tab = "#00ff00"
        hl.tab = "#0000ff"
        return hl
      end,
    },
  },
}
