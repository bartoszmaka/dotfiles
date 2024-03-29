return {
  {
    "ggandor/flit.nvim",
    keys = function()
      local ret = {}
      for _, key in ipairs({ "f", "F", "t", "T" }) do
        ret[#ret + 1] = { key, mode = { "n", "x", "o" }, desc = key }
      end
      return ret
    end,
    opts = { labeled_modes = "nx" },
  },
  {
    "ggandor/leap.nvim",
    keys = {
      -- { "<leader>s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
      -- { "<leader>S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
      -- { "<leader>gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
    },
    config = function(_, opts)
      local leap = require("leap")
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      leap.add_default_mappings(false)
      vim.keymap.del({ "x", "o" }, "x")
      vim.keymap.del({ "x", "o" }, "X")


      vim.cmd [[
        highlight! link LeapLabelPrimary IncSearch
        highlight! link LeapLabelSecondary IncSearch
        " highlight! link LeapMatch IncSearch
      ]]
    end,
  },
}
