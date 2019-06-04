filetype off
call plug#begin()
Plug 'sheerun/vim-polyglot'
Plug 'Yggdroot/indentLine'
Plug 'joshdick/onedark.vim'                                        " colorscheme
Plug 'bling/vim-airline'                                           " UI improvement
Plug 'vim-airline/vim-airline-themes'                              " themes for airline
Plug 'machakann/vim-highlightedyank'                               " highlight yanked code

Plug 'tpope/vim-commentary'                                        " change selected code into comment
Plug 'tpope/vim-repeat'                                            " better .
Plug 'easymotion/vim-easymotion'                                   " adds improved w e b j k
Plug 'rhysd/clever-f.vim'                                          " better f F

if exists('$TMUX')
  Plug 'christoomey/vim-tmux-navigator'                            " move between vim windows and tmux panes with the same mapping
  Plug 'christoomey/vim-tmux-runner'                               " run tests in other tmux pane
  Plug 'roxma/vim-tmux-clipboard'                                  " sync with tmux clipboard
endif

Plug 'andymass/vim-matchup',    { 'commit': 'afd7a6b' }
Plug 'Valloric/MatchTagAlways', { 'commit': '352eb47' }
Plug 'tpope/vim-fugitive'                                          " git related commands
Plug 'airblade/vim-gitgutter'                                      " shows git signs next to line numbers
Plug 'dominikduda/vim_current_word', { 'branch': 'development' }   " highlight word under cursor
Plug 'AndrewRadev/splitjoin.vim'                                   " split to multiple lines
Plug 'terryma/vim-multiple-cursors'                                " multiple cursors
Plug 'scrooloose/nerdtree'                                         " project explorer
Plug 'jistr/vim-nerdtree-tabs'                                     " better behavior for nerdtree
" Plug 'Xuyuanp/nerdtree-git-plugin'                                 " nerdTree git integration
Plug 'tsony-tsonev/nerdtree-git-plugin'                              " nerdTree git integration
Plug 'tveskag/nvim-blame-line'

Plug 'szw/vim-maximizer'                                           " maximize window
Plug 'simeji/winresizer'                                           " window resize helper
Plug 'godlygeek/tabular',               { 'on': 'Tabularize' }     " text align with regexp
Plug 'majutsushi/tagbar',               { 'on': 'TagbarToggle' }   " preview file structure
Plug 'simnalamburt/vim-mundo',          { 'on': 'MundoToggle' }    " purview undos
Plug 'tpope/vim-abolish'
Plug 'osyo-manga/vim-anzu'
Plug 'ap/vim-css-color'
Plug 'vim-scripts/copypath.vim'
Plug 'tpope/vim-surround'                                          " vim verb for surrounding word

