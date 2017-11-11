filetype off
call plug#begin('~/.vim/plugged')

" autocompletion, tags, fuzzy search
  if has('nvim')
    Plug 'Shougo/deoplete.nvim',    { 'do': ':UpdateRemotePlugins' } " autocompletion engine
    Plug 'c0r73x/neotags.nvim'                                      " async tags handler
    Plug 'kassio/neoterm'                                           " terminal provider
    Plug 'junegunn/fzf',            { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'                                         " fuzzy searcher
    Plug 'pbogut/fzf-mru.vim'                                       " fzf extension provides most recently used
  else
    Plug 'Shougo/deoplete.nvim'                                     " autocompletion engine
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
    Plug 'jsfaint/gen_tags.vim'                                     " tags generator
    Plug 'ctrlpvim/ctrlp.vim'                                       " fuzzy searcher
    Plug 'JazzCore/ctrlp-cmatcher', { 'do': './install.sh' }        " fuzzy searcher performance improvement
  endif

  Plug 'Shougo/neosnippet'
  Plug 'Shougo/neosnippet-snippets'
  Plug 'Shougo/neoinclude.vim'                                      " extends deoplete
  Plug 'ervandew/supertab'                                          " select autocompletion with tab
  Plug 'rking/ag.vim'                                               " searching engine
  Plug 'w0rp/ale'                                                   " async syntax checking
  Plug 'jiangmiao/auto-pairs'                                       " auto insert parentheses, quotes etc.
  Plug 'tpope/vim-endwise'                                          " auto insert 'end', 'endif' etc.
  Plug 'tpope/vim-surround'                                         " vim verb for surrounding word
  Plug 'tpope/vim-commentary'                                       " change selected code into comment
  Plug 'tpope/vim-repeat'                                           " better .
  Plug 'rhysd/clever-f.vim'                                         " better f F t T
  Plug 'easymotion/vim-easymotion'                                  " adds improved w e b j k

  Plug 'terryma/vim-multiple-cursors'
  Plug 'matze/vim-move'                                             " move block of code
  Plug 'godlygeek/tabular'                                          " text align with regexp
  Plug 'janko-m/vim-test'                                           " test launcher
  Plug 'benizi/vim-automkdir'                                       " autocreate folder if necessary when writing
  Plug 'terryma/vim-expand-region'                                  " select helper
  Plug 'tpope/vim-fugitive'                                         " git related commands
  Plug 'bartoszmaka/vim_current_word'                               " highlight word under cursor
  Plug 'ntpeters/vim-better-whitespace'                             " detect trailing whitespaces
  Plug 'bounceme/poppy.vim'                                         " improve parentheses colorize behaviour

" UI extensions
  Plug 'mhinz/vim-startify'                                         " fancy project manager
  Plug 'bagrat/vim-workspace'                                       " IDE like tabs management
  Plug 'majutsushi/tagbar'                                          " perview file structure
  Plug 'simnalamburt/vim-mundo'                                     " perview undos
  Plug 'scrooloose/nerdtree'                                        " project explorer
  Plug 'jistr/vim-nerdtree-tabs'                                    " better behavior for nerdtree
  Plug 'Xuyuanp/nerdtree-git-plugin'                                " nerdTree git integration
  Plug 'machakann/vim-highlightedyank'                              " highlight yanked code
  Plug 'joshdick/onedark.vim'                                       " colorscheme
  Plug 'nathanaelkane/vim-indent-guides'                            " visualize indent level
  Plug 'airblade/vim-gitgutter'                                     " shows git signs next to line numbers
  Plug 'bling/vim-airline'                                          " UI improvement
  Plug 'vim-airline/vim-airline-themes'                             " themes for airline
  Plug 'blueyed/vim-diminactive'                                    " dim inactive windows
  Plug 'szw/vim-maximizer'                                          " maximize window
  Plug 'simeji/winresizer'                                          " window resize helper
  Plug 'wesQ3/vim-windowswap'                                       " windows management extension
  Plug 'ryanoasis/vim-devicons'                                     " Fancy icons

" language specific
  Plug 'aliou/sql-heredoc.vim'
  Plug 'rlue/vim-getting-things-down',     { 'for' : ['markdown'] }
  Plug 'Shougo/neco-vim',                  { 'for' : ['vim'] }
  Plug 'lmeijvogel/vim-yaml-helper',       { 'for' : ['yaml'] }
  Plug 'pangloss/vim-javascript',          { 'for' : ['javascript, javascript.jsx'] }
  Plug 'mxw/vim-jsx',                      { 'for' : ['javascript, javascript.jsx'] }
  Plug 'fishbullet/deoplete-ruby',         { 'for' : ['ruby'] }

  if !has('gui')
    Plug 'christoomey/vim-tmux-navigator'                           " tmux integration
  endif
call plug#end()

" **********************************
" vim variables

filetype plugin indent on
syntax on                               " Enable syntax coloring
let mapleader="\<Space>"

" meta
set shell=/bin/zsh                      " shell path
if has('nvim')
  " let g:ruby_host_prog    = '~/.rvm/gems/ruby-2.4.1/bin/neovim-ruby-host'
  let g:python_host_prog  = '/usr/local/bin/python2'
  let g:python3_host_prog = '/usr/local/bin/python3'
endif
set novisualbell
set undofile                            " keep history in file
set undodir=$HOME/.vim/undo             " path for this file
set noswapfile
set grepprg=ag
set nobackup
set autoread
set lazyredraw
set hidden                              " don't close buffers
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
set completeopt=longest,menuone,preview
set omnifunc=syntaxcomplete#Complete
set noshowmatch                         " has something to do with matching brackets
set backspace=indent,eol,start
set updatetime=500

" indent
set autoindent
set smartindent

" window management
set scrolloff=4                         " show at least 4 lines above or under cursor
set sidescrolloff=5
set splitright                          " place new vertical split on right side of current window
set splitbelow                          " place new horizontal split under current window

" tabulator
set smarttab
set softtabstop=2
set shiftwidth=2                        " default tab width
set expandtab                           " Spaces instead of tabs

" line length
set synmaxcol=120                       " disable syntax colors after 120 column
set colorcolumn=120                     " color 120th column
set textwidth=0                         " do not break lines automatically
set showbreak=\/_
set nowrap                              " don't wrap lines

" searching
set ignorecase
set smartcase
set hlsearch
set incsearch

" ui
set mouse=a
set laststatus=2                        " always show status line
set showcmd                             " show pressed keys
set number                              " show line numbers
set norelativenumber
set signcolumn=yes                      " make place for symbols next to line numbers
set ruler
set cursorline                          " Highlight current line
set title
set title titlestring=%<%F%=

" **********************************
" colorscheme tweaks

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
set fillchars+=stl:\ ,stlnc:\ ,vert:\│

if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" **********************************
" plugin variables

let g:webdevicons_enable                             = 1
let g:webdevicons_enable_nerdtree                    = 0
let g:WebDevIconsNerdTreeAfterGlyphPadding           = ''
let g:airline_powerline_fonts                        = 1
let g:airline#extensions#tabline#enabled             = 1
let g:airline#extensions#branch#enabled              = 1
let g:airline#extensions#branch#format               = 2
let g:airline#extensions#branch#displayed_head_limit = 15
let g:airline#extensions#tagbar#enabled              = 1
let g:airline#extensions#hunks#enabled               = 1
let g:gitgutter_map_keys                             = 0
let g:gitgutter_sign_added                           = '.'
let g:gitgutter_sign_modified                        = '.'
let g:gitgutter_sign_removed                         = '.'
let g:gitgutter_sign_removed_first_line              = '.'
let g:gitgutter_sign_modified_removed                = '.'

let g:diminactive_buftype_blacklist                  = ['nofile', 'nowrite', 'acwrite', 'quickfix', 'help']
let g:diminactive_enable_focus                       = 1

let g:indent_guides_exclude_filetypes                = ['help', 'nerdtree', 'startify', 'quickfix', 'qf']
let g:indent_guides_auto_colors                      = 1
let g:indent_guides_enable_on_vim_startup            = 1

" nerdtree, mundo, tagbar
let g:NERDTreeWinSize = 25
let g:mundo_right     = 1

let g:winresizer_vert_resize    = 1
let g:winresizer_horiz_resize   = 1

let g:gtdown_cycle_states       = ['TODO', 'WIP', 'DONE', 'WAIT', 'CANCELLED']
let g:gtdown_default_fold_level = 2222
let g:gtdown_show_progress      = 1
let g:gtdown_fold_list_items    = 0

" poppy
" au! cursormoved * call PoppyInit()
let g:poppy_point_enable = 1
let g:poppyhigh          = ['MatchParen']
let loaded_matchparen    = 1

" vim current word
let g:vim_current_word#enabled                        = 1
let vim_current_word#highlight_only_in_focused_window = 1
let g:vim_current_word#highlight_twins                = 1
let g:vim_current_word#highlight_current_word         = 1
let g:vim_current_word#highlight_after_delay          = 1

" easymotion
let g:EasyMotion_startofline = 0 " keep cursor column when JK motion

" vim-tmux-navigator
if !has('gui')
  let g:tmux_navigator_no_mappings = 1
endif

" ale syntax checker
let g:ale_echo_msg_error_str   = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format      = '[%linter%] %s [%severity%]'
let g:ale_sign_error           = '>'
let g:ale_sign_warning         = '-'
let g:ale_lint_on_save         = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_sign_column_always   = 1
let g:ale_set_highlights       = 0
let g:ale_linters = {
      \ 'ruby':       ['rubocop'],
      \ 'javascript': ['eslint'],
      \}
let g:ale_fixers = {
      \ 'ruby':       ['rubocop --auto-correct'],
      \ 'javascript': ['eslint'],
      \}
nmap <C-m><C-f> <Plug>(ale_fix)

let g:better_whitespace_filetypes_blacklist=['fzf', 'markdown', 'yaml', 'qf']

let g:AutoPairsShortcutToggle     = ''
let g:AutoPairsShortcutBackInsert = ''
let g:AutoPairsShortcutJump       = ''
let g:AutoPairsShortcutFastWrap   = ''
let g:AutoPairsMapCh              = ''

" completion
let deoplete#tag#cache_limit_size    = 50000000
let g:deoplete#auto_complete_delay   = 2
let g:deoplete#enable_ignore_case    = 0
let g:deoplete#enable_smart_case     = 1
let g:deoplete#enable_at_startup     = 1
let g:deoplete#enable_refresh_always = 1
let g:deoplete#auto_refresh_delay    = 2
let g:deoplete#max_abbr_width        = 0
let g:deoplete#max_menu_width        = 0
let g:deoplete#max_list              = 30
" let g:vimrubocop_config              = '~/.rubocop.yml'
" let g:tern_request_timeout           = 1
" let g:tern_show_signature_in_pum     = '0'

" This is the default extra key bindings
if has('nvim')
  let g:fzf_layout = { 'down': '~40%' }
  let g:fzf_layout = { 'window': 'enew' }
  let g:fzf_layout = { 'window': '-tabnew' }
  let g:fzf_layout = { 'window': '10split enew' }
  let g:fzf_colors =
  \ { 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'Comment'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'border':  ['fg', 'Ignore'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment'] }
  let g:fzf_history_dir = '~/.local/share/fzf-history'
else
  let g:ctrlp_show_hidden  = 1
  let g:ctrlp_cache_dir    = $HOME . '/.cache/ctrlp'
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching  = 0
endif

" Mapping selecting mappings
if(has('nvim'))
  let g:neotags_ctags_timeout = 8
  let g:neotags_ctags_bin = 'ctags'
  let g:neotags_ctags_args = [
        \ '--recurse=yes',
        \ '--sort=yes',
        \ '--fields=+l',
        \ '--c-kinds=+p',
        \ '--c++-kinds=+p',
        \ '--extras=+q',
        \ '--exclude=.git',
        \ '--exclude=node_modules',
        \ '--exclude=dist',
        \ '--exclude=tmp',
        \ '--exclude=.tmp',
        \ ]
  let g:neotags_enabled = 1
  let g:neotags_highlight = 0
  let g:neotags_file = './tags'
  let g:neotags_recursive = 1
  let g:neotags_events_update = ['BufReadPost']

  if has('gui_macvim')
    let test#strategy          = 'iterm'
  elseif has('nvim')
    let test#strategy          = 'neoterm'
  elseif v:version >= 800
    let test#strategy          = 'basic'
  endif
  " neoterm
  let g:neoterm_keep_term_open = 1
  let g:neoterm_run_tests_bg   = 1
  let g:neoterm_position       = 'horizontal'
  let g:neoterm_size           = 16
endif

" **********************************
" augroups

augroup nerdtree
  autocmd!
  autocmd VimEnter *
              \   if !argc()
              \ |   Startify
              \ |   NERDTree
              \ |   wincmd w
              \ | endif
augroup END

augroup yaml-helper
  autocmd!
  autocmd CursorHold *.yml YamlGetFullPath
augroup END

augroup dim-inactive-fix
  autocmd!
  autocmd BufNew * DimInactive
augroup END

augroup remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

augroup insert-mode-tweaks
  autocmd!
  autocmd InsertEnter * highlight CursorLine   guibg=#512121 ctermbg=52
  autocmd InsertEnter * highlight CursorLineNR guibg=#512121
  autocmd InsertLeave * highlight CursorLine   guibg=#343D46 ctermbg=16
  autocmd InsertLeave * highlight CursorLineNR guibg=#343D46
augroup END

augroup color-scheme-tweaks
  autocmd!
  highlight   IncSearch             guifg=#FF0000   guibg=NONE    gui=bold   ctermfg=15   ctermbg=NONE   cterm=bold
  highlight   Search                guifg=#FFFFFF   guibg=NONE    gui=bold   ctermfg=15   ctermbg=NONE   cterm=bold
  highlight   CurrentWordTwins      ctermbg=12      guibg=#363636
  highlight   CurrentWord           ctermbg=14      guibg=#262020
augroup END

command! TODO :call getting_things_down#show_todo()
augroup gtDown
  autocmd BufReadPre TODO.md nmap     <buffer> <silent> <leader>s :call getting_things_down#cycle_status()<CR>
  autocmd BufReadPre TODO.md nnoremap <buffer> <silent> <leader>t :call getting_things_down#toggle_task()<CR>
  autocmd BufReadPre TODO.md vnoremap <buffer> <silent> <leader>t :call getting_things_down#toggle_task()<CR>
  autocmd BufReadPre TODO.md hi! markdownTodoReadyN guifg=#E5C07B
  autocmd BufReadPre TODO.md hi! markdownTodoDoneN guifg=#999999
  autocmd BufReadPre TODO.md hi! markdownTodoWaitingN guifg=#9648AD
augroup END

augroup tab-lengths
  autocmd!
  autocmd Filetype neoterm    setlocal so=0
  autocmd Filetype gitcommit  setlocal cc=72
  autocmd Filetype nerdtree   setlocal ts=2 sts=2 sw=2
augroup END
autocmd BufNewFile,BufRead *.slim setlocal filetype=slim

" **********************************
" custom functions

function! AltCommand(path, vim_command)
  let l:alternate = system("find . -path ./_site -prune -or -path ./target -prune -or -path ./.DS_Store -prune -or -path ./build -prune -or -path ./Carthage -prune -or -path tags -prune -or -path ./tmp -prune -or -path ./log -prune -or -path ./.git -prune -or -type f -print | alt -f - " . a:path)
  if empty(l:alternate)
    echo "No alternate file for " . a:path . " exists!"
  else
    exec a:vim_command . " " . l:alternate
  endif
endfunction

" **********************************
" Plugin related keymaps

" autocomplete
let g:SuperTabDefaultCompletionType = "<C-n>"
imap <C-j>     <Tab>
imap <C-k>     <S-Tab>
imap <C-e>     <Plug>(neosnippet_expand_or_jump)
smap <C-e>     <Plug>(neosnippet_expand_or_jump)
xmap <C-e>     <Plug>(neosnippet_expand_target)

if has('nvim')
  let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit' }
  nnoremap <C-p><C-p> :FZF<CR>
  nnoremap <C-p><C-r> :FZFMru<CR>
  nnoremap <C-p><C-b> :Buffers<CR>
  nnoremap <C-p><C-l> :Lines<CR>

  nmap     <C-k><C-s> <plug>(fzf-maps-n)
  xmap     <C-k><C-s> <plug>(fzf-maps-x)
  omap     <C-k><C-s> <plug>(fzf-maps-o)

  imap     <C-x><C-k> <plug>(fzf-complete-word)
  imap     <C-x><C-f> <plug>(fzf-complete-path)
  imap     <C-x><C-j> <plug>(fzf-complete-file-ag)
  imap     <C-x><C-l> <plug>(fzf-complete-line)
  inoremap <expr> <C-x><C-k> fzf#complete('cat /usr/share/dict/words')
  inoremap <expr> <C-x><C-k> fzf#vim#complete#word({'left': '15%'})
else
  map <C-p><C-r> :CtrlPMRU<CR>
  let g:ctrlp_map = '<C-p><C-p>'
  map <C-p><C-b> :CtrlPBuffer<CR>
endif

" extension windows management
if has('nvim')
  nnoremap <C-k><C-t> :Ttoggle<CR>
endif

nnoremap <C-k><C-u> :MundoToggle<CR>
nnoremap <C-k><C-f> :NERDTreeFind<CR>zz
nnoremap <C-k><C-e> :NERDTreeToggle<CR>

nnoremap <C-k><C-v> :TagbarToggle<CR>

nnoremap <C-g><C-d> :Gdiff<CR>
nnoremap <C-g><C-s> :Gstatus<CR>
nnoremap <C-g><C-b> :Gblame<CR>

" vim move (block of code)
let g:move_key_modifier             = 'C'
let g:winresizer_start_key          = '<C-w>e'
let g:maximizer_default_mapping_key = '<C-w>m'

" Find the alternate file for the current path and open it (basically go to test file)
nnoremap <C-o><C-t> :w<cr>:call AltCommand(expand('%'), ':e')<cr>

" workspace navigation
noremap <leader>2 :WSNext<CR>
noremap <leader>1 :WSPrev<CR>
noremap <leader>! :WSClose<CR>
noremap <leader><space>! :WSClose!<CR>
cabbrev bonly WSBufOnly

" launch test suite
nnoremap <leader>tt :TestNearest<CR>
nnoremap <leader>tf :TestFile<CR>
nnoremap <leader>ta :TestSuite<CR>
nnoremap <leader>tl :TestLast<CR>
nnoremap <leader>tg :TestVisit<CR>


" vim expand region
vmap v <Plug>(expand_region_expand)

" Easymotion
map  <leader><space> <Plug>(easymotion-prefix)
map  <leader>fi      <Plug>(easymotion-sn)
omap <leader>fi      <Plug>(easymotion-tn)
map  <leader>n       <Plug>(easymotion-next)
map  <leader>N       <Plug>(easymotion-prev)
map  <leader>L       <Plug>(easymotion-lineforward)
map  <leader>H       <Plug>(easymotion-linebackward)
map  <leader>.       <Plug>(easymotion-repeat)

let g:ag_highlight=1

" Search projectwide
nnoremap , :Ag!<Space>-Q<Space>''<Left>

" Search selected text project wide (+ possibility to pass path)
vnoremap , y:Ag!<Space>-Q<Space>'<C-r>"'<Space>

" Window navigation
if (has('nvim'))
  :tnoremap <Esc> <C-\><C-n>
  :tnoremap ii    <C-\><C-n>
  :tnoremap <A-h> <C-\><C-n><C-w>h
  :tnoremap <A-j> <C-\><C-n><C-w>j
  :tnoremap <A-k> <C-\><C-n><C-w>k
  :tnoremap <A-l> <C-\><C-n><C-w>l
endif

if !has('gui')
  nnoremap <silent> <M-h> :TmuxNavigateLeft<cr>
  nnoremap <silent> <M-j> :TmuxNavigateDown<cr>
  nnoremap <silent> <M-k> :TmuxNavigateUp<cr>
  nnoremap <silent> <M-l> :TmuxNavigateRight<cr>
  nnoremap <silent> <M-/> :TmuxNavigatePrevious<cr>
endif

" **********************************
" Non plugin related keymaps

" sometimes I just hold shift for too long
cabbrev W   w
cabbrev Wq  wq
cabbrev Wqa wqa
cabbrev Q   q
cabbrev Qa  qa

" disable hls
noremap  <Esc><Esc> :<C-u>nohls<CR>

" close buffer
nnoremap <leader>q :close<CR>

" focus on next search and cursor history jump
nnoremap n     nzz
nnoremap N     Nzz
nnoremap <C-o> <C-o>zz
nnoremap <C-i> <C-i>zz

vnoremap <Tab>   >gv
vnoremap <S-Tab> <gv

" replace word under cursor
nnoremap <leader>F bye:%s/<C-r>"/

" replace selected word
vnoremap <leader>F y:%s/<C-r>"/

" tabs navigation
nnoremap tt :tabnew<CR>
nnoremap TT :tabclose<CR>
nnoremap tl :tabs<CR>

" select whole file, (map old C-a functionality to <leader>a)
nnoremap <C-a>     ggVG
nnoremap <leader>a <C-a>

" system clipboard integration
vnoremap <leader>y "+y
nnoremap <leader>Y "+yg_
nnoremap <leader>y "+y
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Replace currenctly selected text with one from system clipboard
vmap <C-v> x"+P

" treat multiline statement as multiple lines
nnoremap j gj
nnoremap k gk

" split and merge lines
nnoremap <leader>j i<CR><Esc>
nnoremap <leader>k <esc>kJ

" Esc key mappings
inoremap ii <Esc>
vnoremap ii <Esc>

" begin and end of line
map <leader>h ^
map <leader>l $

if has("gui_macvim")
  set guifont=Code\ New\ Roman\ Nerd\ Font\ Complete\ Mono:h18
  set guioptions-=m  "remove menu bar
  set guioptions-=T  "remove toolbar
  set guioptions-=r  "remove right-hand scroll bar
  set guioptions-=L  "remove left-hand scroll bar
  set guioptions-=e  "remove left-hand scroll bar
endif
