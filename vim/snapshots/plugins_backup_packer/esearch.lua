vim.cmd[[
nmap <leader>f  <plug>(esearch)
]]

vim.cmd [[
let g:esearch = {}
let g:esearch.name = '[esearch]'
let g:esearch.win_new = {esearch -> esearch#buf#goto_or_open(esearch.name, 'vnew')}
]]

-- -- vim.g.esearch = {
-- --   name = '[esearch]',
-- --   win_new = {esearch -> esearch#buf#goto_or_open(esearch.name, 'vnew')}
-- -- }
