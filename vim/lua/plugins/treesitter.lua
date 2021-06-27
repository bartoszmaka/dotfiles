require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = { enable = true },
  indent = { enable = true },
  rainbow = { enable = true },
  autopairs = { enable = true },
  autotag = { enable = true },
  matchup = { enable = true }
}
-- require'treesitter-context.config'.setup{
--   enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
-- }

vim.g.matchup_matchparen_offscreen           = {method = 'popup'}
vim.g.matchup_matchparen_deferred            = 1
vim.g.matchup_matchparen_hi_surround_always  = 0
vim.g.matchup_matchparen_timeout             = 350
vim.g.matchup_matchparen_insert_timeout      = 150
vim.g.matchup_matchparen_deferred_show_delay = 120
vim.g.matchup_matchparen_deferred_hide_delay = 500
vim.g.matchup_matchparen_stopline            = 40
vim.g.matchup_motion_override_Npercent       = 0

vim.cmd [[
  augroup matchup_config
    autocmd!
  
    highlight! MatchParen       guifg=NONE    guibg=NONE gui=bold,underline
    highlight! MatchParenCur    guifg=NONE    guibg=NONE gui=bold,underline
  augroup END
]]

-- local ts_conds = require('nvim-autopairs.ts-conds')


-- npairs.add_rules({
--   Rule("%", "%", "lua")
--     :with_pair(ts_conds.is_ts_node({'string','comment'})),
--   Rule("$", "$", "lua")
--     :with_pair(ts_conds.is_not_ts_node({'function'}))
-- })


-- local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
-- parser_config.embedded_template = {
--   install_info = {
--     url = 'https://github.com/tree-sitter/tree-sitter-embedded-template',
--     files =  { 'src/parser.c' },
--     requires_generate_from_grammar  = true,
--   },
--   used_by = {'eelixir', 'eex', 'leex', 'eruby', 'erb'}
-- }
