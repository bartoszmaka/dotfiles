vim.g.switch_mapping = ""
vim.cmd[[
nnoremap <leader>s :Switch<CR>
nnoremap <leader>S :SwitchReverse<CR>
autocmd FileType ruby let b:switch_custom_definitions =
    \ [
    \   {
    \     'let!\?(:\([a-zA-Z0-9_]\+\))\W\?{\(.\+\)}': '\1 =\2',
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
]]
