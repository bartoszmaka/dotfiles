local nnoremap = require('config_helper').nnoremap

vim.g.ale_enabled = 0

vim.g.ale_set_loclist = 0
vim.g.ale_set_quickfix = 0
vim.g.ale_echo_cursor = 1
vim.g.ale_virtualtext_cursor = 1
vim.g.ale_cursor_detail = 0

vim.g.ale_hover_cursor = 1
vim.g.ale_disable_lsp = 0
vim.g.ale_floating_preview = 0
vim.g.ale_hover_to_floating_preview = 0
vim.g.ale_detail_to_floating_preview = 1
vim.g.ale_close_preview_on_insert = 1
vim.g.ale_floating_window_border = {'│', '─', '╭', '╮', '╯', '╰'}
vim.g.ale_virtualtext_delay = 350
vim.g.ale_echo_msg_format = '[%linter%] [%severity%] %s'

vim.g.ale_linters_explicit = 1
vim.g.ale_lint_on_text_changed = 'never'
vim.g.ale_lint_delay = 600
vim.g.ale_lint_on_insert_leave = 1

local project = vim.fn.getcwd()

if string.match(project, 'DevQAHub') then
  vim.g.ale_linters = {
    ["*"] = { 'remove_trailing_lines', 'trim_whitespace' },
    javascript = { 'tsserver', 'eslint' },
    typescript = { 'tsserver', 'eslint' },
    javascriptreact = { 'tsserver', 'eslint' },
    typescriptreact = { 'tsserver', 'eslint' },
    scss = { 'scsslint', 'stylelint' },
    ruby = { 'standardrb' },
  }
  vim.g.ale_fixers = {
    ["*"] = { 'remove_trailing_lines', 'trim_whitespace' },
    javascript = { 'prettier' },
    typescript = { 'prettier' },
    typescriptreact = { 'prettier' },
    scss = { 'prettier' },
    ruby = { 'standardrb' },
  }
else
  vim.g.ale_linters = {
    ["*"] = { 'remove_trailing_lines', 'trim_whitespace' },
    javascript = { 'tsserver', 'eslint' },
    typescript = { 'tsserver', 'eslint' },
    javascriptreact = { 'tsserver', 'eslint' },
    typescriptreact = { 'tsserver', 'eslint' },
    scss = { 'scsslint', 'stylelint' },
    ruby = { 'rubocop' },
  }
  vim.g.ale_fixers = {
    ["*"] = { 'remove_trailing_lines', 'trim_whitespace' },
    javascript = { 'prettier' },
    typescript = { 'prettier' },
    javascriptreact = { 'tsserver', 'eslint' },
    typescriptreact = { 'prettier' },
    scss = { 'prettier' },
    ruby = { 'rubocop' },
  }
end
vim.g.ale_ruby_rubocop_executable = 'bundle'

_G.setup_ale = function()
  _G.use_ale = true

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      underline = false,
      virtual_text = false,
      signs = false,
      update_in_insert = false,
    }
  )

  vim.g.ale_enabled = 1

  -- use a floating window to show the lint problems

  -- customize the linters
  -- vim.g.ale_yaml_yamllint_options = '-f ' .. vim.fn.stdpath("config") .. "/linters/yamllint.yml"

  nnoremap('[e', ':ALEPreviousWrap<CR>:ALEDetail<CR>', { silent = true })
  nnoremap(']e', ':ALENextWrap<CR>:ALEDetail<CR>', { silent = true })

  nnoremap("<leader>df", ":ALEFix<CR>")
  nnoremap("<leader>dd", ":ALEDetail<CR>")
  nnoremap("<leader>dl", ":ALELint<CR>")
  nnoremap("<leader>dL", ":ALEToggle<CR>")
  nnoremap("<C-m><C-f>", ":ALEFix<CR>")

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
  vim.cmd[[ALEDisable]]
  vim.cmd[[ALEEnable]]
end

-- vim.cmd[[
-- autocmd BufRead */subster-web* lua _G.setup_ale()
-- autocmd BufRead */subster-booking* lua _G.setup_ale()
-- autocmd BufRead */DevQAHub* lua _G.setup_ale()
-- ]]
