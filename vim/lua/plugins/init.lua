return {
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'neovim/nvim-lspconfig' },
  { 'glepnir/lspsaga.nvim',              config = function() require('lsp.plugins.lspsaga') end },
  { 'nvim-lua/lsp-status.nvim' },
  { 'jose-elias-alvarez/typescript.nvim' },
  { 'b0o/schemastore.nvim' }, -- schemas for jsonls (common rc files)
  { 'folke/trouble.nvim',                config = function() require('lsp.plugins.trouble') end },
  { 'j-hui/fidget.nvim',                 config = function() require('lsp.plugins.fidget') end },

  -- lsp/code integration
  { 'onsails/lspkind-nvim',              config = function() require('lsp.plugins.lspkind') end }, -- lsp and completion icons
  { 'RishabhRD/nvim-lsputils',           dependencies = { 'RishabhRD/popfix' } },                  -- lsp integration utils (better go to def etc)
  { 'ray-x/lsp_signature.nvim' },                                                                  -- display arguments names while typing
  {
    'jose-elias-alvarez/null-ls.nvim',                                                             -- null ls
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function() require('lsp.plugins.null-ls') end,
  },

  -- syntax
  { 'jparise/vim-graphql' },

  -- utils
  { 'rhysd/clever-f.vim' },                -- better 'f'
  { 'tpope/vim-abolish' },                 -- swap case
  { 'windwp/nvim-autopairs' },             -- automatically add matching parentheses
  { 'windwp/nvim-ts-autotag' },            -- automatically add matching tags
  { 'tpope/vim-surround' },                -- surround motion
  { 'simonefranza/nvim-conv' },            -- convert units
  { 'dominikduda/vim_yank_with_context' }, -- yank with file name and line numbers
  { 'lmeijvogel/vim-yaml-helper',       ft = { 'yaml', 'yml' } },
  { 'mogelbrod/vim-jsonpath' },
  { 'godlygeek/tabular',                config = function() require('plugins_config.tabular') end }, -- align text
  -- UI
  {
    'bartoszmaka/nvim-gps',
    config = function() require('plugins_config.gps') end,
    dependencies = 'nvim-treesitter/nvim-treesitter'
  },
  { 'SmiteshP/nvim-navic',              config = function() require('plugins_config.navic') end, },
  { 'ldelossa/gh.nvim' },
  {
    'nvim-telescope/telescope.nvim',
    version = '0.1.0',
    config = function()
      require('plugins_config.telescope')
    end
  },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  { 'fhill2/telescope-ultisnips.nvim' },
}
