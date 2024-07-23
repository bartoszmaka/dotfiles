-- TODO:
-- HACK:
-- FIX:
-- PASSED:
return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    keywords = {
      FIX =  { icon = " ", color = "default", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, },
      TODO = { icon = " ", color = "default" },
      HACK = { icon = " ", color = "default" },
      WARN = { icon = " ", color = "default", alt = { "WARNING", "XXX" } },
      PERF = { icon = " ", color = "default", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      NOTE = { icon = " ", color = "default", alt = { "INFO" } },
      TEST = { icon = "⏲ ", color = "default", alt = { "TESTING", "PASSED", "FAILED" } },
    },
    colors = {
      comment = { "Comment" },
      default = { "Comment", "#7C3AED" },
    },
  }
}
