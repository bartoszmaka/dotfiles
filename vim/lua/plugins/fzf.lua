local config_helper = require('config_helper')
local nnoremap = config_helper.nnoremap

vim.cmd[[
let $FZF_DEFAULT_OPTS='--layout=reverse'
let g:fzf_command_prefix = 'Fzf'
let g:fzf_mru_relative = 1
let g:fzf_colors = { 'bg': ['bg', 'FZFNormal'] }
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 }}

command! -bang -nargs=? -complete=dir FZFFilesPreview call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
autocmd FileType fzf tnoremap <buffer> <esc> <esc>
]]

vim.api.nvim_command[[
  command! -count=1 HFiles call fzf#run({
        \ 'source': 'git log HEAD -n <count> --diff-filter=MA --name-only --pretty=format: | sed -e /^$/d',
        \ 'sink': 'e',
        \ 'window': 'call FloatingFZF()'
        \ })
]]

vim.g.mapleader = ' '
nnoremap('<leader>pp', ':FZFFilesPreview<CR>')
nnoremap('<leader>pr', ':FZFFreshMruPreview<CR>')
nnoremap('<leader>pg', ':FzfGitFiles?<CR>')
nnoremap('<leader>pb', ':FzfBuffers<CR>')
nnoremap('<leader>pf', ':FzfRg<CR>')
nnoremap('<leader>pl', ':FzfBLines<CR>')
nnoremap('<leader>pv', ':FzfBCommits<CR>')
nnoremap('<leader>pm', ':FzfMarks<CR>')
nnoremap('<leader>pc', ':FzfCommands<CR>')
nnoremap('<leader>pt', ':FzfBTags<CR>')
nnoremap('<leader>ph1', ':HFiles 1<CR>')
nnoremap('<leader>ph2', ':HFiles 2<CR>')
nnoremap('<leader>ph3', ':HFiles 3<CR>')
nnoremap('<leader>ph4', ':HFiles 4<CR>')
nnoremap('<leader>ph5', ':HFiles 5<CR>')
