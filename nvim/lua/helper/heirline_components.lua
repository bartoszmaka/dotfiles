local M = {}

local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local colors = require("helper.colors").onedark
local symbols = require("helper.symbols")

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

local function listed_buffers()
	local bufs = {}
	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buflisted then
			table.insert(bufs, bufnr)
		end
	end
	return bufs
end

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

M.tabline = {
	hl = { bg = colors.bg_d },
	utils.make_buflist(BufferLineBlock),
	{ provider = "%=" },
}

return M
