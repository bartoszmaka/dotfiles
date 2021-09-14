local packer = require('packer')
local use = packer.use

use { 'wbthomason/packer.nvim' }

-- Complete and LSP
use { 'neovim/nvim-lspconfig' }
use { 'kabouzeid/nvim-lspinstall' }

use { 'onsails/lspkind-nvim', config = function() require('lsp/lspkind') end }
use { 'glepnir/lspsaga.nvim', config = function() require('lsp.lspsaga') end }
use { 'RishabhRD/nvim-lsputils', requires = 'RishabhRD/popfix'}

use { 'tsuyoshicho/vim-efm-langserver-settings' }
use { 'tpope/vim-projectionist', config = function() require('plugins.projectionist') end }
use {
  "hrsh7th/nvim-cmp",
  requires = {
    "quangnguyen30192/cmp-nvim-ultisnips",
    "hrsh7th/cmp-nvim-lsp",
    "f3fora/cmp-spell",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer"
  }
}
use { 'andersevenrud/compe-tmux', branch = 'cmp' }
use {'tzachar/cmp-tabnine', run='./install.sh', requires = 'hrsh7th/nvim-cmp'}
use { 'SirVer/ultisnips', config = function() require('plugins.ultisnips') end }
use { 'kamykn/spelunker.vim', config = function() require('plugins.spelunker') end }
use { 'ludovicchabant/vim-gutentags', config = function() require('plugins.gutentags') end }

-- UI
use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' }, config = function() require('plugins.gitsigns') end }
use { 'APZelos/blamer.nvim', config = function() require('plugins.blamer') end } -- remove once gitsigns has more configurable blame
use { 'navarasu/onedark.nvim' }
use { 'romgrk/barbar.nvim', config = function() require('plugins.tabline') end }
use {
  'glepnir/galaxyline.nvim',
  branch = 'main',
  requires = {'kyazdani42/nvim-web-devicons', opt = true},
  config = function() require('plugins.galaxyline') end
}

-- UI
use { 'lukas-reineke/indent-blankline.nvim', config = function() require('plugins.indentline') end }
use { 'norcalli/nvim-colorizer.lua', config = function() require('colorizer').setup() end }

-- syntax highlight
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
use {'rhysd/conflict-marker.vim', config = function() require('plugins.conflict-marker') end }

-- features
use { 'tpope/vim-repeat' , config = function() require('plugins.repeat') end }

use {
  'kyazdani42/nvim-tree.lua',
  requires = { 'kyazdani42/nvim-web-devicons' },
  config = function()
    require('plugins.nvim-tree')
  end,
}
use {'simnalamburt/vim-mundo', config = function() require('plugins.mundo.lua') end }
use { 'liuchengxu/vista.vim', config = function() require('plugins.vista') end }

use {'junegunn/fzf', dir = '~/.fzf', run = './install --all' , config = function() require('plugins.fzf') end }
use {'junegunn/fzf.vim'}
use { 'bartoszmaka/fzf-mru.vim' }

use { 'dominikduda/vim_yank_with_context' }
use { 'RRethy/vim-illuminate', config = function() require('plugins.illuminate') end }
use { 'mg979/vim-visual-multi', config = function() require('plugins.visual-multi') end }
use { 'tpope/vim-commentary', config = function() require('plugins.commentary') end }
use { 'windwp/nvim-autopairs' }
use { 'osyo-manga/vim-anzu', config = function() require('plugins.anzu') end }
use { 'roxma/vim-tmux-clipboard' }
use { 'christoomey/vim-tmux-navigator', config = function() require('plugins.tmux-navigator') end }
use { 'janko/vim-test', requires = { 'preservim/vimux' }, config = function() require('plugins.vim-test') end }
use { 'windwp/nvim-ts-autotag' }
use { 'tpope/vim-surround' }
use { 'rhysd/clever-f.vim' }
use { 'AndrewRadev/splitjoin.vim', config = function() require('plugins.splitjoin') end }

use { 'tpope/vim-abolish' }
use { 'tpope/vim-fugitive', config = function() require('plugins.fugitive') end }
use { 'dyng/ctrlsf.vim', config = function() require('plugins.ctrlsf') end }

use { 'lmeijvogel/vim-yaml-helper', ft = { 'yaml', 'yml' } }
use { 'mogelbrod/vim-jsonpath' }
use { 'simeji/winresizer', config = function() require('plugins.winresizer') end }

use {'szw/vim-maximizer', config = function() require('plugins.maximizer') end }

use { 'dstein64/nvim-scrollview', config = function() require('plugins.scrollview') end }
use { 'eugen0329/vim-esearch', config = function() require('plugins.esearch') end }
use { 'easymotion/vim-easymotion', config = function() require('plugins.easymotion') end }
use { 'hkupty/iron.nvim', config = function() require('plugins.iron') end } -- repl
use { 'gennaro-tedesco/nvim-peekup' }

require('lsp')
require('plugins.autopairs')
require('plugins.completion')
require('plugins.colorscheme')

vim.cmd [[autocmd BufWritePost init.lua PackerCompile]]
