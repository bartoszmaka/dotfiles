local function augroup(name)
  return vim.api.nvim_create_augroup("autocmds_lua" .. name, { clear = true })
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

vim.api.nvim_create_autocmd({ 'BufEnter','BufNewFile','BufWritePost' }, {
  group = augroup("tmux_rename_on_enter"),
  callback = function ()
    vim.system({"tmux", "rename-window", vim.fn.expand("%:.")})
  end
  }
)

vim.api.nvim_create_autocmd({ "VimLeave" }, {
  group = augroup("tmux_rename_on_exit"),
  callback = function ()
    vim.system({"tmux", "rename-window", vim.uv.cwd()})
  end
  }
)

-- vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
--   callback = function()
--     local ok, cl = pcall(vim.api.nvim_win_get_var, 0, "auto-cursorline")
--     if ok and cl then
--       vim.wo.cursorline = true
--       vim.api.nvim_win_del_var(0, "auto-cursorline")
--     end
--   end,
-- })

-- vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
--   callback = function()
--     local cl = vim.wo.cursorline
--     if cl then
--       vim.api.nvim_win_set_var(0, "auto-cursorline", cl)
--       vim.wo.cursorline = false
--     end
--   end,
-- })

vim.cmd [[
  filetype plugin on
  command! CopyPath execute 'let @+ = expand("%:.")'
  nnoremap <leader>cp :CopyPath<CR>

  " autocmd BufEnter,BufNewFile,BufWritePost * call system("tmux rename-window " . expand("%:."))
  " autocmd VimLeave * call system("tmux rename-window `pwd`")

  " augroup color_current_line_in_insert
  "   autocmd!
  "   autocmd InsertEnter * if index(['TelescopePrompt'], &ft) < 0 | highlight! CursorLine   guibg=#512121 | endif
  "   autocmd InsertEnter * if index(['TelescopePrompt'], &ft) < 0 | highlight! CursorLineNR guibg=#512121 | endif
  "   autocmd InsertEnter * if index(['TelescopePrompt'], &ft) < 0 | highlight! CursorLineSign guibg=#512121 | endif
  "   autocmd InsertLeave * if index(['TelescopePrompt'], &ft) < 0 | highlight! CursorLine   guibg=#21283b | endif
  "   autocmd InsertLeave * if index(['TelescopePrompt'], &ft) < 0 | highlight! CursorLineNR guibg=#21283b | endif
  "   autocmd InsertLeave * if index(['TelescopePrompt'], &ft) < 0 | highlight! CursorLineSign guibg=#21283b | endif
  " augroup END

  augroup fix_filetype
    autocmd! BufRead,BufNewFile,BufEnter *.sh setf sh
  augroup END
]]

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("Closeq"),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})
