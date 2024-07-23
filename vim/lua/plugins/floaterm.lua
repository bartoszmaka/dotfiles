return {
  'voldikss/vim-floaterm',
  config = function()
    local helper = require('helper')
    local nnoremap = helper.nnoremap
    local tnoremap = helper.tnoremap

    vim.g.floaterm_height = 0.3
    vim.g.floaterm_wintype = 'split'
    vim.g.floaterm_position = 'botright'
    vim.g.floaterm_autoclose = 0

    vim.cmd [[
      autocmd User FloatermOpen setlocal nonumber
      highlight Floaterm guibg=#141b24 guifg=#93a4c3
    ]]

    nnoremap('<C-f><C-f>`', [[:FloatermToggle<CR>]]) -- Mapped to C-` in alactirry
    tnoremap('<C-f><C-f>`', [[<C-\><C-n>:FloatermToggle<CR>]]) -- Mapped to C-` in alactirry
    -- nnoremap('<C-l><C-n>', [[:FloatermToggle<CR>]])
    -- tnoremap('<C-l><C-n>', [[<C-\><C-n>:FloatermToggle<CR>]])
  end
}
