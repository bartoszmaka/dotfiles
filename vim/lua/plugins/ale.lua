local nnoremap = require('config_helper').nnoremap

vim.g.ale_enabled = 0
vim.g.ale_disable_lsp = 1

-- use a floating window to show the lint problems
vim.g.ale_hover_cursor = 1
vim.g.ale_floating_preview = 1
-- vim.g.ale_cursor_detail = 1
vim.g.ale_hover_to_floating_preview = 1
vim.g.ale_detail_to_floating_preview = 1
vim.g.ale_close_preview_on_insert = 1
vim.g.ale_floating_window_border = {'│', '─', '╭', '╮', '╯', '╰'}
vim.g.ale_virtualtext_cursor = 1
vim.g.ale_virtualtext_delay = 350
vim.g.ale_echo_cursor = 1
vim.g.ale_echo_msg_format = '[%linter%] [%severity%] %s'

vim.g.ale_linters_explicit = 1
vim.g.ale_lint_on_text_changed = 'never'
vim.g.ale_lint_delay = 600
vim.g.ale_lint_on_insert_leave = 1

vim.g.ale_fixers = {
  ["*"] = { 'remove_trailing_lines', 'trim_whitespace' },
  javascript = { 'prettier', 'eslint' },
  ruby = { 'rubocop' },
}
vim.g.ale_ruby_rubocop_executable = 'bundle'

-- customize the linters
-- vim.g.ale_yaml_yamllint_options = '-f ' .. vim.fn.stdpath("config") .. "/linters/yamllint.yml"

-- nnoremap('[e', ':ALEPreviousWrap<CR>', { silent = true })
-- nnoremap(']e', ':ALENextWrap<CR>', { silent = true })

-- nnoremap("<leader>df", ":ALEFix<CR>")
-- nnoremap("<leader>dd", ":ALEDetail<CR>")
-- nnoremap("<leader>dl", ":ALELint<CR>")
-- nnoremap("<leader>dL", ":ALEToggle<CR>")
-- nnoremap("<C-m><C-f>", ":ALEFix<CR>")

vim.g.ale_sign_error = ""
vim.g.ale_sign_warning = ""
vim.g.ale_sign_info = ""

vim.cmd[[
  augroup ale_configuration
    autocmd!
  
    
    highlight! AleInfo guibg=NONE gui=NONE
    highlight! AleInfoSign guifg=#f2cc81
    highlight! AleWarning guibg=#443333 gui=NONE
    highlight! AleWarningSign guifg=#f2cc81 gui=NONE
    highlight! AleError guibg=#512121 gui=NONE
    highlight! AleErrorSign guifg=#992525 gui=NONE

    autocmd InsertEnter * ALELintStop
  augroup END
]]

  -- let g:ale_lint_timers = []

  -- function! Lint(_)
  --   echomsg('test')
  --   echomsg(g:ale_lint_timers)
  --   ALELint
  -- endfunction

  -- function! ThrottleLint()
  --   for t in g:ale_lint_timers
  --     timer_stop(1)
  --   endfor


  --   let new_timer = timer_start(2000, 'Lint')
  --   call add(g:ale_lint_timers, new_timer)
  -- endfunction
