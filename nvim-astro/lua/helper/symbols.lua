local M = {}

-- LSP
M.action = "󰛩"
M.Error = ""
M.Warn = ""
M.Info = ""
M.Hint = ""
M.error = M.Error
M.warning = M.Warn
M.information = M.Info
M.hint = M.Hint

-- UI
M.ArrowLeft = ""
M.ArrowRight = ""
M.Search = ""
M.InProgress = ""
M.Ellipsis = "…"
M.FolderClosed = ""
M.FolderOpen = ""
M.FolderEmpty = ""
M.Close = "󰅖"
M.FileModified = ""
M.FileReadOnly = ""
M.FoldClosed = ""
M.FoldOpened = ""
M.FoldSeparator = " "

-- Git
M.branch = ""
M.added = ""
M.modified = ""
M.removed = ""
M.renamed   = "➜"
M.untracked = ""
M.ignored   = "◌"
M.unstaged  = "✗"
M.staged    = "✓"
M.conflict  = ""

M.Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" }
M.Breakpoint = ""
M.BreakpointCondition = ""
M.BreakpointRejected = { "", "DiagnosticError" }
M.LogPoint = ".>"


-- Types
M.Array = "󰅪"
M.Boolean = "◩"
M.Class = ""
M.Color = ""
M.Constant = "󰏿"
M.Constructor = ""
M.Copilot = ""
M.Enum = ""
M.EnumMember = ""
M.Event = ""
M.Field = ""
M.File = "󰈙"
M.Folder = M.FolderEmpty
M.Function = "󰊕"
M.Interface = ""
M.Key = ""
M.Keyword = ""
M.Method = "󰊕"
M.Module = ""
M.Namespace = ""
M.Null = ""
M.Number = "󰎠"
M.Object = "󰅩"
M.Operator = ""
M.Package = ""
M.Property = ""
M.Reference = ""
M.Snippet = ""
M.String = ""
M.Struct = ""
M.Text = ""
M.TypeParameter = ""
M.Unit = ""
M.Variable = ""
M.Tag = ''
M.trace = ''
M.TabNine = "T"
M.Value = ""
M.Emmet = ""
M.Time = ''

-- Borders
M.corners = {
  round = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
  sharp = { '┌', '─', '┐', '│', '┘', '─', '└', '│' },
  double = { '╔', '═', '╗', '║', '╝', '═', '╚', '║' },
  bold = { '┏', '━', '┓', '┃', '┛', '━', '┗', '┃' },
  classic = { '╓', '─', '╖', '║', '╜', '─', '╙', '║' },
  ascii = { '+', '-', '+', '|', '+', '-', '+', '|' },
  empty = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
  solid = { '▛', '▀', '▜', '▋', '▙', '▄', '▟', '▐' },
  dotted = { '┌', '┄', '┐', '┊', '┘', '┄', '└', '┊' },
  dashed = { '┌', '┅', '┐', '┊', '┘', '┅', '└', '┊' },
  none = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
  single_no_border = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
}

return M
