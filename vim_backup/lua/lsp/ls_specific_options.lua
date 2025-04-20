local efm = require('lsp/efm_specific_options')

return  {
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
          },
        },
        telemetry = {
          enable = false,
        },
      },
    }
  },
  vtsls = {
    settings = {
      languages = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
      typescript = {
        updateImportsOnFileMove = { enabled = "always" },
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
        updateImportsOnFileMove = { enabled = "always" },
        inlayHints = {
          parameterNames = { enabled = "literals" },
          parameterTypes = { enabled = true },
          variableTypes = { enabled = true },
          propertyDeclarationTypes = { enabled = true },
          functionLikeReturnTypes = { enabled = true },
          enumMemberValues = { enabled = true },
        },
      },
      vtsls = {
        enableMoveToFileCodeAction = true,
      },
    },
  },
  jsonls = {
    on_new_config = function(new_config)
      new_config.settings.json.schemas = new_config.settings.json.schemas or {}
      vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
    end,
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
        format = { enable = true }
      },
    }
  },
  yamlls = {
    settings = {
      yaml = {
        keyOrdering = false,
      },
    }
  },
  ruby_lsp = {
    filetypes = { 'ruby', 'eruby' },
    init_options = {
      enabledFeatures = {
        codeActions = true,
        codeLens = true,
        completion = true,
        definition = true,
        diagnostics = true,
        documentHighlights = true,
        documentLink = true,
        documentSymbols = true,
        foldingRanges = true,
        formatting = true,
        hover = true,
        inlayHint = true,
        onTypeFormatting = true,
        selectionRanges = true,
        semanticHighlighting = true,
        signatureHelp = true,
        typeHierarchy = true,
        workspaceSymbol = true
      },
      featuresConfiguration = {
        inlayHint = {
          implicitHashValue = true,
          implicitRescue = true
        }
      },
      -- formatter = "auto",
      -- linters = {},
      experimentalFeaturesEnabled = true
    }
  },
  solargraph = {
    filetypes = { 'ruby', 'eruby' },
    settings = {
      solargraph = {
        diagnostics = true,
      },
    }
  },
  efm = {
    settings = {
      rootMarkers = { ".git/" },
      languages = efm.languages
    },
    filetypes = vim.tbl_keys(efm.languages),
    init_options = { documentFormatting = true, codeAction = true }
  },
  emmet_language_server = {
    filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "svelte", "pug", "typescriptreact", "vue" },
    init_options = {
      preferences = {},
      showexpandedabbreviation = "always",
      showabbreviationsuggestions = true,
      showsuggestionsassnippets = false,
      syntaxprofiles = {},
      variables = {},
      excludelanguages = {},
    }
  }
}