Plug 'junegunn/fzf',                    { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'bartoszmaka/fzf-mru.vim'

Plug 'dyng/ctrlsf.vim'                                             " search projectwide but with different plugin :D
Plug 'mhinz/vim-grepper'                                           " search projectwide

Plug 'jiangmiao/auto-pairs'                                        " auto insert parentheses, quotes etc.
Plug 'tpope/vim-endwise'                                           " auto insert 'end', 'endif' etc.
Plug 'alvan/vim-closetag'                                          " autoclose html tag

" completion engine
if has('nvim')
  Plug 'Shougo/deoplete.nvim',          { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'                                      " autocompletion engine
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" completion sources
Plug 'Shougo/neosnippet'
Plug 'wellle/tmux-complete.vim'
Plug 'Shougo/neoinclude.vim'                                       " extends deoplete
Plug 'carlitux/deoplete-ternjs',        { 'for': ['javascript', 'javascript.jsx', 'typescript', 'html', 'coffee', 'eruby', 'css'], 'do': 'npm install -g tern' }
Plug 'tbodt/deoplete-tabnine',          { 'do': './install.sh' }
Plug 'autozimu/LanguageClient-neovim',  { 'branch': 'next', 'do': 'bash install.sh' }
Plug 'Shougo/neco-vim',                 { 'for': ['vim'] }

Plug 'ludovicchabant/vim-gutentags'                                " ctags engine
Plug 'w0rp/ale'                                                    " async syntax checking
Plug 'mattn/emmet-vim'

Plug 'lmeijvogel/vim-yaml-helper',      { 'for': ['yaml'] }

Plug 'tpope/vim-bundler',               { 'for': ['ruby', 'eruby'] }
Plug 'tpope/vim-rails',                 { 'for': ['ruby', 'eruby'] }
Plug 'tpope/vim-rake',                  { 'for': ['ruby', 'eruby'] }
Plug 'vim-ruby/vim-ruby',               { 'for': ['ruby', 'eruby'] }
Plug 'tpope/vim-projectionist'
Plug 'moll/vim-node',                   { 'for': ['javascript', 'javascript.jsx', 'typescript', 'html', 'coffee', 'eruby', 'css'] }

" Plug 'mhartington/nvim-typescript',     { 'for': ['typescript', 'html', 'coffee', 'eruby', 'css'], 'do': './install.sh' }
" Plug 'HerringtonDarkholme/yats.vim',    { 'for': ['typescript', 'html', 'coffee', 'eruby', 'css'] }
Plug 'MaxMEllon/vim-jsx-pretty',        { 'for': ['javascript', 'javascript.jsx', 'typescript', 'html', 'coffee', 'eruby', 'css'] }
" Plug 'pangloss/vim-javascript',         { 'for': ['javascript', 'javascript.jsx', 'typescript', 'html', 'coffee', 'eruby', 'css'] }
" Plug 'yardnsm/vim-import-cost',         { 'for': ['javascript', 'javascript.jsx', 'typescript', 'html', 'coffee', 'eruby', 'css'], 'do': 'npm install -g import-cost' }
" Plug 'bartoszmaka/vim-import-js',       { 'for': ['javascript', 'javascript.jsx', 'typescript', 'html', 'coffee', 'eruby', 'css'], 'do': 'npm install -g import-js' }
" Plug 'dunckr/js_alternate.vim',         { 'for': ['javascript', 'javascript.jsx', 'typescript', 'html', 'coffee', 'eruby', 'css'] }

" Plug 'rhysd/vim-crystal',               { 'for': ['crystal'] }
Plug 'chrisbra/csv.vim',                { 'for': ['csv'] }
Plug 'TaDaa/vimade'
call plug#end()

" **********************************
" vim variables
syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins
let mapleader="\<Space>"

" Use brew/apt installed python instead of venv or osx default
if has('nvim') && has('mac')
  let g:python_host_prog  = '/usr/local/bin/python2'
  let g:python3_host_prog = '/usr/local/bin/python3'
else
  let g:python_host_prog  = '/usr/bin/python2'
  let g:python3_host_prog = '/usr/bin/python3'
endif
" meta
set autoread
syntax sync minlines=256
set undofile                            " keep history in file
set undodir=$HOME/.vim/undo             " path for this file
set grepprg=ag
set noswapfile
set directory=/tmp
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
set completeopt=longest,menuone,noinsert,noselect
set backspace=indent,eol,start
set pumheight=15
set spellsuggest=best,8
set signcolumn=yes

" indent
set smartindent

" window management
set scrolloff=4                         " show at least 4 lines above or under cursor
set sidescrolloff=15
set splitright                          " place new vertical split on right side of current window
set splitbelow                          " place new horizontal split under current window
set diffopt+=vertical

" tabulator
set softtabstop=2
set shiftwidth=2                        " default tab width
set expandtab                           " Spaces instead of tabs

" line length
set synmaxcol=350                       " disable syntax colors after given column
set colorcolumn=81                      " color 120th column
set showbreak=\/_
set nowrap                              " don't wrap lines

" searching
set ignorecase
set smartcase

" ui
set noshowmode                          " do not display current mode in cmdline (airline already handles it)
set listchars=
      \eol:$,
      \tab:>-,
      \trail:~,
      \extends:>,
      \precedes:< " define how whitespaces will be displayed
set list                                " show whitespaces
set mouse=a
set showcmd                             " show pressed keys
set number                              " show line numbers
set title
set cursorline

" **********************************
" related with enabling italic text
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"

if (has("termguicolors"))
  set termguicolors
endif

colorscheme onedark
let g:airline_theme = 'onedark'
set fillchars+=stl:\ ,stlnc:\ ,vert:\│

" **********************************
" plugin variables
let g:loaded_matchit = 1

" airline
set statusline+=%{gutentags#statusline()}
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_section_z                              = '%2p%% %3l:%2c'
let g:airline_section_b                              = ''
let g:airline_section_c                              = '%{expand("%:F")}'
let g:airline#parts#ffenc#skip_expected_string       = 'utf-8[unix]'
let g:airline#extensions#branch#enabled              = 1
let g:airline#extensions#branch#format               = 2
let g:airline#extensions#branch#displayed_head_limit = 15
let g:airline#extensions#tagbar#enabled              = 1
let g:airline#extensions#hunks#enabled               = 1
let g:airline#extensions#tabline#enabled             = 1
let g:airline#extensions#tabline#show_tabs           = 0
let g:airline#extensions#tabline#show_close_button   = 0
let g:airline#extensions#tabline#tab_nr_type         = 2
let g:airline_symbols.linenr                         = ''
let g:airline_symbols.maxlinenr                      = ''
let g:airline_symbols.readonly                       = '🔒'
let g:airline_symbols.spell                          = 'Ꞩ'
let g:airline_symbols.whitespace                     = 'Ξ'
let g:airline#extensions#anzu#enabled                = 0
let g:airline#extensions#tabline#buffer_idx_mode     = 1
let g:anzu_status_format                             = "%#Search#▶%p◀ (%i/%l)"
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

" vimade
let g:vimade = {}
let g:vimade.fadelevel = 0.7

" gitgutter
let g:gitgutter_map_keys = 0

" jsxpretty
let g:vim_jsx_pretty_colorful_config = 1

" nerdtree
highlight! NERDTreeOpenable ctermfg=132 guifg=#D19A66
highlight! def link NERDTreeClosable NERDTreeOpenable
let g:NERDTreeWinSize                   = 36
let g:NERDTreeMinimalUI                 = 1
let g:NERDTreeStatusline                = ""
let g:NERDTreeGitStatusNodeColorization = 1
let g:NERDTreeGitStatusWithFlags        = 0
let g:NERDTreeDirArrowExpandable        = ''
let g:NERDTreeDirArrowCollapsible       = ''
let g:NERDTreeColorMapCustom = {
    \ "Dirty"     : "#299999",
    \ "Modified"  : "#CC6666",
    \ "Untracked" : "#CC6666",
    \ "Staged"    : "#29DD29",
    \ "Clean"     : "#00FF00",
    \ "Ignored"   : "#AAAAAA"
    \ }

" mundo
let g:mundo_right = 1

" tagbar
let g:tagbar_type_ruby = {
    \ 'kinds'      : ['m:modules',
                    \ 'c:classes',
                    \ 'C:constants',
                    \ 'F:singleton methods',
                    \ 'f:methods',
                    \ 'a:aliases'],
    \ 'kind2scope' : { 'c' : 'class',
                     \ 'm' : 'class' },
    \ 'scope2kind' : { 'class' : 'c' },
    \ 'ctagsbin'   : 'ripper-tags',
    \ 'ctagsargs'  : ['-f', '-']
    \ }

" guntentags
autocmd BufWritePost *.rb silent exec "!ripper-tags -R --exclude=vendor --tag-file=./ripper-tags"
autocmd FileType ruby,eruby setlocal tags+=./ripper-tags
let g:gutentags_ctags_exclude = [
      \ "node_modules",
      \ ".git",
      \ "client/node_modules",
      \ "client/package.json",
      \ "client/package-lock.json",
      \ "client/coverage",
      \ "public",
      \ "bin",
      \ "log",
      \ "app/assets",
      \ "spec/fixtures",
      \ ]

" winresizer
let g:winresizer_vert_resize    = 1
let g:winresizer_horiz_resize   = 1

" vimcurrentword
let g:vim_current_word#enabled                        = 1
let g:vim_current_word#highlight_only_in_focused_window = 1
let g:vim_current_word#highlight_twins                = 1
let g:vim_current_word#highlight_current_word         = 1
let g:vim_current_word#highlight_after_delay          = 1

" easymotion
let g:EasyMotion_startofline = 0 " keep cursor column when JK motion

" MatchTagAlways
let g:mta_use_matchparen_group       = 0
let g:mta_set_default_matchtag_color = 0
let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'eruby' : 1,
    \ 'javascript.jsx' : 1,
    \ 'html.handlebars' : 1,
    \}

" autopairs
let g:AutoPairsShortcutToggle     = ''
let g:AutoPairsShortcutBackInsert = ''
let g:AutoPairsShortcutJump       = ''
let g:AutoPairsShortcutFastWrap   = ''
let g:AutoPairsMapCh              = ''
let g:ag_highlight=1

" closetag
let g:closetag_filenames               = '*.html,*.xhtml,*.phtml,*.js,*.jsx,*.erb,*.eex,*.hbs'
let g:closetag_xhtml_filenames         = '*.xhtml,*.jsx,*.js,*.erb,*.eex'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_shortcut                = '>'

" matchup
let g:matchup_matchparen_status_offscreen   = 1
let g:matchup_matchparen_deferred           = 1
let g:matchup_matchparen_hi_surround_always = 1
let g:matchup_transmute_enabled             = 0

" polyglot
let g:polyglot_disabled = ['jsx']

" ruby
let g:rubycomplete_buffer_loading    = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails             = 1
let g:rubycomplete_load_gemfile      = 1
let g:rubycomplete_use_bundler       = 1

" splitjoin
let g:splitjoin_split_mapping     = ''
let g:splitjoin_join_mapping      = ''
let g:splitjoin_ruby_curly_braces = 0
let g:splitjoin_ruby_hanging_args = 0

" multiplecursors
let g:multi_cursor_exit_from_insert_mode = 0

" languageclient
let g:LanguageClient_autoStop = 0
let g:LanguageClient_diagnosticsEnable = 0
let g:LanguageClient_serverCommands = {
    \ 'ruby': ['solargraph', 'stdio'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['javascript-typescript-stdio'],
    \ 'python': ['/usr/local/bin/pyls'],
    \ }
let g:LanguageClient_loadSettings = 1

" deoplete
call deoplete#custom#option({
      \ 'auto_complete_delay': 5,
      \ 'min_pattern_length': 1,
      \ })
let g:deoplete#enable_at_startup= 1
call deoplete#custom#source('LanguageClient', 'rank', 1200)
call deoplete#custom#source('LanguageClient', 'max_abbr_width', 40)
call deoplete#custom#source('file', 'rank', 1100)
call deoplete#custom#source('tabnine', 'rank', 1000)
call deoplete#custom#option('max_list', 80)

" neosnippet
let g:neosnippet#disable_runtime_snippets = {
      \   '_' : 1,
      \ }
