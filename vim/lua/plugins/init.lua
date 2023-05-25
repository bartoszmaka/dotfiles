return {
  { 'folke/trouble.nvim',      config = function() require('lsp.plugins.trouble') end },
  { 'j-hui/fidget.nvim',       config = function() require('lsp.plugins.fidget') end },

  -- lsp/code integration
  { 'onsails/lspkind-nvim',    config = function() require('lsp.plugins.lspkind') end },           -- lsp and completion icons
  { 'RishabhRD/nvim-lsputils', dependencies = { 'RishabhRD/popfix' } },                            -- lsp integration utils (better go to def etc)
  {
    'jose-elias-alvarez/null-ls.nvim',                                                             -- null ls
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function() require('lsp.plugins.null-ls') end,
  },

  -- syntax
  { 'jparise/vim-graphql' },

  -- utils
  { 'tpope/vim-abolish' },                 -- swap case
  { 'windwp/nvim-autopairs' },             -- automatically add matching parentheses
  { 'windwp/nvim-ts-autotag' },            -- automatically add matching tags
  { 'tpope/vim-surround' },                -- surround motion
  { 'simonefranza/nvim-conv' },            -- convert units
  { 'dominikduda/vim_yank_with_context' }, -- yank with file name and line numbers
  -- { 'lmeijvogel/vim-yaml-helper', lazy = false },
  { 'mogelbrod/vim-jsonpath' },
  -- UI
  { 'ldelossa/gh.nvim' },
}
