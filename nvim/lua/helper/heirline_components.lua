local M = {}

local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local colors = require("helper.colors").onedark
local symbols = require("helper.symbols")

local diagnostic_line_colors = {
  [vim.diagnostic.severity.ERROR] = colors.red,
  [vim.diagnostic.severity.WARN] = colors.yellow,
  [vim.diagnostic.severity.INFO] = colors.cyan,
  [vim.diagnostic.severity.HINT] = colors.dark_cyan,
}

local function highest_diagnostic_severity(bufnr, lnum)
  local diagnostics = vim.diagnostic.get(bufnr, { lnum = lnum - 1 })
  local severity

  for _, diagnostic in ipairs(diagnostics) do
    if not severity or diagnostic.severity < severity then
      severity = diagnostic.severity
    end
  end

  return severity
end

local function get_node(bufnr)
  local ok, node = pcall(vim.treesitter.get_node, { bufnr = bufnr })
  if ok and node then
    return node
  end

  local parser_ok, parser = pcall(vim.treesitter.get_parser, bufnr)
  if not parser_ok or not parser then
    return nil
  end

  local tree = parser:parse()[1]
  if not tree then
    return nil
  end

  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  return tree:root():named_descendant_for_range(row - 1, col, row - 1, col)
end

local function truncate_text(text, max_len)
  if not text or text == "" then
    return ""
  end
  if #text <= max_len then
    return text
  end
  return text:sub(1, max_len - 3) .. "..."
end

local function parse_tag_name(text)
  if not text or text == "" then
    return nil
  end
  return text:match("<%s*([%w%._:-]+)")
end

local function get_react_breadcrumb(bufnr)
  local node = get_node(bufnr)
  if not node then
    return ""
  end

  local function first_child_text_by_types(current, wanted_types)
    for child in current:iter_children() do
      if wanted_types[child:type()] then
        return vim.treesitter.get_node_text(child, bufnr)
      end
    end
  end

  local function collect_tag(current)
    local node_type = current:type()
    if node_type == "jsx_element" then
      local opening_text = first_child_text_by_types(current, {
        jsx_opening_element = true,
      })
      return parse_tag_name(opening_text)
    end
    if node_type == "element" then
      local start_text = first_child_text_by_types(current, {
        start_tag = true,
        self_closing_tag = true,
      })
      return parse_tag_name(start_text)
    end
    if node_type == "jsx_self_closing_element" or node_type == "self_closing_tag" then
      return parse_tag_name(vim.treesitter.get_node_text(current, bufnr))
    end
  end

  local tags = {}
  while node do
    local tag = collect_tag(node)
    if tag and tag ~= "" then
      table.insert(tags, 1, tag)
    end
    node = node:parent()
  end

  if #tags == 0 then
    return ""
  end

  return table.concat(tags, " > ")
end

local function is_rspec_target(bufnr)
  if vim.bo[bufnr].filetype ~= "ruby" then
    return false
  end
  local name = vim.api.nvim_buf_get_name(bufnr)
  if name:match("_spec%.rb$") then
    return true
  end
  return name:match("/spec/") ~= nil
end

local function parse_rspec_segment(line)
  if not line or line == "" then
    return nil
  end

  local method
  for _, keyword in ipairs({ "describe", "context", "it", "specify", "feature", "scenario" }) do
    if line:match("%f[%w_]" .. keyword .. "%f[^%w_]") then
      method = keyword
      break
    end
  end

  if not method then
    return nil
  end

  local desc = line:match(method .. "%s*%(%s*['\"]([^'\"]+)")
    or line:match(method .. "%s+['\"]([^'\"]+)")
    or line:match(method .. "%s*%(%s*([^,%)%s]+)")
    or line:match(method .. "%s+([^,%s]+)")

  if not desc or desc == "" then
    return method
  end

  desc = desc:gsub("^:", ""):gsub("^described_class$", "described_class")
  return method .. " " .. truncate_text(desc, 40)
end