let g:neosnippet#snippets_directory='~/.repos/dotfiles/vim/vimsnippets'
let g:neosnippet#scope_aliases = {}
let g:neosnippet#scope_aliases['javascript'] = 'html,javascript,javascript.jsx'

" ale
let g:ale_virtualtext_cursor   = 1
let g:ale_virtualtext_delay    = 100
let g:ale_echo_msg_error_str   = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format      = '[%linter%] %s [%severity%]'
let g:ale_sign_error           = '🚨'
let g:ale_sign_warning         = '🤔'
let g:ale_lint_on_save         = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_sign_column_always   = 1
let g:ale_set_highlights       = 1
let g:ale_fixers = {
      \ 'ruby':           ['remove_trailing_lines', 'trim_whitespace', 'rubocop'],
      \ 'javascript':     ['eslint', 'importjs'],
      \ 'javascript.jsx': ['eslint', 'importjs'],
      \ 'vim':            ['remove_trailing_lines', 'trim_whitespace'],
      \ 'json':           ['jq'],
      \ 'python':         ['yapf'],
      \}
let g:ale_linters = {
      \ 'ruby':           ['rubocop'],
      \ 'javascript':     ['eslint'],
      \ 'json':           ['jq'],
      \ 'python':         ['pyls', 'autopep8', 'yapf'],
      \}
