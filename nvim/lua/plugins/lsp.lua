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
        reuse_client = function(client, config)
          return client.config.root_dir == config.root_dir
        end,
      })

      vim.lsp.enable(lsps)

      vim.diagnostic.config({
        severity_sort = true,
        underline = true,
        virtual_lines = false,
        virtual_text = true,
        update_in_insert = true,
        float = {
          show_header = true,
          border = "rounded",
          focusable = true,
        },
        signs = {
          priority = 10,
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.INFO] = " ",
            [vim.diagnostic.severity.HINT] = "󰠠 ",
          },
        },
      })

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

          if client and client.server_capabilities.documentHighlightProvider then
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
