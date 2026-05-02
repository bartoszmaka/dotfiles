return {
  {
    'tpope/vim-fugitive',
    cmd = { 'Git', 'Gvdiffsplit', 'Gdiffsplit', 'Gread', 'Gwrite', 'Gedit' },
    keys = {
      { '<C-g><C-b>', '<cmd>Git blame<CR>',     desc = 'Git blame' },
      { '<C-g><C-d>', '<cmd>Gvdiffsplit!<CR>',  desc = 'Git diff (vertical)' },
    },
  },
  {
    'akinsho/git-conflict.nvim',
    version = '*',
    opts = function()
      local group = vim.api.nvim_create_augroup('git_conflict_diagnostics', { clear = true })

      vim.api.nvim_create_autocmd('User', {
        group = group,
        pattern = 'GitConflictDetected',
        callback = function(args)
          vim.diagnostic.enable(false, { bufnr = args.buf })
        end,
      })

      vim.api.nvim_create_autocmd('User', {
        group = group,
        pattern = 'GitConflictResolved',
        callback = function(args)
          vim.diagnostic.enable(true, { bufnr = args.buf })
        end,
      })

      return {
        default_mappings = false,
        default_commands = true,
        disable_diagnostics = false,
        list_opener = 'copen',
        highlights = {
          incoming = 'DiffAdd',
          current = 'DiffText',
        },
      }
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local symbols = require('helper.symbols')
      local colors = require('helper.colors').onedark

      require('gitsigns').setup({
        on_attach = function(bufnr)
          local gitsigns = require('gitsigns')

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          map('n', ']g', function()
            if vim.wo.diff then
              vim.cmd.normal({ ']g', bang = true })
            else
              gitsigns.nav_hunk('next')
            end
          end)

          map('n', '[g', function()
            if vim.wo.diff then
              vim.cmd.normal({ '[g', bang = true })
            else
              gitsigns.nav_hunk('prev')
            end
          end)

          map('n', '<leader>gs', gitsigns.stage_hunk)
          map('n', '<leader>gr', gitsigns.reset_hunk)
          map('v', '<leader>gs', function() gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
          map('v', '<leader>gr', function() gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
          map('n', '<leader>gS', gitsigns.stage_buffer)
          map('n', '<leader>gu', gitsigns.undo_stage_hunk)
          map('n', '<leader>gR', gitsigns.reset_buffer)
          map('n', '<leader>gp', gitsigns.preview_hunk)
          map('n', '<leader>gb', function() gitsigns.blame_line { full = true } end)
          map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
          map('n', '<leader>gd', gitsigns.diffthis)
          map('n', '<leader>gD', function() gitsigns.diffthis('~') end)
          map('n', '<leader>td', gitsigns.toggle_deleted)
          map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end,

        signs = {
          add          = { text = symbols.git_bar },
          change       = { text = symbols.git_bar },
          delete       = { text = symbols.git_deleted_below },
          topdelete    = { text = symbols.git_deleted_above },
          changedelete = { text = symbols.git_bar },
        },
        signs_staged = {
          add          = { text = symbols.git_bar },
          change       = { text = symbols.git_bar },
          delete       = { text = symbols.git_deleted_below },
          topdelete    = { text = symbols.git_deleted_above },
          changedelete = { text = symbols.git_bar },
        },
        sign_priority = 500,
        signs_staged_enable = true,
        numhl = false,
        linehl = false,
        current_line_blame = true,
        current_line_blame_formatter = '   <author>, <author_time:%R> • <summary>',
        current_line_blame_opts = {
          delay = 200
        }
      })

      local hl = function(name, val) vim.api.nvim_set_hl(0, name, val) end
      hl('GitSignsStagedAdd',              { fg = colors.dimmed_green })
      hl('GitSignsStagedChange',           { fg = colors.dimmed_yellow })
      hl('GitSignsStagedChangeLn',         { fg = colors.dimmed_yellow })
      hl('GitSignsStagedChangeNr',         { fg = colors.dimmed_yellow })
      hl('GitSignsStagedChangedelete',     { fg = colors.dimmed_yellow })
      hl('GitSignsStagedChangedeleteLn',   { fg = colors.dimmed_yellow })
      hl('GitSignsStagedChangedeleteN',    { fg = colors.dimmed_yellow })
      hl('GitGutterChange',                { fg = colors.dimmed_yellow })
      hl('GitGutterAdd',                   { fg = colors.dimmed_green })
      hl('GitGutterDelete',                { fg = colors.dimmed_red })
      hl('GitSignsChange',                 { fg = colors.dimmed_yellow })
      hl('GitSignsChangeNr',               { fg = colors.dimmed_yellow })
      hl('GitSignsChangeLn',               { fg = colors.dimmed_yellow })
      hl('GitSignsAdd',                    { fg = colors.dimmed_green })
      hl('GitSignsDelete',                 { fg = colors.dimmed_red })
    end,
  },
}
