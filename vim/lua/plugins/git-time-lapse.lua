vim.cmd[[
function! s:git_time_lapse()
  call git-time-lapse#git_time_lapse()
endfunction

command! -nargs=0 GitTimeLapse call gittimelapse#git_time_lapse()
noremap <silent> <script> <Plug>(git-time-lapse) :<C-u> call git-time-lapse#git_time_lapse()<CR>
]]
