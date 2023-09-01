return {
  'tpope/vim-rails',
  config = function()
    local nnoremap = require('helper').nnoremap

    vim.g.rails_no_alternate_commands = 1
    -- nnoremap('<leader>s', ':R<CR>')
  end,
}