let g:ale_linter_aliases = {'jsx': 'css'}

" fzf
let g:fzf_command_prefix = 'Fzf'
let g:fzf_layout = { 'down': '~25%' }
let g:fzf_mru_relative = 1
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
" **********************************

" custom functions
function! RemoveTernPortIfExists()
  if !empty(glob(join([getcwd(), ".tern-port"], "/")))
    echo ".tern-port exists, deleting with result:"
    echo delete(fnameescape(join([getcwd(), ".tern-port"], "/"))) == 0 ? "Success" : "Fail"
  endif
endfunction
autocmd VimEnter * :call RemoveTernPortIfExists()

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

" Go to alternative file
function! AltCommand(path, vim_command)
  let l:alternate = system("find . -path ./_site -prune -or -path ./target -prune -or -path ./.DS_Store -prune -or -path ./build -prune -or -path ./Carthage -prune -or -path tags -prune -or -path ./tmp -prune -or -path ./log -prune -or -path ./.git -prune -or -type f -print | alt -f - " . a:path)
  if empty(l:alternate)
    call A
    " echo "No alternate file for " . a:path . " exists!"
  else
    exec a:vim_command . " " . l:alternate
  endif
endfunction

" https://github.com/Shougo/deoplete.nvim/issues/162
function! Multiple_cursors_before()
  call deoplete#disable()
  let b:deoplete_disable_auto_complete = 1
  let g:matchup_matchparen_enabled = 0
