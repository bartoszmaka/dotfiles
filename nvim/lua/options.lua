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
vim.opt.signcolumn = "yes:1"
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
vim.g.markdown_syntax_conceal = 0
vim.opt.viewoptions = { "cursor", "slash", "unix" }
vim.opt.fillchars = {
  foldopen = symbols.FoldOpened,
  foldclose = symbols.FoldClosed,
  foldsep = ' ',
  fold = ' ',
}

-- Folding (kept here so it stays in effect even when ufo loads later)
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

local cabbrevs = {
  { 'W',   'w' },   { 'Wa',  'wa' },  { 'WA',  'wa' },
  { 'Wq',  'wq' },  { 'WQ',  'wq' },  { 'Wqa', 'wqa' }, { 'WQa', 'wqa' },
  { 'Q',   'q' },   { 'Qa',  'qa' },  { 'Q!',  'q!' },  { 'Qa!', 'qa!' },
}
for _, ab in ipairs(cabbrevs) do
  vim.cmd(('cabbrev %s %s'):format(ab[1], ab[2]))
end
