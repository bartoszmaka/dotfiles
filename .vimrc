filetype off
call plug#begin('~/.vim/plugged')
" autocompletion
    Plug 'Shougo/deoplete.nvim',                   { 'do': ':UpdateRemotePlugins' }
    Plug 'honza/vim-snippets'
    Plug 'Shougo/neco-syntax'
    " Plug 'ujihisa/neco-look'
    Plug 'Shougo/neco-vim'
    Plug 'Shougo/context_filetype.vim'
    Plug 'Shougo/neoinclude.vim'                   " extends deoplete
    Plug 'Shougo/neosnippet-snippets'              " snipplets for neosnipplet
    Plug 'Shougo/neopairs.vim'
    Plug 'sbdchd/neoformat'                        " code formatting engine
    Plug 'ervandew/supertab'                       " Confrim autocompletion with tab

" behavior
    Plug 'tpope/vim-endwise',
    Plug 'neomake/neomake'                         " async make
    Plug 'janko-m/vim-test'                        " test engine
    Plug 'rhysd/clever-f.vim'                      " better f F t T
    Plug 'matze/vim-move'                          " Move block of code
    Plug 'bronson/vim-trailing-whitespace'         " Detect trailing whitespaces
    Plug 'c0r73x/neotags.nvim'
    " Plug 'xolox/vim-misc'
    "     Plug 'xolox/vim-easytags'
    Plug 'benizi/vim-automkdir'                    " autocreate folder if necessary when writing
    Plug 'tpope/vim-fugitive'                      " Git engine for vim

" syntax helpers
    Plug 'godlygeek/tabular'                       " Text align with regexp
    Plug 'tpope/vim-commentary'                    " Comments
    Plug 'tpope/vim-surround'                      " Surround verb

" extensions
    Plug 'kassio/neoterm'                          " terminal mode
    Plug 'ctrlpvim/ctrlp.vim'                      " In project file finder
        Plug 'JazzCore/ctrlp-cmatcher',            { 'do': './install.sh' }
    Plug 'Shougo/unite.vim'
        Plug 'Shougo/neoyank.vim'
    Plug 'majutsushi/tagbar'                       " perview file structure
    Plug 'simnalamburt/vim-mundo'                  " perview undos
    Plug 'scrooloose/nerdtree'                     " Project explorer
        Plug 'jistr/vim-nerdtree-tabs'             " Better behavior for nerdtree
        Plug 'Xuyuanp/nerdtree-git-plugin'
" ui
    Plug 'joshdick/onedark.vim'
    Plug 'gko/vim-coloresque'                      " Color perview for vim
    Plug 'Yggdroot/indentLine'                     " vertical lines for indent
    Plug 'szw/vim-maximizer'                       " maximize window
    Plug 'airblade/vim-gitgutter'                  " Shows git signs next to line numbers
    Plug 'bling/vim-airline'                       " Airline
        Plug 'vim-airline/vim-airline-themes'      " Themes for airline
    Plug 'blueyed/vim-diminactive'
    Plug 'simeji/winresizer'

" language specific
    Plug 'vim-ruby/vim-ruby',                      { 'for' : ['ruby'] }
    Plug 'ngmy/vim-rubocop',                       { 'for' : ['ruby'] }
    Plug 'davidhalter/jedi-vim',                   { 'for' : ['python'] }
    Plug 'zchee/deoplete-jedi',                    { 'for' : ['python'] }
    Plug 'groenewege/vim-less',                    { 'for' : ['less'] }
    Plug 'cakebaker/scss-syntax.vim',              { 'for' : ['scss','sass'] }
    Plug 'hail2u/vim-css3-syntax',                 { 'for' : ['css','scss','sass'] }
    Plug 'ap/vim-css-color',                       { 'for' : ['css','scss','sass','less','styl'] }
    Plug 'othree/html5.vim',                       { 'for' : ['html'] }
    Plug 'Valloric/MatchTagAlways',                { 'for' : ['html' , 'xhtml' , 'xml' , 'jinja'] }
    Plug 'pangloss/vim-javascript',                { 'for' : ['javascript'] }
    Plug 'maksimr/vim-jsbeautify',                 { 'for' : ['javascript'] }
    Plug 'leafgarland/typescript-vim',             { 'for' : ['typescript'] }
    Plug 'kchmck/vim-coffee-script',               { 'for' : ['coffee'] }
    Plug 'mmalecki/vim-node.js',                   { 'for' : ['javascript'] }
    Plug 'leshill/vim-json',                       { 'for' : ['javascript','json'] }
    Plug 'othree/javascript-libraries-syntax.vim', { 'for' : ['javascript','coffee','ls','typescript'] }
call plug#end()
" **********************************

