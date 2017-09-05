filetype off
call plug#begin('~/.vim/plugged')

" Testing
  Plug 'dkprice/vim-easygrep'
  Plug 'dyng/ctrlsf.vim'
  " Plug 'schickling/vim-bufonly'

" autocompletion
  Plug 'Shougo/deoplete.nvim',          { 'do': ':UpdateRemotePlugins' }
  Plug 'Shougo/neoinclude.vim'                                           " extends deoplete
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'

" auto insert pairs
  Plug 'jiangmiao/auto-pairs' " auto insert parentheses, quotes etc.
  Plug 'tpope/vim-endwise'    " auto insert 'end', 'endif' etc.

" syntax checker
  Plug 'ntpeters/vim-better-whitespace' " Detect trailing whitespaces
  Plug 'w0rp/ale'                       " async syntax checking

" project explorer
  Plug 'scrooloose/nerdtree'         " Project explorer
  Plug 'jistr/vim-nerdtree-tabs'     " Better behavior for nerdtree
  Plug 'Xuyuanp/nerdtree-git-plugin' " NerdTree git integration

" project finder
  Plug 'ctrlpvim/ctrlp.vim'                                      " In project file finder
  Plug 'JazzCore/ctrlp-cmatcher',       { 'do': './install.sh' }
  Plug 'rking/ag.vim'                                            " find in files helper

" UI
  Plug 'dominikduda/vim_current_word'
  Plug 'machakann/vim-highlightedyank'
  Plug 'joshdick/onedark.vim'            " ColorScheme
  Plug 'ryanoasis/vim-devicons'          " Fancy icons
  Plug 'ap/vim-css-color'                " Color perview for vim
  Plug 'nathanaelkane/vim-indent-guides'
  Plug 'airblade/vim-gitgutter'          " Shows git signs next to line numbers
  Plug 'bling/vim-airline'               " Airline
  Plug 'vim-airline/vim-airline-themes'  " Themes for airline
  Plug 'blueyed/vim-diminactive'         " Dim inactive windows
  Plug 'kien/rainbow_parentheses.vim'    " Different parentheses colors for each depth level
  Plug 'bounceme/poppy.vim'              " Improve parentheses colorize behaviour

" window management
  Plug 'szw/vim-maximizer'            " maximize window
  Plug 'simeji/winresizer'            " window resize helper

" tabs management
  Plug 'bagrat/vim-workspace'

" code edit improvements
  Plug 'Valloric/MatchTagAlways'
  Plug 'tpope/vim-repeat'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'rhysd/clever-f.vim'           " better f F t T
  Plug 'matze/vim-move'               " Move block of code
  Plug 'easymotion/vim-easymotion'
  Plug 'tpope/vim-surround'           " Surround verb
  Plug 'tpope/vim-commentary'         " Change selected code into comment
  Plug 'godlygeek/tabular'            " Text align with regexp
  Plug 'terryma/vim-expand-region'    " Select helper

" Behavior
  Plug 'janko-m/vim-test'     " Test helper
  Plug 'benizi/vim-automkdir' " autocreate folder if necessary when writing
  Plug 'tpope/vim-fugitive'   " Git engine for vim

" Terminal provider
  Plug 'kassio/neoterm'               " terminal mode

" Markdown perview
  Plug 'shime/vim-livedown'

" Yank history
  Plug 'Shougo/unite.vim'
  Plug 'Shougo/neoyank.vim'

" Code minimap
  Plug 'majutsushi/tagbar'            " perview file structure
  Plug 'c0r73x/neotags.nvim'

" File history visualisation
  Plug 'simnalamburt/vim-mundo'           " perview undos

" tmux integration
  Plug 'christoomey/vim-tmux-navigator'

" language specific
  Plug 'pangloss/vim-javascript'
  Plug 'aliou/sql-heredoc.vim'
  Plug 'mxw/vim-jsx'
  Plug 'sheerun/vim-polyglot'
  Plug 'fishbullet/deoplete-ruby',         { 'for' : ['ruby'] }
  Plug 'Shougo/neco-vim',            { 'for' : ['vim'] }
  Plug 'lmeijvogel/vim-yaml-helper',       { 'for' : ['yaml'] }
  Plug 'ervandew/supertab'                                               " Confirm autocompletion with tab

  Plug 'rlue/vim-getting-things-down'
