return {
  'tpope/vim-rails',
  config = function()
    local nnoremap = require('helper').nnoremap

    vim.g.rails_no_alternate_commands = 1
    nnoremap('<leader>ec', ':Econtroller<CR>')
    nnoremap('<leader>ev', ':Eview<CR>')
    nnoremap('<leader>es', ':Eschema<CR>')
    nnoremap('<leader>emo', ':Emodel<CR>')
    nnoremap('<leader>ema', ':Emailer<CR>')
    nnoremap('<leader>emi', ':Emigration<CR>')
    nnoremap('<leader>en', ':Eenvironment<CR>')
    nnoremap('<leader>ela', ':Elayout<CR>')
    nnoremap('<leader>eli', ':Elib<CR>')
    nnoremap('<leader>elo', ':Elocale<CR>')
    nnoremap('<leader>esp', ':Espec<CR>')
    nnoremap('<leader>est', ':Estylesheet<CR>')
    nnoremap('<leader>et', ':Etask<CR>')

    -- nnoremap('<leader>ef', ':Efixtures<CR>')
    -- nnoremap('<leader>ec', ':Efunctionaltest<CR>')
    -- nnoremap('<leader>ec', ':Einitializer<CR>')
    -- nnoremap('<leader>ec', ':Eintegrationtest<CR>')
    -- nnoremap('<leader>ec', ':Ejavascript<CR>')
  end,
}
