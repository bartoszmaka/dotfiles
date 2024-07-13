return {
  "luukvbaal/statuscol.nvim",
  opts = function()
    local builtin = require("statuscol.builtin")
    local symbols = require('helper.symbols')

    return {
      ft_ignore = { "neo-tree", "neotree", "sagaoutline" },
      bt_ignore = { "neo-tree", "neotree", "sagaoutline" },
      segments = {
        {
          text = { builtin.foldfunc },
        },
        {
          sign = { namespace = { "diagnostic/signs" }, maxwidth = 1, colwidth = 2 },
          click = "v:lua.ScSa"
        },
        {
          text = { builtin.lnumfunc },
          condition = { true, builtin.not_empty },
        },
        { text = { " " } },
        {
          sign = {
            namespace = { "gitsigns" },
            fillchar = symbols.git_bar,
            maxwidth = 1,
            colwidth = 1,
            wrap = true,
          },
        },
        { text = { " " } },
      },
    }
  end,
  config = function(_, opts)
    require("statuscol").setup(opts)
  end,
}
