local M = {}

local conditions = require("heirline.conditions")
local colors = require("helper.colors").onedark
local symbols = require("helper.symbols")

local mode_colors = {
  n = colors.green,
  i = colors.blue,
  v = colors.purple,
  V = colors.purple,
  ["\22"] = colors.purple,
  c = colors.orange,
  s = colors.yellow,
  S = colors.yellow,
  ["\19"] = colors.yellow,
  R = colors.red,
  r = colors.red,
  ["!"] = colors.red,
  t = colors.cyan,
}

local mode_names = {
  n = "NORMAL",
  no = "OP",
  nov = "OP",
  noV = "OP",
  ["no\22"] = "OP",
  niI = "NORMAL",
  niR = "NORMAL",
  niV = "NORMAL",
  nt = "NORMAL",
  v = "VISUAL",
  vs = "VISUAL",
  V = "V-LINE",
  Vs = "V-LINE",
  ["\22"] = "V-BLOCK",
  ["\22s"] = "V-BLOCK",
  s = "SELECT",
  S = "S-LINE",
  ["\19"] = "S-BLOCK",
  i = "INSERT",
  ic = "INSERT",
  ix = "INSERT",
  R = "REPLACE",
  Rc = "REPLACE",
  Rx = "REPLACE",
  Rv = "V-REPLACE",
  Rvc = "V-REPLACE",
  Rvx = "V-REPLACE",
  c = "COMMAND",
  cv = "EX",
  ce = "EX",
  r = "PROMPT",
  rm = "MORE",
  ["r?"] = "CONFIRM",
  ["!"] = "SHELL",
  t = "TERMINAL",
}

local function mode_color(self)
  local key = (self.mode or vim.fn.mode(1)):sub(1, 1)
  return mode_colors[key] or colors.blue
end

M.statusline = {
  hl = { bg = colors.bg_d, fg = colors.fg },
  init = function(self)
    self.mode = vim.fn.mode(1)
  end,
  {
    provider = function(self)
      return " " .. (mode_names[self.mode] or self.mode) .. " "
    end,
    hl = function(self)
      return { fg = colors.black, bg = mode_color(self), bold = true }
    end,
    update = { "ModeChanged", pattern = "*:*" },
  },
  { provider = "%=", hl = { bg = colors.bg_d } },
  {
    condition = conditions.lsp_attached,
    provider = function()
      local names = {}
      for _, client in ipairs(vim.lsp.get_clients { bufnr = 0 }) do
        table.insert(names, client.name)
      end
      if #names == 0 then return "" end
      return " " .. table.concat(names, ", ") .. " "
    end,
    hl = { fg = colors.green, bg = colors.bg_d },
    update = { "LspAttach", "LspDetach", "BufEnter" },
  },
  {
    condition = conditions.has_diagnostics,
    init = function(self)
      self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
      self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
      self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
      self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    end,
    {
      provider = " ",
      hl = { bg = colors.bg_d },
    },
    {
      condition = function(self)
        return self.errors > 0
      end,
      provider = function(self)
        return symbols.Error .. " " .. self.errors .. " "
      end,
      hl = { fg = colors.red, bg = colors.bg_d },
    },
    {
      condition = function(self)
        return self.warnings > 0
      end,
      provider = function(self)
        return symbols.Warn .. " " .. self.warnings .. " "
      end,
      hl = { fg = colors.yellow, bg = colors.bg_d },
    },
    {
      condition = function(self)
        return self.info > 0
      end,
      provider = function(self)
        return symbols.Info .. " " .. self.info .. " "
      end,
      hl = { fg = colors.cyan, bg = colors.bg_d },
    },
    {
      condition = function(self)
        return self.hints > 0
      end,
      provider = function(self)
        return symbols.Hint .. " " .. self.hints .. " "
      end,
      hl = { fg = colors.dark_cyan, bg = colors.bg_d },
    },
    update = { "DiagnosticChanged", "BufEnter" },
  },
  {
    provider = function()
      local ft = vim.bo.filetype
      return ft ~= "" and (" " .. ft .. " ") or ""
    end,
    hl = { fg = colors.grey, bg = colors.bg_d },
  },
  {
    provider = function()
      return string.format(" %d/%d ", vim.fn.line("."), vim.fn.line("$"))
    end,
    hl = function(self)
      return { fg = colors.black, bg = mode_color(self), bold = true }
    end,
    update = { "CursorMoved", "CursorMovedI", "BufEnter" },
  },
}

return M
