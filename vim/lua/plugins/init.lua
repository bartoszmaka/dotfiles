-- install packer if not installed
local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local is_packer_installed = fn.empty(fn.glob(install_path)) > 0
if is_packer_installed then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

local packer = require('packer')
local use = packer.use

use { 'wbthomason/packer.nvim' }

-- Complete and LSP
use { 'neovim/nvim-lspconfig' }
use { 'kabouzeid/nvim-lspinstall' }
use { 'onsails/lspkind-nvim' }
use { 'gfanto/fzf-lsp.nvim' }

use {'tsuyoshicho/vim-efm-langserver-settings'}
use { 'tpope/vim-projectionist', config = function() require('plugins.projectionist')end }
use { 'hrsh7th/nvim-compe' }
use { 'SirVer/ultisnips', config = function()
  vim.g.UltiSnipsExpandTrigger="<C-e>"
  vim.g.UltiSnipsJumpForwardTrigger="<C-e>"
  vim.g.UltiSnipsJumpBackwardTrigger="<C-b>"
end}
-- use { 'nvim-lua/lsp-status.nvim' }

-- Diagnostics
use { 'dense-analysis/ale', config = function() require('plugins.ale') end }
use { "nathunsmitty/nvim-ale-diagnostic" }
use { 'kamykn/spelunker.vim', config = function()
  vim.cmd[[
  highlight SpelunkerSpellBad gui=underline
  highlight SpelunkerComplexOrCompoundWord gui=underline
  map [s <NOP>
  map ]s <NOP>
  nnoremap <silent> [s :call spelunker#jump_prev()<CR>
  nnoremap <silent> ]s :call spelunker#jump_next()<CR>
  ]]
end}

-- ctags, since LSP are not perfect
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
use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = function() require('plugins.treesitter') end }
use { 'p00f/nvim-ts-rainbow', requires = { 'nvim-treesitter/nvim-treesitter' } }
use { 'nvim-treesitter/playground', requires = { 'nvim-treesitter/nvim-treesitter' } }
-- use { 'romgrk/nvim-treesitter-context' }
use { 'andymass/vim-matchup' }
use { 'jparise/vim-graphql' }
use {'rhysd/conflict-marker.vim', config = function() require('plugins.conflict-marker') end }

-- features
use { 'tpope/vim-repeat' , config = function()
  vim.cmd[[
  call repeat#set("\<plug>.", v:count)
  ]]
end}

use {
  'kyazdani42/nvim-tree.lua',
  requires = { 'kyazdani42/nvim-web-devicons' },
  config = function()
    require('plugins.nvim-tree')
  end,
}
use {'simnalamburt/vim-mundo', config = function()
  vim.cmd[[
  let g:mundo_right = 1
  nnoremap <C-k><C-u> :MundoToggle<CR>
  ]]
end}

use { 'liuchengxu/vista.vim', config = function() require('plugins.vista') end }

use {'junegunn/fzf', dir = '~/.fzf', run = './install --all' , config = function() require('plugins.fzf') end}
use {'junegunn/fzf.vim'}
use { 'bartoszmaka/fzf-mru.vim' }

use { 'dominikduda/vim_yank_with_context' }
-- use { 'dominikduda/vim_current_word', config = function() require('plugins.current-word') end }
use { 'RRethy/vim-illuminate', config = function()
  vim.g.Illuminate_delay = 400
  vim.cmd[[
  highlight! illuminatedWord guibg=#222200 gui=bold
  highlight! illuminatedCurWord guibg=#363636 gui=bold
  ]]
end}
use { 'mg979/vim-visual-multi', config = function() require('plugins.visual-multi') end }
use { 'tpope/vim-commentary',
  config = function()
    local nmap = require('config_helper').nmap

    nmap('gj', 'yypkgccj')
  end}
use { 'windwp/nvim-autopairs', config = function() require('nvim-autopairs').setup() end }

use { 'osyo-manga/vim-anzu', config = function()
  vim.cmd [[
  let g:anzu_status_format = "%#Search#▶%p◀ (%i/%l)"
  nmap n <Plug>(anzu-n-with-echo)zz<Plug>(anzu-echo-search-status)
  nmap N <Plug>(anzu-N-with-echo)zz<Plug>(anzu-echo-search-status)
  nmap * <Plug>(anzu-star-with-echo)zz<Plug>(anzu-echo-search-status)
  nmap # <Plug>(anzu-sharp-with-echo)zz<Plug>(anzu-echo-search-status)
  ]]
end}

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
-- use { 'alvan/vim-closetag' }
use { 'windwp/nvim-ts-autotag' }
use { 'tpope/vim-surround' }
use { 'rhysd/clever-f.vim' }
use { 'AndrewRadev/splitjoin.vim', config = function()
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
end}
-- use { 'tpope/vim-endwise' }
use { 'tpope/vim-abolish' }
use { 'tpope/vim-fugitive', config = function() require('plugins.fugitive') end }
use { 'dyng/ctrlsf.vim', config = function() require('plugins.ctrlsf') end }

use { 'lmeijvogel/vim-yaml-helper', ft = { 'yaml', 'yml' } }
use { 'mogelbrod/vim-jsonpath' }
use { 'simeji/winresizer', config = function()
  vim.cmd[[
  let g:winresizer_start_key = ''
  nnoremap <C-w>m :MaximizerToggle<CR>
  nnoremap <C-w>e :WinResizerStartResize<CR>
  ]]
end}

use {'szw/vim-maximizer', config = function()
  vim.cmd[[
  let g:maximizer_default_mapping_key = '<C-w>m'
  ]]
end}

require('plugins.lsp')
require('plugins.completion')
require('plugins.colorscheme')

-- vim.cmd [[autocmd BufWritePost init.lua PackerCompile]]
vim.cmd [[command! CopyPath execute 'let @+ = expand("%")']]

vim.cmd[[
augroup remember_cursor_position
autocmd!
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END
]]

