require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = { enable = true },
  indent = { enable = true },
  rainbow = { enable = true },
  autopairs = { enable = true },
  autotag = { enable = true }
}

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