endfunction

function! Multiple_cursors_after()
  call deoplete#enable()
  let b:deoplete_disable_auto_complete = 0
  let g:matchup_matchparen_enabled = 1
endfunction

function! TweakedDiffPut()
  :diffput 1
  :diffupdate
endfunction

function! GoToOrCreateRightWindow()
  execute "only"
  execute "normal! \<C-w>v"
endfunction

function! ToggleScrollBind()
  if exists("g:scroll_bind_endabled") && g:scroll_bind_endabled
    let g:scroll_bind_endabled = 0
    :set noscrollbind
    :wincmd w
    :set noscrollbind
    :q!
    :wincmd w
  else
    let g:scroll_bind_endabled = 1
    :vs
    call feedkeys("\<C-f>\<C-e>\<C-e>", 'tx')
    :set scrollbind
    :wincmd w
    :set scrollbind
  endif
endfunction

function! DisableAllHeavyStuff()
  setlocal syntax off
  setlocal nospell
  call AleDisable()
  let b:deoplete_disable_auto_complete = 1
endfunction
" **********************************

" augroups
augroup filetype-scoped-settings
  autocmd!
  autocmd FileType json syntax region jsonKeyword matchgroup=jsonQuote start=/"/  end=/"\ze[[:blank:]\r\n]*\:/ contained
  autocmd FileType json syntax region jsonString oneline matchgroup=jsonQuote start=/"/  skip=/\\\\\|\\"/  end=/"/ contains=jsonEscape contained
  autocmd FileType json setlocal conceallevel=2
  autocmd FileType ruby,eruby compiler ruby
  autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
  autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
  autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
  autocmd Filetype gitcommit  setlocal colorcolumn=73 spell
  autocmd Filetype nerdtree   setlocal tabstop=2 softtabstop=2 shiftwidth=2 signcolumn=no
  autocmd Filetype nerdtree   VimadeBufDisable
  autocmd BufEnter,BufReadPre,BufNewFile *.md
        \ setlocal conceallevel=0
  autocmd Filetype fzf
        \ tnoremap <silent> <C-f> <C-\><C-n>:MaximizerToggle<CR>a
  autocmd CursorHold *.yml YamlGetFullPath
augroup END

" for some reason, those have to be outside the group
autocmd FileType vim,tex
      \ let [
      \ b:matchup_matchparen_fallback,
      \ b:matchup_matchparen_enabled]
      \ = [0, 0]
autocmd QuickFixCmdPost wincmd J
autocmd! FileType fzf
autocmd  FileType fzf
      \  set laststatus=0 noshowmode noruler signcolumn=no
      \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" let blamelineFiletypesBlacklist = ['fugitiveblame', 'help', 'qf']
" autocmd BufReadPost * if index(blamelineFiletypesBlacklist, &ft) < 0 | EnableBlameLine

augroup disable-syntax-for-huge-files
  autocmd!
  autocmd BufReadPre * if getfsize(@%) > 1000000 | call DisableAllHeavyStuff() | endif
augroup END

augroup remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

augroup color-scheme-tweaks
  autocmd!
  autocmd InsertEnter * set cursorcolumn
  autocmd CursorMoved,CursorHold,InsertLeave * set nocursorcolumn
  autocmd InsertEnter * highlight CursorLine   guibg=#512121
  autocmd InsertEnter * highlight CursorLineNR guibg=#512121
  autocmd InsertLeave * highlight CursorLine   guibg=#343D46
  autocmd InsertLeave * highlight CursorLineNR guibg=#343D46

  highlight CursorColumn     guibg=#512121
  highlight CursorColumnNR   guibg=#512121
  highlight IncSearch        guifg=#FF0000   guibg=NONE    gui=bold
  highlight Search           guifg=#FFFFFF   guibg=NONE    gui=bold
  highlight TabLineSel       guifg=#E5C07B
  highlight MatchTag         guibg=#4d4d4d   gui=bold
  highlight MatchWord        guibg=#4d4d4d   gui=bold

  highlight CurrentWordTwins guibg=#363636   gui=bold
  highlight CurrentWord      guibg=#222200   gui=bold

  highlight ALEWarning            guibg=#512121
  highlight ALEError              guibg=#512121

  highlight Comment          gui=italic,bold
