local helper = require('helper')

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

-- unmaps
nnoremap('Q', '<NOP>')
nnoremap('q:', '<NOP>')
nnoremap('ZZ', '<NOP>')

-- better movement
inoremap('jk', '<ESC>')
tmap('jk', [[<C-\><C-n>]])
tmap('<esc>', [[<C-\><C-n>]])
nmap('<leader>h', '^')
nmap('<leader>l', '$')
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

-- save on cmd + s (mapped to f13-14 in alacritty config)
nnoremap('<F13>', '<esc>:w<CR>')
inoremap('<F13>', '<esc>:w<CR>')
nnoremap('<C-_>s', '<esc>:w<CR>')
inoremap('<C-_>s', '<esc>:w<CR>')
nnoremap('<F15>', '<esc>:w<CR>')
inoremap('<F15>', '<esc>:w<CR>')
nnoremap('<F16>', '<esc>:w<CR>')
inoremap('<F16>', '<esc>:w<CR>')

-- terminal window navigation
tnoremap('<C-w>h', [[<C-\><C-n><C-w>h]])
tnoremap('<C-w>j', [[<C-\><C-n><C-w>j]])
tnoremap('<C-w>k', [[<C-\><C-n><C-w>k]])
tnoremap('<C-w>l', [[<C-\><C-n><C-w>l]])

-- split and join lines
nnoremap('<leader>j', 'i<CR><Esc>', { desc = "Split line" })
nnoremap('<leader>k', '<esc>kJ', { desc = "Join to prev line" })

nnoremap('/', [[/\V]])
nnoremap('?', '/')
nnoremap('<Bs>', ':noh<CR>')
nnoremap('<leader>r', [["zyiw:%s/\V<C-r>z//g<Left><Left>]], { desc = "Replace in file" })
vnoremap('<leader>r', [["zy:%s/\V<C-r>z//g<Left><Left>]], { desc = "Replace in file" })
nnoremap('<leader>R', [["zyiw:%s/\V<C-r>z/<C-r>z/g<Left><Left>]], { desc = "Prefilled replace in file" })
vnoremap('<leader>R', [["zy:%s/\V<C-r>z/<C-r>z/g<Left><Left>]], { desc = "Prefilled replace in file" })
nnoremap('<C-k><C-k>', [[:g/\(context \|it \|describe\)/p<CR>]], { desc = "Peek spec structure" })

vnoremap('<C-m><C-s>', ':sort<CR>')
vnoremap('<CR><C-s>', ':sort<CR>')

vim.keymap.set('n', '<leader>cp', function()
  local path = vim.fn.expand('%')
  local line = vim.fn.line('.')
  local result = path .. ':' .. line
  vim.fn.setreg('+', result)
  print('Copied path: ' .. result)
end, { desc = 'Copy relative path with line number to clipboard' })

vim.keymap.set('n', '<leader>cs', function()
  local ok, ls = pcall(require, 'luasnip')
  if not ok then
    vim.notify('LuaSnip is not available', vim.log.levels.WARN)
    return
  end

  local filetype = vim.bo.filetype
  local snippets = ls.get_snippets(filetype) or {}
  local autosnippets = ls.get_snippets(filetype, { type = 'autosnippets' }) or {}
  local triggers = {}
  local seen = {}

  for _, snippet in ipairs(snippets) do
    if not seen[snippet.trigger] then
      seen[snippet.trigger] = true
      table.insert(triggers, snippet.trigger)
    end
  end

  for _, snippet in ipairs(autosnippets) do
    local trigger = snippet.trigger .. ' [A]'
    if not seen[trigger] then
      seen[trigger] = true
      table.insert(triggers, trigger)
    end
  end

  table.sort(triggers)

  if #triggers == 0 then
    vim.notify(('No LuaSnip snippets loaded for `%s`'):format(filetype), vim.log.levels.INFO)
    return
  end

  local lines = {
    ('LuaSnip snippets for `%s` (%d)'):format(filetype, #triggers),
    '',
  }
  vim.list_extend(lines, triggers)

  vim.cmd('vnew')
  local buf = vim.api.nvim_get_current_buf()
  vim.bo[buf].buftype = 'nofile'
  vim.bo[buf].bufhidden = 'wipe'
  vim.bo[buf].swapfile = false
  vim.bo[buf].modifiable = true
  vim.bo[buf].filetype = 'snippets'
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false
  vim.bo[buf].readonly = true
  vim.api.nvim_buf_set_name(buf, ('snippets://%s'):format(filetype))
end, { desc = 'Inspect LuaSnip snippets' })

nnoremap("<leader>uh", [[:lua vim.show_pos()<CR>]], { desc = "Inspect highlights" })

function FoldDeeperThanCursor()
  local cursor_line = vim.fn.line('.')
  local current_fold_level = vim.fn.foldlevel(cursor_line)
  local total_lines = vim.fn.line('$')
  for lnum = 1, total_lines do
    local fold_level = vim.fn.foldlevel(lnum)
    if fold_level > current_fold_level then
      vim.cmd(lnum .. 'foldclose')
    else
      vim.cmd(lnum .. 'foldopen')
    end
  end
end
vim.keymap.set('n', '<leader>zF', ':lua FoldDeeperThanCursor()<CR>', { noremap = true, silent = true })

-- VSCode like keymaps
nmap('<F3>', '*')
nmap('<S-F3>', '#')
