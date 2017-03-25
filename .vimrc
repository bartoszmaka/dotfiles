filetype off
call plug#begin('~/.vim/plugged')

" Testing
    Plug 'tpope/vim-rails',             { 'for' : ['ruby'] }
    Plug 'tpope/vim-cucumber',          { 'for' : ['ruby'] }
    Plug 'ecomba/vim-ruby-refactoring', { 'for' : ['ruby'] }
    Plug 'vim-scripts/greplace.vim'
    Plug 'AndrewRadev/switch.vim'

" autocompletion
    Plug 'Shougo/deoplete.nvim',                    { 'do': ':UpdateRemotePlugins' }
    " Plug 'honza/vim-snippets'
    " Plug 'Shougo/context_filetype.vim'
    Plug 'Shougo/neosnippet'
    Plug 'Shougo/neoinclude.vim'                    " extends deoplete
    Plug 'Shougo/neosnippet-snippets'               " snipplets for neosnipplet
    " Plug 'sbdchd/neoformat'                         " code formatting engine
    Plug 'ervandew/supertab'                        " Confirm autocompletion with tab

" auto insert pairs
    Plug 'jiangmiao/auto-pairs'                     " auto insert parentheses, quotes etc.
    Plug 'tpope/vim-endwise'                        " auto insert 'end', 'endif' etc.

" syntax checker
    Plug 'neomake/neomake'                          " async make
    Plug 'vim-syntastic/syntastic'                  " syntax checking engine
    " Plug 'bronson/vim-trailing-whitespace'          " Detect trailing whitespaces
    Plug 'ntpeters/vim-better-whitespace'           " Detect trailing whitespaces

" prosect explorer
    Plug 'scrooloose/nerdtree'                      " Project explorer
    Plug 'jistr/vim-nerdtree-tabs'                  " Better behavior for nerdtree
    Plug 'Xuyuanp/nerdtree-git-plugin'              " NerdTree git integration

" project finder
    Plug 'ctrlpvim/ctrlp.vim'                       " In project file finder
    Plug 'JazzCore/ctrlp-cmatcher',             { 'do': './install.sh' }

" UI
    Plug 'joshdick/onedark.vim'                     " ColorScheme
    Plug 'ryanoasis/vim-devicons'                   " Fancy icons
    Plug 'gko/vim-coloresque'                       " Color perview for vim
    Plug 'Yggdroot/indentLine'                      " Vertical lines for indent
    Plug 'airblade/vim-gitgutter'                   " Shows git signs next to line numbers
    Plug 'bling/vim-airline'                        " Airline
    Plug 'vim-airline/vim-airline-themes'           " Themes for airline
    Plug 'blueyed/vim-diminactive'                  " Dim inactive windows
    Plug 'kien/rainbow_parentheses.vim'             " Different parentheses colors for each depth level

" window management
    Plug 'szw/vim-maximizer'                        " maximize window
    Plug 'simeji/winresizer'                        " window resize helper

" code edit improvements
    Plug 'rhysd/clever-f.vim'                       " better f F t T
    Plug 'matze/vim-move'                           " Move block of code
    Plug 'easymotion/vim-easymotion'
    Plug 'tpope/vim-surround'                       " Surround verb
    Plug 'tpope/vim-commentary'                     " Change selected code into comment
    Plug 'godlygeek/tabular'                        " Text align with regexp
    Plug 'mhinz/vim-grepper'                        " find in files helper
    Plug 'terryma/vim-expand-region'                " Select helper

" Behavior
    Plug 'janko-m/vim-test'                         " Test helper
    Plug 'benizi/vim-automkdir'                     " autocreate folder if necessary when writing
    Plug 'tpope/vim-fugitive'                       " Git engine for vim

" Live perview
    Plug 'jaxbot/browserlink.vim'

" Terminal provider
    Plug 'kassio/neoterm'                           " terminal mode

" Yank history
    Plug 'Shougo/unite.vim'
    Plug 'Shougo/neoyank.vim'

" Code minimap
    Plug 'majutsushi/tagbar'                        " perview file structure
    Plug 'c0r73x/neotags.nvim'

" File history visualisation
    Plug 'simnalamburt/vim-mundo'                   " perview undos

" tmux integration
    Plug 'christoomey/vim-tmux-navigator'

