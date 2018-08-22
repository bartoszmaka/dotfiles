filetype off
call plug#begin()
" Cosmetic
Plug 'nathanaelkane/vim-indent-guides'                             " visualize indent level
Plug 'joshdick/onedark.vim'                                        " colorscheme
Plug 'bling/vim-airline'                                           " UI improvement
Plug 'vim-airline/vim-airline-themes'                              " themes for airline
Plug 'machakann/vim-highlightedyank'                               " highlight yanked code
Plug 'blueyed/vim-diminactive'                                     " dim inactive windows
Plug 'ryanoasis/vim-devicons'                                      " Fancy icons

" command improvements
if exists('$TMUX')
  Plug 'christoomey/vim-tmux-navigator'                            " tmux integration
endif
Plug 'tpope/vim-commentary'                                        " change selected code into comment
Plug 'tpope/vim-repeat'                                            " better .
Plug 'easymotion/vim-easymotion'                                   " adds improved w e b j k
Plug 'rhysd/clever-f.vim'                                          " better f F

" tools
Plug 'tpope/vim-fugitive'                                          " git related commands
Plug 'airblade/vim-gitgutter'                                      " shows git signs next to line numbers
Plug 'christoomey/vim-tmux-runner'                                 " tmux integration
Plug 'bartoszmaka/vim_current_word'                                " highlight word under cursor
Plug 'AndrewRadev/splitjoin.vim'                                   " split to multiple lines
Plug 'janko-m/vim-test'                                            " test launcher
Plug 'terryma/vim-multiple-cursors'                                " multiple cursors
Plug 'scrooloose/nerdtree'                                         " project explorer
Plug 'jistr/vim-nerdtree-tabs'                                     " better behavior for nerdtree
Plug 'Xuyuanp/nerdtree-git-plugin'                                 " nerdTree git integration
Plug 'szw/vim-maximizer'                                           " maximize window
Plug 'simeji/winresizer'                                           " window resize helper
Plug 'godlygeek/tabular',               { 'on': 'Tabularize' }     " text align with regexp
Plug 'majutsushi/tagbar',               { 'on': 'TagbarToggle' }   " preview file structure
Plug 'simnalamburt/vim-mundo',          { 'on': 'MundoToggle' }    " preview undos

Plug 'zefei/vim-wintabs'                                           " tabs and buffers management
Plug 'zefei/vim-wintabs-powerline'

