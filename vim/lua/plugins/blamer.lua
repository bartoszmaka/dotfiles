local g = vim.g
g.blamer_enabled = 1
g.blamer_show_in_insert_modes = 0
g.blamer_template = '<author>, <committer-time> • <summary>'
g.blamer_relative_time = 1

vim.cmd[[
  augroup blamer-config
    autocmd!

    highlight! Blamer gui=italic guifg=#455574 guibg=NONE
  augroup END
]]

-- highlight! Blamer gui=italic guifg=#455574 guibg=#21283b
