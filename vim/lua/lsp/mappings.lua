local M = {}
M.set_mappings = function()

  local function set_keymap(...) vim.api.nvim_set_keymap(...) end
  local opts = { noremap = true, silent = true }

  -- some are defined in vim/lua/plugins/lspsaga.lua
  -- buf_set_keymap('n', '<leader>K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  -- buf_set_keymap('n', '<leader><C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- buf_set_keymap('n', '[e', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  -- buf_set_keymap('n', ']e', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  -- buf_set_keymap("n", "gh", "<cmd>lua require('lsp.functions').PeekDefinition()<CR>", opts)
  -- buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

  set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  set_keymap("v", "<C-m><C-f>", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  set_keymap("v", "<CR><C-f>", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)

  if (vim.fn.has('nvim-0.8') == 1) then
    set_keymap("n", "<C-m><C-f>", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)
    set_keymap("n", "<CR><C-f>", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)
    set_keymap("n", "<leader>mf", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)
    set_keymap("n", "<CR>f", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
    set_keymap("n", "<C-m>f", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
    set_keymap("n", "<leader>mF", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
  else
    set_keymap("n", "<C-m><C-f>", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    set_keymap("n", "<CR><C-f>", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    set_keymap("n", "<leader>mf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    set_keymap("n", "<CR>f", "<cmd>lua vim.lsp.buf.formatting_seq_sync()<CR>", opts)
    set_keymap("n", "<C-m>f", "<cmd>lua vim.lsp.buf.formatting_seq_sync()<CR>", opts)
    set_keymap("n", "<leader>mF", "<cmd>lua vim.lsp.buf.formatting_seq_sync()<CR>", opts)
  end

  function FormatRangeOperator()
    local old_func = vim.go.operatorfunc
    _G.op_func_formatting = function()
      local start = vim.api.nvim_buf_get_mark(0, '[')
      local finish = vim.api.nvim_buf_get_mark(0, ']')
      vim.lsp.buf.range_formatting({}, start, finish)
      vim.go.operatorfunc = old_func
      _G.op_func_formatting = nil
    end
    vim.go.operatorfunc = 'v:lua.op_func_formatting'
    vim.api.nvim_feedkeys('g@', 'n', false)
  end

  set_keymap("n", "gm", "<cmd>lua FormatRangeOperator()<CR>", opts)
end

return M
