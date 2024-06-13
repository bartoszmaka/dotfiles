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
    filetypes = { 'ruby' }
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
