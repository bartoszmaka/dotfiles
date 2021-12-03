local packer = require('packer')
local use = packer.use

use { 'wbthomason/packer.nvim' }
use { 'neovim/nvim-lspconfig' }
use { 'williamboman/nvim-lsp-installer' }
use { 'onsails/lspkind-nvim', config = function() require('lsp/lspkind') end }
use { 'tsuyoshicho/vim-efm-langserver-settings' }
use { 'tpope/vim-projectionist', config = function() require('plugins.projectionist') end }
use {
  "hrsh7th/nvim-cmp",
  requires = {
    "quangnguyen30192/cmp-nvim-ultisnips",
    "hrsh7th/cmp-nvim-lsp",
    "f3fora/cmp-spell",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-omni",
    "hrsh7th/cmp-nvim-lsp-document-symbol",
    "lukas-reineke/cmp-rg",
  }
}
use { 'tzachar/cmp-tabnine', run='./install.sh', requires = 'hrsh7th/nvim-cmp' }
use { 'ray-x/lsp_signature.nvim' }
use { 'SirVer/ultisnips', config = function() require('plugins.ultisnips') end }
use { 'kamykn/spelunker.vim', config = function() require('plugins.spelunker') end }
use { 'ludovicchabant/vim-gutentags', config = function() require('plugins.gutentags') end }
use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' }, config = function() require('plugins.gitsigns') end }
use { 'APZelos/blamer.nvim', config = function() require('plugins.blamer') end } -- remove once gitsigns has more configurable blame
use { 'navarasu/onedark.nvim' }
use { 'romgrk/barbar.nvim', config = function() require('plugins.tabline') end }
use {
  'glepnir/galaxyline.nvim',
  branch = 'main',
  requires = { 'kyazdani42/nvim-web-devicons', opt = true},
  config = function() require('plugins.galaxyline') end
}
use { 'lukas-reineke/indent-blankline.nvim', config = function() require('plugins.indentline') end }
use { 'norcalli/nvim-colorizer.lua', config = function() require('colorizer').setup() end }
use {
  'nvim-treesitter/nvim-treesitter',
  requires = {
    { 'nvim-treesitter/playground' },
    { 'p00f/nvim-ts-rainbow' },
    { 'nvim-treesitter/nvim-treesitter-textobjects' },
    { 'JoosepAlviste/nvim-ts-context-commentstring' },
    { 'romgrk/nvim-treesitter-context' },
  },
  run = ':TSUpdate',
  config = function()
    require('plugins.treesitter')
  end
}
use {
  "SmiteshP/nvim-gps",
  requires = "nvim-treesitter/nvim-treesitter",
  config = function() require('plugins.gps') end
}
use { 'andymass/vim-matchup' }
use { 'jparise/vim-graphql' }
use { 'rhysd/conflict-marker.vim', config = function() require('plugins.conflict-marker') end }
use { 'tpope/vim-repeat' , config = function() require('plugins.repeat') end }
use {
  'kyazdani42/nvim-tree.lua',
  requires = { 'kyazdani42/nvim-web-devicons' },
  config = function()
    require('plugins.nvim-tree')
  end,
}
use { 'simnalamburt/vim-mundo', config = function() require('plugins.mundo') end }
use { 'liuchengxu/vista.vim', config = function() require('plugins.vista') end }
use { 'junegunn/fzf', dir = '~/.fzf', run = './install --all' , config = function() require('plugins.fzf') end }
use { 'junegunn/fzf.vim'}
use { 'bartoszmaka/fzf-mru.vim' }
use { 'ibhagwan/fzf-lua',
  requires = {
    'vijaymarupudi/nvim-fzf',
    'kyazdani42/nvim-web-devicons'
  },
  run = './install --bin'
}
use { 'dominikduda/vim_yank_with_context' }
use { 'RRethy/vim-illuminate', config = function() require('plugins.illuminate') end }
use { 'mg979/vim-visual-multi', config = function() require('plugins.visual-multi') end }
use { 'tpope/vim-commentary', config = function() require('plugins.commentary') end }
use { 'windwp/nvim-autopairs' }
use { 'osyo-manga/vim-anzu', config = function() require('plugins.anzu') end }
use { 'knubie/vim-kitty-navigator',
  run = 'cp ./*.py ~/.config/kitty/',
  -- cond = function() return vim.fn.exists('$KITTY_WINDOW_ID') == 1 end,
  config = function() require('plugins.kitty-navigator') end }
use { 'christoomey/vim-tmux-navigator',
  -- cond = function() return vim.fn.exists('$TMUX') == 1 end,
  config = function()
    require('plugins.tmux-navigator')
  end,
  requires = {
    'roxma/vim-tmux-clipboard',
    'preservim/vimux'
  }
}
use { 'janko/vim-test', config = function() require('plugins.vim-test') end }
use { 'windwp/nvim-ts-autotag' }
use { 'tpope/vim-surround' }
use { 'rhysd/clever-f.vim' }
use { 'AndrewRadev/splitjoin.vim', config = function() require('plugins.splitjoin') end }
use { 'tpope/vim-abolish' }
use { 'tpope/vim-fugitive', config = function() require('plugins.fugitive') end }
use { 'junkblocker/git-time-lapse' }
use { 'dyng/ctrlsf.vim', config = function() require('plugins.ctrlsf') end }
use { 'lmeijvogel/vim-yaml-helper', ft = { 'yaml', 'yml' } }
use { 'mogelbrod/vim-jsonpath' }
use { 'simeji/winresizer', config = function() require('plugins.winresizer') end }
use { 'szw/vim-maximizer', config = function() require('plugins.maximizer') end }
use { 'dstein64/nvim-scrollview', config = function() require('plugins.scrollview') end }
-- use { 'eugen0329/vim-esearch', config = function() require('plugins.esearch') end }
-- use { 'easymotion/vim-easymotion', config = function() require('plugins.easymotion') end }
use {
  'phaazon/hop.nvim',
  branch = 'v1',
  config = function() require('plugins.hop') end,
}
use { 'nvim-lua/lsp-status.nvim' }
use { 'andrewradev/switch.vim', config = function() require('plugins.switch') end }
use { 'voldikss/vim-floaterm', config = function() require('plugins.floaterm') end }
use { 'simonefranza/nvim-conv' }
use { 'rcarriga/nvim-notify', config = function() require('plugins.nvim-notify') end }
use { 'kevinhwang91/nvim-bqf', ft = 'qf', config = function() require('plugins.bqf') end}
-- use { 'AckslD/nvim-neoclip.lua',
--   requires = {'tami5/sqlite.lua', module = 'sqlite'},
--   config = function() require('plugins.neoclip').setup() end,
-- }
use {
  'VonHeikemen/searchbox.nvim',
  requires = { { 'MunifTanjim/nui.nvim' } },
  config = function() require('plugins.searchbox') end,
}


require('lsp')
require('plugins.autopairs')
require('plugins.completion')
require('plugins.colorscheme')
-- require('plugins.vsnip')

vim.cmd [[autocmd BufWritePost init.lua PackerCompile]]