augroup END
" **********************************

" Plugin related keymaps
nnoremap <leader>a :A<CR>
nnoremap <leader>A :call GoToOrCreateRightWindow()<CR>:A<CR>
nnoremap <leader>S :call ToggleScrollBind()<CR>

" MatchTagAlways
nnoremap <leader>% :MtaJumpToOtherTag<CR>

" vim-repeat
silent! call repeat#set("\<Plug>.", v:count)

" easymotion
map ,f        <Plug>(easymotion-bd-f)
map ,w        <Plug>(easymotion-bd-w)
map ,e        <Plug>(easymotion-bd-e)
map ,b        <Plug>(easymotion-bd-w)
map ,W        <Plug>(easymotion-bd-W)
map ,E        <Plug>(easymotion-bd-E)
map ,B        <Plug>(easymotion-bd-W)
map <leader>n <Plug>(easymotion-bd-n)
map <leader>N <Plug>(easymotion-bd-n)
nmap s        <Plug>(easymotion-overwin-f2)

" neosnippet
imap <expr><c-e>
  \ neosnippet#expandable_or_jumpable() ?
  \ "\<Plug>(neosnippet_expand_or_jump)" :
  \ "\<C-y>,"

" languageclient
nnoremap K :call LanguageClient#textDocument_hover()<CR>
nnoremap <C-m><C-m> :call LanguageClient_contextMenu()<CR>
nnoremap <C-m><C-d> :call LanguageClient#textDocument_definition()<CR>
nnoremap <C-m><C-r> :call LanguageClient#textDocument_rename()<CR>

inoremap <expr><TAB>   pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"

" tabular
vnoremap <C-m><C-t> :Tabularize /

vnoremap <C-m><C-s> :sort<CR>

" tools windows management
let g:winresizer_start_key          = '<C-w>e'
let g:maximizer_default_mapping_key = '<C-w>m'
nnoremap <C-k><C-u> :MundoToggle<CR>
nnoremap <C-k><C-f> :NERDTreeFind<CR>zz
nnoremap <C-k><C-e> :NERDTreeToggle<CR>
nnoremap <C-k><C-s> :CtrlSFToggle<CR>
nnoremap <C-k><C-v> :TagbarToggle<CR>
nnoremap <C-g><C-b> :Gblame<CR>
nnoremap <C-g><C-d> :Gdiff<CR>

" Find the alternate file for the current path and open it (basically go to test file)
nnoremap <C-g><C-t> :w<cr>:call AltCommand(expand('%'), ':e')<cr>
nnoremap <leader>to :w<cr>:call AltCommand(expand('%'), ':e')<cr>

