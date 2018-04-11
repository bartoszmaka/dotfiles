filetype off
call plug#begin('~/.vim/plugged')

"autocomplete
if has('nvim')
  Plug 'Shougo/deoplete.nvim',    { 'do': ':UpdateRemotePlugins' } " autocompletion engine
  Plug 'kassio/neoterm'                                           " terminal provider
else
  Plug 'Shougo/deoplete.nvim'                                     " autocompletion engine
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'Shougo/echodoc.vim'                 " displays function signatures from completions in the command line.

"fuzzy
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'pbogut/fzf-mru.vim'

Plug 'mhinz/vim-grepper'

Plug 'ludovicchabant/vim-gutentags'
Plug 'tpope/vim-fugitive'                                         " git related commands
Plug 'rking/ag.vim'                                               " searching engine
Plug 'w0rp/ale'                                                   " async syntax checking
Plug 'terryma/vim-multiple-cursors'

Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neoinclude.vim'                                      " extends deoplete
Plug 'ervandew/supertab'                                          " select autocompletion with tab
Plug 'jiangmiao/auto-pairs'                                       " auto insert parentheses, quotes etc.
Plug 'tpope/vim-endwise'                                          " auto insert 'end', 'endif' etc.
Plug 'tpope/vim-surround'                                         " vim verb for surrounding word
Plug 'tpope/vim-commentary'                                       " change selected code into comment
Plug 'tpope/vim-repeat'                                           " better .
Plug 'easymotion/vim-easymotion'                                  " adds improved w e b j k
Plug 'alvan/vim-closetag'                                         " autoclose html tag
Plug 'godlygeek/tabular', { 'on': 'Tabularize' }                  " text align with regexp
Plug 'janko-m/vim-test'                                           " test launcher
Plug 'bartoszmaka/vim_current_word'                               " highlight word under cursor
Plug 'AndrewRadev/splitjoin.vim'
Plug 'rhysd/clever-f.vim'

" UI extensions
Plug 'bagrat/vim-workspace'                                       " IDE like tabs management
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }                " perview file structure
Plug 'simnalamburt/vim-mundo', { 'on': 'MundoToggle' }            " perview undos
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
Plug 'ryanoasis/vim-devicons'                                     " Fancy icons
Plug 'junegunn/vim-peekaboo'

" language specific 

Plug 'elixir-editors/vim-elixir',        { 'for': ['elixir', 'eelixir'] }
Plug 'slashmili/alchemist.vim',          { 'for': ['elixir', 'eelixir'] }
" Plug 'gasparch/vim-ide-elixir',          { 'for': ['elixir', 'eelixir'] }
Plug 'kchmck/vim-coffee-script',         { 'for': ['javascript'] }
Plug 'maksimr/vim-jsbeautify',           { 'for': ['javascript', 'javascript.jsx', 'html', 'css' ] }
Plug 'aliou/sql-heredoc.vim'
Plug 'rlue/vim-getting-things-down',     { 'for': ['markdown'] }
Plug 'Shougo/neco-vim',                  { 'for': ['vim'] }
Plug 'lmeijvogel/vim-yaml-helper',       { 'for': ['yaml'] }
Plug 'pangloss/vim-javascript',          { 'for': ['javascript', 'javascript.jsx'] }
Plug 'MaxMEllon/vim-jsx-pretty',         { 'for': ['javascript', 'javascript.jsx'] }
Plug 'fishbullet/deoplete-ruby',         { 'for': ['ruby'] }

