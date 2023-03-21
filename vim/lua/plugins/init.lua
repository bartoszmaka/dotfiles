return {
  -- { 'ludovicchabant/vim-gutentags', config = function() require('plugins_config.gutentags') end }, -- tags generator
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
  { 'RishabhRD/nvim-lsputils',           dependencies = { 'RishabhRD/popfix' } }, -- lsp integration utils (better go to def etc)
  { 'ray-x/lsp_signature.nvim' }, -- display arguments names while typing
  { 'jose-elias-alvarez/null-ls.nvim', -- null ls
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function() require('lsp.plugins.null-ls') end,
  },

  -- syntax
  { 'nvim-treesitter/nvim-treesitter', -- syntax highlighting
    dependencies = {
      { 'nvim-treesitter/playground' },
      { 'p00f/nvim-ts-rainbow' },
      { 'nvim-treesitter/nvim-treesitter-textobjects' },
      { 'JoosepAlviste/nvim-ts-context-commentstring' },
      { 'nvim-treesitter/nvim-treesitter-context' },
    },
    build = ':TSUpdate',
    config = function() require('plugins_config.treesitter') end
  },
  { 'm-demare/hlargs.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function() require('plugins_config.hlargs') end
  },
  { 'jparise/vim-graphql' },
  -- { 'rhysd/conflict-marker.vim', config = function() require('plugins_config.conflict-marker') end },

  -- utils
  { 'rhysd/clever-f.vim' }, -- better 'f'
  { 'tpope/vim-abolish' }, -- swap case
  { 'windwp/nvim-autopairs' }, -- automatically add matching parentheses
  { 'windwp/nvim-ts-autotag' }, -- automatically add matching tags
  { 'tpope/vim-surround' }, -- surround motion
  { 'simonefranza/nvim-conv' }, -- convert units
  { 'dominikduda/vim_yank_with_context' }, -- yank with file name and line numbers
  { 'lmeijvogel/vim-yaml-helper',       ft = { 'yaml', 'yml' } },
  { 'mogelbrod/vim-jsonpath' },
  { 'godlygeek/tabular',                config = function() require('plugins_config.tabular') end }, -- align text
  -- UI
  {
    'SmiteshP/nvim-gps',
    config = function() require('plugins_config.gps') end,
    dependencies = 'nvim-treesitter/nvim-treesitter'
  },
  { 'vim-scripts/LargeFile' }, -- large files helper
  { 'ldelossa/gh.nvim' },
  { 'nvim-telescope/telescope.nvim', version = '0.1.0', config = function()
    require('plugins_config.telescope')
  end },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  { 'fhill2/telescope-ultisnips.nvim' },
  { 'skywind3000/vim-quickui' },
  { 'inkarkat/vim-AdvancedSorters' },
  {
    "windwp/nvim-spectre",
    -- stylua: ignore
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    },
  },
}