call plug#end()
" **********************************

filetype plugin indent on
syntax on                      " Enable syntax coloring
let mapleader = "\<Space>"

" meta
set shell=/bin/zsh
set novisualbell
set undofile
set undodir=$HOME/.vim/undo
set noswapfile
set grepprg=ag
" set foldmethod=indent
set nobackup
set autoread
set lazyredraw
set hidden                     " don't close buffers
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
" set completeopt=longest,menuone
set completeopt=longest,menuone,preview
set omnifunc=syntaxcomplete#Complete
set noshowmatch                   " has something to do with matching brackets
set backspace=indent,eol,start
" set tags=./tags;

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
set softtabstop=2
set shiftwidth=2 " Default tab width
set expandtab    " Spaces instead of tabs

" line length
set colorcolumn=120 " Color 120th column
set textwidth=0     " do not break lines automatically
set showbreak=\/_

" searching
set ignorecase
set smartcase
set hlsearch
set incsearch
" set nohlsearch

" ui
set mouse=a
set laststatus=2                   " always show status line
set showcmd
set number
set norelativenumber
set ruler
set cursorline                   " Highlight current line
set title
set title titlestring=%<%F%=

let g:gtdown_cycle_states = ['TODO', 'WIP', 'DONE', 'WAIT', 'CANCELLED']
let g:gtdown_default_fold_level = 2222
let g:gtdown_show_progress = 1
let g:gtdown_fold_list_items = 0
let g:polyglot_disabled = ['markdown']
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

let g:webdevicons_enable                     = 1
let g:webdevicons_enable_nerdtree                = 0
let g:WebDevIconsNerdTreeAfterGlyphPadding           = ''

set fillchars+=stl:\ ,stlnc:\ ,vert:\│

" let g:workspace_powerline_separators = 1
let g:workspace_tab_icon = "\uf00a"
let g:workspace_left_trunc_icon = "\uf0a8"
let g:workspace_right_trunc_icon = "\uf0a9"
let g:airline_powerline_fonts  = 1
let g:airline#extensions#branch#enabled        = 1
let g:airline#extensions#branch#format         = 2
let g:airline#extensions#branch#displayed_head_limit = 15
let g:airline#extensions#tagbar#enabled        = 1
let g:airline#extensions#hunks#enabled         = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_enable_on_vim_startup = 1


if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" let g:gitgutter_sign_column_always = 1
set signcolumn=yes
let g:gitgutter_map_keys = 0

let g:diminactive_buftype_blacklist = ['nofile', 'nowrite', 'acwrite', 'quickfix', 'help']
let g:diminactive_enable_focus    = 1
" Rainbow Parentheses
let g:rbpt_colorpairs = [
  \ ['brown',     'lightcyan'],
  \ ['Darkblue',  'khaki'],
  \ ['darkgray',  'lightmagenta'],
  \ ['darkgreen',   'lemonchiffon'],
  \ ['darkcyan',  'RoyalBlue3'],
  \ ['darkred',   'SeaGreen3'],
  \ ['darkmagenta', 'DarkOrchid3'],
  \ ['brown',     'firebrick3'],
  \ ['gray',    'RoyalBlue3'],
  \ ['black',     'SeaGreen3'],
  \ ['darkmagenta', 'DarkOrchid3'],
  \ ['Darkblue',  'firebrick3'],
  \ ['darkgreen',   'lightcyan'],
  \ ['darkcyan',  'khaki'],
  \ ['darkred',   'lightmagenta'],
  \ ['red',     'lemonchiffon'],
  \ ]
let g:rbpt_max = 16
" Poppy
au! cursormoved * call PoppyInit()
let g:poppy_point_enable = 1
let g:poppyhigh = ['MatchParen']
let loaded_matchparen = 1

" livedown
let g:livedown_browser = 'google-chrome'
let g:livedown_open = 1

" vim current word
let g:vim_current_word#enabled = 1
let vim_current_word#highlight_only_in_focused_window = 1
let g:vim_current_word#highlight_twins = 1
let g:vim_current_word#highlight_current_word = 1

