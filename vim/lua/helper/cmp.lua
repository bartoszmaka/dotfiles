local symbols = require('helper').symbols
local tailwind_formatter = require("tailwindcss-colorizer-cmp").formatter
local get = require('helper').get

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
  local lsp_name_shorthand = ({
    emmet_language_server = 'emmet',
  })
  local source_tag = ({
    buffer = '[Buf]',
    omni = '[Omni]',
    ultisnips = '[Snip]',
    spell = '[Spell]',
    cmp_tabnine = '[AI]',
    copilot = '[AI]',
    cmdline = '[CMD]',
    nvim_lsp_signature_help = '[Arg]',
  })[entry.source.name] or entry.source.name or ''

  local icon = symbols[vim_item.kind]

  if entry.source.name == 'nvim_lsp' then
    local ls_name = get(entry, 'source.source.client.config.name')
    source = lsp_name_shorthand[ls_name] or ls_name or ''
    source_tag = '(' .. source .. ')'

    if ls_name == 'tailwindcss' and vim_item.kind == 'Color' then
      local formatted = tailwind_formatter(entry, vim_item)

      if formatted.kind == "X" then
        formatted.kind = formatted.kind
      end
    end
  end

  vim_item.kind = ' ' .. icon .. ' '
  vim_item.menu = ' ' .. source_tag

  return vim_item
end

return M
