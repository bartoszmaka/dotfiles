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
    vim.g.UltiSnipsExpandTrigger="<C-e>"
    vim.g.UltiSnipsJumpForwardTrigger="<C-e>"
    vim.g.UltiSnipsJumpBackwardTrigger="<C-b>"
  end}
  use { 'onsails/lspkind-nvim' }
  use { 'tpope/vim-projectionist' }
  use { 'hrsh7th/nvim-compe' }

  use { 'dense-analysis/ale' }
  use { "nathunsmitty/nvim-ale-diagnostic" }

  use { 'ludovicchabant/vim-gutentags' }

  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' }, }
  use { 'APZelos/blamer.nvim' } -- remove once gitsigns has more configurable blame
  use { 'navarasu/onedark.nvim' }
  use { 'romgrk/barbar.nvim' }
  use {
    'glepnir/galaxyline.nvim',
    branch = 'main',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
  }

  use { 'lukas-reineke/indent-blankline.nvim', branch = 'lua' }
  use { 'norcalli/nvim-colorizer.lua', config = function() require('colorizer').setup() end }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', }
  use { 'p00f/nvim-ts-rainbow', requires = { 'nvim-treesitter/nvim-treesitter' } }
  use { 'nvim-treesitter/playground', requires = { 'nvim-treesitter/nvim-treesitter' } }
  use { 'jparise/vim-graphql' }
  use {'rhysd/conflict-marker.vim' }

  use {'kyazdani42/nvim-tree.lua', requires = { 'kyazdani42/nvim-web-devicons' } }
  use {'simnalamburt/vim-mundo' }

  use {'junegunn/fzf', dir = '~/.fzf', run = './install --all' }
  use {'junegunn/fzf.vim'}
  use { 'bartoszmaka/fzf-mru.vim' }
  use { 'dominikduda/vim_yank_with_context' }
  use { 'dominikduda/vim_current_word', config = function() require('plugins.current-word') end }
  use { 'mg979/vim-visual-multi' }
  use { 'tpope/vim-commentary',
    config = function()
      local config_helper = require('config_helper')
      local nmap = config_helper.nmap

      nmap('gj', 'yypkgccj')
    end
  }
  use { 'windwp/nvim-autopairs', config = function() require('nvim-autopairs').setup() end }

  use { 'osyo-manga/vim-anzu' }

  use { 'roxma/vim-tmux-clipboard' }
  use { 'christoomey/vim-tmux-navigator', config = function()
    vim.cmd[[
      let g:tmux_navigator_no_mappings = 1
      nnoremap <silent><C-w>h :TmuxNavigateLeft<CR>
      nnoremap <silent><C-w>j :TmuxNavigateDown<CR>
      nnoremap <silent><C-w>k :TmuxNavigateUp<CR>
      nnoremap <silent><C-w>l :TmuxNavigateRight<CR>
    ]]
  end}

  use { 'janko/vim-test',
    requires = { 'preservim/vimux' },
    config = function() require('plugins.vim-test') end
  }
  use { 'alvan/vim-closetag' }
  use { 'tpope/vim-surround' }
  use { 'rhysd/clever-f.vim' }
  use { 'AndrewRadev/splitjoin.vim'}
  use { 'tpope/vim-endwise' }
  use { 'tpope/vim-abolish' }
  use { 'tpope/vim-fugitive', config = function() require('plugins.fugitive') end }
  use { 'dyng/ctrlsf.vim', config = function() require('plugins.ctrlsf') end }

  use { 'lmeijvogel/vim-yaml-helper', ft = { 'yaml', 'yml' } }
  use { 'mogelbrod/vim-jsonpath' }

end)

require('plugins.colorscheme')
require('plugins.treesitter')
require('plugins.gitsigns')
require('plugins.blamer')
require('plugins.indentline')
require('plugins.nvim-tree')
require('plugins.fzf')
require('plugins.lsp')
require('plugins.ale')
require('plugins.completion')
require('plugins.gutentags')
require('plugins.tabline')
require('plugins.galaxyline')
require('plugins.projectionist')
require('plugins.conflict-marker')

vim.cmd [[autocmd BufWritePost init.lua PackerCompile]]
vim.cmd [[command! CopyPath execute 'let @+ = expand("%")']]

vim.cmd[[
augroup remember_cursor_position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END
]]

vim.cmd[[
  let mapleader="\<Space>"
  let g:splitjoin_split_mapping     = ''
  let g:splitjoin_join_mapping      = ''
  let g:splitjoin_ruby_curly_braces = 0
  let g:splitjoin_ruby_hanging_args = 0
  nmap <C-m><C-d> :SplitjoinJoin<cr>
  nmap <C-m><C-s> :SplitjoinSplit<cr>
  nmap <leader>md :SplitjoinJoin<cr>
  nmap <leader>ms :SplitjoinSplit<cr>
]]
vim.cmd [[autocmd FileType javascript.jsx setlocal commentstring={/*\ %s\ */}]]

vim.cmd[[
let g:mundo_right = 1
nnoremap <C-k><C-u> :MundoToggle<CR>
]]

vim.cmd [[
let g:anzu_status_format = "%#Search#▶%p◀ (%i/%l)"
nmap n <Plug>(anzu-n-with-echo)zz<Plug>(anzu-echo-search-status)
nmap N <Plug>(anzu-N-with-echo)zz<Plug>(anzu-echo-search-status)
nmap * <Plug>(anzu-star-with-echo)zz<Plug>(anzu-echo-search-status)
nmap # <Plug>(anzu-sharp-with-echo)zz<Plug>(anzu-echo-search-status)
]]
