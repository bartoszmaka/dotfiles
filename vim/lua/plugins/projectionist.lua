local config_helper = require('config_helper')

local nnoremap = config_helper.nnoremap

vim.g.projectionist_heuristics = {
  ['*'] = {
    ['*.vue'] = {
      ['alternate'] = '__tests__/{}.test.js',
      ['type'] = 'source'
    },
    ['*.js'] = {
      ['alternate'] = '__tests__/{}.test.js',
      ['type'] = 'source'
    },
    ['__tests__/*.test.js'] = {
      ['alternate'] = '{}.js',
      ['type'] = 'test'
    },
    ['*.ts'] = {
      ['alternate'] = '__tests__/{}.test.ts',
      ['type'] = 'source'
    },
    ['__tests__/*.test.ts'] = {
      ['alternate'] = '{}.ts',
      ['type'] = 'test'
    },
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
    }
  }
}

nnoremap('<leader>a', ':A<CR>')