" Plug 'romainl/vim-cool'
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
if has('nvim') && has('mac')
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
set synmaxcol=180                       " disable syntax colors after given column
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
let g:workspace_powerline_separators = 1
let g:webdevicons_enable                             = 1
let g:webdevicons_enable_nerdtree                    = 0
let g:WebDevIconsNerdTreeAfterGlyphPadding           = ''
let g:airline_powerline_fonts                        = 1
let g:airline#extensions#tabline#buffer_idx_mode     = 1
let g:airline#extensions#tabline#enabled             = 1
let g:airline#extensions#branch#enabled              = 1
let g:airline#extensions#branch#format               = 2
let g:airline#extensions#branch#displayed_head_limit = 15
let g:airline#extensions#tagbar#enabled              = 1
let g:airline#extensions#hunks#enabled               = 1
let g:gitgutter_map_keys                             = 0
let g:gitgutter_sign_added                           = '+'
let g:gitgutter_sign_modified                        = '.'
let g:gitgutter_sign_removed                         = '-'
let g:gitgutter_sign_removed_first_line              = '-'
let g:gitgutter_sign_modified_removed                = '.'

let g:diminactive_buftype_blacklist                  = ['nofile', 'nowrite', 'acwrite', 'quickfix', 'help']
let g:diminactive_enable_focus                       = 1

let g:indent_guides_exclude_filetypes                = ['help', 'nerdtree', 'quickfix', 'qf']
let g:indent_guides_auto_colors                      = 1
let g:indent_guides_enable_on_vim_startup            = 1

" nerdtree, mundo, tagbar
let g:NERDTreeWinSize = 35
let g:mundo_right     = 1

let g:winresizer_vert_resize    = 1
let g:winresizer_horiz_resize   = 1

let g:gtdown_cycle_states       = ['TODO', 'WIP', 'DONE', 'WAIT', 'CANCELLED']
let g:gtdown_default_fold_level = 2222
let g:gtdown_show_progress      = 1
let g:gtdown_fold_list_items    = 0

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
let g:ale_sign_error           = '->'
let g:ale_sign_warning         = '::'
let g:ale_lint_on_save         = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_sign_column_always   = 1
let g:ale_set_highlights       = 0
let g:ale_fixers = {
      \ 'ruby':       ['remove_trailing_lines', 'trim_whitespace'],
      \ 'javascript': ['remove_trailing_lines', 'trim_whitespace', 'eslint'],
      \ 'vim':        ['remove_trailing_lines', 'trim_whitespace'],
      \}
" let g:ale_linters = {'jsx': ['stylelint', 'eslint']}
" let g:ale_linter_aliases = {'jsx': 'css'}

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
let g:deoplete#max_menu_width        = 50
let g:deoplete#max_list              = 30

let g:fzf_command_prefix = 'Fzf'
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
" Customize fzf colors to match your color scheme
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

let g:gutentags_ctags_exclude = ["node_modules", ".git"]

if has('gui_macvim')
  let test#strategy          = 'iterm'
elseif has('nvim')
  let test#strategy          = 'neoterm'
endif

if(has('nvim'))
  let g:neosnippet#snippets_directory='~/repos/dotfiles/vimsnippets'
  let g:neosnippet#scope_aliases = {}
  let g:neosnippet#scope_aliases['javascript'] = 'html,javascript'
  let g:neosnippet#scope_aliases['ruby'] = 'html,ruby'

  " neoterm
  let g:neoterm_keep_term_open = 1
  let g:neoterm_run_tests_bg   = 1
  let g:neoterm_position       = 'horizontal'
  let g:neoterm_size           = 16
endif
" closetag config
let g:closetag_filenames               = '*.html,*.xhtml,*.phtml,*.js,*.jsx,*.erb,*.eex'
let g:closetag_xhtml_filenames         = '*.xhtml,*.jsx,*.js,*.erb,*.eex'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_shortcut                = '>'
" let g:CoolTotalMatches = 1
" **********************************

augroup tweak-hls
  autocmd!
  autocmd InsertEnter * setlocal nohls
augroup END

augroup fix-filetypes
  autocmd!
  autocmd BufNewFile,BufRead .eslintrc  setlocal filetype=json
  autocmd BufNewFile,BufRead *.slim     setlocal filetype=slim
  autocmd BufNewFile,BufRead *.js,*.jsx setlocal filetype=javascript.jsx
augroup END

