require('lazy').setup({
  -- { 'ludovicchabant/vim-gutentags', config = function() require('plugins.gutentags') end }, -- tags generator
  { 'tweekmonster/startuptime.vim' },
  { 'nathom/filetype.nvim',              config = function() require('plugins.filetype') end },
  { 'lewis6991/impatient.nvim' },

  -- lsp installation
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
  { 'tpope/vim-projectionist', config = function() require('plugins.projectionist') end }, -- project navigation (implementation to test etc)
  { 'bartoszmaka/vim-rails',   config = function() require('plugins.rails') end,        branch = 'dev' },

  -- completion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'quangnguyen30192/cmp-nvim-ultisnips',
      'hrsh7th/cmp-nvim-lsp',
      'f3fora/cmp-spell',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-omni',
      'lukas-reineke/cmp-rg',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lsp-signature-help',
    }
  },
  { 'SirVer/ultisnips',          config = function() require('plugins.ultisnips') end },
  { 'mattn/emmet-vim',
    ft = { 'eruby', 'svelte', 'html', 'elixir', 'javascript' },
    config = function() require('plugins.emmet') end
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
    config = function() require('plugins.treesitter') end
  },
  { 'm-demare/hlargs.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function() require('plugins.hlargs') end
  },
  { 'jparise/vim-graphql' },
  { 'rhysd/conflict-marker.vim', config = function() require('plugins.conflict-marker') end },

  -- utils
  { 'tpope/vim-fugitive',        config = function() require('plugins.fugitive') end }, -- git integration
  { 'tpope/vim-repeat',          config = function() require('plugins.repeat') end }, -- better '.'
  { 'rhysd/clever-f.vim' }, -- better 'f'
  { 'AndrewRadev/splitjoin.vim', config = function() require('plugins.splitjoin') end }, -- split and join mutiline
  { 'tpope/vim-abolish' }, -- swap case
  { 'andymass/vim-matchup',      config = function() require('plugins.matchup') end }, -- jump to matching anything
  { 'Valloric/MatchTagAlways',   config = function() require('plugins.match_tag_always') end }, -- jump to matching tag
  { 'windwp/nvim-autopairs' }, -- automatically add matching parentheses
  { 'windwp/nvim-ts-autotag' }, -- automatically add matching tags
  { 'tpope/vim-surround' }, -- surround motion
  { 'simonefranza/nvim-conv' }, -- convert units
  { 'junegunn/fzf', -- project fuzzy searcher
    dir = '~/.fzf',
    build = './install -- all',
    config = function()
      require('plugins.fzf')
    end,
  },
  { 'junegunn/fzf.vim' },
  { 'bartoszmaka/fzf-mru.vim' },
  { 'ibhagwan/fzf-lua',
    dependencies = {
      'vijaymarupudi/nvim-fzf',
      'kyazdani42/nvim-web-devicons'
    },
    build = './install -- bin'
  },
  { 'dominikduda/vim_yank_with_context' }, -- yank with file name and line numbers
  { 'phaazon/hop.nvim',                 config = function() require('plugins.hop') end,         branch = 'v1', },
  { 'mg979/vim-visual-multi',           config = function() require('plugins.visual-multi') end }, -- multiple cursors
  { 'tpope/vim-commentary',             config = function() require('plugins.commentary') end }, -- commenting
  { 'janko/vim-test',                   config = function() require('plugins.vim-test') end }, -- run tests
  { 'christoomey/vim-tmux-navigator',
    config = function() require('plugins.tmux-navigator') end,
    dependencies = {
      'roxma/vim-tmux-clipboard',
      'preservim/vimux'
    }
  },
  { 'lmeijvogel/vim-yaml-helper', ft = { 'yaml', 'yml' } },
  { 'mogelbrod/vim-jsonpath' },
  { 'andrewradev/switch.vim',     config = function() require('plugins.switch') end },
  { 'godlygeek/tabular',          config = function() require('plugins.tabular') end }, -- align text
  { 'AndrewRadev/sideways.vim',   config = function() require('plugins.sideways') end }, -- move fn arguments

  -- additional windows
  { 'dyng/ctrlsf.vim',            config = function() require('plugins.ctrlsf') end }, -- project wide search
  { 'kyazdani42/nvim-tree.lua', -- project tree
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require('plugins.nvim-tree')
    end,
  },
  { 'simnalamburt/vim-mundo', config = function() require('plugins.mundo') end }, -- undo tree
  { 'liuchengxu/vista.vim',   config = function() require('plugins.vista') end }, -- symbols listing
  { 'voldikss/vim-floaterm',  config = function() require('plugins.floaterm') end }, -- terminal window


  -- UI
  { 'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('plugins.gitsigns')
    end,
  },
  { 'navarasu/onedark.nvim', config = function() require('plugins.onedark') end }, -- colorscheme
  { 'romgrk/barbar.nvim',    config = function() require('plugins.tabline') end }, -- tabs line
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = function() require('plugins.lualine') end
  },
  {
    'SmiteshP/nvim-gps',
    config = function() require('plugins.gps') end,
    dependencies = 'nvim-treesitter/nvim-treesitter'
  },
  { 'lukas-reineke/indent-blankline.nvim', config = function() require('plugins.indentline') end },
  { 'norcalli/nvim-colorizer.lua',         config = function() require('colorizer').setup() end },
  { 'RRethy/vim-illuminate',               config = function() require('plugins.illuminate') end },
  { 'rcarriga/nvim-notify',                config = function() require('plugins.nvim-notify') end }, -- notifications windows
  { 'simeji/winresizer',                   config = function() require('plugins.winresizer') end }, -- resize windows
  { 'szw/vim-maximizer',                   config = function() require('plugins.maximizer') end }, -- maximize window
  { 'petertriho/nvim-scrollbar',           config = function() require('plugins.scrollbar') end }, -- scrollbar
  { 'vim-scripts/LargeFile' }, -- large files helper
  { 'kevinhwang91/nvim-hlslens',           config = function() require('plugins.hlslens') end }, -- better highlight search
  { 'ldelossa/gh.nvim' },
  { 'nvim-telescope/telescope.nvim', version = '0.1.0', config = function()
    require('plugins.telescope')
  end },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  { 'fhill2/telescope-ultisnips.nvim' },
  { 'skywind3000/vim-quickui' },
  { 'inkarkat/vim-AdvancedSorters' },

})

local loadedLsp, _ = pcall(require, 'lsp')
local loadedAutopairs, _ = pcall(require, 'plugins.autopairs')
local loadedCompletion, _ = pcall(require, 'plugins.completion')

if not loadedLsp then print('Error in lsp config') end
if not loadedAutopairs then print('Error in autoparis config') end
if not loadedCompletion then print('Error in completion config') end