" nerdtree, mundo, tagbar
let g:NERDTreeWinSize = 25
let g:mundo_right = 1
let g:maximizer_default_mapping_key   = '<C-w>m'

" start with nerdtree open if no file were specified (2 lines below)
augroup nerdtree
  autocmd!
  " autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
augroup END
nmap   <F2>     :NERDTreeToggle<CR>
nmap   <leader><F2> :NERDTreeFind<CR>zz
noremap  <F3>     :TagbarToggle<CR>
nnoremap <F4>     :MundoToggle<CR>

" easymotion
let g:EasyMotion_startofline = 0 " keep cursor column when JK motion

" winresizer code 101 is 'e'
let g:winresizer_vert_resize  = 1
let g:winresizer_horiz_resize   = 1
let g:winresizer_keycode_finish = 101
" vim-polyglot
let g:polyglot_disabled = ['javascript', 'markdown', 'jsx']

" vim-tmux-navigator
let g:tmux_navigator_no_mappings = 1

" rust formatter on save
let g:rustfmt_autosave = 1

" let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
"🌩 ⛅ <- those icons does not always show for some reason
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_error = '!'
let g:ale_sign_warning = '.'
let g:ale_lint_delay = 400
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'normal'
let g:ale_sign_column_always = 1

let g:AutoPairsShortcutToggle = ''
let g:AutoPairsShortcutBackInsert = ''
let g:AutoPairsShortcutJump = ''
let g:AutoPairsShortcutFastWrap = ''
let g:AutoPairsMapCh = ''

" completion
let g:UltiSnipsExpandTrigger = "<C-e>"
let g:UltiSnipsJumpForwardTrigger = "<C-j>"
let g:UltiSnipsJumpBackwardTrigger = "<C-k>"
let g:SuperTabDefaultCompletionType = "<c-n>"
let deoplete#tag#cache_limit_size = 50000000
let g:deoplete#auto_complete_delay = 2
let g:deoplete#enable_ignore_case = 0
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_refresh_always = 1
let g:deoplete#auto_refresh_delay = 2
let g:deoplete#max_abbr_width = 0
let g:deoplete#max_menu_width = 0
let g:deoplete#max_list = 30
let g:vimrubocop_config        = '~/.rubocop.yml'
imap <c-j> <Tab>
imap <c-k> <S-Tab>
let g:tern_request_timeout = 1
let g:tern_show_signature_in_pum = '0'

" ctrlp
let g:ctrlp_map     = '<c-p>'
let g:ctrlp_cmd     = 'CtrlPMixed'
let g:ctrlp_show_hidden = 1
let g:ctrlp_cache_dir   = $HOME . '/.cache/ctrlp'
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
  map <C-l> :CtrlPMRU<CR>
endif

let g:neotags_ctags_timeout = 5
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
      \ '--exclude=dist'
      \ ]
let g:neotags_enabled = 1
let g:neotags_highlight = 0
let g:neotags_file = './tags'
let g:neotags_recursive = 1
let g:neotags_events_update = ['BufReadPost']

" neoterm
let test#strategy      = 'neoterm'
let g:neoterm_keep_term_open = 1
let g:neoterm_run_tests_bg   = 1
let g:neoterm_position     = 'horizontal'
let g:neoterm_size       = 10
nnoremap <leader>te :Ttoggle<CR>
let g:better_whitespace_filetypes_blacklist=[]

" matchtagalways
let g:jsx_ext_required = 0
let g:mta_filetypes = {
  \ 'html' : 1,
  \ 'xhtml' : 1,
  \ 'xml' : 1,
  \ 'javascript' : 1,
  \}
" **********************************
augroup add-html-snippets-to-js
  autocmd FileType javascript UltiSnipsAddFiletypes html
augroup END

augroup yaml-helper
  autocmd!
  autocmd CursorHold *.yml YamlGetFullPath
augroup END

augroup trailing-whitespaces
  autocmd!
  " Show trailing-whitespaces in all files, but dont delete them in markdown
  autocmd BufEnter * EnableStripWhitespaceOnSave
  autocmd FileType markdown autocmd BufEnter <buffer> DisableStripWhitespaceOnSave
augroup END

