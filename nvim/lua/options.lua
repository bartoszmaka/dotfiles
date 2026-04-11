local symbols = require('helper.symbols')

vim.opt.number = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 12
vim.opt.colorcolumn = "81,121"
vim.opt.wrap = false
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"
vim.opt.inccommand = "nosplit"
vim.opt.signcolumn = "yes:2"
vim.opt.numberwidth = 1
vim.opt.showmode = false
vim.opt.termguicolors = true
vim.g.mapleader = " "
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.wildignorecase = true
vim.opt.undodir = vim.fn.stdpath("cache") .. "/nvim/undo"
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.winborder = 'single'
vim.opt.updatetime = 300
vim.opt.conceallevel = 0
vim.opt.viewoptions = { "cursor", "slash", "unix" }
vim.opt.fillchars = {
  foldopen = symbols.FoldOpened,
  foldclose = symbols.FoldClosed,
  foldsep = " ",
  fold = " ",
}

vim.cmd("cabbrev W   w")
vim.cmd("cabbrev Wa  wa")
vim.cmd("cabbrev WA  wa")
vim.cmd("cabbrev Wq  wq")
vim.cmd("cabbrev WQ  wq")
vim.cmd("cabbrev Wqa wqa")
vim.cmd("cabbrev WQa wqa")
vim.cmd("cabbrev Q   q")
vim.cmd("cabbrev Qa  qa")
vim.cmd("cabbrev Q!  q!")
vim.cmd("cabbrev Qa! qa!")
