nnoremap = require('config_helper').nnoremap

if vim.fn.exists('$KITTY_WINDOW_ID') ~= 1 or vim.fn.exists('$TMUX') == 1 then
  vim.g.kitty_navigator_no_mappings = 1
  return
end

vim.g.kitty_navigator_no_mappings = 1

nnoremap('<C-w>h', ':KittyNavigateLeft<CR>', { silent = true })
nnoremap('<C-w>j', ':KittyNavigateDown<CR>', { silent = true })
nnoremap('<C-w>k', ':KittyNavigateUp<CR>', { silent = true })
nnoremap('<C-w>l', ':KittyNavigateRight<CR>', { silent = true })

nnoremap('<M-h>', ':KittyNavigateLeft<CR>', { silent = true })
nnoremap('<M-j>', ':KittyNavigateDown<CR>', { silent = true })
nnoremap('<M-k>', ':KittyNavigateUp<CR>', { silent = true })
nnoremap('<M-l>', ':KittyNavigateRight<CR>', { silent = true })
