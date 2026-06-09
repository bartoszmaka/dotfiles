local function augroup(name)
  return vim.api.nvim_create_augroup('autocmds_lua' .. name, { clear = true })
end

vim.filetype.add({
  extension = {
    mdc = 'markdown',
  },
})

if vim.fn.exists('$TMUX') == 1 then
  vim.api.nvim_create_autocmd({ 'BufEnter', 'BufNewFile', 'BufWritePost' }, {
    group = augroup('tmux_rename_on_enter'),
    callback = function()
      vim.system({ 'tmux', 'rename-window', vim.fn.expand('%.') })
    end,
  })

  vim.api.nvim_create_autocmd({ 'VimLeave' }, {
    group = augroup('tmux_rename_on_exit'),
    callback = function()
      vim.system({ 'tmux', 'rename-window', vim.uv.cwd() })
    end,
  })
end

vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = augroup('checktime'),
  command = 'checktime',
})

vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup('highlight_yank'),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- vim.api.nvim_create_autocmd("FileType", {
--   group = augroup("autotag_eruby"),
--   pattern = "eruby",
--   callback = function()
--     local ok, autotag = pcall(require, "nvim-ts-autotag")
--     if ok then autotag.setup() end
--   end,
-- })

vim.api.nvim_create_autocmd('FileType', {
  group = augroup('autotag_attach'),
  pattern = '*',
  callback = function()
    local ok, autotag_internal = pcall(require, 'nvim-ts-autotag.internal')
    if ok then autotag_internal.attach() end
  end,
})

vim.api.nvim_create_autocmd('BufDelete', {
  group = augroup('autotag_detach'),
  pattern = '*',
  callback = function(args)
    local ok, autotag_internal = pcall(require, 'nvim-ts-autotag.internal')
    if ok then autotag_internal.detach(args.buf) end
  end,
})