local function get_rspec_breadcrumb(bufnr)
  if not is_rspec_target(bufnr) then
    return ""
  end

  local node = get_node(bufnr)
  if not node then
    return ""
  end

  local segments = {}
  while node do
    local node_type = node:type()
    if node_type == "block" or node_type == "do_block" then
      local row = node:start() + 1
      local line = vim.api.nvim_buf_get_lines(bufnr, row - 1, row, false)[1]
      local segment = parse_rspec_segment(line)
      if segment then
        table.insert(segments, 1, segment)
      end
    end
    node = node:parent()
  end

  if #segments == 0 then
    return ""
  end

  return table.concat(segments, " > ")
end

local function get_context_breadcrumb(bufnr)
  local ft = vim.bo[bufnr].filetype
  if ft == "javascript" or ft == "javascriptreact" or ft == "typescriptreact" or ft == "html" then
    local react = get_react_breadcrumb(bufnr)
    if react ~= "" then
      return react
    end
  end

  local rspec = get_rspec_breadcrumb(bufnr)
  if rspec ~= "" then
    return rspec
  end

  local ok, navic = pcall(require, "nvim-navic")
  if ok and navic.is_available() then
    return navic.get_location() or ""
  end

  return ""
end

local function lpad(s, width)
  s = s or ""
  if #s >= width then
    return s
  end
  return string.rep(" ", width - #s) .. s
end

local function mouse_line()
  local pos = vim.fn.getmousepos()
  return (pos and pos.line) or vim.v.lnum
end

-- local diff_state_rank = {
--  none = 0,
--  added = 1,
--  changed = 2,
--  removed = 3,
-- }
--
-- local function stronger_diff_state(current, candidate)
--  local current_rank = diff_state_rank[current or "none"] or 0
--  local candidate_rank = diff_state_rank[candidate or "none"] or 0
--  if candidate_rank > current_rank then
--    return candidate
--  end
--  return current
-- end
--
-- local function diff_state_from_sign_name(name)
--  if type(name) ~= "string" or name == "" then
--    return nil
--  end
--  local lname = name:lower()
--  if not lname:find("gitsigns", 1, true) then
--    return nil
--  end
--  if lname:find("changedelete", 1, true) or lname:find("topdelete", 1, true) or lname:find("delete", 1, true) then
--    return "removed"
--  end
--  if lname:find("change", 1, true) then
--    return "changed"
--  end
--  if lname:find("add", 1, true) then
--    return "added"
--  end
--  return nil
-- end
--
-- local function placed_signs_on_line(bufnr, lnum)
--  local target_bufnr = bufnr == 0 and vim.api.nvim_get_current_buf() or bufnr
--  if type(target_bufnr) ~= "number" or target_bufnr < 1 or not vim.api.nvim_buf_is_valid(target_bufnr) then
--    return {}
--  end
--  local ok, placed = pcall(vim.fn.sign_getplaced, target_bufnr, { group = "*", lnum = lnum })
--  if not ok then
--    return {}
--  end
--  local row = placed and placed[1]
--  return (row and row.signs) or {}
-- end
--
-- local function line_diff_state(bufnr, lnum)
--  local function state_from_hunk(hunk)
--    if type(hunk) ~= "table" or type(hunk.type) ~= "string" or type(hunk.added) ~= "table" then
--      return nil
--    end
--
--    local start = tonumber(hunk.added.start) or 0
--    local vend = tonumber(hunk.vend) or start
--    local hunk_type = hunk.type
--
--    if hunk_type == "delete" then
--      local delete_line = start <= 0 and 1 or start
--      return lnum == delete_line and "removed" or nil
--    end
--
--    if lnum < start or lnum > vend then
--      return nil
--    end
--
--    if hunk_type == "add" then
--      return "added"
--    end
--
--    if hunk_type == "change" then
--      local added_count = tonumber(hunk.added.count) or 0
--      local removed_count = tonumber(hunk.removed and hunk.removed.count) or 0
--      local change_end = start + math.max(0, math.min(added_count, removed_count) - 1)
--
--      if removed_count > added_count and lnum == math.max(start, change_end) then
--        return "removed"
--      end
--      if lnum <= change_end then
--        return "changed"
--      end
--      return "added"
--    end
--
--    return nil
--  end
--
--  local function state_from_gitsigns_hunks()
--    local ok, cache_mod = pcall(require, "gitsigns.cache")
--    if not ok or type(cache_mod) ~= "table" or type(cache_mod.cache) ~= "table" then
--      return nil
--    end
--
--    local bcache = cache_mod.cache[bufnr]
--    if type(bcache) ~= "table" then
--      return nil
--    end
--
--    local state = "none"
--    for _, hunk in ipairs(bcache.hunks or {}) do
--      state = stronger_diff_state(state, state_from_hunk(hunk))
--    end
--    for _, hunk in ipairs(bcache.hunks_staged or {}) do
--      state = stronger_diff_state(state, state_from_hunk(hunk))
--    end
--
--    return state ~= "none" and state or nil
--  end
--
--  local state_from_hunks = state_from_gitsigns_hunks()
--  if state_from_hunks then
--    return state_from_hunks
--  end
--
--  local state = "none"
--  for _, sign in ipairs(placed_signs_on_line(bufnr, lnum)) do
--    state = stronger_diff_state(state, diff_state_from_sign_name(sign.name))
--  end
--  return state
-- end
--
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

local function avante_provider_label()
  local ok_cfg, cfg = pcall(require, 'avante.config')
  if not ok_cfg or type(cfg.get) ~= 'function' then
    return ''
  end
  local ok_get, settings = pcall(cfg.get)
  if not ok_get or type(settings) ~= 'table' then
    return ''
  end

  local provider = settings.provider
  if type(provider) ~= 'string' or provider == '' then
    return ''
  end

  local model = ''
  local providers = settings.providers
  if type(providers) == 'table' and type(providers[provider]) == 'table' then
    model = providers[provider].model or ''
  end
  if model == '' then
    local acp = settings.acp_providers
    if type(acp) == 'table' and type(acp[provider]) == 'table' then
      model = acp[provider].model or ''
    end
  end

  if model == '' then
    return string.format(' 󰚩 %s ', provider)
  end
  return string.format(' 󰚩 %s:%s ', provider, model)
end

local AvanteStatus = {
  condition = function()
    return package.loaded['avante.config'] ~= nil
  end,
  provider = function()
    return avante_provider_label()
  end,
  hl = { fg = colors.purple, bg = colors.bg_d },
  update = { 'BufEnter', 'WinEnter', 'User' },
}

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
  {
    condition = function()
      return get_context_breadcrumb(0) ~= ""
    end,
    update = { "CursorMoved", "CursorMovedI", "BufEnter", "LspAttach", "LspDetach" },
    {
      provider = function()
        local location = get_context_breadcrumb(0)
        if location == "" then
          return ""
        end
        return " " .. location
      end,
      hl = { fg = colors.fg, bg = colors.bg_d },
    },
    {
      provider = " ",
      hl = { bg = colors.bg_d },
    },
  },
  { provider = "%=", hl = { bg = colors.bg_d } },
  AvanteStatus,
  {
    condition = conditions.lsp_attached,
    provider = function()
      local names = {}
      for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
        table.insert(names, client.name)
      end
      if #names == 0 then
        return ""
      end
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

local FoldColumn = {
  init = function(self)
    self.lnum = vim.v.lnum
    self.virtnum = vim.v.virtnum
  end,

  provider = function(self)
    -- Don’t draw anything for wrapped/virtual screen lines
    if self.virtnum ~= 0 then
      return "  "
    end

    local lnum = self.lnum

    -- If this line isn't in a fold at all, keep width stable
    local lvl = vim.fn.foldlevel(lnum)
    if lvl <= 0 then
      return "  "
    end

    -- Fold-start detection: level increases compared to previous line
    local prev_lvl = (lnum > 1) and vim.fn.foldlevel(lnum - 1) or 0
    local is_fold_start = lvl > prev_lvl
    if not is_fold_start then
      return "  "
    end

    local fc = vim.opt.fillchars:get()
    local icon_open = fc.foldopen or ""
    local icon_close = fc.foldclose or ""

    -- If this fold is closed, foldclosed(lnum) returns fold start; otherwise -1
    local is_closed = vim.fn.foldclosed(lnum) ~= -1
    local icon = is_closed and icon_close or icon_open

    return icon .. " "
  end,

  on_click = {
    name = "heirline_fold_toggle",
    callback = function()
      local lnum = mouse_line()
      -- Toggle fold at the clicked line
      vim.cmd(string.format("keepjumps normal! %dgza", lnum))
    end,
  },
}

local SignColumn = {
  provider = "%s",
  -- init = function(self)
  --  self.bufnr = vim.api.nvim_get_current_buf()
  --  self.lnum = vim.v.lnum
  --  self.virtnum = vim.v.virtnum
  -- end,
  -- provider = function(self)
  --  if self.virtnum ~= 0 then
  --    return "  "
  --  end
  --
  --  for _, sign in ipairs(placed_signs_on_line(self.bufnr, self.lnum)) do
  --    local sign_name = sign.name or ""
  --    if not sign_name:match("^GitSigns") then
  --      local defs = vim.fn.sign_getdefined(sign_name)
  --      local text = defs and defs[1] and defs[1].text or ""
  --      if type(text) == "string" and text ~= "" then
  --        return text .. " "
  --      end
  --    end
  --  end
  --
  --  return "  "
  -- end,
  on_click = {
    name = "heirline_sign_click",
    callback = function()
      local lnum = mouse_line()
      -- Nice default: if there are diagnostics on that line, show float.
      local bufnr = vim.api.nvim_get_current_buf()
      local diags = vim.diagnostic.get(bufnr, { lnum = lnum - 1 })
      if diags and #diags > 0 then
        vim.diagnostic.open_float(bufnr, { scope = "line" })
      end
    end,
  },
}
local NumberColumn = {
  init = function(self)
    self.lnum = vim.v.lnum
    self.relnum = vim.v.relnum
    self.virtnum = vim.v.virtnum
    self.width = vim.wo.numberwidth
    self.bufnr = vim.api.nvim_get_current_buf()
    self.diagnostic_severity = highest_diagnostic_severity(self.bufnr, self.lnum)
    -- self.bufnr = vim.api.nvim_get_current_buf()
    -- self.diff_state = line_diff_state(self.bufnr, self.lnum)
  end,

  provider = function(self)
    if self.virtnum ~= 0 then
      return lpad("", self.width) .. " "
    end

    local show = ""
    if vim.wo.relativenumber and self.relnum ~= 0 then
      show = tostring(self.relnum)
    elseif vim.wo.number then
      show = tostring(self.lnum)
    end

    return lpad(show, self.width) .. " "
  end,

  hl = function(self)
    local fg = diagnostic_line_colors[self.diagnostic_severity]
    if not fg then
      return {}
    end

    return { fg = fg }
  end,
  --
  on_click = {
    name = "heirline_number_click",
    callback = function()
      -- Example click: set cursor to clicked line
      local lnum = mouse_line()
      pcall(vim.api.nvim_win_set_cursor, 0, { lnum, 0 })
    end,
  },
}

M.statuscolumn = {
  FoldColumn,
  SignColumn,
  NumberColumn,
}

local BufferLineBlock = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(self.bufnr)
  end,
  hl = function(self)
    if self.is_active then
      return { fg = colors.fg, bg = colors.bg0, bold = true }
    end
    return { fg = colors.grey, bg = colors.bg_d }
  end,
  on_click = {
    minwid = function(self)
      return self.bufnr
    end,
    callback = function(_, minwid, _, button)
      if button == "m" then
        vim.api.nvim_buf_delete(minwid, {})
        return
      end
      vim.api.nvim_set_current_buf(minwid)
    end,
    name = "heirline_tabline_buffer",
  },
  {
    provider = function(self)
      local name = vim.fn.fnamemodify(self.filename, ":t")
      if name == "" then
        return " [No Name]"
      end
      return " " .. name
    end,
  },
  {
    condition = function(self)
      return vim.bo[self.bufnr].modified
    end,
    provider = " " .. symbols.dot,
    hl = { fg = colors.yellow },
  },
  {
    provider = " " .. symbols.bar_right_thin,
    hl = { fg = colors.bg2 },
  },
}

return M
