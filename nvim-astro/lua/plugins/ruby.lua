return {
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "ruby" })
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed =
        require("astrocore").list_insert_unique(opts.ensure_installed, { "solargraph", "ruby_lsp" })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed =
        require("astrocore").list_insert_unique(opts.ensure_installed, { "solargraph", "ruby_lsp" })
    end,
  },
  {
    'tpope/vim-rails',
    -- ft = { "ruby", "eruby", "yaml", "toml" },
    config = function()
      local nnoremap = require('helper').nnoremap

      vim.g.rails_no_alternate_commands = 1
      nnoremap('<leader>ec', ':Econtroller<CR>', { desc = "Go to controller" })
      nnoremap('<leader>ev', ':Eview<CR>', { desc = "Go to view" })
      nnoremap('<leader>es', ':Eschema<CR>', { desc = "Go to schema" })
      nnoremap('<leader>emo', ':Emodel<CR>', { desc = "Go to model" })
      nnoremap('<leader>ema', ':Emailer<CR>', { desc = "Go to mailer" })
      nnoremap('<leader>emi', ':Emigration<CR>', { desc = "Go to migration" })
      nnoremap('<leader>en', ':Eenvironment<CR>', { desc = "Go to environment" })
      nnoremap('<leader>ela', ':Elayout<CR>', { desc = "Go to layout" })
      nnoremap('<leader>eli', ':Elib<CR>', { desc = "Go to lib" })
      nnoremap('<leader>elo', ':Elocale<CR>', { desc = "Go to locale" })
      nnoremap('<leader>esp', ':Espec<CR>', { desc = "Go to spec" })
      nnoremap('<leader>est', ':Estylesheet<CR>', { desc = "Go to stylesheet" })
      nnoremap('<leader>et', ':Etask<CR>', { desc = "Go to task" })

      -- nnoremap('<leader>ef', ':Efixtures<CR>')
      -- nnoremap('<leader>ec', ':Efunctionaltest<CR>')
      -- nnoremap('<leader>ec', ':Einitializer<CR>')
      -- nnoremap('<leader>ec', ':Eintegrationtest<CR>')
      -- nnoremap('<leader>ec', ':Ejavascript<CR>')

      vim.g.rails_projections = {
        ['app/*.rb'] = {
          ['alternate'] = 'spec/{}_spec.rb',
          ['type'] = 'source'
        },
        ['lib/*.rb'] = {
          ['alternate'] = 'spec/{}_spec.rb',
          ['type'] = 'source'
        },
        ['spec/*_spec.rb'] = {
          ['alternate'] = 'app/{}.rb',
          ['type'] = 'test'
        },
        ['app/controllers/*_controller.rb'] = {
          ['alternate'] = 'spec/requests/{}_spec.rb',
          ['type'] = 'test'
        },
        ['spec/requests/*_spec.rb'] = {
          ['alternate'] = 'app/controllers/{}_controller.rb',
          ['type'] = 'test'
        },
        ['app/graphql/types/*_type.rb'] = {
          ['alternate'] = 'spec/requests/graphql/{}s_spec.rb',
          ['type'] = 'source',
        },
        ['spec/requests/graphql/*s_spec.rb'] = {
          ['alternate'] = 'app/graphql/types/{}_type.rb',
          ['type'] = 'source',
        }
      }
    end,
  }

  -- {
  --   "stevearc/conform.nvim",
  --   optional = true,
  --   opts = {
  --     formatters_by_ft = {
  --       ruby = { "standardrb" },
  --     },
  --   },
  -- },
}
