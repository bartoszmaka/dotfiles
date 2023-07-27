local symbols = require('helper').symbols
local get = require('helper').get
local lspkind_loaded, lspkind = pcall(require, 'lspkind')

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

M.format_entry = function(entry, vim_item)
  local source = ''
  local formatted_source = ''
  -- local source_tag = ({
  --   buffer = '[Buf]',
  --   omni = '[Omni]',
  --   ultisnips = '[Snip]',
  --   spell = '[Spell]',
  --   cmp_tabnine = '[AI]',
  --   copilot = '[AI]',
  --   cmdline = '[CMD]',
  --   nvim_lsp_signature_help = '~ [Sign]',
  -- })[entry.source.name] or entry.source.name

  if entry.source.name == 'nvim_lsp_signature_help' then
    vim_item.kind = string.format('%s %s', symbols.Function, 'Args')
  elseif lspkind_loaded then
    vim_item.kind = lspkind.symbolic(vim_item.kind, { mode = 'symbol_text' })
  else
    vim_item.kind = string.format('%s %s', symbols[vim_item.kind], symbols[vim_item.kind])
  end

  if entry.source.name == 'nvim_lsp' then
    source = get(entry, 'source.source.client.config.name') or ''
    formatted_source = '(' .. source .. ')'
  end

  local strings = vim.split(vim_item.kind, '%s', { trimempty = true })
  vim_item.kind = ' ' .. strings[1] .. ' '
  if entry.source.name ~= "nvim_lsp" and strings[2] == "Text" then
    vim_item.menu = ' ' .. entry.source.name
  else
    vim_item.menu = ' ' .. strings[2] .. ' ' .. formatted_source
  end

  return vim_item
end

return M
