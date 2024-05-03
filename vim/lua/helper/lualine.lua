local colors = require('helper.colors').onedark

local M = {}

M.getFlags = function()
  local flags = {}
  if string.len(vim.fn["gutentags#statusline"]()) > 0 then table.insert(flags, '♺') end

  return table.concat(flags, ' ')
end

M.isOnlySplitOpen = function()
  if vim.fn.winnr('$') == 1 then
    return true
  end

  local excluded_filetypes = {}
  return false
end

M.isNotOnlySplitOpen = function()
  return not M.isOnlySplitOpen()
end

M.theme = {
  onedark = {
    normal = {
      a = { fg = colors.bg0, bg = colors.green, gui = 'bold' },
      b = { fg = colors.fg, bg = colors.bg_d },
      c = { fg = colors.fg, bg = colors.bg_d },
      y = { fg = colors.fg, bg = colors.bg3 },
      z = { fg = colors.bg0, bg = colors.green, gui = 'none' },
    },
    command = {
      a = { fg = colors.bg0, bg = colors.yellow, gui = 'bold' },
      z = { fg = colors.bg0, bg = colors.yellow, gui = 'none' },
    },
    insert = {
      a = { fg = colors.bg0, bg = colors.blue, gui = 'bold' },
      z = { fg = colors.bg0, bg = colors.blue, gui = 'none' },
    },
    visual = {
      a = { fg = colors.bg0, bg = colors.purple, gui = 'bold' },
      z = { fg = colors.bg0, bg = colors.purple, gui = 'none' },
    },
    terminal = {
      a = { fg = colors.bg0, bg = colors.cyan, gui = 'bold' },
      z = { fg = colors.bg0, bg = colors.cyan, gui = 'none' },
    },
    replace = {
      a = { fg = colors.bg0, bg = colors.red, gui = 'bold' },
      z = { fg = colors.bg0, bg = colors.red, gui = 'none' },
    },
    inactive = {
      a = { fg = colors.bg0, bg = colors.bg, gui = 'bold' },
      b = { fg = colors.fg, bg = colors.bg },
      c = { fg = colors.grey, bg = colors.bg },
      z = { fg = colors.grey, bg = colors.bg, gui = 'none' },
    },
  }
}

return M
