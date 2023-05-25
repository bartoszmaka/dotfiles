local M = {}

M.getGitInfo = function()
  local diff_data = {0,0,0}
  if vim.fn.exists('b:gitsigns_status') == 1 then
    local gitsigns_dict = vim.api.nvim_buf_get_var(0, 'gitsigns_status')
    diff_data[1] = tonumber(gitsigns_dict:match('+(%d+)')) or 0
    diff_data[2] = tonumber(gitsigns_dict:match('~(%d+)')) or 0
    diff_data[3] = tonumber(gitsigns_dict:match('-(%d+)')) or 0
  end

  return string.format('   +%s ~%s -%s ', diff_data[1], diff_data[2], diff_data[3])
end

M.getTreesitterContext = function()
  local f = require'nvim-treesitter'.statusline({
    indicator_size = vim.fn.winwidth(0) - 48 - string.len(vim.fn.expand('%f')),
    type_patterns = {
      "class",
      'module',
      "function",
      "method",
      "call",
      'block',
      "interface",
      "type_spec",
      "table",
      "if_statement",
      "for_statement",
      "for_in_statement",
      'jsx_element',
      'try_statement',
    },
    separator = ' > ',
    transform_fn = function(line)
      -- if line starts with "<" => return line.split.first
      -- if line starts with "describe|context|it" => return line.split[0]..line.split[1].max(20)
      return line
        :gsub('%s*[%[%(%{]*%s*$', '')
        :gsub("(.*) ?[%[%(%{<].*","%1")
    end
  })
  local context = string.format("%s", f) -- convert to string, it may be a empty ts node

  if context == "vim.NIL" then
    return ""
  end
  return '> ' .. context
end

return M

