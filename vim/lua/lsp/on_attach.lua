local set_contains = require('config_helper.set_contains').set_contains
local set_default_formatter_for_filetypes = require('lsp.functions').set_default_formatter_for_filetypes

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  if set_contains({ 'css', 'scss', 'sass' }, vim.bo.filetype) then
    buf_set_option('omnifunc', 'csscomplete#CompleteCSS')
  elseif set_contains({ 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' }, vim.bo.filetype) then
    local ts_utils = require("nvim-lsp-ts-utils")
    ts_utils.setup({
      debug = false,
      disable_commands = false,
      enable_import_on_completion = true,
      import_all_timeout = 5000, -- ms
      import_all_priorities = {
        same_file = 1, -- add to existing import statement
        local_files = 2, -- git files or files with relative path markers
        buffer_content = 3, -- loaded buffer content
        buffers = 4, -- loaded buffer names
      },
      import_all_scan_buffers = 100,
      import_all_select_source = false,
      filter_out_diagnostics_by_severity = { 'hint' },
      filter_out_diagnostics_by_code = { 80001 },
      auto_inlay_hints = true,
      inlay_hints_highlight = "Comment",
      update_imports_on_move = true,
      require_confirmation_on_move = true,
      watch_dir = nil,
    })
    ts_utils.setup_client(client)

  else
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  end
  -- Mappings.
  local opts = { noremap=true, silent=true }
  vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
  vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
  vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
  vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
  vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
  vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
  vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
  vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
  vim.cmd("command! LspDiagPrev lua vim.diagnostic.goto_prev()")
  vim.cmd("command! LspDiagNext lua vim.diagnostic.goto_next()")
  vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")

  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<leader>K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<leader><C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap("v", "<C-m><C-f>", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  buf_set_keymap("v", "<CR><C-f>", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  buf_set_keymap('n', '[e', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']e', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap("n", "<C-m>f", "<cmd>lua vim.lsp.buf.formatting_seq_sync()<CR>", opts)
  buf_set_keymap("n", "<C-m><C-f>", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  buf_set_keymap("n", "<CR>f", "<cmd>lua vim.lsp.buf.formatting_seq_sync()<CR>", opts)
  buf_set_keymap("n", "<CR><C-f>", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  buf_set_keymap("n", "<leader>mF", "<cmd>lua vim.lsp.buf.formatting_seq_sync()<CR>", opts)
  buf_set_keymap("n", "<leader>mf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  -- buf_set_keymap("n", "gh", "<cmd>lua require('lsp.functions').PeekDefinition()<CR>", opts)
  -- buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

  set_default_formatter_for_filetypes('solargraph', {'ruby'})
  set_default_formatter_for_filetypes('null-ls', {'javascript', 'vue'})
end

return on_attach
