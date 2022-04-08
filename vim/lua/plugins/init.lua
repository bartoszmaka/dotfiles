local packer = require('packer')
local use = packer.use

use { 'wbthomason/packer.nvim' } -- plugin manager
use { 'nathom/filetype.nvim', config = function() require('plugins.filetype') end }
use { 'tweekmonster/startuptime.vim' }
use 'lewis6991/impatient.nvim'

-- lsp installation
use { 'neovim/nvim-lspconfig' }
use { 'williamboman/nvim-lsp-installer' }


-- lsp/code integration
use { 'onsails/lspkind-nvim', config = function() require('lsp.lspkind') end } -- lsp and completion icons
use { 'jose-elias-alvarez/nvim-lsp-ts-utils' }                                 -- typescript codeactions
use { 'RishabhRD/nvim-lsputils', requires = { 'RishabhRD/popfix' } }           -- lsp integration utils (better go to def etc)
use { 'ray-x/lsp_signature.nvim' }                                             -- display arguments names while typing
use { 'jose-elias-alvarez/null-ls.nvim',                                       -- null ls
  requires = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('lsp.null-ls')
  end,
}
use { 'tpope/vim-projectionist', config = function() require('plugins.projectionist') end }  -- project navigation (implementation to test etc)
use { 'ludovicchabant/vim-gutentags', config = function() require('plugins.gutentags') end } -- tags generator
use { 'bartoszmaka/vim-rails', branch = "dev",config = function() require('plugins.rails') end }
use {
  "narutoxy/dim.lua",
  requires = { "nvim-treesitter/nvim-treesitter", "neovim/nvim-lspconfig" },
  config = function() require('plugins.dim') end
}


