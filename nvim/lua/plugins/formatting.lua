return {
  {
    'stevearc/conform.nvim',
    config = function()
      local conform = require('conform')
      local util = require('conform.util')
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

      conform.setup({
        formatters_by_ft = {
          ['*']           = { 'trim_whitespace', 'codespell' },
          ruby            = { 'rubocop_bundle' },
          javascript      = { 'prettierd', 'prettier' },
          typescript      = { 'prettierd', 'prettier' },
          javascriptreact = { 'prettierd', 'prettier' },
          typescriptreact = { 'prettierd', 'prettier' },
          css             = { 'prettierd', 'prettier' },
          html            = { 'prettierd', 'prettier' },
          json            = { 'prettierd', 'prettier' },
          jsonc           = { 'prettierd', 'prettier' },
          yaml            = { 'prettierd', 'prettier' },
          markdown        = { 'prettierd', 'prettier', 'injected' },
          graphql         = { 'prettierd', 'prettier' },
          lua             = { 'stylua' },
          sh              = { 'beautysh' },
        },
        formatters = {
          rubocop_bundle = {
            command = 'bundle',
            args = {
              'exec',
              'rubocop',
              '--autocorrect-all',
              '--stderr',
              '--stdin',
              '$FILENAME',
            },
            stdin = true,
            cwd = util.root_file({ 'Gemfile', '.rubocop.yml' }),
            require_cwd = true,
          },
        },
        format_on_save = false,
      })

      local format_with_notification = function()
        local bufnr = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { 'Formatting...' })
        local winid = vim.api.nvim_open_win(bufnr, false, {
          relative = 'editor',
          anchor = 'SE',
          row = vim.o.lines - 2,
          col = vim.o.columns,
          width = 20,
          height = 1,
          style = 'minimal',
          border = 'rounded',
          focusable = false,
          noautocmd = true,
        })
        vim.bo[bufnr].bufhidden = 'wipe'
        require('conform').format({ async = true, quiet = true, lsp_fallback = true }, function(err)
          vim.api.nvim_win_close(winid, true)
          if err then
            vim.notify(err, vim.log.levels.WARN)
          end
        end)
      end

      vim.keymap.set('n', '<C-m><C-F>', format_with_notification, { desc = 'Format buffer' })
    end,
  },
  {
    'zapling/mason-conform.nvim',
    dependencies = {
      'williamboman/mason.nvim',
      'stevearc/conform.nvim',
    },
    config = function()
      require('mason-conform').setup({
        ensure_installed = {
          'prettierd',
          'prettier',
          'stylua',
        },
      })
    end,
  },
}