" workspace navigation
noremap <M-}>               :bnext<CR>
noremap <M-{>               :bprevious<CR>
noremap <leader>]           :bnext<CR>
noremap <leader>[           :bprevious<CR>
nnoremap <silent> <leader>w :bp<bar>sp<bar>bn<bar>bd<CR>
noremap <leader><space>!    :bdelete!<CR>

" airline
nmap    <leader>1           <Plug>AirlineSelectTab1
nmap    <leader>2           <Plug>AirlineSelectTab2
nmap    <leader>3           <Plug>AirlineSelectTab3
nmap    <leader>4           <Plug>AirlineSelectTab4
nmap    <leader>5           <Plug>AirlineSelectTab5
nmap    <leader>6           <Plug>AirlineSelectTab6
nmap    <leader>7           <Plug>AirlineSelectTab7
nmap    <leader>8           <Plug>AirlineSelectTab8
nmap    <leader>9           <Plug>AirlineSelectTab9

" fzf
command! -bang -nargs=? -complete=dir FZFFilesPreview
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
nnoremap <C-p><C-p> :FZFFilesPreview<CR>
nnoremap <C-p><C-r> :FZFFreshMruPreview<CR>
nnoremap <C-p><C-g> :FzfGitFiles?<CR>
nnoremap <C-p><C-h> :FzfHistory<CR>
nnoremap <C-p><C-b> :FzfBuffers<CR>
nnoremap <C-p><C-f> :FzfAg<CR>
nnoremap <C-p><C-l> :FzfLines<CR>
nnoremap <C-p><C-v> :FzfCommits<CR>
nnoremap <C-p><C-m> :FzfMarks<CR>
let g:fzf_action = {
      \ 'ctrl-q': function('s:build_quickfix_list'),
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit'}

" grepper, ctrlsf
vmap <leader>F         <Plug>CtrlSFVwordPath
nnoremap <leader>f         :Grepper<CR>
nnoremap <leader>F         :CtrlSF 
nnoremap <leader>*         :Grepper -tool ag -highlight -cword -noprompt<CR>
nnoremap <leader><leader>* :Grepper -tool ag -highlight -cword -noprompt -side<CR>

" ale
nnoremap <C-m><C-f> :ALEFix<CR>
nnoremap <C-m><C-l> :ALELint<CR>
nnoremap <C-m><C-w> :set list!<CR>
nnoremap [e :ALEPreviousWrap<CR>
nnoremap ]e :ALENextWrap<CR>

" multiplecursors
nnoremap <C-m><C-n> :MultipleCursorsFind 
vnoremap <C-m><C-n> :MultipleCursorsFind 

" splitjoin
nnoremap <C-m><C-j> :SplitjoinJoin<cr>
nnoremap <C-m><C-s> :SplitjoinSplit<cr>

" gitgutter
nnoremap [g :GitGutterPrevHunk<CR>
nnoremap ]g :GitGutterNextHunk<CR>
" **********************************

" Non plugin related keymaps

" jump to last opened file
nnoremap <leader>` :e#<CR>

" search exact match by default
nnoremap / /\V
nnoremap ? /
" disable highlight on del
nnoremap <Bs> :noh<CR>

nnoremap <C-]> g]
nnoremap g] <C-]>

" replace selected word in file
nnoremap <leader>r yiw:%s/\V<C-r>"//g<Left><Left>
vnoremap <leader>r y:%s/\V<C-r>"//g<Left><Left>

" move manual lookup to leader?
nnoremap <leader>? K

" sometimes I just hold shift for too long
cabbrev W   w
cabbrev Wa  wa
cabbrev Wq  wq
cabbrev WQ  wq
cabbrev Wqa wqa
cabbrev WQa wqa
cabbrev Q   q
cabbrev Qa  qa
cabbrev Q!  q
cabbrev Qa! qa

" disable entering Ex-mode with Q (accessible through :<C-f>)
nnoremap Q <NOP>
map q: <NOP>

" vim command line mappings
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>
cnoremap <C-d> <Delete>
cnoremap <C-g> <C-c>

" windows navigation
" for linux
nnoremap <M-h>      <C-w>h
nnoremap <M-j>      <C-w>j
nnoremap <M-k>      <C-w>k
nnoremap <M-l>      <C-w>l
" for iterm (also requires 'send hex' config)
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

" unify keymaps with tmux
nnoremap <C-w>" <C-w>s
nnoremap <C-w>% <C-w>v

" close buffer
nnoremap <leader>q :close<CR>

" split and merge lines
nnoremap <leader>j i<CR><Esc>
nnoremap <leader>k <esc>kJ

" begin and end of line
map <leader>h ^
map <leader>l $

" treat multiline statement as multiple lines
nnoremap j gj
nnoremap k gk

" always focus after cursor jump
nmap n <Plug>(anzu-n-with-echo)zz:set cuc<CR><Plug>(anzu-echo-search-status)
nmap N <Plug>(anzu-N-with-echo)zz:set cuc<CR><Plug>(anzu-echo-search-status)
nmap * <Plug>(anzu-star-with-echo)zz:set cuc<CR><Plug>(anzu-echo-search-status)
nmap # <Plug>(anzu-sharp-with-echo)zz:set cuc<CR><Plug>(anzu-echo-search-status)
nnoremap <C-o> <C-o>zz
nnoremap <C-i> <C-i>zz
nnoremap gi gi<ESC>zza
nnoremap g; g;zz
nnoremap `` ``zz

" move block of code without losing selection
vnoremap > >gv
vnoremap < <gv

" system clipboard integration
vnoremap <leader>y "+y
nnoremap <leader>Y "+yg_
nnoremap <leader>y "+y
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" IDE like shortcuts in case of pair programming with jetbrains normies
inoremap <C-d> <esc>YpA
nnoremap <C-x> dd
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
nnoremap <C-s> :w<CR>
