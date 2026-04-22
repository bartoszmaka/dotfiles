return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      {
        "j-hui/fidget.nvim",
        event = "LspAttach",
        opts = {
          progress = {
            display = {
              progress_icon = { pattern = "dots", period = 1 },
            },
          },
        },
      },
    },
    config = function()
      local symbols = require("helper.symbols")

      local function is_real_file_buffer(bufnr)
        if not vim.api.nvim_buf_is_valid(bufnr) then
          return false
        end

        if vim.bo[bufnr].buftype ~= "" then
          return false
        end

        local bufname = vim.api.nvim_buf_get_name(bufnr)
        if bufname == "" then
          return false
        end

        local stat = vim.uv.fs_stat(bufname)
        return stat ~= nil and stat.type == "file"
      end

      local lsps = {
        "ruby_lsp",
        "vtsls",
        "eslint",
        "tailwindcss",
        "cssls",
        "emmet_language_server",
        "jsonls",
        "yamlls",
        "bashls",
        "lua_ls",
        "dockerls",
        "graphql",
      }

      local capabilities = require("blink.cmp").get_lsp_capabilities(nil, true)
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

      vim.lsp.config("*", {
        capabilities = capabilities,
        root_markers = { ".git" },
      })

      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })

      vim.lsp.config("vtsls", {
        filetypes = {
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
        },
        settings = {
          typescript = {
            tsserver = {
              maxTsServerMemory = 8192,
            },
            inlayHints = {
              parameterNames = { enabled = "all" },
              parameterTypes = { enabled = true },
              variableTypes = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              enumMemberValues = { enabled = true },
            },
          },
          javascript = {
            inlayHints = {
              parameterNames = { enabled = "all" },
              parameterTypes = { enabled = true },
              variableTypes = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              enumMemberValues = { enabled = true },
            },
          },
        },
      })

      vim.lsp.config("tailwindcss", {
        filetypes = {
          "html", "css", "scss",
          "javascript", "javascriptreact",
          "typescript", "typescriptreact",
          "eruby",
        },
      })

      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = lsps,
        automatic_installation = true,
        automatic_enable = false,
      })

      vim.lsp.config("ruby_lsp", {
        filetypes = { "ruby", "eruby" },
        reuse_client = function(client, config)
          return client.config.root_dir == config.root_dir
        end,
      })

      vim.lsp.enable(lsps)

      local ruby_lsp_auto_start_group = vim.api.nvim_create_augroup("ruby_lsp_auto_start", { clear = true })

      local function start_ruby_lsp_for_project(bufnr)
        if not is_real_file_buffer(bufnr) then
          return
        end

        local bufname = vim.api.nvim_buf_get_name(bufnr)
        local filetype = vim.bo[bufnr].filetype
        if filetype ~= "ruby" and filetype ~= "eruby" then
          return
        end

        local search_path = bufname ~= "" and vim.fs.dirname(bufname) or vim.fn.getcwd()
        local gemfile = vim.fs.find("Gemfile", { upward = true, path = search_path })[1]
        if not gemfile then
          return
        end

        vim.lsp.start(vim.lsp.config["ruby_lsp"], { bufnr = bufnr })
      end

      vim.api.nvim_create_autocmd({ "VimEnter", "BufEnter", "BufNewFile" }, {
        group = ruby_lsp_auto_start_group,
        callback = function(args)
          start_ruby_lsp_for_project(args.buf)
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        group = ruby_lsp_auto_start_group,
        pattern = { "ruby", "eruby" },
        callback = function(args)
          start_ruby_lsp_for_project(args.buf)
        end,
      })

      vim.diagnostic.config({
        severity_sort = true,
        underline = true,
        virtual_lines = false,
        virtual_text = true,
        update_in_insert = false,
        float = {
          show_header = true,
          border = "single",
          focusable = true,
        },
        signs = {
          priority = 10,
          text = {
            [vim.diagnostic.severity.ERROR] = symbols.Error,
            [vim.diagnostic.severity.WARN] = symbols.Warn,
            [vim.diagnostic.severity.INFO] = symbols.Info,
            [vim.diagnostic.severity.HINT] = symbols.Hint,
          },
        },
      })

      -- local original_signs_handler = vim.diagnostic.handlers.signs
      -- local diagnostic_signs_namespace = vim.api.nvim_create_namespace("diagnostic_signs")
      -- local diagnostics_by_buffer = {}
      -- local signs_opts_by_buffer = {}
      --
      -- local function show_collapsed_signs(bufnr, opts)
      --   opts = opts or signs_opts_by_buffer[bufnr] or {}
      --   opts.signs = opts.signs or {}
      --
      --   local highest_per_line = {}
      --   local by_namespace = diagnostics_by_buffer[bufnr]
      --   if by_namespace then
      --     for _, diagnostics in pairs(by_namespace) do
      --       for _, diagnostic in ipairs(diagnostics) do
      --         local current = highest_per_line[diagnostic.lnum]
      --         if not current or diagnostic.severity < current.severity then
      --           highest_per_line[diagnostic.lnum] = diagnostic
      --         end
      --       end
      --     end
      --   end
      --
      --   original_signs_handler.show(diagnostic_signs_namespace, bufnr, vim.tbl_values(highest_per_line), opts)
      -- end
      --
      -- vim.diagnostic.handlers.signs = {
      --   show = function(namespace, bufnr, diagnostics, opts)
      --     diagnostics_by_buffer[bufnr] = diagnostics_by_buffer[bufnr] or {}
      --     diagnostics_by_buffer[bufnr][namespace] = diagnostics
      --     signs_opts_by_buffer[bufnr] = opts
      --     show_collapsed_signs(bufnr, opts)
      --   end,
      --   hide = function(namespace, bufnr)
      --     if diagnostics_by_buffer[bufnr] then
      --       diagnostics_by_buffer[bufnr][namespace] = nil
      --       if vim.tbl_isempty(diagnostics_by_buffer[bufnr]) then
      --         diagnostics_by_buffer[bufnr] = nil
      --         signs_opts_by_buffer[bufnr] = nil
      --         original_signs_handler.hide(diagnostic_signs_namespace, bufnr)
      --         return
      --       end
      --     end
      --     show_collapsed_signs(bufnr)
      --   end,
      -- }

      vim.keymap.set("n", "[e", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
      vim.keymap.set("n", "]e", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
      vim.keymap.set("n", "<leader>E", vim.diagnostic.open_float, { desc = "Show diagnostics" })
      vim.keymap.set("n", "<leader>K", vim.lsp.buf.hover, { desc = "Show hover documentation" })
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
      vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename symbol" })
      vim.keymap.set("n", "<C-m><C-e>", vim.diagnostic.setloclist, { desc = "Diagnostics to loclist" })

      vim.api.nvim_create_user_command("Format", function(_)
        vim.lsp.buf.format()
      end, { desc = "Format current buffer with LSP" })

      vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = true })
      vim.cmd [[
        hi! LspReferenceRead  guibg=#283347
        hi! LspReferenceText  guibg=#2a324a
        hi! LspReferenceWrite guibg=#1a2e1b
      ]]

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          local bufnr = args.buf

          if client and client.server_capabilities.documentHighlightProvider and is_real_file_buffer(bufnr) then
            vim.api.nvim_create_autocmd("CursorHold", {
              group = "LspDocumentHighlight",
              buffer = bufnr,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd("CursorMoved", {
              group = "LspDocumentHighlight",
              buffer = bufnr,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })
    end,
    keys = {
      { "<leader>cl", ":LspInfo<CR>", desc = "Lsp Info" },
      { "<leader>cm", ":Mason<CR>", desc = "Mason Info" },
    },
  },
}
