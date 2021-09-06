vim.cmd[[
let g:esearch = {}

nmap <leader>f  <plug>(esearch)
vmap <leader>f  <plug>(operator-esearch-prefill)

let g:esearch.name = '[esearch]'
let g:esearch.win_new = {esearch -> esearch#buf#goto_or_open(esearch.name, 'vnew')}
]]
