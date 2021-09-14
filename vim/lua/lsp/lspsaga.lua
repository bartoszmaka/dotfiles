local nnoremap = require('config_helper').nnoremap
local vnoremap = require('config_helper').vnoremap
local symbols = require('config_helper/symbols')
local saga = require 'lspsaga'

saga.init_lsp_saga({
  error_sign = symbols.error,
  warn_sign = symbols.warning,
  hint_sign = symbols.information,
  infor_sign = symbols.information,
  code_action_icon = ' ',
  code_action_prompt = {
    enable = true,
    sign = true,
    sign_priority = 20,
    virtual_text = true,
  },
  finder_definition_icon = '  ',
  finder_reference_icon = '  ',
  max_preview_lines = 10, -- preview lines of lsp_finder and definition preview
  finder_action_keys = {
    open = 'o', vsplit = 's',split = 'i',quit = 'q',scroll_down = '<C-f>', scroll_up = '<C-b>' -- quit can be a table
  },
  code_action_keys = {
    quit = 'q',exec = '<CR>'
  },
  rename_action_keys = {
    quit = '<C-c>',exec = '<CR>'  -- quit can be a table
  },
  definition_preview_icon = '  ',
  -- "single" "double" "round" "plus"
  border_style = "round",
  rename_prompt_prefix = '➤',
  -- if you don't use nvim-lspconfig you must pass your server name and
  -- the related filetypes into this table
})

nnoremap('gh', ':Lspsaga preview_definition<CR>')
nnoremap('<silent><leader>ca', ':Lspsaga code_action<CR>')
vnoremap('<silent><leader>ca', ':<C-U>Lspsaga range_code_action<CR>')
vim.cmd[[
nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
nnoremap <silent> gs <cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>
]]
