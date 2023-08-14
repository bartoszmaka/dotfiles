return {}
-- return {
--   'dense-analysis/ale',
--   config = function()
--     vim.g.ale_lint_on_text_changed = 'never'
--     vim.g.ale_lint_on_insert_leave = 0
--     vim.g.ale_fix_on_save = 1
--     vim.g.ale_open_list = 0
--     vim.g.ale_fixers = {
--       astro = { 'prettier' },
--       css = { 'prettier' },
--       go = { 'gofmt', 'goimports' },
--       hcl = { 'remove_trailing_lines', 'terraform', 'trim_whitespace' },
--       javascript = { 'prettier' },
--       json = { 'prettier' },
--       jsonc = { 'prettier' },
--       python = { 'black', 'ruff' },
--       ruby = { 'rubocop' },
--       rust = { 'rustfmt' },
--       typescript = { 'prettier' },
--       typescriptreact = { 'prettier' },
--     }
--     vim.g.ale_linters = {
--       beancount = {},
--       graphql = { 'gqlint' },
--       rust = { 'analyzer' },
--       python = { 'pyright', 'ruff' },
--     }
--     vim.g.ale_echo_msg_format = '%linter%:%code%: %s'
--     vim.g.ale_floating_preview = 1
--     vim.g.ale_python_ruff_options = '--unfixable F401,F841'
--     vim.g.ale_javascript_eslint_suppress_eslintignore = 1
--     vim.g.ale_javascript_eslint_suppress_missing_config = 1
--     vim.g.ale_rust_analyzer_config = {
--       diagnostics = { disabled = { 'inactive-code' } },
--       procMacro = { enable = 1 },
--     }
--     vim.g.ale_sign_error = ' ✖'
--     vim.g.ale_sign_warning = ' •'

--     vim.cmd [[
--     function! s:on_ready(linter, lsp_details) abort
--     let l:id = a:lsp_details.connection_id
--     let l:buffer = a:lsp_details.buffer

--     if ale#lsp#HasCapability(l:id, 'definition')
--     call setbufvar(l:buffer, 'use_ale_tags_fallback', 0)
--     endif
--     endfunction

--     function! s:ale_lint_post() abort
--       let l:buffer = bufnr('')
--     let l:Callback = function('s:on_ready')

--     if getbufvar(l:buffer, 'checked_ale_tags_fallback', 0)
--     return
--       else
--     call setbufvar(l:buffer, 'checked_ale_tags_fallback', 1)
--     endif

--     for l:linter in ale#linter#Get(getbufvar(l:buffer, '&filetype'))
--     if !empty(l:linter.lsp)
--     call ale#lsp_linter#StartLSP(l:buffer, l:linter, l:Callback)
--     endif
--     endfor
--     endfunction

--     augroup ALETagsFallback
--     autocmd!
--     autocmd User ALELSPStarted call s:ale_lint_post()
--     augroup END

--     function! s:execute(lsp_has_definition, fallback) abort
--     let l:buffer = bufnr('')

--     try
--     if getbufvar(l:buffer, 'use_ale_tags_fallback', 1)
--     execute a:fallback
--       else
--       execute a:lsp_has_definition
--       endif
--       catch
--       execute 'echohl ErrorMsg | echomsg v:exception | echohl None'
--     endtry
--     endfunction

--     command! -bar ALETagsFallbackGoToDefinition call s:execute("ALEGoToDefinition", "normal! \<C-]>")
--     command! -bar ALETagsFallbackGoToDefinitionInSplit call s:execute("ALEGoToDefinition -split", "normal! \<C-W>\<C-]>")

--     nnoremap <silent> <Plug>(ale_tags_fallback_go_to_definition) :ALETagsFallbackGoToDefinition<Return>
--     nnoremap <silent> <Plug>(ale_tags_fallback_go_to_definition_in_split) :ALETagsFallbackGoToDefinitionInSplit<Return>

--     " }}}

--     " The ALEDisable and ALEEnable family actually only affect linters, for some
--     " reason.
--     command! ALEDisableFix let g:ale_fix_on_save = 0
--     command! ALEEnableFix let g:ale_fix_on_save = 1
--     command! ALEDisableFixBuffer let b:ale_fix_on_save = 0
--     command! ALEEnableFixBuffer let b:ale_fix_on_save = 1

--     nmap gh <Plug>(ale_hover)
--     nmap gd <Plug>(ale_go_to_definition)
--     nmap gt <Plug>(ale_go_to_type_definition)
--     nmap <C-]> <Plug>(ale_tags_fallback_go_to_definition)
--     nmap <C-W><C-]> <Plug>(ale_tags_fallback_go_to_definition_in_vsplit)
--     nmap <C-W>gd <Plug>(ale_go_to_definition_in_vsplit)
--     nmap <C-W>gt <Plug>(ale_go_to_type_definition_in_vsplit)

--     " Set up a prettier sign for warnings/errors

-- ]]
--   end
-- }