augroup rainbow-parentheses
  autocmd!
  autocmd VimEnter * RainbowParenthesesToggle
  autocmd Syntax * RainbowParenthesesLoadRound
  autocmd Syntax * RainbowParenthesesLoadSquare
  autocmd Syntax * RainbowParenthesesLoadBraces
augroup END

augroup dim-inactive-fix
  autocmd!
  autocmd BufNew * DimInactive
augroup END

" augroup reload-vimrc-on-save
"   " it breaks airline for some reason
"   autocmd!
"   autocmd BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
" augroup END

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

let g:mta_set_default_matchtag_color = 0
augroup color-scheme-tweaks
  autocmd!
  highlight   Cursor           gui=reverse
  highlight   HighlightedyankRegion  cterm=reverse   gui=reverse
  highlight   iCursor          guibg=green   guifg=white
  highlight   CursorLineNR       guibg=#343D46
  highlight   IncSearch        guifg=#FF0000   guibg=NONE    guisp=NONE    gui=bold   ctermfg=15   ctermbg=NONE   cterm=bold
  highlight   Search           guifg=#FFFFFF   guibg=NONE    guisp=NONE    gui=bold   ctermfg=15   ctermbg=NONE   cterm=bold
  highlight   ExtraWhitespace      ctermbg=160   guibg=#D70000
  highlight   CurrentWordTwins     ctermbg=12    guibg=#363636
  highlight   CurrentWord        ctermbg=14    guibg=#262020
  highlight   MatchTag           gui=bold    cterm=bold

  highlight   WorkspaceBufferCurrent   guibg=#E5C07B   ctermbg=180   guifg=#262626   ctermfg=16
  highlight   WorkspaceBufferActive  guibg=#C5A05B   ctermbg=179   guifg=#262626   ctermfg=16
  highlight   WorkspaceBufferHidden  guibg=#444444   ctermbg=59    guifg=#262626   ctermfg=16
  highlight   WorkspaceBufferTrunc   guibg=#FF0000   ctermbg=196   guifg=#262626   ctermfg=16
  highlight   WorkspaceTabCurrent    guibg=#C678DD   ctermbg=176   guifg=#262626   ctermfg=16
  highlight   WorkspaceTabHidden     guibg=#9648AD   ctermbg=97    guifg=#262626   ctermfg=16
  highlight   WorkspaceFill      guibg=#282C34   ctermbg=17    guifg=#FFFFFF   ctermfg=15

  highlight   IndentGuidesOdd      guibg=#304050   ctermbg=61
  highlight   IndentGuidesEven     guibg=#403560   ctermbg=60
augroup END
let g:mta_use_matchparen_group = 0


command! TODO :call getting_things_down#show_todo()
augroup gtDown
    " Cycle through TODO keywords
        autocmd BufReadPre TODO.md nmap <buffer> <silent> <leader>s :call getting_things_down#cycle_status()<CR>
    " Toggle TODO tasks
        autocmd BufReadPre TODO.md nnoremap <buffer> <silent> <leader>t :call getting_things_down#toggle_task()<CR>
        autocmd BufReadPre TODO.md vnoremap <buffer> <silent> <leader>t :call getting_things_down#toggle_task()<CR>
    " Change default task colors
        autocmd BufReadPre TODO.md hi! markdownTodoReadyN guifg=#E5C07B
        autocmd BufReadPre TODO.md hi! markdownTodoDoneN guifg=#C5A05B
        autocmd BufReadPre TODO.md hi! markdownTodoWaitingN guifg=#9648AD
augroup END

augroup tab-lengths
  autocmd!
  autocmd Filetype gitcommit  setlocal cc=72
  autocmd Filetype nerdtree   setlocal ts=2 sts=2 sw=2
  autocmd Filetype ruby     setlocal ts=2 sts=2 sw=2
  autocmd Filetype eruby    setlocal ts=2 sts=2 sw=2
  autocmd Filetype scss     setlocal ts=2 sts=2 sw=2
  autocmd Filetype sass     setlocal ts=2 sts=2 sw=2
  autocmd Filetype slim     setlocal ts=2 sts=2 sw=2
  autocmd Filetype html     setlocal ts=2 sts=2 sw=2
  autocmd Filetype jsx      setlocal ts=2 sts=2 sw=2
  autocmd Filetype haml     setlocal ts=2 sts=2 sw=2
  autocmd Filetype ruby     setlocal ts=2 sts=2 sw=2
  autocmd Filetype coffee   setlocal ts=2 sts=2 sw=2
  autocmd Filetype yaml     setlocal ts=2 sts=2 sw=2
  autocmd Filetype c      setlocal ts=4 sts=4 sw=4 cc=79
  autocmd Filetype cpp    setlocal ts=4 sts=4 sw=4 cc=79
  autocmd Filetype objc     setlocal ts=4 sts=4 sw=4 cc=79
  autocmd Filetype javascript setlocal ts=2 sts=2 sw=2 cc=79
  autocmd Filetype python   setlocal ts=4 sts=4 sw=4 cc=79
