filetype off
call plug#begin('~/.vim/plugged')
" autocompletion
    Plug 'kassio/neoterm'                       "terminal mode
    Plug 'neomake/neomake'                      "async make
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'Shougo/neosnippet-snippets'           " snipplets for neosnipplet
    Plug 'Shougo/neoinclude.vim'                " extends deoplete
    Plug 'sbdchd/neoformat'                     " code formatting engine
    Plug 'janko-m/vim-test'                     " test engine
    Plug 'matze/vim-move'                       " Move block of code

" behavior
    Plug 'rhysd/clever-f.vim'                   " better f F t T
    Plug 'tpope/vim-commentary'                 " Comments
    Plug 'tpope/vim-surround'                   " Surround verb
    Plug 'gko/vim-coloresque'                   " Color perview for vim
    Plug 'bronson/vim-trailing-whitespace'      " Detect trailing whitespaces
    Plug 'jiangmiao/auto-pairs'                 " Auto insert matching brackets and tags
    Plug 'gko/vim-coloresque'                   " Color perview for vim
    Plug 'ctrlpvim/ctrlp.vim'                   " In project file finder
        Plug 'JazzCore/ctrlp-cmatcher', { 'do': './install.sh' }
    Plug 'xolox/vim-misc'
        Plug 'xolox/vim-easytags'
    Plug 'ervandew/supertab'                    " Confrim autocompletion with tab

" git
    Plug 'tpope/vim-fugitive'                   " Git engine for vim
    Plug 'godlygeek/tabular'                    " Text align with regexp
    Plug 'benizi/vim-automkdir'                 " autocreate folder if necessary when writing

" ui
    " Plug 'morhetz/gruvbox'
    " Plug 'frankier/neovim-colors-solarized-truecolor-only'
    " Plug 'tomasr/molokai'                       " Color Scheme
    Plug 'joshdick/onedark.vim'
    Plug 'Yggdroot/indentLine'                  " vertical lines for indent
    Plug 'szw/vim-maximizer'                    " maximize window
    Plug 'bling/vim-airline'                    " Airline
    Plug 'vim-airline/vim-airline-themes'       " Themes for airline
    Plug 'majutsushi/tagbar'                    " perview file structure
    Plug 'simnalamburt/vim-mundo'               " perview undos
    Plug 'airblade/vim-gitgutter'               " Shows git signs next to line numbers
    Plug 'scrooloose/nerdtree'                  " Project explorer
    Plug 'jistr/vim-nerdtree-tabs'              " Better behavior for nerdtree
    Plug 'Xuyuanp/nerdtree-git-plugin'

" language related
    Plug 'vim-ruby/vim-ruby',   { 'for' : 'ruby' }
    Plug 'ngmy/vim-rubocop',    { 'for' : 'ruby' }
call plug#end()
" **********************************

filetype plugin indent on
syntax on                               " Enable syntax coloring
let mapleader = "'"

" meta
language en_US.UTF-8
set shell=/bin/zsh
set langmenu=en_US.UTF-8
set fileencoding=utf-8
set encoding=utf8
set lazyredraw
set noswapfile
set novisualbell
set nobackup

