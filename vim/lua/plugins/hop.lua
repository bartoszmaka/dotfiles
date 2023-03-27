return {
  'phaazon/hop.nvim',
  branch = 'v1',
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

    vim.cmd[[
      augroup hop_overrides
        autocmd!

        highlight! HopNextKey guibg=#1a212e guifg=#efbd5d
        highlight! HopNextKey1 guibg=#1a212e guifg=#efbd5d
        highlight! HopNextKey2 guibg=#1a212e guifg=#dd9046
        highlight! HopUnmatched guibg=#1a212e
      augroup END
    ]]
  end,
}
