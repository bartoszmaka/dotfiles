-- local navicLoaded, navic = pcall(require, 'nvim-navic')
-- local gpsLoaded, gps = pcall(require, 'nvim-gps')

local colors = require('helper.colors').onedark
local symbols = require('helper.symbols')

local M = {}

local copilot_colors = {
  [""] = { fg = colors.green },
  ["Normal"] = { fg = colors.green },
  ["Warning"] = { fg = colors.orange },
  ["InProgress"] = { fg = colors.blue },
}

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

-- Recording Status
M.recording = function()
  local reg = vim.fn.reg_recording()
  if reg == "" then return "" end -- not recording
  return "󰑊 REC @" .. reg
end

M.theme = {
  onedark = {
    normal = {
      a = { fg = colors.bg0, bg = colors.green, gui = 'bold' },
      b = { fg = colors.fg, bg = colors.bg0 },
      c = { fg = colors.fg, bg = colors.bg_d },
      x = { fg = colors.fg, bg = colors.bg_d },
      y = { fg = colors.fg, bg = colors.bg_d },
      z = { fg = colors.bg0, bg = colors.green, gui = 'none' },
    },
    command = {
      a = { fg = colors.bg0, bg = colors.yellow, gui = 'bold' },
      z = { fg = colors.bg0, bg = colors.yellow, gui = 'none' },
    },
    insert = {
      a = { fg = colors.bg0,  bg = colors.blue, gui = 'bold' },
      z = { fg = colors.bg_d, bg = colors.blue, gui = 'none' },
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
  },
  github_dark_default = {
    normal = {
      a = { fg = colors.black, bg = colors.blue_bright, gui = 'bold' },
      b = { fg = colors.fg, bg = colors.bg },
      c = { fg = colors.fg, bg = colors.bg },
      x = { fg = colors.fg, bg = colors.bg },
      y = { fg = colors.fg, bg = colors.bg },
      z = { fg = colors.bg0, bg = colors.green, gui = 'none' },
    },
    command = {
      a = { fg = colors.fg, bg = colors.yellow, gui = 'bold' },
      z = { fg = colors.fg, bg = colors.yellow, gui = 'none' },
    },
    insert = {
      a = { fg = colors.fg,  bg = colors.green_bright, gui = 'bold' },
      z = { fg = colors.bg, bg = colors.green_bright, gui = 'none' },
    },
    visual = {
      a = { fg = colors.fg, bg = colors.yellow_bright, gui = 'bold' },
      z = { fg = colors.fg, bg = colors.yellow_bright, gui = 'none' },
    },
    terminal = {
      a = { fg = colors.fg, bg = colors.yellow, gui = 'bold' },
      z = { fg = colors.fg, bg = colors.yellow, gui = 'none' },
    },
    replace = {
      a = { fg = colors.fg, bg = colors.red_bright, gui = 'bold' },
      z = { fg = colors.fg, bg = colors.red_bright, gui = 'none' },
    },
    -- inactive = {
    --   a = { fg = colors.bg0, bg = colors.bg, gui = 'bold' },
    --   b = { fg = colors.fg, bg = colors.bg },
    --   c = { fg = colors.grey, bg = colors.bg },
    --   z = { fg = colors.grey, bg = colors.bg, gui = 'none' },
    -- },
  }
}

M.components = {
  recording = { M.recording },
  diagnostics = {
    'diagnostics',
    sources = { 'nvim_lsp' },
    sections = { 'error', 'warn', 'info', 'hint' },
    color_error = colors.red,   -- changes diagnostic's error foreground color
    color_warn = colors.orange, -- changes diagnostic's warn foreground color
    color_info = colors.blue,   -- Changes diagnostic's info foreground color
    color_hint = colors.blue,   -- Changes diagnostic's hint foreground color
    symbols = {
      error = ' ' .. symbols.Error .. ' ',
      warn = ' ' .. symbols.Warn .. ' ',
      info = ' ' .. symbols.Info .. ' ',
      hint = ' ' .. symbols.Hint .. ' ',
    }
  },
  diff = {
    'diff',
    icon = '  ',
    colored = false,                                          -- displays diff status in color if set to true
    -- all colors are in format #rrggbb
    color_added = nil,                                        -- changes diff's added foreground color
    color_modified = nil,                                     -- changes diff's modified foreground color
    color_removed = nil,                                      -- changes diff's removed foreground color
    symbols = { added = '+', modified = '~', removed = '-' }, -- changes diff symbols
  },
  location = {
    'location',
    fmt = function()
      local max_lines = vim.fn.line('$')
      local line = vim.fn.line('.')
      local column = vim.fn.col('.')
      return string.format(" %3d/%d:%2d ", line, max_lines, column)
    end
  },
  filetype = { 'filetype', colored = true, icon_only = true },
  filename = { 'filename', file_status = true, path = 1 },
  -- navic = {
  --   function()
  --     return " " .. (navic.get_location() or require('nvim-gps').get_location())
  --   end,
  --   cond = function()
  --     return (navicLoaded and navic.is_available()) or (require('nvim-gps').is_available())
  --   end,
  --   padding = { left_padding = 2, right_padding = 0 }
  -- },
  flags = { M.getFlags, color = { fg = colors.yellow } },
  copilot = {
    function()
      local icon = symbols.Copilot
      local status = require("copilot.api").status.data
      return icon .. (status.message or "")
    end,
    cond = function()
      local ok, clients = pcall(vim.lsp.get_active_clients, { name = "copilot", bufnr = 0 })
      return ok and #clients > 0
    end,
    color = function()
      local status = require("copilot.api").status.data
      return copilot_colors[status.status] or colors[""]
    end,
  },
  winbar_filetype = { 'filetype', colored = false, icon_only = true },
  winbar_filename = { 'filename', path = 1,        file_status = true },
  winbar_filetype_inactive = { 'filetype', colored = false, icon_only = true },
  winbar_filename_inactive = { 'filename', path = 1,        file_status = true, color = { fg = colors.grey } },
  -- dropbar = {
  --   function() return require('dropbar.utils').bar.get_current() end
  -- },
}

return M