" language specific
    Plug 'Shougo/neco-vim',                         { 'for' : ['vim'] }
    Plug 'fishbullet/deoplete-ruby',                { 'for' : ['ruby'] }
    Plug 'sunaku/vim-ruby-minitest',                { 'for' : ['ruby'] }
    Plug 'vim-ruby/vim-ruby',                       { 'for' : ['ruby'] }
    Plug 'ngmy/vim-rubocop',                        { 'for' : ['ruby'] }
    Plug 'slim-template/vim-slim',                  { 'for' : ['slim'] }
    Plug 'groenewege/vim-less',                     { 'for' : ['less'] }
    Plug 'cakebaker/scss-syntax.vim',               { 'for' : ['scss','sass'] }
    Plug 'hail2u/vim-css3-syntax',                  { 'for' : ['css','scss','sass'] }
    Plug 'ap/vim-css-color',                        { 'for' : ['css','scss','sass','less','styl'] }
    Plug 'othree/html5.vim',                        { 'for' : ['html'] }
    Plug 'Valloric/MatchTagAlways',                 { 'for' : ['html' , 'xhtml' , 'xml' , 'jinja'] }
    Plug 'pangloss/vim-javascript',                 { 'for' : ['javascript'] }
    Plug 'maksimr/vim-jsbeautify',                  { 'for' : ['javascript'] }
    Plug 'leafgarland/typescript-vim',              { 'for' : ['typescript'] }
    Plug 'kchmck/vim-coffee-script',                { 'for' : ['coffee'] }
    Plug 'mmalecki/vim-node.js',                    { 'for' : ['javascript'] }
    Plug 'leshill/vim-json',                        { 'for' : ['javascript','json'] }
    Plug 'othree/javascript-libraries-syntax.vim',  { 'for' : ['javascript','coffee','ls','typescript'] }
    Plug 'davidhalter/jedi-vim',                    { 'for' : ['python'] }
    Plug 'zchee/deoplete-jedi',                     { 'for' : ['python'] }
    " Plug 'zchee/deoplete-clang',                    { 'for' : ['c', 'cpp', 'objc'] }
call plug#end()
" **********************************

filetype plugin indent on
syntax on                                          " Enable syntax coloring
let mapleader = "\<Space>"

