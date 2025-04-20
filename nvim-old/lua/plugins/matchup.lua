return {
  'andymass/vim-matchup',
  config = function()
    -- vim.g.matchup_matchparen_offscreen           = { method = 'popup', highlight = "MatchupPopupWindow"}
    vim.g.matchup_matchparen_offscreen           = { method = 'popup' }
    vim.g.matchup_matchparen_deferred            = 1
    vim.g.matchup_matchparen_hi_surround_always  = 0
    vim.g.matchup_matchparen_timeout             = 350
    vim.g.matchup_matchparen_insert_timeout      = 150
    vim.g.matchup_matchparen_deferred_show_delay = 120
    vim.g.matchup_matchparen_deferred_hide_delay = 500

    vim.cmd [[
      nnoremap <leader>mm :MatchupWhereAmI!!<CR>

      augroup matchup_overrides
        autocmd!
        highlight! MatchParen         guifg=NONE    guibg=NONE gui=bold,underline
        highlight! MatchParenCur      guifg=NONE    guibg=NONE gui=bold,underline
        " highlight! MatchupPopupWindow guibg=#141b24
      augroup END
    ]]
  end,
}
