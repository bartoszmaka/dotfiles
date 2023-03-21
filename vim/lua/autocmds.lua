local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  command = "checktime",
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

vim.cmd [[
  filetype plugin on
  command! CopyPath execute 'let @+ = expand("%")'

  function! ClearRegisters()
    let regs='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-="*+'
    let i=0
    while (i<strlen(regs))
        exec 'let @'.regs[i].'=""'
        let i=i+1
    endwhile
  endfunction
  command! ClearRegisters call ClearRegisters()

  autocmd BufEnter,BufNewFile,BufWritePost * call system("tmux rename-window " . expand("%"))
  autocmd VimLeave * call system("tmux rename-window `pwd`")

  " augroup remember_cursor_position
  "   autocmd!
  "   autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  " augroup END

  augroup color_current_line_in_insert
    autocmd!
    autocmd InsertEnter * highlight! CursorLine   guibg=#512121
    autocmd InsertEnter * highlight! CursorLineNR guibg=#512121
    autocmd InsertLeave * highlight! CursorLine   guibg=#21283b
    autocmd InsertLeave * highlight! CursorLineNR guibg=#21283b
  augroup END
]]
