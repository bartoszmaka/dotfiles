return {
  'tpope/vim-projectionist',
  config = function()
    local nnoremap = require('config_helper').nnoremap
    vim.g.projectionist_heuristics = {
      -- vue
      ['*'] = {
        ['*.vue'] = {
          ['alternate'] = '__tests__/{}.test.js',
          ['type'] = 'source'
        },

        -- javascript
        ['*.js'] = {
          ['alternate'] = '{dirname}/__tests__/{basename}.test.js',
          ['type'] = 'source'
        },
        ['**/__tests__/*.test.js'] = {
          ['alternate'] = '{dirname}/{basename}.js',
          ['type'] = 'test'
        },

        -- typescript
        ['*.ts'] = {
          ['alternate'] = '__tests__/{}.test.ts',
          ['type'] = 'source'
        },
        ['__tests__/*.test.ts'] = {
          ['alternate'] = '{}.ts',
          ['type'] = 'test'
        },

        -- ruby/rails
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
    }

   -- nnoremap('<leader>a', ':A<CR>')
    nnoremap('<leader>a', ':silent! :A<CR>') -- ignore E315
  end,
}
