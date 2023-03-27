return {
  'RRethy/vim-illuminate',
  config = function()
    require('illuminate').configure({
      delay = 200
    })

    vim.cmd[[
      augroup illuminate_overrides
        autocmd!
        highlight! illuminatedWord guibg=#314365
        highlight! illuminatedCurWord guibg=#314365 gui=bold
        highlight! link IlluminatedWordRead illuminatedWord
        highlight! link IlluminatedWordWrite illuminatedWord
        highlight! link IlluminatedWordText None
      augroup END
    ]]
  end
}