-- completion
use {
  "hrsh7th/nvim-cmp",
  requires = {
    "hrsh7th/cmp-copilot",
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
use { 'github/copilot.vim' }
use { 'SirVer/ultisnips', config = function() require('plugins.ultisnips') end }
use { 'kamykn/spelunker.vim',                                                                -- spell checker
  requires = { { "kamykn/popup-menu.nvim" } },
  config = function() require('plugins.spelunker') end,
}


-- syntax
use { 'nvim-treesitter/nvim-treesitter', -- syntax highlighting
  requires = {
    { 'nvim-treesitter/playground' },
    { 'p00f/nvim-ts-rainbow' },
    { 'nvim-treesitter/nvim-treesitter-textobjects' },
    { 'JoosepAlviste/nvim-ts-context-commentstring' },
    { 'romgrk/nvim-treesitter-context' },
  },
  run = ':TSUpdate',
  config = function() require('plugins.treesitter') end
}
use { 'm-demare/hlargs.nvim',
  requires = { 'nvim-treesitter/nvim-treesitter' },
  config = function() require('plugins.hlargs') end
}
use { 'jparise/vim-graphql' }
use { 'rhysd/conflict-marker.vim', config = function() require('plugins.conflict-marker') end }


-- utils
use { 'tpope/vim-fugitive', config = function() require('plugins.fugitive') end }               -- git integration
use { 'APZelos/blamer.nvim', config = function() require('plugins.blamer') end }                -- remove once gitsigns has more configurable blame
use { 'tpope/vim-repeat', config = function() require('plugins.repeat') end }                   -- better "."
use { 'rhysd/clever-f.vim' }                                                                    -- better "f"
use { 'AndrewRadev/splitjoin.vim', config = function() require('plugins.splitjoin') end }       -- split and join mutiline
use { 'tpope/vim-abolish' }                                                                     -- swap case
use { 'andymass/vim-matchup', config = function() require('plugins.matchup') end }              -- jump to matching anything
use { 'Valloric/MatchTagAlways', config = function() require('plugins.match_tag_always') end } -- jump to matching tag
use { 'windwp/nvim-autopairs' }                                                                 -- automatically add matching parentheses
use { 'windwp/nvim-ts-autotag' }                                                                -- automatically add matching tags
use { 'tpope/vim-surround' }                                                                    -- surround motion
use { 'simonefranza/nvim-conv' }                                                                -- convert units
use { 'junegunn/fzf',                                                                           -- project fuzzy searcher
  dir = '~/.fzf',
  run = './install -- all',
  config = function()
    require('plugins.fzf')
  end,
}
use { 'junegunn/fzf.vim'}
use { 'bartoszmaka/fzf-mru.vim' }
use { 'ibhagwan/fzf-lua',
  requires = {
    'vijaymarupudi/nvim-fzf',
    'kyazdani42/nvim-web-devicons'
  },
  run = './install -- bin'
}
use { 'dominikduda/vim_yank_with_context' }                                                     -- yank with file name and line numbers
use { 'phaazon/hop.nvim',                                                                       -- better jumps
  branch = 'v1',
  config = function() require('plugins.hop') end,
}
use { 'mg979/vim-visual-multi', config = function() require('plugins.visual-multi') end }       -- multiple cursors
use { 'tpope/vim-commentary', config = function() require('plugins.commentary') end }           -- commenting
use { 'janko/vim-test', config = function() require('plugins.vim-test') end }                   -- run tests
use { 'knubie/vim-kitty-navigator',
  run = 'cp ./*.py ~/.config/kitty/',
  -- cond = function() return vim.fn.exists('$KITTY_WINDOW_ID') == 1 end,
  config = function() require('plugins.kitty-navigator') end
}
use { 'christoomey/vim-tmux-navigator',
  -- cond = function() return vim.fn.exists('$TMUX') == 1 end,
  config = function()
    require('plugins.tmux-navigator')
  end,
  requires = {
    'roxma/vim-tmux-clipboard',
    'preservim/vimux'
  } }
use { 'junkblocker/git-time-lapse', config = function() require('plugins.git-time-lapse') end }
use { 'lmeijvogel/vim-yaml-helper', ft = { 'yaml', 'yml' } }
use { 'mogelbrod/vim-jsonpath' }
use { 'andrewradev/switch.vim', config = function() require('plugins.switch') end }
use { 'godlygeek/tabular', config = function() require('plugins.tabular') end }                 -- align text
use { 'AndrewRadev/sideways.vim', config = function() require('plugins.sideways') end }         -- move fn arguments

                                                                                                -- additional windows
use { 'dyng/ctrlsf.vim', config = function() require('plugins.ctrlsf') end }                    -- project wide search
use { 'kyazdani42/nvim-tree.lua',                                                               -- project tree
  requires = { 'kyazdani42/nvim-web-devicons' },
  config = function()
    require('plugins.nvim-tree')
  end,
}
use { 'simnalamburt/vim-mundo', config = function() require('plugins.mundo') end }              -- undo tree
use { 'liuchengxu/vista.vim', config = function() require('plugins.vista') end }                -- symbols listing
use { 'voldikss/vim-floaterm', config = function() require('plugins.floaterm') end }            -- terminal window


-- UI
use { 'lewis6991/gitsigns.nvim',
  requires = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('plugins.gitsigns')
  end,
}
use { 'navarasu/onedark.nvim' }                                                                      -- colorscheme
use { 'romgrk/barbar.nvim', config = function() require('plugins.tabline') end }                     -- tabs line
use { 'glepnir/galaxyline.nvim',                                                                     -- status line
  branch = 'main',
  requires = { 'kyazdani42/nvim-web-devicons', opt = true},
  config = function() require('plugins.galaxyline') end
}

use { 'lukas-reineke/indent-blankline.nvim', config = function() require('plugins.indentline') end }
use { 'norcalli/nvim-colorizer.lua', config = function() require('colorizer').setup() end }
use { 'RRethy/vim-illuminate', config = function() require('plugins.illuminate') end }
use { 'rcarriga/nvim-notify', config = function() require('plugins.nvim-notify') end }               -- notifications windows
use { 'simeji/winresizer', config = function() require('plugins.winresizer') end }                   -- resize windows
use { 'szw/vim-maximizer', config = function() require('plugins.maximizer') end }                    -- maximize window
use { 'petertriho/nvim-scrollbar', config = function() require('plugins.scrollbar') end }            -- scrollbar
use { 'vim-scripts/LargeFile' }                                                                      -- large files helper
use { 'kevinhwang91/nvim-hlslens', config = function() require('plugins.hlslens') end }              -- better highlight search

pcall(require,'lsp')
pcall(require,'plugins.autopairs')
pcall(require,'plugins.completion')
pcall(require,'plugins.colorscheme')
-- require('plugins.colorscheme')

vim.cmd [[autocmd BufWritePost init.lua PackerCompile]]
