return {
  'phaazon/hop.nvim',
  config = function()
    local nnoremap = require('config_helper').nnoremap

    require('hop').setup {
      keys = 'etovxqpdygfblzhckisuran',
      term_seq_bias = 0.5,
    }

    nnoremap(';j', ':HopLineAC<CR>')
    nnoremap(';k', ':HopLineBC<CR>')
    nnoremap(';w', ':HopWordAC<CR>')
    nnoremap(';b', ':HopWordBC<CR>')
    nnoremap(';f', ':HopPattern<CR>')
  end,
  branch = 'v1',
}
