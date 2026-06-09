local config_root = vim.fn.fnamemodify(debug.getinfo(1, 'S').source:sub(2), ':p:h:h')

package.path = table.concat({
  config_root .. '/lua/?.lua',
  config_root .. '/lua/?/init.lua',
  package.path,
}, ';')

vim.cmd('filetype on')
require('autocmds')

local function assert_filetype(filename, expected)
  local path = '/private/tmp/' .. filename
  vim.fn.delete(path)
  vim.cmd.edit(vim.fn.fnameescape(path))

  local actual = vim.bo.filetype
  vim.cmd('bwipeout!')
  vim.fn.delete(path)

  assert(actual == expected, string.format('expected %s to use filetype %q, got %q', filename, expected, actual))
end

assert_filetype('codex-filetype-test.mdc', 'markdown')
