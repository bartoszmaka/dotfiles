return {
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

        -- Navigation
        map('n', ']g', function()
          if vim.wo.diff then
            vim.cmd.normal({']g', bang = true})
          else
            gitsigns.nav_hunk('next')
          end
        end)

        map('n', '[g', function()
          if vim.wo.diff then
            vim.cmd.normal({'[g', bang = true})
          else
            gitsigns.nav_hunk('prev')
          end
        end)

        -- Actions
        map('n', '<leader>gs', gitsigns.stage_hunk)
        map('n', '<leader>gs', gitsigns.reset_hunk)
        map('v', '<leader>gr', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
        map('v', '<leader>gr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
        map('n', '<leader>gS', gitsigns.stage_buffer)
        map('n', '<leader>gu', gitsigns.undo_stage_hunk)
        map('n', '<leader>gR', gitsigns.reset_buffer)
        map('n', '<leader>gp', gitsigns.preview_hunk)
        map('n', '<leader>gb', function() gitsigns.blame_line{full=true} end)
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
        map('n', '<leader>gd', gitsigns.diffthis)
        map('n', '<leader>gD', function() gitsigns.diffthis('~') end)
        map('n', '<leader>td', gitsigns.toggle_deleted)

        -- Text object
        map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
      end,

      signs = {
        add = { text = symbols.git_bar, },
        change = { text = symbols.git_bar, },
        delete = { text = symbols.git_deleted_below, },
        topdelete = { text = symbols.git_deleted_above, },
        changedelete = { text = symbols.git_bar, },
      },
      signs_staged = {
        add = { text = symbols.git_bar, },
        change = { text = symbols.git_bar, },
        delete = { text = symbols.git_deleted_below, },
        topdelete = { text = symbols.git_deleted_above, },
        changedelete = { text = symbols.git_bar, },
      },
      signs_staged_enable = true,
      numhl = false,
      linehl = false,
      current_line_blame = true,
      current_line_blame_formatter = '   <author>, <author_time:%R> • <summary>',
    })

    vim.cmd [[
      onoremap ih <cmd>lua require('gitsigns').select_hunk()<CR>
      xnoremap ih <cmd>lua require('gitsigns').select_hunk()<CR>

      augroup gitsigns_overrides
      autocmd!
        highlight! GitSignsStagedAdd guifg=#284414
        highlight! GitSignsStagedChange guifg=#5a3e08
        highlight! GitSignsStagedChangeLn guifg=#5a3e08
        highlight! GitSignsStagedChangeNr guifg=#5a3e08
        highlight! GitSignsStagedChangedelete guifg=#5a3e08
        highlight! GitSignsStagedChangedeleteLn guifg=#5a3e08
        highlight! GitSignsStagedChangedeleteN guifg=#5a3e08
        highlight! GitGutterChange guifg=#5a3e08 guibg=NONE
        highlight! GitGutterAdd guifg=#284414 guibg=NONE
        highlight! GitGutterDelete guifg=#5f050d guibg=NONE
        highlight! GitSignsChange guifg=#5a3e08 guibg=NONE
        highlight! GitSignsChangeNr guifg=#5a3e08 guibg=NONE
        highlight! GitSignsChangeLn guifg=#5a3e08 guibg=NONE
        highlight! GitSignsAdd guifg=#284414 guibg=NONE
        highlight! GitSignsDelete guifg=#5f050d guibg=NONE
      augroup END
      ]]
  end
}
