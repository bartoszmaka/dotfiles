return {
  "luukvbaal/statuscol.nvim",
  opts = function()
    local builtin = require("statuscol.builtin")
    local symbols = require('helper.symbols')

    return {
      ft_ignore = { "neo-tree", "neotree", "sagaoutline", "help", "Mundo", "floaterm", "ctrlsf" },
      bt_ignore = { "neo-tree", "neotree", "sagaoutline", "help", "Mundo", "floaterm", "ctrlsf" },
      segments = {
        {
          text = { builtin.foldfunc },
        },
        {
          sign = { namespace = { "diagnostic/signs" }, name = { ".*" }, maxwidth = 1, colwidth = 2 },
          click = "v:lua.ScSa"
        },
        {
          sign = {
            namespace = { "gitsigns" },
            fillchar = ' ',
            maxwidth = 1,
            colwidth = 1,
            wrap = true,
          },
        },
        {
          text = { builtin.lnumfunc },
          condition = { true, builtin.not_empty },
        },
        { text = { " " } },
      },
    }
  end,
  config = function(_, opts)
    require("statuscol").setup(opts)
  end,
}
