return {
  'SirVer/ultisnips',
  config = function()
    vim.g.UltiSnipsExpandTrigger = '<Plug>(ultisnips_expand)'
    vim.g.UltiSnipsJumpForwardTrigger = '<Plug>(ultisnips_jump_forward)'
    vim.g.UltiSnipsJumpBackwardTrigger = '<Plug>(ultisnips_jump_backward)'
    vim.g.UltiSnipsListSnippets = '<c-x><c-s>'
    vim.g.UltiSnipsRemoveSelectModeMappings = 0

    vim.cmd [[
      augroup setup_snippet_aliases
      autocmd!

      autocmd FileType eruby UltiSnipsAddFiletypes eruby
      autocmd FileType javascript UltiSnipsAddFiletypes javascriptreact
      autocmd FileType typescript UltiSnipsAddFiletypes javascript.javascriptreact
      autocmd FileType javascriptreact UltiSnipsAddFiletypes javascript
      autocmd FileType typescriptreact UltiSnipsAddFiletypes javascript.typescript.javascriptreact
      autocmd FileType javascript.jsx UltiSnipsAddFiletypes javascript.javascriptreact.javascript.jsx
      autocmd FileType typescript.tsx UltiSnipsAddFiletypes javascript.typescript.javascriptreact.javascript.jsx
      autocmd FileType vue UltiSnipsAddFiletypes javascript.typescript.javascriptreact.javascript.jsx
      augroup END
      ]]
  end
}
