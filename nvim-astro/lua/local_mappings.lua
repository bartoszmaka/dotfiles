local helper = require('helper')

-- aliases
local map = helper.map
local vmap = helper.vmap
local tmap = helper.tmap
local imap = helper.imap
local nmap = helper.nmap
local cmap = helper.cmap
local vnoremap = helper.vnoremap
local inoremap = helper.inoremap
local nnoremap = helper.nnoremap
local cnoremap = helper.cnoremap
local tnoremap = helper.tnoremap
local unmap = helper.unmap

-- unmaps
nnoremap('Q', '<NOP>')  -- disable ex mode
nnoremap('q:', '<NOP>') -- disable command line
nnoremap('ZZ', '<NOP>') -- disable quit with ZZ
vim.cmd [[
  " unmap <leader>lD
  " unmap <leader>lG
  " unmap <leader>lI
  " unmap <leader>lL
  " unmap <leader>lR
  " unmap <leader>lS
  " unmap <leader>la
  " unmap <leader>ld
  " unmap <leader>lf
  " unmap <leader>lh
  " unmap <leader>li
  " unmap <leader>ll
  " unmap <leader>lr
  " unmap <leader>ls
]]

-- better movement
inoremap('jk', '<ESC>')
tmap('jk', [[<C-\><C-n>]])
tmap('<esc>', [[<C-\><C-n>]])
nmap('<leader>h', '^')
nmap('<leader>l', '$', { nowait = true })
vim.cmd [[ nmap <nowait><leader>l $]]
vmap('<leader>h', '^')
vmap('<leader>l', '$')
nnoremap('K', '5k')
nnoremap('J', '5j')
vnoremap('K', '5k')
vnoremap('J', '5j')
nnoremap('j', 'gj')
nnoremap('k', 'gk')

vnoremap('<Tab>', '>gv')
vnoremap('<S-Tab>', '<gv')

-- console like keymaps
cnoremap('<C-a>', '<Home>')
cnoremap('<C-e>', '<End>')
cnoremap('<C-p>', '<Up>')
cnoremap('<C-n>', '<Down>')
cnoremap('<C-b>', '<S-Left>')
cnoremap('<C-f>', '<S-Right>')
cnoremap('<C-g>', '<C-c>')
inoremap('<C-a>', '<Home>')
nnoremap('<C-e>', '<End>')

-- center screen after jump
nnoremap('g;', 'g;zz')
nnoremap('``', '``zz')
vnoremap('>', '>gv')
vnoremap('<', '<gv')
vnoremap('<Tab>', '>gv')
vnoremap('<S-Tab>', '<gv')


-- save on cmd + s (mapped to f13-14 in alacritty config)
nnoremap('<F13>', '<esc>:w<CR>')
inoremap('<F13>', '<esc>:w<CR>')
nnoremap('<F15>', '<esc>:w<CR>')
inoremap('<F15>', '<esc>:w<CR>')
nnoremap('<C-_>s', '<esc>:w<CR>')
inoremap('<C-_>s', '<esc>:w<CR>')

-- alt + hjkl to jump windows (cmd + hjkl mapped in alacritty config)
tnoremap('<C-w>h', [[<C-\><C-n><C-w>h]])
tnoremap('<C-w>j', [[<C-\><C-n><C-w>j]])
tnoremap('<C-w>k', [[<C-\><C-n><C-w>k]])
tnoremap('<C-w>l', [[<C-\><C-n><C-w>l]])
-- nnoremap('<M-h>', '<C-w>h')
-- nnoremap('<M-j>', '<C-w>j')
-- nnoremap('<M-k>', '<C-w>k')
-- nnoremap('<M-l>', '<C-w>l')

-- split and join lines
nnoremap('<leader>j', 'i<CR><Esc>', { desc = "Split line" })
nnoremap('<leader>k', '<esc>kJ', { desc = "Join to prev line" })

nnoremap('/', [[/\V]])                                          -- search with nomagic flag
nnoremap('?', '/')                                              -- search with magic flag (default)
nnoremap('<Bs>', ':noh<CR>')                                    -- turn off highlight
nnoremap('<leader>r', [["zyiw:%s/\V<C-r>z//g<Left><Left>]], { desc = "Replace in file" })       -- replace under cursor
vnoremap('<leader>r', [["zy:%s/\V<C-r>z//g<Left><Left>]], { desc = "Replace in file" })         -- replace under cursor
nnoremap('<leader>R', [["zyiw:%s/\V<C-r>z/<C-r>z/g<Left><Left>]], { desc = "Prefilled replace in file" }) -- replace under cursor and paste same word into target
vnoremap('<leader>R', [["zy:%s/\V<C-r>z/<C-r>z/g<Left><Left>]], { desc = "Prefilled replace in file" })   -- replace under cursor and paste same word into target
nnoremap('<C-k><C-k>', [[:g/\(context \|it \|describe\)/p<CR>]], { desc = "Peek spec structure" })

vnoremap('<C-m><C-s>', ':sort<CR>')
vnoremap('<CR><C-s>', ':sort<CR>')

vim.cmd([[command! FindDuplicates :g/^\(.*\)$\n\1$/p]])

if vim.fn.has("nvim-0.9.0") == 1 then
  nnoremap("<leader>uh", [[:lua vim.show_pos()<CR>]], { desc = "Inspect highlights" })
else
  nnoremap([[<leader>uh]], [[:TSHighlightCapturesUnderCursor<CR>]], { desc = "Inspect highlights" })
end

vim.cmd [[
  nnoremap <leader>uH :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name")
  \ . '> trans<' . synIDattr(synID(line("."),col("."),0),"name")
  \ . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name")
  \ . ">"<CR>
]]

-- VSCode like keymaps
nmap('<F3>', '*')
nmap('<S-F3>', '#')
nmap('<C-G>', '<C-k><C-g>')
