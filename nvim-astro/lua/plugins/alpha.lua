return {
  'goolord/alpha-nvim',
  opts = function (_, opts)
    opts.section.buttons.val = {
      opts.button("n"            , "  New file"                        , [[:enew <CR>]])                                              ,
      opts.button("⌘ p"          , "󰕕  Fuzzy finder file"               , [[:FzfLua files<CR>]])                                       ,
      opts.button("⌃p ⌃r"        , "  Recently opened files"           , [[:FzfLua oldfiles<CR>]])                                    ,
      opts.button("⌘ ⇧ p"        , "  Fuzzy finder actions"            , [[:FzfLua<CR>]])                                             ,
      opts.button("⌘ ⇧ e"        , "  Open files tree"                 , [[:Neotree filesystem<CR>]])                                 ,
      opts.button("⌘ ⇧ f"        , "  Show finder"                     , [[:lua require("fzf-lua").live_grep()<CR>]])                 ,
      opts.button("⌘ ⇧ m"        , "  Show errors"                     , [[:lua require("fzf-lua").lsp_workspace_diagnostics()<CR>]]) ,
      opts.button("⌘ b"          , "  Toggle side panel"               , [[:Neotree close<CR>]])                                      ,
      opts.button("⌃ `"          , "  Show terminal"                   , [[:FloatermToggle<CR>]])                                     ,
      opts.button("SPC p g"      , "  Fuzzy browse git changes"        , [[:FzfLua git_status<CR>]])                                  ,
    }

    opts.opts.layout[1].val = 8
  end,
};
