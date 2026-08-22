return {
  {
    'neovim/nvim-lspconfig',
    lazy = false,
    dependencies = {
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      {
        'j-hui/fidget.nvim',
        event = 'LspAttach',
        opts = {
          progress = {
            display = {
              progress_icon = { pattern = 'dots', period = 1 },
            },
          },
        },
      },
    },
    config = function()
      local symbols = require('helper.symbols')
      local colors = require('helper.colors').onedark

      local function is_real_file_buffer(bufnr)
        if not vim.api.nvim_buf_is_valid(bufnr) then
          return false
        end

        if vim.bo[bufnr].buftype ~= '' then
          return false
        end

        local bufname = vim.api.nvim_buf_get_name(bufnr)
        if bufname == '' then
          return false
        end

        local stat = vim.uv.fs_stat(bufname)
        return stat ~= nil and stat.type == 'file'
      end

      local lsps = {
        'ruby_lsp',
        'pyright',
        'vtsls',
        'eslint',
        'tailwindcss',
        'cssls',
        'emmet_language_server',
        'jsonls',
        'yamlls',
        'bashls',
        'lua_ls',
        'dockerls',
        'graphql',
      }

      local capabilities = require('blink.cmp').get_lsp_capabilities(nil, true)
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

      vim.lsp.config('*', {
        capabilities = capabilities,
        root_markers = { '.git' },
      })

      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' },
            },
          },
        },
      })

      vim.lsp.config('vtsls', {
        filetypes = {
          'javascript',
          'javascriptreact',
          'typescript',
          'typescriptreact',
        },
        settings = {
          typescript = {
            tsserver = {
              maxTsServerMemory = 8192,
            },
            inlayHints = {
              parameterNames = { enabled = 'all' },
              parameterTypes = { enabled = true },
              variableTypes = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              enumMemberValues = { enabled = true },
            },
          },
          javascript = {
            inlayHints = {
              parameterNames = { enabled = 'all' },
              parameterTypes = { enabled = true },
              variableTypes = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              enumMemberValues = { enabled = true },
            },
          },
        },
      })

      vim.lsp.config('tailwindcss', {
        filetypes = {
          'html', 'css', 'scss',
          'javascript', 'javascriptreact',
          'typescript', 'typescriptreact',
          'eruby',
        },
      })

      require('mason').setup()
      require('mason-lspconfig').setup({
        ensure_installed = lsps,
        automatic_enable = false,
      })

      -- ruby_lsp should only come up in projects that actually have a Gemfile.
      -- A dynamic root_dir() that simply never calls on_dir() is the documented
      -- way to skip activation (:h lsp-root_dir), and it keeps ruby_lsp on the
      -- same vim.lsp.enable() path as every other server.
      --
      -- The previous hand-rolled `vim.lsp.start(vim.lsp.config['ruby_lsp'], ...)`
      -- autocmds could not work: vim.lsp.start() only resolves root markers from
      -- `opts._root_markers`, never from `config.root_markers` (see lsp.lua:745),
      -- so ruby_lsp always started with root_dir = nil. It then fell back to
      -- nvim's cwd -- fine when nvim was launched from the project, silently
      -- broken (or exiting outright) otherwise. nil root_dir also defeated client
      -- reuse: reuse_client_default treats "no workspace" as matching anything, so
      -- a second Ruby project reused the first project's client instead of
      -- starting its own. (The custom reuse_client above was dead code -- lsp.start
      -- reads opts.reuse_client, not config.reuse_client.)
      vim.lsp.config('ruby_lsp', {
        filetypes = { 'ruby', 'eruby' },
        root_dir = function(bufnr, on_dir)
          local bufname = vim.api.nvim_buf_get_name(bufnr)
          local search_path = bufname ~= '' and vim.fs.dirname(bufname) or vim.fn.getcwd()
          local gemfile = vim.fs.find('Gemfile', { upward = true, path = search_path })[1]
          if gemfile then
            on_dir(vim.fs.dirname(gemfile))
          end
        end,
      })

      vim.lsp.enable(lsps)

      vim.diagnostic.config({
        severity_sort = true,
        underline = true,
        virtual_lines = false,
        virtual_text = true,
        update_in_insert = false,
        float = {
          show_header = true,
          border = 'single',
          focusable = true,
        },
        signs = false,
      })

      vim.keymap.set('n', '[e', function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = 'Prev diagnostic' })
      vim.keymap.set('n', ']e', function() vim.diagnostic.jump({ count = 1, float = true }) end,  { desc = 'Next diagnostic' })
      vim.keymap.set('n', '<leader>E', vim.diagnostic.open_float, { desc = 'Show diagnostics' })
      vim.keymap.set('n', '<leader>K', vim.lsp.buf.hover, { desc = 'Show hover documentation' })
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code action' })
      vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, { desc = 'Rename symbol' })
      vim.keymap.set('n', '<C-m><C-e>', vim.diagnostic.setloclist, { desc = 'Diagnostics to loclist' })

      local function attached_client_names(bufnr)
        local names = {}
        for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
          table.insert(names, client.name)
        end
        return names
      end

      local function collect_clients(filter, scope)
        local query = scope == 'buffer' and { bufnr = vim.api.nvim_get_current_buf() } or {}
        local clients = vim.lsp.get_clients(query)
        if filter and filter ~= '' then
          clients = vim.tbl_filter(function(c) return c.name == filter end, clients)
        end
        return clients
      end

      -- Re-run nvim's own activation logic for one buffer. It re-resolves
      -- filetypes/root_dir and starts whatever applies and isn't attached yet.
      local function activate_buffer()
        vim.cmd('silent! doautocmd nvim.lsp.enable FileType')
      end

      vim.api.nvim_create_user_command('LspRestart', function(opts)
        local bufnr = vim.api.nvim_get_current_buf()
        local clients = collect_clients(opts.args, 'buffer')

        if #clients == 0 then
          vim.notify('LspRestart: no matching LSP client on this buffer', vim.log.levels.WARN)
          return
        end

        local names = {}
        for _, client in ipairs(clients) do
          table.insert(names, client.name)
          client:stop(true)
        end

        vim.defer_fn(function()
          vim.lsp.enable(names)
          activate_buffer()
          vim.notify('LspRestart: ' .. table.concat(names, ', '))
        end, 500)
      end, {
        nargs = '?',
        complete = function() return attached_client_names(vim.api.nvim_get_current_buf()) end,
        desc = 'Restart LSP server(s) attached to current buffer',
      })

      vim.api.nvim_create_user_command('LspRestartAll', function(opts)
        local clients = collect_clients(opts.args, 'all')

        if #clients == 0 then
          vim.notify('LspRestartAll: no matching LSP clients running', vim.log.levels.WARN)
          return
        end

        local seen = {}
        local names = {}
        for _, client in ipairs(clients) do
          if not seen[client.name] then
            seen[client.name] = true
            table.insert(names, client.name)
          end
          client:stop(true)
        end

        vim.defer_fn(function()
          vim.lsp.enable(names)
          vim.cmd('silent! doautoall nvim.lsp.enable FileType')
          vim.notify('LspRestartAll: ' .. table.concat(names, ', '))
        end, 500)
      end, {
        nargs = '?',
        complete = function()
          local seen, names = {}, {}
          for _, client in ipairs(vim.lsp.get_clients()) do
            if not seen[client.name] then
              seen[client.name] = true
              table.insert(names, client.name)
            end
          end
          return names
        end,
        desc = 'Restart every running LSP server (or one by name)',
      })

      vim.api.nvim_create_user_command('LspStart', function(opts)
        local bufnr = vim.api.nvim_get_current_buf()

        local before = {}
        for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
          before[client.name] = true
        end

        if opts.args ~= '' then
          local ok, err = pcall(vim.lsp.enable, opts.args)
          if not ok then
            vim.notify('LspStart: ' .. tostring(err), vim.log.levels.ERROR)
            return
          end
        end

        activate_buffer()

        vim.defer_fn(function()
          local started = {}
          for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
            if not before[client.name] then
              table.insert(started, client.name)
            end
          end

          if #started > 0 then
            vim.notify('LspStart: ' .. table.concat(started, ', '))
          elseif next(before) then
            vim.notify('LspStart: already attached (' .. table.concat(vim.tbl_keys(before), ', ') .. ')')
          else
            vim.notify(
              'LspStart: nothing started -- no configured server matches ft=' ..
              (vim.bo[bufnr].filetype == '' and '(none)' or vim.bo[bufnr].filetype) ..
              ', or its root_dir did not resolve. :LspInfo / :LspLog for details.',
              vim.log.levels.WARN
            )
          end
        end, 500)
      end, {
        nargs = '?',
        complete = function()
          local attached = {}
          for _, client in ipairs(vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })) do
            attached[client.name] = true
          end
          return vim.tbl_filter(function(name) return not attached[name] end, lsps)
        end,
        desc = 'Start configured LSP server(s) for the current buffer',
      })

      vim.api.nvim_create_user_command('LspStop', function(opts)
        local clients = collect_clients(opts.args, 'buffer')

        if #clients == 0 then
          vim.notify('LspStop: no matching LSP client on this buffer', vim.log.levels.WARN)
          return
        end

        local names = {}
        for _, client in ipairs(clients) do
          table.insert(names, client.name)
          client:stop(true)
        end
        vim.notify('LspStop: ' .. table.concat(names, ', '))
      end, {
        nargs = '?',
        complete = function() return attached_client_names(vim.api.nvim_get_current_buf()) end,
        desc = 'Stop LSP server(s) attached to current buffer',
      })

      -- vim.api.nvim_create_user_command("Format", function(_)
      --   vim.lsp.buf.format()
      -- end, { desc = "Format current buffer with LSP" })

      vim.api.nvim_create_augroup('LspDocumentHighlight', { clear = true })
      vim.api.nvim_set_hl(0, 'LspReferenceRead',  { bg = colors.bg2 })
      vim.api.nvim_set_hl(0, 'LspReferenceText',  { bg = colors.bg3 })
      vim.api.nvim_set_hl(0, 'LspReferenceWrite', { bg = colors.diff_add })

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          local bufnr = args.buf

          if client and client.server_capabilities.documentHighlightProvider and is_real_file_buffer(bufnr) then
            vim.api.nvim_create_autocmd('CursorHold', {
              group = 'LspDocumentHighlight',
              buffer = bufnr,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd('CursorMoved', {
              group = 'LspDocumentHighlight',
              buffer = bufnr,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })
    end,
    keys = {
      { '<leader>cl', ':LspInfo<CR>', desc = 'Lsp Info' },
      { '<leader>cm', ':Mason<CR>',   desc = 'Mason Info' },
    },
  },
}
