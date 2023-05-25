return {
  'kevinhwang91/nvim-hlslens',
  config = function()
    require('hlslens').setup({})
    local nnoremap = require('helper').nnoremap

    nnoremap('n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]])
    nnoremap('N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]])
    nnoremap('*', [[*<Cmd>lua require('hlslens').start()<CR>]])
    nnoremap('#', [[#<Cmd>lua require('hlslens').start()<CR>]])
    nnoremap('g*', [[g*<Cmd>lua require('hlslens').start()<CR>]])
    nnoremap('g#', [[g#<Cmd>lua require('hlslens').start()<CR>]])

    vim.cmd[[
      augroup hlslens_overrides
        autocmd!
        highlight! default link CurSearch IncSearch
        highlight! default link HlSearchNear IncSearch
        highlight! default link HlSearchLens Comment
        highlight! default link HlSearchLensNear IncSearch
        highlight! default link HlSearchFloat IncSearch
      augroup END
    ]]
  end
}
