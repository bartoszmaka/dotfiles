vim.g.matchup_matchparen_offscreen           = {method = 'popup'}
vim.g.matchup_matchparen_deferred            = 1
vim.g.matchup_matchparen_hi_surround_always  = 0
vim.g.matchup_matchparen_timeout             = 350
vim.g.matchup_matchparen_insert_timeout      = 150
vim.g.matchup_matchparen_deferred_show_delay = 120
vim.g.matchup_matchparen_deferred_hide_delay = 500
-- vim.g.matchup_matchparen_stopline            = 40

-- vim.g.loaded_matchit = 1
-- vim.g.matchup_motion_override_Npercent       = 0

-- vim.cmd [[
-- augroup reparse_treesitter
--   autocmd!
--   autocmd BufReadPost,FileReadPost *.lua echomsg('aaa')
-- augroup END
-- ]]

vim.cmd [[
augroup matchup_config
autocmd!
  highlight! MatchParen        guifg=NONE    guibg=NONE gui=bold,underline
  highlight! MatchParenCur     guifg=NONE    guibg=NONE gui=bold,underline
augroup END

nnoremap <C-k><C-k> :MatchupWhereAmI!!<CR>
]]