" meta
set shell=/bin/zsh
set noswapfile
set novisualbell
set nobackup
set lazyredraw
set hidden                                         " don't close buffers
set wildignore+=
            \*/tmp/*,
            \*.so,
            \*.swp,
            \*.zipo

" encoding
language en_US.UTF-8
set langmenu=en_US.UTF-8
set fileencoding=utf-8
set encoding=utf8

" behavior
set completeopt=longest,menuone
set omnifunc=syntaxcomplete#Complete
set noshowmatch                                     " has something to do with matching brackets
set backspace=indent,eol,start

" indent
set autoindent
set smartindent

" window management
set scrolloff=4
set sidescrolloff=5
set splitright
set splitbelow

" tabulator
set smarttab
set softtabstop=4
set shiftwidth=4                                   " Default tab width
set expandtab                                      " Spaces instead of tabs

" line length
set colorcolumn=120                                " Color 120th column
set textwidth=0                                     " do not break lines automatically
set showbreak=\/_

" searching
set ignorecase
set smartcase
set hlsearch
set incsearch
" set nohlsearch

" ui
set mouse=a
set laststatus=2                                   " always show status line
set showcmd
set number
set norelativenumber
set ruler
set cursorline                                     " Highlight current line
set title
set title titlestring=%<%F%=

" Rainbow Parentheses
let g:rbpt_colorpairs = [
    \ ['brown',       'lightcyan'],
    \ ['Darkblue',    'khaki'],
    \ ['darkgray',    'lightmagenta'],
    \ ['darkgreen',   'lemonchiffon'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'lightcyan'],
    \ ['darkcyan',    'khaki'],
    \ ['darkred',     'lightmagenta'],
    \ ['red',         'lemonchiffon'],
    \ ]
let g:rbpt_max = 16
" colorscheme
if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
    set termguicolors
endif
if (has("autocmd") && !has("gui"))
    let s:monek_grey = { "gui": "#343D46", "cterm": "16", "cterm16": "0" }
    autocmd ColorScheme * call onedark#set_highlight("CursorLine", { "bg": s:monek_grey })
end
set background=dark
colorscheme onedark
let g:airline_theme = 'onedark'

let g:webdevicons_enable                                       = 1
let g:webdevicons_enable_nerdtree                              = 0
let g:WebDevIconsNerdTreeAfterGlyphPadding                     = ''
let g:webdevicons_enable_airline_statusline                    = 1
let g:webdevicons_enable_airline_tabline                       = 1
let g:webdevicons_enable_airline_statusline_fileformat_symbols = 1

set fillchars+=stl:\ ,stlnc:\ ,vert:\│
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep         = ''
let g:airline_left_alt_sep     = ''
let g:airline_right_sep        = ''
let g:airline_right_alt_sep    = ''
let g:airline_symbols.branch   = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr   = ''
let g:airline_symbols.space    = "\ua0"
let g:airline_powerline_fonts  = 1
let g:Powerline_symbols        = 'unicode'
let g:airline#extensions#tabline#enabled             = 1
let g:airline#extensions#tabline#buffer_idx_mode     = 1
let g:airline#extensions#tabline#buffer_nr_show      = 1
let g:airline#extensions#tabline#buffer_nr_format    = '%s:'
let g:airline#extensions#tabline#fnamemod            = ':t'
let g:airline#extensions#tabline#fnamecollapse       = 1
let g:airline#extensions#tabline#fnametruncate       = 0
let g:airline#extensions#tabline#formatter           = 'unique_tail_improved'
let g:airline#extensions#branch#enabled              = 1
let g:airline#extensions#branch#format               = 2
let g:airline#extensions#branch#displayed_head_limit = 15
let g:airline#extensions#tagbar#enabled              = 0
let g:airline#extensions#hunks#enabled               = 0
let g:airline#extensions#syntastic#enabled           = 0
let g:airline#parts#ffenc#skip_expected_string       = 'utf-8[unix]'
let g:indentLine_color_term    = 239
let g:indentLine_color_gui     = '#717273'
let g:indentLine_char          = '¦'
let g:indentLine_concealcursor = 'niv'             " (default 'inc')
let g:indentLine_conceallevel  = 2                  " (default 2)                " (default 2)

if has('conceal')
    set conceallevel=2 concealcursor=niv
endif

let g:gitgutter_sign_column_always = 1
let g:gitgutter_map_keys = 0

let g:diminactive_buftype_blacklist = ['nofile', 'nowrite', 'acwrite', 'quickfix', 'help']
let g:diminactive_enable_focus      = 1

" nerdtree, mundo, tagbar
let g:NERDTreeWinSize               = 25
"close vim if only NERDTree is opened
augroup nerdtree
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    " start with nerdtree open if no file were specified (2 lines below)
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
augroup END
let g:maximizer_default_mapping_key   = '<C-w>m'
nmap     <F2>         :NERDTreeToggle<CR>
nmap     <leader><F2> :NERDTreeFind<CR>zz
noremap  <F3>         :TagbarToggle<CR>
nnoremap <F4>         :MundoToggle<CR>

" easymotion
let g:EasyMotion_startofline = 0 " keep cursor column when JK motion

" winresizer 101 is 'e'
let g:winresizer_vert_resize    = 1
let g:winresizer_horiz_resize   = 1
let g:winresizer_keycode_finish = 101

" vim-tmux-navigator
let g:tmux_navigator_no_mappings = 1


" syntastic things
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:AutoPairsShortcutToggle = ''
let g:AutoPairsShortcutBackInsert = ''
let g:AutoPairsShortcutJump = ''
let g:AutoPairsShortcutFastWrap = ''
let g:AutoPairsMapCh = ''

" completion
let g:SuperTabDefaultCompletionType  = '<C-n>'
let g:deoplete#enable_at_startup     = 1
let g:deoplete#enable_ignore_case    = 1
let g:deoplete#enable_smart_case     = 1
let g:deoplete#enable_camel_case     = 1
let g:deoplete#enable_refresh_always = 1
let g:neomake_ruby_enabled_makers    = ['rubocop']
let g:neomake_python_enabled_makers  = ['flake8']
let g:vimrubocop_config              = '~/.rubocop.yml'
imap        <expr><C-j>     pumvisible() ? "\<C-n>" : "\<C-j>"
imap        <expr><C-k>     pumvisible() ? "\<C-p>" : "\<C-k>"
inoremap    <expr><C-f>     pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<Right>"
inoremap    <expr><C-b>     pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<Left>"
imap        <expr><C-d>     pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
imap        <expr><C-u>     pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"
imap        <C-e><C-e>      <Plug>(neosnippet_expand_or_jump)
smap        <C-e><C-e>      <Plug>(neosnippet_expand_or_jump)
xmap        <C-e><C-e>      <Plug>(neosnippet_expand_target)
imap        <C-e><C-e>      <Plug>(neosnippet_expand_or_jump)
smap        <expr><TAB>     neosnippet#expandable_or_jumpable() ?
                            \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" ctrlp
let g:ctrlp_map         = '<c-p>'
let g:ctrlp_cmd         = 'CtrlPMixed'
let g:ctrlp_show_hidden = 1
let g:ctrlp_cache_dir   = $HOME . '/.cache/ctrlp'
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    let g:ctrlp_use_caching = 0
    map <C-l> :CtrlPMRU<CR>
endif

" tags
let g:neotags_appendpath = 0
let g:neotags_recursive  = 0
let g:neotags_ctags_bin  = 'ag -g "" '. getcwd() .' | ctags'
let g:neotags_ctags_args = [
            \ '-L -',
            \ '--fields=+l',
            \ '--c-kinds=+p',
            \ '--c++-kinds=+p',
            \ '--sort=no',
            \ '--extra=+q'
            \ ]

" neoterm
let test#strategy            = 'neoterm'
let g:neoterm_keep_term_open = 1
let g:neoterm_run_tests_bg   = 1
let g:neoterm_position       = 'horizontal'
let g:neoterm_size           = 10
nnoremap <leader>te :Ttoggle<CR>
let g:better_whitespace_filetypes_blacklist=[]
" **********************************

" augroups
autocmd! BufWritePost * Neomake
" autocmd BufWritePre * FixWhitespace

augroup trailing-whitespaces
    autocmd!
" Show trailing-whitespaces in all files, but dont delete them in markdown
    autocmd BufEnter * EnableStripWhitespaceOnSave
    autocmd FileType markdown autocmd BufEnter <buffer> DisableStripWhitespaceOnSave
augroup END

augroup rainbow-parentheses
    autocmd!
    au VimEnter * RainbowParenthesesToggle
    au Syntax * RainbowParenthesesLoadRound
    au Syntax * RainbowParenthesesLoadSquare
    au Syntax * RainbowParenthesesLoadBraces
augroup END

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
    " autocmd InsertEnter * set norelativenumber
    autocmd InsertEnter * highlight CursorLine guibg=#512121 ctermbg=52
    autocmd InsertEnter * highlight CursorLineNR guibg=#512121
    " autocmd InsertLeave * set relativenumber
    autocmd InsertLeave * highlight CursorLine guibg=#343D46 ctermbg=16
    autocmd InsertLeave * highlight CursorLineNR guibg=#343D46
augroup END

augroup tab-lengths
    autocmd!
    autocmd Filetype ruby       setlocal ts=2 sts=2 sw=2
    autocmd Filetype eruby      setlocal ts=2 sts=2 sw=2
    autocmd Filetype scss       setlocal ts=2 sts=2 sw=2
    autocmd Filetype sass       setlocal ts=2 sts=2 sw=2
    autocmd Filetype slim       setlocal ts=2 sts=2 sw=2
    autocmd Filetype html       setlocal ts=2 sts=2 sw=2
    autocmd Filetype haml       setlocal ts=2 sts=2 sw=2
    autocmd Filetype ruby       setlocal ts=2 sts=2 sw=2
    autocmd Filetype coffee     setlocal ts=2 sts=2 sw=2
    autocmd Filetype yaml       setlocal ts=2 sts=2 sw=2
    autocmd Filetype c          setlocal ts=4 sts=4 sw=4 cc=79
    autocmd Filetype cpp        setlocal ts=4 sts=4 sw=4 cc=79
    autocmd Filetype objc       setlocal ts=4 sts=4 sw=4 cc=79
    autocmd Filetype javascript setlocal ts=4 sts=4 sw=4 cc=79
    autocmd Filetype python     setlocal ts=4 sts=4 sw=4 cc=79
augroup END
autocmd BufNewFile,BufRead *.slim setlocal filetype=slim

" colorscheme customization
hi IncSearch guifg=#FF0000 guibg=NONE guisp=NONE gui=bold ctermfg=15 ctermbg=NONE cterm=bold
hi Search guifg=#FFFFFF guibg=NONE guisp=NONE gui=bold ctermfg=15 ctermbg=NONE cterm=bold
hi ExtraWhitespace ctermbg=160 guibg=#D70000
" hi MatchParen guifg=#00FF00 guibg=#000000 ctermbg=NONE ctermfg=NONE cterm=underline,bold
" hi CursorLineNR guifg=#AAAAAA guibg=#333399 guisp=NONE gui=NONE ctermfg=232 ctermbg=184 cterm=bold
 " **********************************

" keymaps
nnoremap <leader>ya :Unite history/yank -default-action=append<CR>
" vim-switch
nnoremap <leader>s :Switch<CR>
nnoremap <leader>S :SwitchReverse<CR>
    " disable hls
noremap  <Esc><Esc> :<C-u>nohls<CR>
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
    " tabs and buffers navigation
nnoremap gr :bnext<CR>
nnoremap gR :bprev<CR>
nnoremap tt :tabnew<CR>
nnoremap TT :tabclose<CR>
nnoremap tl :tabs<CR>
nnoremap Tl :buffers<CR>
vmap v <Plug>(expand_region_expand)
    " Unite keymaps
nnoremap <leader>uu :Unite<CR>
    " Easymotion
map <leader>fi <Plug>(easymotion-sn)
omap <leader>fi <Plug>(easymotion-tn)
map <leader>n <Plug>(easymotion-next)
map <leader>N <Plug>(easymotion-prev)
map <leader><leader>/ <Plug>(easymotion-sn)
omap <leader><leader>/ <Plug>(easymotion-tn)
map <Leader>L <Plug>(easymotion-lineforward)
map <Leader>H <Plug>(easymotion-linebackward)
map <Leader>. <Plug>(easymotion-repeat)
    " grepper
nnoremap <leader>F :Grepper -tool ag<CR>

    " Window navigation
:tnoremap <Esc> <C-\><C-n>
:tnoremap ii    <C-\><C-n>
:tnoremap <A-h> <C-\><C-n><C-w>h
:tnoremap <A-j> <C-\><C-n><C-w>j
:tnoremap <A-k> <C-\><C-n><C-w>k
:tnoremap <A-l> <C-\><C-n><C-w>l
" :nnoremap <A-h> <C-w>h
" :nnoremap <A-j> <C-w>j
" :nnoremap <A-k> <C-w>k
" :nnoremap <A-l> <C-w>l
nnoremap <silent> <M-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <M-j> :TmuxNavigateDown<cr>
nnoremap <silent> <M-k> :TmuxNavigateUp<cr>
nnoremap <silent> <M-l> :TmuxNavigateRight<cr>
nnoremap <silent> <M-/> :TmuxNavigatePrevious<cr>

" non plugin related mappings
" treat multiline statement as multiple lines
nnoremap j gj
nnoremap k gk
" allow moving cursor in insert mode
inoremap <c-h> <Esc>ha
inoremap <c-l> <Esc>la
" map ; as : for faster command typing
nnoremap ; :
" nnoremap <leader>g g;
nnoremap <leader>j i<CR><Esc>
nnoremap <leader>k <esc>kJ
" Esc key mappings
inoremap ii <Esc>
vnoremap ii <Esc>
" begin and end of line
map <leader>h ^
map <leader>l $
" Disable arrow keys
nnoremap <Up>    <NOP>
nnoremap <Down>  <NOP>
nnoremap <Left>  <NOP>
nnoremap <Right> <NOP>
inoremap <Up>    <NOP>
inoremap <Down>  <NOP>
inoremap <Left>  <NOP>
inoremap <Right> <NOP>
vnoremap <Up>    <NOP>
vnoremap <Down>  <NOP>
vnoremap <Left>  <NOP>
vnoremap <Right> <NOP>
" Disable ex mode
nnoremap Q q
" Disable q:, use :<C-f> instead
nnoremap q: <NOP>
vnoremap q: <NOP>

" function s:spellcheckmode()
"   if exists("g:syntax_on") | syntax off | else | syntax enable | endif
"   set spell!
"   set cursorline!
" endfunc

" command! SpellCheckModeToggle call s:spellcheckmode()

" nnoremap <leader>sp :SpellCheckModeToggle<CR>
