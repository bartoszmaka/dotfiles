return {
  {
    'tpope/vim-fugitive',
    config = function()
      vim.cmd [[
        let mapleader="\<Space>"
        nnoremap <C-g><C-b> :Git blame<CR>
        nnoremap <C-g><C-d> :Gvdiffsplit!<CR>
      ]]
    end,
  },
  {
    'akinsho/git-conflict.nvim',
    version = "*",
    opts = {
      default_mappings = false,
      default_commands = true,
      disable_diagnostics = true,
      list_opener = 'copen',
      highlights = {
        incoming = 'DiffAdd',
        current = 'DiffText',
      },
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local symbols = require('helper.symbols')

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
      })

      vim.cmd [[
        augroup gitsigns_overrides
          autocmd!
          highlight! GitSignsStagedAdd guifg=#284414
          highlight! GitSignsStagedChange guifg=#5a3e08
          highlight! GitSignsStagedChangeLn guifg=#5a3e08
          highlight! GitSignsStagedChangeNr guifg=#5a3e08
          highlight! GitSignsStagedChangedelete guifg=#5a3e08
          highlight! GitSignsStagedChangedeleteLn guifg=#5a3e08
          highlight! GitSignsStagedChangedeleteN guifg=#5a3e08
          highlight! GitGutterChange guifg=#5a3e08
          highlight! GitGutterAdd guifg=#284414
          highlight! GitGutterDelete guifg=#5f050d
          highlight! GitSignsChange guifg=#5a3e08
          highlight! GitSignsChangeNr guifg=#5a3e08
          highlight! GitSignsChangeLn guifg=#5a3e08
          highlight! GitSignsAdd guifg=#284414
          highlight! GitSignsDelete guifg=#5f050d
        augroup END
      ]]
    end,
  },
}