filetype plugin indent on
syntax on                                          " Enable syntax coloring
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
set hidden                                         " don't close buffers
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
set shiftwidth=4                                   " Default tab width
set expandtab                                      " Spaces instead of tabs

" searching
set ignorecase
set smartcase
set hlsearch
set incsearch

" ui
set scrolloff=4
set sidescrolloff=5
set showbreak=\/_
set laststatus=2                                   " always show status line
set showcmd
set number
set relativenumber
set ruler
set colorcolumn=120                                " Color 120th column
set cursorline                                     " Highlight current line

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
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#buffer_nr_format = '%s:'
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#fnamecollapse = 1
let g:airline#extensions#tabline#fnametruncate = 0
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#717273'
let g:indentLine_char = '¦'
let g:indentLine_concealcursor = 'niv'             " (default 'inc')
let g:indentLine_conceallevel = 2                  " (default 2)

let g:gitgutter_sign_column_always = 1

let g:diminactive_buftype_blacklist = []
let g:diminactive_enable_focus = 1

" nerdtree, mundo, tagbar
let g:NERDTreeWinSize = 25
let g:nerdtree_tabs_open_on_console_startup=2
let g:tagbar_autoclose = 1
let g:maximizer_default_mapping_key = '<F9>'
nmap     <F2> :NERDTreeTabsToggle<CR>
noremap  <F3> :TagbarToggle<CR>
nnoremap <F4> :MundoToggle<CR>

" winresizer 101 is 'e'
let g:winresizer_vert_resize = 1
let g:winresizer_horiz_resize = 1
let g:winresizer_keycode_finish = 101

" completion
let g:SuperTabDefaultCompletionType = '<C-n>'
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_camel_case = 1
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
inoremap <C-e><C-e>     <Plug>(neosnippet_expand_or_jump)
snoremap <C-e><C-e>     <Plug>(neosnippet_expand_or_jump)
xnoremap <C-e><C-e>     <Plug>(neosnippet_expand_target)

" ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_show_hidden = 1
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    let g:ctrlp_use_caching = 0
    map <C-l> :CtrlPMRU<CR>
endif

" tags
" let g:easytags_async = 1
" let g:easytags_syntax_keyword = 'always'
" set tags=./tags;
" let g:easytags_dynamic_files = 2
" set cpoptions+=d
let g:neotags_appendpath = 0
let g:neotags_recursive = 0
let g:neotags_ctags_bin = 'ag -g "" '. getcwd() .' | ctags'
let g:neotags_ctags_args = [
            \ '-L -',
            \ '--fields=+l',
            \ '--c-kinds=+p',
            \ '--c++-kinds=+p',
            \ '--sort=no',
            \ '--extra=+q'
            \ ]
" neoterm
let test#strategy = 'neoterm'
let g:neoterm_keep_term_open = 1
let g:neoterm_run_tests_bg = 1
let g:neoterm_position = 'horizontal'
let g:neoterm_size = 10
nnoremap <leader>te :Ttoggle<CR>
" **********************************

" augroups
autocmd! BufWritePost * Neomake
autocmd BufWritePre * FixWhitespace

augroup dim-inactive-fix
    autocmd!
    autocmd BufNew * DimInactive
augroup END

augroup reload-vimrc-on-save
    " it breaks airline for some reason
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

augroup remember-cursor-position
    autocmd!
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

augroup insert-mode-tweaks
    autocmd!
    autocmd InsertEnter * set norelativenumber
    autocmd InsertLeave * set relativenumber
    autocmd InsertEnter * highlight CursorLine guibg=#181A1F ctermbg=2
    autocmd InsertLeave * highlight CursorLine guibg=#2C323C ctermbg=125
augroup END

augroup tab-lengths
    autocmd!
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
augroup END
" **********************************

" keymaps
nnoremap <leader>ly :Unite history/yank -default-action=append<CR>
    " disable hls
noremap <Esc><Esc> :<C-u>nohls<CR>
    " vim test
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
:tnoremap <Esc> <C-\><C-n>
:tnoremap jk    <C-\><C-n>
:tnoremap <A-h> <C-\><C-n><C-w>h
:tnoremap <A-j> <C-\><C-n><C-w>j
:tnoremap <A-k> <C-\><C-n><C-w>k
:tnoremap <A-l> <C-\><C-n><C-w>l
:nnoremap <A-h> <C-w>h
:nnoremap <A-j> <C-w>j
:nnoremap <A-k> <C-w>k
:nnoremap <A-l> <C-w>l
    " This may require disabling system screen lock shortcut (ubuntu default)
" nnoremap <A-C-h> :vertical resize +1<CR>
" nnoremap <A-C-j> :resize -1<CR>
" nnoremap <A-C-k> :resize +1<CR>
" nnoremap <A-C-l> :vertical resize -1<CR>
