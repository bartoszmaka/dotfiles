local function augroup(name)
  return vim.api.nvim_create_augroup("autocmds_lua" .. name, { clear = true })
end

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufNewFile', 'BufWritePost' }, {
  group = augroup("tmux_rename_on_enter"),
  callback = function()
    vim.system({ "tmux", "rename-window", vim.fn.expand("%.") })
  end
})

vim.api.nvim_create_autocmd({ "VimLeave" }, {
  group = augroup("tmux_rename_on_exit"),
  callback = function()
    vim.system({ "tmux", "rename-window", vim.uv.cwd() })
  end
})

vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  command = "checktime",
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.cmd [[
augroup remember_folds
  autocmd!
  autocmd BufWinLeave *.* mkview
  autocmd BufWinEnter *.* silent! loadview
augroup END
]]
