return {
  'lewis6991/gitsigns.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('gitsigns').setup {
      signs = {
        add = {
          hl = 'GitSignsAdd',
          text = '┃',
          numhl = 'GitSignsAddNr',
          linehl = 'GitSignsAddLn',
        },
        change = {
          hl = 'GitSignsChange',
          text = '┃',
          numhl = 'GitSignsChangeNr',
          linehl = 'GitSignsChangeLn',
        },
        delete = {
          hl = 'GitSignsDelete',
          text = '┃',
          numhl = 'GitSignsDeleteNr',
          linehl = 'GitSignsDeleteLn',
        },
        topdelete = {
          hl = 'GitSignsDelete',
          text = '┃',
          numhl = 'GitSignsDeleteNr',
          linehl = 'GitSignsDeleteLn',
        },
        changedelete = {
          hl = 'GitSignsChange',
          text = '┃',
          numhl = 'GitSignsChangeNr',
          linehl = 'GitSignsChangeLn',
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
        ['n <leader>gi'] = '<cmd>lua require"gitsigns".blame_line({ full = true})<CR>',

        -- Text objects
        ['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
        ['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>'
      },
      current_line_blame = true,
      current_line_blame_formatter = '   <author>, <author_time:%R> • <summary>',
    }

    vim.cmd [[
      onoremap ih <cmd>lua require('gitsigns').select_hunk()<CR>
      xnoremap ih <cmd>lua require('gitsigns').select_hunk()<CR>
    ]]
  end
}