augroup nerdtree
  autocmd!
  autocmd VimEnter *
        \   if !argc()
        \ |   NERDTree
        \ |   wincmd w
        \ | endif
        \ | set list
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

augroup gtDown
  autocmd!
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

command! TODO :call getting_things_down#show_todo()
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
noremap <leader>] :WSNext<CR>
noremap <leader>[ :WSPrev<CR>
noremap <leader>! :WSClose<CR>
noremap <leader><space>! :WSClose!<CR>
cabbrev bonly WSBufOnly
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

" launch test suite
nnoremap <leader>tt :TestNearest<CR>
nnoremap <leader>tf :TestFile<CR>
nnoremap <leader>ta :TestSuite<CR>
nnoremap <leader>tl :TestLast<CR>
nnoremap <leader>tg :TestVisit<CR>
nnoremap <leader>to :w<cr>:call AltCommand(expand('%'), ':e')<cr>

let g:ag_highlight=1
let g:splitjoin_split_mapping = ''
let g:splitjoin_join_mapping  = ''

" easymotion
" nmap <leader>w <Plug>(easymotion-w)
" nmap <leader>b <Plug>(easymotion-b)
" nmap <leader>e <Plug>(easymotion-e)

" list mappings
nnoremap <C-k><C-s> :FzfMaps<CR>

" popup fuzzy finders
nnoremap <C-p><C-p> :FZF<CR>
nnoremap <C-p><C-r> :FZFFreshMru<CR>
nnoremap <C-p><C-g> :FzfGitFiles<CR>
nnoremap <C-p><C-h> :FzfHistory<CR>
nnoremap <C-p><C-b> :FzfBuffers<CR>
nnoremap <C-p><C-f> :FzfAg<CR>
nnoremap <C-p><C-l> :FzfLines<CR>
nnoremap <C-p><C-v> :FzfCommits<CR>
nnoremap <C-p><C-w> :FzfWindows<CR>

" ALE actions
nnoremap <C-m><C-g> :Grepper<CR>
nnoremap <C-m><C-f> :ALEFix<CR>
nnoremap <C-m><C-l> :ALELint<CR>
nnoremap <C-m><C-w> :set list!<CR>

nnoremap <C-m><C-d> :SplitjoinJoin<cr>
nnoremap <C-m><C-s> :SplitjoinSplit<cr>

" splitjoin

let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-c>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'
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

" **********************************
" Non plugin related keymaps

" sometimes I just hold shift for too long
cabbrev W   w
cabbrev Wa   w
cabbrev Wq  wq
cabbrev Wqa wqa
cabbrev Q   q
cabbrev Qa  qa
cabbrev Q!   q
cabbrev Qa!  qa

" disable hls
" noremap  <Esc><Esc> :<C-u>nohls<CR>

" close buffer
nnoremap <leader>q :close<CR>

" focus on next search and cursor history jump
nnoremap n     :setlocal hls<CR>nzz
nnoremap N     :setlocal hls<CR>Nzz
nnoremap <C-o> <C-o>zz
nnoremap <C-i> <C-i>zz

vnoremap <Tab>   >gv
vnoremap <S-Tab> <gv

" replace word under cursor
nnoremap <leader>r bye:%s/<C-r>"/

" replace selected word
vnoremap <leader>r y:%s/<C-r>"/

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

" treat multiline statement as multiple lines
nnoremap j gj
nnoremap k gk

" split and merge lines
nnoremap <leader>j i<CR><Esc>
nnoremap <leader>k <esc>kJ

" begin and end of line
map <leader>h ^
map <leader>l $

if has("gui_macvim")
  set guifont=Hasklug\ Nerd\ Font\ Complete:h18
  set guioptions-=m  "remove menu bar
  set guioptions-=T  "remove toolbar
  set guioptions-=r  "remove right-hand scroll bar
  set guioptions-=L  "remove left-hand scroll bar
  set guioptions-=e  "remove left-hand scroll bar
endif
