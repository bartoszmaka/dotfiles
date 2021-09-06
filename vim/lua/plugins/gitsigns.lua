vim.cmd [[
  augroup gitsigns_tweaks
    autocmd!
  
    highlight! GitSignsChange guifg=#f2cc81
    highlight! GitSignsChangeNr guifg=#f2cc81
    highlight! GitSignsChangeLn guifg=#f2cc81
  augroup END
]]
-- local format = require('config_helper.timeago').format
require('gitsigns').setup {
  signs = {
    add = {
      hl = 'GitSignsAdd',
      text = '┃',
      numhl='GitSignsAddNr',
      linehl='GitSignsAddLn',
    },
    change = {
      hl = 'GitSignsChange',
      text = '┃',
      numhl='GitSignsChangeNr',
      linehl='GitSignsChangeLn',
    },
    delete = {
      hl = 'GitSignsDelete',
      text = '┃',
      numhl='GitSignsDeleteNr',
      linehl='GitSignsDeleteLn',
    },
    topdelete = {
      hl = 'GitSignsDelete',
      text = '┃',
      numhl='GitSignsDeleteNr',
      linehl='GitSignsDeleteLn',
    },
    changedelete = {
      hl = 'GitSignsChange',
      text = '┃',
      numhl='GitSignsChangeNr',
      linehl='GitSignsChangeLn',
    },
  },
  numhl = false,
  linehl = false,
  keymaps = {
    noremap = true,
    buffer = true,

    ['n ]g'] = {
      expr = true,
      "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'",
    },
    ['n [g'] = {
      expr = true,
      "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'",
    },

    ['n <leader>gs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
    ['v <leader>gs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <leader>gS'] = '<cmd>lua require"gitsigns".stage_buffer()<CR>',
    ['n <leader>gu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    ['n <leader>gr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    ['v <leader>gr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <leader>gR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
    ['n <leader>gp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
    ['n <leader>gb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',

    -- Text objects
    ['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
    ['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>'
  },
  current_line_blame = false,
  -- current_line_blame_formatter = function(name, blame_info)
  --   if blame_info.author == name then
  --     blame_info.author = 'You'
  --   end

  --   local text
  --   if blame_info.author == 'Not Committed Yet' then
  --     text = blame_info.author
  --   else
  --     text = string.format(
  --       '%s, %s • %s',
  --       blame_info.author,
  --       format(blame_info['author_time']),
  --       blame_info.summary
  --     )
  --   end

  --   return {{' '..text, 'GitSignsCurrentLineBlame'}}
  -- end
}

vim.cmd[[
  onoremap ih <cmd>lua require('gitsigns').select_hunk()<CR>
  xnoremap ih <cmd>lua require('gitsigns').select_hunk()<CR>
]]
