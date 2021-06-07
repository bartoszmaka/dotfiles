local execute = vim.api.nvim_command
local fn = vim.fn

-- install packer if not installed
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local is_packer_installed = fn.empty(fn.glob(install_path)) > 0
if is_packer_installed then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

require('packer').startup(function(use)
  use { 'wbthomason/packer.nvim' }

  use { 'neovim/nvim-lspconfig' }
  use { 'kabouzeid/nvim-lspinstall' }
  use { 'SirVer/ultisnips', config = function()
    vim.g.UltiSnipsExpandTrigger="<NOP>"
    vim.g.UltiSnipsJumpForwardTrigger="<NOP>"
    vim.g.UltiSnipsJumpBackwardTrigger="<NOP>"
  end}
  use { 'onsails/lspkind-nvim' }
  use { 'tpope/vim-projectionist' }
  use { 'hrsh7th/nvim-compe' }
  -- use { 'nvim-lua/completion-nvim' }
  -- use { 'steelsojka/completion-buffers'}

  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
  }
  use { 'APZelos/blamer.nvim' } -- remove once gitsigns has more configurable blame
  use { 'navarasu/onedark.nvim' }
  use { 'romgrk/barbar.nvim' }
  use {
    'glepnir/galaxyline.nvim',
    branch = 'main',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
  }
  use { 'norcalli/nvim-colorizer.lua', config = function() require('colorizer').setup() end }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  }
  use {
    'p00f/nvim-ts-rainbow',
    requires = { 'nvim-treesitter/nvim-treesitter' }
  }
  use {
    "lukas-reineke/indent-blankline.nvim",
    branch = "lua",
  }
  use {'kyazdani42/nvim-tree.lua', requires = { 'kyazdani42/nvim-web-devicons' } }

  use {'junegunn/fzf', dir = '~/.fzf', run = './install --all' }
  use {'junegunn/fzf.vim'}
  use { 'bartoszmaka/fzf-mru.vim' }
  -- use {
  -- 	'nvim-telescope/telescope.nvim',
  -- 	requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  -- }
  -- use {
  -- 	'nvim-telescope/telescope-media-files.nvim',
  -- 	requires = {{'nvim-telescope/telescope.nvim'}, {'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  -- }
  use { 'dominikduda/vim_yank_with_context' }
  use { 'dominikduda/vim_current_word',
    config = function()
      local config_helper = require('config_helper')
      local let = config_helper.let
      local cmd = vim.cmd

      let('g', 'vim_current_word#enabled', 1)
      let('g', 'vim_current_word#highlight_only_in_focused_window', 1)
      let('g', 'vim_current_word#highlight_twins', 1)
      let('g', 'vim_current_word#highlight_current_word', 1)
      let('g', 'vim_current_word#highlight_delay', 400)
      cmd [[
      augroup vim_current_word
      autocmd!

      highlight! CurrentWordTwins guibg=#363636 gui=bold
      highlight! CurrentWord      guibg=#222200 gui=bold
      augroup END
      ]]
    end
  }
  use { 'mg979/vim-visual-multi' }
  use { 'tpope/vim-commentary',
    config = function()
      local config_helper = require('config_helper')
      local nmap = config_helper.nmap

      nmap('gj', 'yypkgccj')
    end
  }
  use { 'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end
  }
  use { 'alvan/vim-closetag' }
  use { 'tpope/vim-surround' }
  use { 'rhysd/clever-f.vim' }
  use { 'AndrewRadev/splitjoin.vim' }
  use { 'tpope/vim-endwise' }
  use { 'tpope/vim-abolish' }

end)

require('plugins.colorscheme')
require('plugins.treesitter')
require('plugins.gitsigns')
require('plugins.blamer')
require('plugins.indentline')
require('plugins.nvim-tree')
require('plugins.fzf')
-- require('plugins.telescope')
require('plugins.lsp')
require('plugins.completion')
require('plugins.tabline')
require('plugins.galaxyline')
require('plugins.projectionist')

vim.cmd [[autocmd BufWritePost init.lua PackerCompile]]
