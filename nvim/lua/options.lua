vim.opt.number = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.scrolloff = 4 -- show at least 4 lines when scrolling horizontaly
vim.opt.colorcolumn = "81,121" -- line lenght marker at 80 columns
vim.opt.wrap = false -- don't wrap lines by default
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"
vim.opt.inccommand = "nosplit" -- live preview replace
vim.opt.signcolumn = "yes" -- always display column for signs left to numbers
vim.opt.showmode = false
vim.opt.termguicolors = true
vim.g.mapleader = " "
vim.opt.undofile = true
vim.opt.wildignorecase = true
vim.opt.undodir = vim.fn.stdpath("cache") .. "/nvim/undo"
vim.opt.hlsearch = true               -- Highlight results
vim.opt.incsearch = true              -- Show results as you type
vim.opt.ignorecase = true             -- Ignore case
vim.opt.smartcase = true              -- unless uppercase chars are given

vim.cmd("cabbrev W   w")
vim.cmd("cabbrev Wa  wa")
vim.cmd("cabbrev WA  wa")
vim.cmd("cabbrev Wq  wq")
vim.cmd("cabbrev WQ  wq")
vim.cmd("cabbrev Wqa wqa")
vim.cmd("cabbrev WQa wqa")
vim.cmd("cabbrev Q   q")
vim.cmd("cabbrev Qa  qa")
vim.cmd("cabbrev Q!  q")
vim.cmd("cabbrev Qa! qa")

local symbols = require("helper.symbols")
vim.diagnostic.config({
	signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = symbols.Error,
      [vim.diagnostic.severity.WARN] = symbols.Warn,
      [vim.diagnostic.severity.HINT] = symbols.Hint,
      [vim.diagnostic.severity.INFO] = symbols.Info,
    }
  },
	underline = true,
	update_in_insert = false,
	virtual_text = true,
})
