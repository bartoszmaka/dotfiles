local M = {}

M.t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

M.deprioritize_underscore = function(lhs, rhs)
  local l = (lhs.completion_item.label:find '^_+') and 1 or 0
  local r = (rhs.completion_item.label:find '^_+') and 1 or 0
  if l ~= r then return l < r end
end

M.prioritize_argument = function(lhs, rhs)
  local l = (lhs.completion_item.label:find '=$') and 1 or 0
  local r = (rhs.completion_item.label:find '=$') and 1 or 0
  if l ~= r then return l > r end
end

M.is_prior_char_whitespace = function()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
end

M.has_words_before = function()
  if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match('^%s*$') == nil
end

return M
