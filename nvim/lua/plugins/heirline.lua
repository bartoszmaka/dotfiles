return {
  {
    "rebelot/heirline.nvim",
    event = "UiEnter",
    dependencies = {
      "navarasu/onedark.nvim",
    },
    config = function(_, opts)
      local components = require("helper.heirline_components")

      vim.opt.laststatus = 3

      require("heirline").setup(vim.tbl_deep_extend("force", opts or {}, {
        statusline = components.statusline,
        tabline = nil,
        statuscolumn = nil,
      }))
    end,
  },
}
