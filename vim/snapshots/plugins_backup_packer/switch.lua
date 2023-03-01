vim.g.switch_mapping = ""
vim.cmd[[
nnoremap <leader>x :Switch<CR>
nnoremap <leader>X :SwitchReverse<CR>
autocmd FileType ruby let b:switch_custom_definitions =
    \ [
    \   {
    \     '\([A-Z][a-z]\+\).make!\?(\(.\+\))': 'create(:\L\1\e, \2)',
    \     '\([A-Z][a-z]\+\).make!\?\W\?$': 'create(:\L\1)'
    \   },
    \ ]
autocmd FileType eruby let b:switch_custom_definitions =
    \ [
    \   {
    \     ':\(\k\+\)\s\+=>': '\1:',
    \     '\<\(\k\+\):':     ':\1 =>',
    \   },
    \ ]
autocmd FileType javascript,typescript,javascriptreact,typescriptreact let b:switch_custom_definitions =
    \ [
    \   {
    \     'className="\([a-zA-Z0-9-_]*\)"': 'className={classNames("\1")}',
    \   },
    \ ]
]]

    -- \     'let!\?(:\([a-zA-Z0-9_]\+\))\W\?{\(.\+\)}': '\1 =\2',
