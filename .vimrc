set nocompatible                "disable Vi compatibility
filetype off
    "Plugins
call plug#begin('~/.vim/plugged')

        "Base
    Plug 'VundleVim/Vundle.vim'             "Plugins manager
    if has('nvim')
        Plug 'benekastah/neomake'
    endif
    Plug 'Valloric/YouCompleteMe', { 'do': './install.py' } "Vim autocomplete engine
    Plug 'scrooloose/syntastic'             "cool syntax checker !might be not configured properly yet
    Plug 'xolox/vim-misc'                   "extension of some vim scripts
    Plug 'xolox/vim-easytags'               "jump to definition with ctrl ]
    Plug 'scrooloose/nerdtree'              "nerd tree
    " Plug 'jistr/vim-nerdtree-tabs'          "Makes NERDTree more like panel
    Plug 'ctrlpvim/ctrlp.vim'               "ctrl+p search
    Plug 'JazzCore/ctrlp-cmatcher'          "ctrlp matching extension
    Plug 'tpope/vim-commentary'             "do comments with 'gc'
    Plug 'ervandew/supertab'                "confrim autocompletion with tab
    Plug 'terryma/vim-expand-region'        "select region +/_
    Plug 'terryma/vim-multiple-cursors'     "multiple cursors, idk how to use this yet
    " Plug 'Shougo/vimproc.vim'
    " Plug 'Quramy/tsuquyomi'
    " Plug 'leafgarland/typescript-vim'
    " Plug 'easymotion/vim-easymotion'        "i have no idea how this works

        "Git
    Plug 'tpope/vim-fugitive'               "allows to use some git commands
    Plug 'Xuyuanp/nerdtree-git-plugin'      "shows some git stuff in nerd tree
    Plug 'airblade/vim-gitgutter'           "shows git + - ~ signs next to line numbers

        "UI
    Plug 'bling/vim-airline'                "bottom status bar
    Plug 'tomasr/molokai'                   "Color Scheme
    Plug 'ryanoasis/vim-devicons'           "cool icons
    Plug 'szw/vim-maximizer'
    Plug 'lambdalisue/vim-fullscreen'
    " Plug 'sjl/gundo.vim'                    "visualise undo tree
    Plug 'gorodinskiy/vim-coloresque'       "show colors in css etc
    " Plug 'severin-lemaignan/vim-minimap'    "<Leader>mm/mc | pretty useless but cool

        "Code
    Plug 'bronson/vim-trailing-whitespace'  "mark useless whitespaces
    Plug 'tpope/vim-surround'               "do stuff with surrounding ( ; < etc
    Plug 'ngmy/vim-rubocop'
    Plug 'tpope/vim-endwise'                "automaticly close structures like 'def-end'
    Plug 'octol/vim-cpp-enhanced-highlight'
    Plug 'jiangmiao/auto-pairs'             "insert or delete brackets, parens, quotes in pair
    Plug 'slim-template/vim-slim'
    Plug 'vim-ruby/vim-ruby'
    Plug 'tpope/vim-haml'
    Plug 'tpope/vim-rails'
call plug#end()


    "system config
set noswapfile                  "disable swap usage
set novisualbell                "disable bell sounds
set nobackup                    "disable backup creation
set encoding=utf-8              "the encoding displayed.
set fileencoding=utf-8          "the encoding written to file.
set fileencodings=utf-8
set hidden                      "hide buffers instead of closing them
set laststatus=2                "always show status
set undolevels=100              "maximum number of changes that can be undone
set updatetime=2000
set timeoutlen=900
set title
" set runtimepath^=~/.vim/bundle/ctrlp.vim

    "searching
set smartcase                   "searching with smart case sense
set incsearch                   "i believe it's realtime searching

    "UI config
if !exists('g:not_finish_vimplug')
  colorscheme molokai
endif
set ruler                       "bottom left bar with cursor coords
set number                      "show current line numbers
set relativenumber              "show other lines relative number
set colorcolumn=120             "120 column is colored
set cursorline                  "cursor line is highlighted
set showcmd                     "show currently typed command in right bottom
set hlsearch                    "keep searched words highlighted

    "code config
set showbreak=/>>               "mark wrapped lines with '+>>'
set autoindent                  "allow creating indents automaticly
set smartindent                 "create indents smarter
set smarttab                    "spaces instead of tabs
set expandtab
set shiftwidth=4
set softtabstop=4
set backspace=indent,eol,start  "allow backspacing over everything


    "some advanced stuff
filetype plugin indent on
let g:ycm_path_to_python_interpreter = '/usr/bin/python'
set omnifunc=syntaxcomplete#Complete
let &t_Co=256
set fillchars+=stl:\ ,stlnc:\
let g:airline_powerline_fonts = 1
let g:ctrlp_show_hidden = 1
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'

" Easytags configuration -> Plug 'xolox/vim-easytags'
    let g:easytags_async = 1                        "Async easytags
    let g:easytags_syntax_keyword = 'always'        "Better performance
    set tags=./tags;                                "tags filename and placement
    let g:easytags_dynamic_files = 2                "create tag file per project
    set cpoptions+=d                                "needed for upper line to work

autocmd! BufWritePost * Neomake

" NERDTree configuration -> Plug 'scrooloose/nerdtree'
    let g:NERDTreeWinSize = 30
        " start with nerdtree open if no file were specified
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
        " close vim if only NERDTree is opened
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Tab lengths:
    autocmd Filetype slim setlocal ts=2 sts=2 sw=2
    autocmd Filetype html setlocal ts=2 sts=2 sw=2
    autocmd Filetype haml setlocal ts=2 sts=2 sw=2
    autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
    autocmd Filetype coffee setlocal ts=2 sts=2 sw=2
    autocmd Filetype sass setlocal ts=4 sts=4 sw=4
    autocmd Filetype yaml setlocal ts=2 sts=2 sw=2
    autocmd Filetype javascript setlocal ts=4 sts=4 sw=4

" Silversearch config
    if executable('ag')
        set grepprg=ag\ --nogroup\ --nocolor
        "Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
        let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
        "ag is fast enough that CtrlP doesn't need to cache
        let g:ctrlp_use_caching = 0
    endif


"custom keymaps
let mapleader=','

" map <C-\> :NERDTreeTabsToggle<CR>
map <C-\> :NERDTreeToggle<CR>

"copy/paste from system clipboard - requires xclip
    noremap YY "+y<CR>
    noremap <leader>p "+gP<CR>
    " nnoremap <F5> :GundoToggle<CR>
