-- gui
vim.opt.syntax = 'enable'         -- enable syntax highlighting
vim.opt.number = true             -- show line numbers
vim.opt.scrolloff = 4             -- show at least 4 lines when scrolling horizontaly
vim.opt.sidescrolloff = 15
vim.opt.mouse = 'a'               -- enable mouse support
vim.opt.colorcolumn = '81,121'    -- line lenght marker at 80 columns
vim.opt.splitright = true         -- vertical split to the right
vim.opt.splitbelow = true         -- orizontal split to the bottom
vim.opt.wrap = false              -- don't wrap lines by default
vim.opt.listchars = {tab='>-',trail='~',extends='>',precedes='<'}
vim.opt.list = true               -- show whitespaces
vim.opt.cursorline = true
vim.opt.inccommand = 'nosplit'    -- live preview replace
-- vim.opt.signcolumn = 'yes:2'      -- always display column for signs left to numbers
vim.opt.signcolumn = 'yes'      -- always display column for signs left to numbers
vim.opt.termguicolors = true
vim.opt.pumheight = 10
vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
-- vim.opt.fillchars = "fold: ,foldopen:, foldclose:, foldsep: "

vim.opt.foldcolumn = '1' -- '0' is not bad
vim.opt.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

-- Meta
vim.g.mapleader = ' '
vim.opt.hidden = true
vim.opt.clipboard = "unnamedplus"
vim.opt.swapfile = false          -- don't use swapfile
vim.opt.lazyredraw = true         -- faster scrolling
vim.opt.synmaxcol = 240           -- max column for syntax highlight
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.updatetime = 750

-- indent
-- b.smartindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- encoding
vim.opt.fileencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.langmenu = 'en_US.UTF-8'

-- searching and commangs
vim.opt.ignorecase = true         -- ignore case letters when search
vim.opt.smartcase = true          -- ignore lowercase for the whole pattern

vim.opt.shortmess = vim.opt.shortmess + 'S'

-- for some reason I can't set it via lua api
vim.cmd [[
  syntax on
  language en_US.UTF-8
  set undofile
  set undodir=$HOME/.config/nvim/undo
  set showtabline=2
  set noshowmode
  set foldmethod=indent
  set wildignore+=*node_modules
]]

vim.g.vimsyn_embed = 'l'
