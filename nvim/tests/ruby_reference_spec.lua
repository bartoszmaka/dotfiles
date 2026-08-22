local config_root = vim.fn.fnamemodify(debug.getinfo(1, 'S').source:sub(2), ':p:h:h')

package.path = table.concat({
  config_root .. '/lua/?.lua',
  config_root .. '/lua/?/init.lua',
  package.path,
}, ';')

local ruby_reference = require('helper.ruby_reference')

local source = {
  'module CustomerLoyalty',
  '  module Points',
  '    class Calculator',
  '      def call',
  '      end',
  '    end',
  '',
  '    class << self',
  '      def system_gets_cents_for(points)',
  '      end',
  '    end',
  '',
  '    def self.system_gets_points_for(cents)',
  '    end',
  '',
  '    CENTS_PER_POINT = 100',
  '    cents = 100',
  '  end',
  'end',
}

vim.api.nvim_buf_set_lines(0, 0, -1, false, source)
vim.bo.filetype = 'ruby'

local cases = {
  { row = 0, col = 9, expected = 'CustomerLoyalty' },
  { row = 1, col = 10, expected = 'CustomerLoyalty::Points' },
  { row = 2, col = 12, expected = 'CustomerLoyalty::Points::Calculator' },
  { row = 3, col = 11, expected = 'CustomerLoyalty::Points::Calculator#call' },
  { row = 8, col = 15, expected = 'CustomerLoyalty::Points.system_gets_cents_for' },
  { row = 12, col = 18, expected = 'CustomerLoyalty::Points.system_gets_points_for' },
  { row = 15, col = 10, expected = 'CustomerLoyalty::Points::CENTS_PER_POINT' },
}

for _, case in ipairs(cases) do
  local actual, err = ruby_reference.reference_at_cursor(0, case.row, case.col)
  assert(actual == case.expected, string.format('expected %q, got %q (%s)', case.expected, actual, err or 'no error'))
end

local actual = ruby_reference.reference_at_cursor(0, 8, 6)
assert(actual == nil, 'expected non-name cursor position to return nil, got ' .. tostring(actual))

actual = ruby_reference.reference_at_cursor(0, 16, 6)
assert(actual == nil, 'expected local variable assignment to return nil, got ' .. tostring(actual))
