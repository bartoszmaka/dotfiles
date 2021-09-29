vim.g.UltiSnipsRemoveSelectModeMappings = 0
vim.g.UltiSnipsExpandTrigger="<C-e>"
vim.g.UltiSnipsJumpForwardTrigger="<C-e>"
vim.g.UltiSnipsJumpBackwardTrigger="<C-b>"

vim.cmd[[
  augroup setup_snippet_aliases
    autocmd!

    autocmd FileType javascript UltiSnipsAddFiletypes javascriptreact
    autocmd FileType typescript UltiSnipsAddFiletypes javascript.javascriptreact
    autocmd FileType javascriptreact UltiSnipsAddFiletypes javascript
    autocmd FileType typescriptreact UltiSnipsAddFiletypes javascript.typescript.javascriptreact
    autocmd FileType javascript.jsx UltiSnipsAddFiletypes javascript.javascriptreact.javascript.jsx
    autocmd FileType typescript.tsx UltiSnipsAddFiletypes javascript.typescript.javascriptreact.javascript.jsx
  augroup END
]]
