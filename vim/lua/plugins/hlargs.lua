require('hlargs').setup()

vim.cmd [[
augroup hlargs
  autocmd!
  highlight! Hlargs guibg=none guifg=none gui=italic
augroup END
]]
