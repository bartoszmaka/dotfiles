require('hlargs').setup()

vim.cmd [[
  augroup hlargs_overrides
    autocmd!
    highlight! Hlargs guibg=none guifg=none gui=italic
  augroup END
]]