" behavior
set autoindent
set smartindent
set noshowmatch
set splitright
set splitbelow
set hidden                " don't close buffers
set autoindent
set smartindent
set backspace=indent,eol,start
set omnifunc=syntaxcomplete#Complete
set wildignore+=
            \*/tmp/*,
            \*.so,
            \*.swp,
            \*.zipo

" tabulator
set smarttab
set softtabstop=4
set shiftwidth=4                        " Default tab width
set expandtab                " Spaces instead of tabs

" searching
set ignorecase
set smartcase
set hlsearch
set incsearch

" ui
set scrolloff=4
set sidescrolloff=5
set showbreak=\/_
set laststatus=2            " always show status line
set showcmd
set number
set relativenumber
set ruler
set colorcolumn=120                     " Color 120th column
set cursorline                         " Highlight current line

" colorscheme
if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
    set termguicolors
endif
colorscheme onedark
let g:airline_theme = 'onedark'

set fillchars+=stl:\ ,stlnc:\ ,vert:\│
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#buffer_nr_format = '%s:'
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#fnamecollapse = 1
let g:airline#extensions#tabline#fnametruncate = 0
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:indentLine_color_term = 239
let g:indentLine_char = '¦'
let g:indentLine_concealcursor = 'niv' " (default 'inc')
let g:indentLine_conceallevel = 2  " (default 2)

let g:gitgutter_sign_column_always = 1

" nerdtree
let g:NERDTreeWinSize = 25
let g:nerdtree_tabs_open_on_console_startup=2

" completion
let g:SuperTabDefaultCompletionType = '<C-n>'
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_refresh_always = 1
let g:deoplete#auto_refresh_delay = 30
let g:neomake_ruby_enabled_makers = ['rubocop']
let g:vimrubocop_config = '~/.rubocop.yml'
let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`', '|':'|'}
imap <expr><C-j>   pumvisible() ? "\<C-n>" : "\<C-j>"
imap <expr><C-k>   pumvisible() ? "\<C-p>" : "\<C-k>"
inoremap <expr><C-f> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<Right>"
inoremap <expr><C-b> pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<Left>"
imap     <expr><C-d> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
imap     <expr><C-u> pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"
" imap <C-j> <Tab>
" imap <C-k> <S-Tab>
imap <C-e><C-e>     <Plug>(neosnippet_expand_or_jump)
smap <C-e><C-e>     <Plug>(neosnippet_expand_or_jump)
xmap <C-e><C-e>     <Plug>(neosnippet_expand_target)

" ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_show_hidden = 1
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    let g:ctrlp_use_caching = 0
endif
map <C-l> :CtrlPMRU<CR>

" tags
let g:easytags_async = 1
let g:easytags_syntax_keyword = 'always'
set tags=./tags;
let g:easytags_dynamic_files = 2
set cpoptions+=d
" **********************************

" augroups
    " Remember cursor position
autocmd! BufWritePost * Neomake
augroup vimrc-remember-cursor-position
    autocmd!
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END
    " Change current line color when entering insert mode
autocmd InsertEnter * highlight  CursorLine guibg=#181A1F
    " Revert current line color to default when leaving insert mode
autocmd InsertLeave * highlight  CursorLine guibg=#2C323C
    " Remove Whitespaces on save
autocmd BufWritePre * FixWhitespace
    " swap relativenumber/norelativenumber or insert mode enter/leave
autocmd InsertEnter * set norelativenumber
autocmd InsertLeave * set relativenumber
    " tab lengths by filetype
autocmd Filetype eruby setlocal ts=2 sts=2 sw=2
autocmd Filetype scss setlocal ts=2 sts=2 sw=2
autocmd Filetype sass setlocal ts=2 sts=2 sw=2
autocmd Filetype slim setlocal ts=2 sts=2 sw=2
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype haml setlocal ts=2 sts=2 sw=2
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd Filetype coffee setlocal ts=2 sts=2 sw=2
autocmd Filetype yaml setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript setlocal ts=4 sts=4 sw=4
autocmd Filetype python setlocal ts=4 sts=4 sw=4
" **********************************

" keymaps
    " maximizer, nerdtree, tagbar, mundo
let g:maximizer_default_mapping_key = '<F9>'
nmap     <F2> :NERDTreeTabsToggle<CR>
noremap  <F3> :TagbarToggle<CR>
nnoremap <F4> :MundoToggle<CR>
    " disable hls
noremap <Esc><Esc> :<C-u>nohls<CR>
    " vim test
let test#strategy = 'neoterm'
let g:neoterm_position = 'horizontal'
nnoremap <leader>tt :TestNearest<CR>
nnoremap <leader>tf :TestFile<CR>
nnoremap <leader>ta :TestSuite<CR>
nnoremap <leader>tl :TestLast<CR>
nnoremap <leader>tg :TestVisit<CR>
    " vim move
let g:move_key_modifier = 'C'
    " copy to clipboard
vnoremap <leader>y  "+y
nnoremap <leader>Y  "+yg_
nnoremap <leader>y  "+y
    " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P
    " Disable arrow keys
nnoremap <Up> <NOP>
nnoremap <Down> <NOP>
nnoremap <Left> <NOP>
nnoremap <Right> <NOP>
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>
vnoremap <Up> <NOP>
vnoremap <Down> <NOP>
vnoremap <Left> <NOP>
vnoremap <Right> <NOP>
    " map ; as :
nnoremap ; :
    " Esc key mappings
inoremap jk <Esc>
inoremap ii <Esc>
vnoremap ii <Esc>
    " tabs and buffers navigation
nnoremap gr :bnext<CR>
nnoremap gR :bprev<CR>
nnoremap tt :tabnew<CR>
nnoremap TT :tabclose<CR>
nnoremap tl :tabs<CR>
nnoremap Tl :buffers<CR>
    " Window navigation
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