augroup END
autocmd BufNewFile,BufRead *.slim setlocal filetype=slim
 " **********************************

" Plugin related keymaps
  " workspace
noremap <Tab> :WSNext<CR>
noremap <S-Tab> :WSPrev<CR>
noremap <Leader><Tab> :WSClose<CR>
noremap <Leader><S-Tab> :WSClose!<CR>
noremap <C-t> :WSTabNew<CR>

cabbrev bonly WSBufOnly

nnoremap <leader>uu :Unite<CR>
nnoremap <leader>ya :Unite history/yank -default-action=append<CR>
  " disable hls
noremap  <Esc><Esc> :<C-u>nohls<CR>
  " vim test
nnoremap <leader>tt :TestNearest<CR>
nnoremap <leader>tf :TestFile<CR>
nnoremap <leader>ta :TestSuite<CR>
nnoremap <leader>tl :TestLast<CR>
nnoremap <leader>tg :TestVisit<CR>
  " vim move (block of code)
let g:move_key_modifier = 'C'
  " vim expand
vmap v <Plug>(expand_region_expand)
  " Easymotion
map <leader>fi <Plug>(easymotion-sn)
omap <leader>fi <Plug>(easymotion-tn)
map <leader>n <Plug>(easymotion-next)
map <leader>N <Plug>(easymotion-prev)
map <Leader>L <Plug>(easymotion-lineforward)
map <Leader>H <Plug>(easymotion-linebackward)
map <Leader>. <Plug>(easymotion-repeat)

let g:ag_highlight=1
  " Search projectwide
nnoremap , :Ag!<Space>-Q<Space>''<Left>
  " Search selected text project wide (+ possibility to pass path)
vnoremap , y:Ag!<Space>-Q<Space>'<C-r>"'<Space>
  " Window navigation
:tnoremap <Esc> <C-\><C-n>
:tnoremap ii  <C-\><C-n>
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
  " Git shortcuts
nnoremap <leader>gst :Gstatus<CR>
nnoremap <leader>gd  :Gdiff<CR>

" Non plugin related keymaps
nnoremap n nzz
nnoremap N Nzz
  " replace word under cursor
nnoremap <leader>F bye:%s/<C-r>"/
  " replace selected word
vnoremap <leader>F y:%s/<C-r>"/

  " tabs navigation
nnoremap tt :tabnew<CR>
nnoremap TT :tabclose<CR>
nnoremap tl :tabs<CR>
  " select whole file, (map old C-a functionality to <leader>a)
nnoremap <C-a> ggVG
nnoremap <leader>a <C-a>
  " copy to clipboard
vnoremap <leader>y  "+y
nnoremap <leader>Y  "+yg_
nnoremap <leader>y  "+y
  " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P
  " Replace currenctly selected text with one from system clipboard
vmap <C-v> x"+P
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

" Disabling mappings
  " Disable ex mode
nnoremap Q q
  " Disable q:, use :<C-f> instead
nnoremap q: <NOP>
vnoremap q: <NOP>
  " Disable arrow keys
nnoremap <Up>  <NOP>
nnoremap <Down>  <NOP>
nnoremap <Left>  <NOP>
nnoremap <Right> <NOP>
inoremap <Up>  <NOP>
inoremap <Down>  <NOP>
inoremap <Left>  <NOP>
inoremap <Right> <NOP>
vnoremap <Up>  <NOP>
vnoremap <Down>  <NOP>
vnoremap <Left>  <NOP>
vnoremap <Right> <NOP>