" Fuzzy searcher
Plug 'junegunn/fzf',                    { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'pbogut/fzf-mru.vim'

" search in project
Plug 'mhinz/vim-grepper'                                           " search projectwide
Plug 'rking/ag.vim'                                                " searching engine

" simple autocomplete
Plug 'jiangmiao/auto-pairs'                                        " auto insert parentheses, quotes etc.
Plug 'tpope/vim-endwise'                                           " auto insert 'end', 'endif' etc.
Plug 'tpope/vim-surround'                                          " vim verb for surrounding word
Plug 'alvan/vim-closetag'                                          " autoclose html tag

" IDE like autocomplete
if has('nvim')
  Plug 'Shougo/deoplete.nvim',          { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'                                      " autocompletion engine
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neoinclude.vim'                                       " extends deoplete
Plug 'autozimu/LanguageClient-neovim',  { 'branch': 'next', 'do': 'bash install.sh' }
Plug 'ludovicchabant/vim-gutentags'                                " ctags engine
Plug 'w0rp/ale'                                                    " async syntax checking

" autocomplete sources
Plug 'deathlyfrantic/deoplete-spell'
Plug 'lmeijvogel/vim-yaml-helper',      "{ 'for': ['yaml'] }
Plug 'tpope/vim-rails',                 "{ 'for': ['ruby, eruby'] }
Plug 'MaxMEllon/vim-jsx-pretty',        "{ 'for': ['javascript'] }
Plug 'pangloss/vim-javascript',         "{ 'for': ['javascript', 'html', 'css', 'coffee', 'eruby'] }
Plug 'carlitux/deoplete-ternjs',        "{ 'for': ['javascript', 'html', 'css', 'coffee', 'eruby'], 'do': 'npm install -g tern' }
Plug 'moll/vim-node',                   "{ 'for': ['javascript'] }
call plug#end()

" **********************************
" vim variables

filetype plugin indent on
syntax on                               " Enable syntax coloring
let mapleader="\<Space>"

" meta
set shell=/bin/zsh                      " shell path
if has('nvim') && has('mac')
  let g:python_host_prog  = '/usr/local/bin/python2'
  let g:python3_host_prog = '/usr/local/bin/python3'
endif
set autoread
syntax sync minlines=256
set novisualbell
set undofile                            " keep history in file
set undodir=$HOME/.vim/undo             " path for this file
set grepprg=ag
set swapfile                            " shit happens (segmentation faults also)
set directory=/tmp
set autoread
set lazyredraw
set hidden                              " don't close buffers
set wildignore+=
      \*/tmp/*,
      \*/node_modules/*,
      \*/.git/*,
      \*.so,
      \*.swp,
      \*.zipo

" encoding
language en_US.UTF-8
set langmenu=en_US.UTF-8
set fileencoding=utf-8
set encoding=utf8

" behavior
set completeopt=longest,menuone,preview
set omnifunc=syntaxcomplete#Complete
set noshowmatch                         " has something to do with matching brackets
set backspace=indent,eol,start
set updatetime=500
set spell
set spellsuggest=best,10

" indent
set autoindent
set smartindent

" window management
set scrolloff=4                         " show at least 4 lines above or under cursor
set sidescrolloff=15
set splitright                          " place new vertical split on right side of current window
set splitbelow                          " place new horizontal split under current window
set diffopt+=vertical

" tabulator
set smarttab
set softtabstop=2
set shiftwidth=2                        " default tab width
set expandtab                           " Spaces instead of tabs

" line length
set synmaxcol=350                       " disable syntax colors after given column
set colorcolumn=80                      " color 120th column
set textwidth=0                         " do not break lines automatically
set showbreak=\/_
set nowrap                              " don't wrap lines

" searching
set ignorecase
set smartcase
set hlsearch
set incsearch

" ui
set noshowmode                          " do not display current mode in cmdline (airline already handles it)
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:< " define how whitespaces will be displayed
set nolist                              " show whitespaces
set mouse=a
set laststatus=2                        " always show status line
set showcmd                             " show pressed keys
set number                              " show line numbers
set norelativenumber
set signcolumn=auto                      " make place for symbols next to line numbers
set ruler
set cursorline                          " Highlight current line
set title
set title titlestring=%<%F%=

" **********************************
" colorscheme tweaks

if (has("termguicolors"))
  set termguicolors
endif

set background=dark
colorscheme onedark
let g:airline_theme = 'onedark'
set fillchars+=stl:\ ,stlnc:\ ,vert:\│

if has('conceal')
  set conceallevel=0
endif

" **********************************
" plugin variables
let g:webdevicons_enable                             = 1
let g:webdevicons_enable_nerdtree                    = 0
let g:WebDevIconsNerdTreeAfterGlyphPadding           = ''
let g:airline_powerline_fonts                        = 1
let g:airline#extensions#branch#enabled              = 1
let g:airline#extensions#branch#format               = 2
let g:airline#extensions#branch#displayed_head_limit = 15
let g:airline#extensions#tagbar#enabled              = 1
let g:airline#extensions#hunks#enabled               = 1
let g:airline_mode_map = {
    \ '__' : '-',
    \ 'n'  : 'N',
    \ 'i'  : 'I',
    \ 'R'  : 'R',
    \ 'c'  : 'C',
    \ 'v'  : 'V',
    \ 'V'  : 'V',
    \ '' : 'V',
    \ 's'  : 'S',
    \ 'S'  : 'S',
    \ '' : 'S',
    \ 't'  : 'T',
    \ }
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.readonly = '🔒'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.whitespace = 'Ξ'
let g:gitgutter_map_keys                             = 0
let g:gitgutter_sign_added                           = '+'
let g:gitgutter_sign_modified                        = '.'
let g:gitgutter_sign_removed                         = '-'
let g:gitgutter_sign_removed_first_line              = '-'
let g:gitgutter_sign_modified_removed                = '.'

let g:diminactive_buftype_blacklist                  = ['nofile', 'nowrite', 'acwrite', 'quickfix', 'help']
let g:diminactive_enable_focus                       = 1

let g:indent_guides_exclude_filetypes                = ['help', 'nerdtree', 'quickfix', 'qf']
let g:indent_guides_auto_colors                      = 0
let g:indent_guides_enable_on_vim_startup            = 1

" nerdtree, mundo, tagbar
let g:NERDTreeWinSize = 35
let g:mundo_right     = 1

let g:winresizer_vert_resize    = 1
let g:winresizer_horiz_resize   = 1

" vim current word
let g:vim_current_word#enabled                        = 1
let vim_current_word#highlight_only_in_focused_window = 1
let g:vim_current_word#highlight_twins                = 1
let g:vim_current_word#highlight_current_word         = 1
let g:vim_current_word#highlight_after_delay          = 1

" easymotion
let g:EasyMotion_startofline = 0 " keep cursor column when JK motion

" ale syntax checker
let g:ale_echo_msg_error_str   = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format      = '[%linter%] %s [%severity%]'
let g:ale_sign_error           = '💩'
let g:ale_sign_warning         = '🤔'
let g:ale_lint_on_save         = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_sign_column_always   = 1
let g:ale_set_highlights       = 0
let g:ale_fixers = {
      \ 'ruby':           ['remove_trailing_lines', 'trim_whitespace', 'rubocop'],
      \ 'javascript':     ['remove_trailing_lines', 'trim_whitespace', 'eslint', 'importjs'],
      \ 'vim':            ['remove_trailing_lines', 'trim_whitespace'],
      \}
let g:ale_linters = {
      \ 'ruby':           ['rubocop'],
      \ 'javascript':     ['eslint'],
      \}
let g:ale_linter_aliases = {'jsx': 'css'}

let g:AutoPairsShortcutToggle     = ''
let g:AutoPairsShortcutBackInsert = ''
let g:AutoPairsShortcutJump       = ''
let g:AutoPairsShortcutFastWrap   = ''
let g:AutoPairsMapCh              = ''
let g:ag_highlight=1

" completion
let g:deoplete#enable_at_startup       = 1
let g:deoplete#file#enable_buffer_path = 1
let g:deoplete#enable_smart_case       = 1

let g:deoplete#sources#ternjs#tern_bin = '/usr/local/bin/ternjs'
let g:deoplete#sources#ternjs#timeout = 0
let g:deoplete#sources#ternjs#docs = 0

let g:LanguageClient_autoStop = 0
let g:LanguageClient_serverCommands = {
    \ 'ruby': ['tcp://localhost:7658'],
    \ 'javascript': ['typescript-language-server', '--stdio'],
    \ 'javascript.jsx': ['typescript-language-server', '--stdio'],
    \ }

let g:vim_jsx_pretty_colorful_config = 1

let g:fzf_command_prefix = 'Fzf'
let g:fzf_colors = {
      \ 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Typedef'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Identifier'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'pointer': ['fg', 'Identifier'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment']
      \ }

let g:gutentags_ctags_exclude = ["node_modules", ".git"]

if has('gui_macvim')
  let test#strategy          = 'iterm'
elseif exists('$TMUX')
  let test#strategy          = 'vtr'
endif

if(has('nvim'))
  let g:neosnippet#snippets_directory='~/.repos/dotfiles/vim/vimsnippets'
  let g:neosnippet#scope_aliases = {}
  let g:neosnippet#scope_aliases['javascript'] = 'html,javascript,javascript.jsx'
endif

" closetag config
let g:closetag_filenames               = '*.html,*.xhtml,*.phtml,*.js,*.jsx,*.erb,*.eex'
let g:closetag_xhtml_filenames         = '*.xhtml,*.jsx,*.js,*.erb,*.eex'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_shortcut                = '>'


" **********************************
" custom functions
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction
" Go to alternative file
function! AltCommand(path, vim_command)
  let l:alternate = system("find . -path ./_site -prune -or -path ./target -prune -or -path ./.DS_Store -prune -or -path ./build -prune -or -path ./Carthage -prune -or -path tags -prune -or -path ./tmp -prune -or -path ./log -prune -or -path ./.git -prune -or -type f -print | alt -f - " . a:path)
  if empty(l:alternate)
    echo "No alternate file for " . a:path . " exists!"
  else
    exec a:vim_command . " " . l:alternate
  endif
endfunction

" Disable Deoplete when selecting multiple cursors starts
function! Multiple_cursors_before()
  if exists('*deoplete#disable')
    exe 'call deoplete#disable()'
  elseif exists(':NeoCompleteLock') == 2
    exe 'NeoCompleteLock'
  endif
endfunction

" Enable Deoplete when selecting multiple cursors ends
function! Multiple_cursors_after()
  if exists('*deoplete#enable')
    exe 'call deoplete#enable()'
  elseif exists(':NeoCompleteUnlock') == 2
    exe 'NeoCompleteUnlock'
  endif
endfunction

augroup open-nerdtree-at-start
  autocmd!
  autocmd VimEnter *
        \   if !argc()
        \ |   NERDTree
        \ |   wincmd w
        \ | endif
        \ | set list
augroup END

augroup remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

augroup yaml-helper
  autocmd!
  autocmd CursorHold *.yml YamlGetFullPath
augroup END

augroup filetype-tweaks
  autocmd!
  autocmd Filetype fugitiveblame,qf setlocal nospell
  autocmd FileType fzf 
        \| set laststatus=0 noshowmode noruler
        \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END

augroup inset-enter-stuff
  autocmd!
  autocmd InsertEnter *
        \  set cursorcolumn
        \| setlocal nohls
        \| highlight CursorLine   guibg=#512121
        \| highlight CursorLineNR guibg=#512121
  autocmd InsertLeave * 
        \| set nocursorcolumn
        \| highlight CursorLine   guibg=#343D46
        \| highlight CursorLineNR guibg=#343D46
augroup END

augroup color-scheme-tweaks
  autocmd!
  highlight CursorColumn     guibg=#512121
  highlight CursorColumnNR   guibg=#512121
  highlight Search           guifg=#CDB07A guibg=NONE gui=bold
  highlight CurrentWordTwins guibg=#1A1A1A
  highlight CurrentWord      guibg=#0D0D0D
  highlight IndentGuidesEven guibg=#2C313A
  highlight IndentGuidesOdd  guibg=#373E49
  highlight TabLineSel       guifg=#E5C07B
  highlight SpellBad         guifg=NONE    guibg=#260F0D
augroup END

" keymaps
nmap <leader>1 :WintabsGo 1<CR>
nmap <leader>2 :WintabsGo 2<CR>
nmap <leader>3 :WintabsGo 3<CR>
nmap <leader>4 :WintabsGo 4<CR>
nmap <leader>5 :WintabsGo 5<CR>
nmap <leader>6 :WintabsGo 6<CR>
nmap <leader>7 :WintabsGo 7<CR>
nmap <leader>8 :WintabsGo 8<CR>
nmap <leader>9 :WintabsGo 9<CR>
map <M-{>      <Plug>(wintabs_previous)
map <leader>[  <Plug>(wintabs_previous)
map <C-H>      <Plug>(wintabs_previous)
map <M-}>      <Plug>(wintabs_next)
map <leader>]  <Plug>(wintabs_next)
map <C-L>      <Plug>(wintabs_next)
map <leader>w  <Plug>(wintabs_close)
map <leader>W  <Plug>(wintabs_undo)
map <C-T>o     <Plug>(wintabs_only)
map <C-W>c     <Plug>(wintabs_close_window)
map <C-W>o     <Plug>(wintabs_only_window)
command! Tabc WintabsCloseVimtab
command! Tabo WintabsOnlyVimtab

let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-c>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

nnoremap [c :GitGutterPrevHunk<CR>
nnoremap ]c :GitGutterNextHunk<CR>
nnoremap [e :ALEPrevWrap<CR>
nnoremap ]e :ALENextWrap<CR>

nnoremap <leader>tt :TestNearest<CR>
nnoremap <leader>tf :TestFile<CR>
nnoremap <leader>ta :TestSuite<CR>
nnoremap <leader>to :w<cr>:call AltCommand(expand('%'), ':e')<cr>

nnoremap <C-k><C-s> :FzfMaps<CR>
nnoremap <C-p><C-p> :FZF<CR>
nnoremap <C-p><C-r> :FZFFreshMru<CR>
nnoremap <C-p><C-g> :FzfGitFiles<CR>
nnoremap <C-p><C-h> :FzfHistory<CR>
nnoremap <C-p><C-b> :FzfBuffers<CR>
nnoremap <C-p><C-f> :FzfAg<CR>
nnoremap <C-p><C-l> :FzfLines<CR>
nnoremap <C-p><C-v> :FzfCommits<CR>
nnoremap <C-p><C-w> :FzfWindows<CR>
nnoremap <C-p><C-o> viwy:FzfTags <C-r>"<CR>
nnoremap <C-p><C-t> viwy:FzfBTags <C-r>"<CR>
imap <expr> <C-c><C-s> fzf#vim#complete#word({'right': '15%'})

nnoremap <C-p><C-e> :call LanguageClient_contextMenu()<CR>
nnoremap <C-k><C-k> :call LanguageClient#textDocument_hover()<CR>
nnoremap gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <C-m><C-r> :call LanguageClient#textDocument_rename()<CR>
nnoremap <C-m><C-f> :ALEFix<CR>

nnoremap <C-m><C-g> :Grepper<CR>
vnoremap <C-m><C-g> y:GrepperAg <C-r>"<CR>
nnoremap <leader>f :Grepper<CR>
vnoremap <leader>f y:GrepperAg <C-r>"<CR>

let g:winresizer_start_key          = '<C-w>e'
let g:maximizer_default_mapping_key = '<C-w>m'
nnoremap <C-k><C-u> :MundoToggle<CR>
nnoremap <C-k><C-f> :NERDTreeFind<CR>zz
nnoremap <C-k><C-e> :NERDTreeToggle<CR>
nnoremap <C-k><C-v> :TagbarToggle<CR>
nnoremap <C-g><C-b> :Gblame<CR>
nnoremap <C-g><C-d> :Gdiff<CR>

" system clipboard integration
vnoremap <leader>y "+y
nnoremap <leader>Y "+yg_
nnoremap <leader>y "+y
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" window manipulation tweaks
" windows navigation
nnoremap <M-h>      <C-w>h
nnoremap <M-j>      <C-w>j
nnoremap <M-k>      <C-w>k
nnoremap <M-l>      <C-w>l
nnoremap <C-space>h <C-w>h
nnoremap <C-space>j <C-w>j
nnoremap <C-space>k <C-w>k
nnoremap <C-space>l <C-w>l
if exists('$TMUX')
  let g:tmux_navigator_no_mappings = 1
  nnoremap <C-w>h :TmuxNavigateLeft<CR>
  nnoremap <C-w>j :TmuxNavigateDown<CR>
  nnoremap <C-w>k :TmuxNavigateUp<CR>
  nnoremap <C-w>l :TmuxNavigateRight<CR>
endif
" tabs navigation
nnoremap tt :tabnew<CR>
nnoremap TT :tabclose<CR>
nnoremap tl :tabs<CR>

" close buffer
nnoremap <leader>q :close<CR>

" unify keymaps with tmux
nnoremap <C-w>" <C-w>s
nnoremap <C-w>% <C-w>v

" cursor behavoiur
"
" always focus after cursor jump
nnoremap n     :setlocal hls<CR>nzz
nnoremap N     :setlocal hls<CR>Nzz
nnoremap <C-o> <C-o>zz
nnoremap <C-i> <C-i>zz

" treat multiline statement as multiple lines
nnoremap j gj
nnoremap k gk
map <leader>h ^
map <leader>l $

" Code manipulation tweaks
" split and merge lines
nnoremap <leader>j i<CR><Esc>
nnoremap <leader>k <esc>kJ

" Move block of code without losing select
vnoremap <Tab>   >gv
vnoremap <S-Tab> <gv

" disable entering Ex-mode with Q (accessible through :<C-f>)
nnoremap Q <NOP>
map q: <NOP>

" sometimes I just hold shift for too long
cabbrev W   w
cabbrev Wa  wa
cabbrev Wq  wq
cabbrev Wqa wqa
cabbrev WQa wqa
cabbrev Q   q
cabbrev Qa  qa
cabbrev Q!  q
cabbrev Qa! qa
