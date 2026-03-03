return {
  {
    "rebelot/heirline.nvim",
    event = "UiEnter",
    dependencies = {
      "navarasu/onedark.nvim",
      "lewis6991/gitsigns.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local conditions = require("heirline.conditions")
      local utils = require("heirline.utils")
      local colors = require("helper.colors").onedark
      local symbols = require("helper.symbols")

      local mode_colors = {
        n      = colors.blue,
        i      = colors.green,
        v      = colors.purple,
        V      = colors.purple,
        ["\22"] = colors.purple,
        c      = colors.orange,
        s      = colors.yellow,
        S      = colors.yellow,
        ["\19"] = colors.yellow,
        R      = colors.red,
        r      = colors.red,
        ["!"]  = colors.red,
        t      = colors.cyan,
      }

      local mode_names = {
        n      = "NORMAL",
        no     = "OP",
        nov    = "OP",
        noV    = "OP",
        ["no\22"] = "OP",
        niI    = "NORMAL",
        niR    = "NORMAL",
        niV    = "NORMAL",
        nt     = "NORMAL",
        v      = "VISUAL",
        vs     = "VISUAL",
        V      = "V-LINE",
        Vs     = "V-LINE",
        ["\22"]  = "V-BLOCK",
        ["\22s"] = "V-BLOCK",
        s      = "SELECT",
        S      = "S-LINE",
        ["\19"] = "S-BLOCK",
        i      = "INSERT",
        ic     = "INSERT",
        ix     = "INSERT",
        R      = "REPLACE",
        Rc     = "REPLACE",
        Rx     = "REPLACE",
        Rv     = "V-REPLACE",
        Rvc    = "V-REPLACE",
        Rvx    = "V-REPLACE",
        c      = "COMMAND",
        cv     = "EX",
        ce     = "EX",
        r      = "PROMPT",
        rm     = "MORE",
        ["r?"] = "CONFIRM",
        ["!"]  = "SHELL",
        t      = "TERMINAL",
      }

      local ViMode = {
        init = function(self)
          self.mode = vim.fn.mode(1)
        end,
        provider = function(self)
          return " " .. (mode_names[self.mode] or self.mode) .. " "
        end,
        hl = function(self)
          local m = self.mode:sub(1, 1)
          return { fg = colors.black, bg = mode_colors[m] or colors.blue, bold = true }
        end,
        update = { "ModeChanged", pattern = "*:*" },
      }

      local GitBranch = {
        condition = conditions.is_git_repo,
        init = function(self)
          self.status_dict = vim.b.gitsigns_status_dict or {}
        end,
        provider = function(self)
          return "  " .. (self.status_dict.head or "") .. " "
        end,
        hl = { fg = colors.purple, bg = colors.bg1 },
      }

      local GitDiff = {
        condition = function()
          return vim.b.gitsigns_status_dict ~= nil
        end,
        init = function(self)
          self.status_dict = vim.b.gitsigns_status_dict or {}
          self.added = self.status_dict.added or 0
          self.removed = self.status_dict.removed or 0
          self.changed = self.status_dict.changed or 0
          self.has_changes = self.added > 0 or self.removed > 0 or self.changed > 0
        end,
        {
          provider = function(self)
            return self.added > 0 and (" +" .. self.added) or ""
          end,
          hl = { fg = colors.green, bg = colors.bg1 },
        },
        {
          provider = function(self)
            return self.changed > 0 and (" ~" .. self.changed) or ""
          end,
          hl = { fg = colors.yellow, bg = colors.bg1 },
        },
        {
          provider = function(self)
            return self.removed > 0 and (" -" .. self.removed) or ""
          end,
          hl = { fg = colors.red, bg = colors.bg1 },
        },
        {
          provider = " ",
          hl = { bg = colors.bg1 },
        },
      }

      local FileName = {
        init = function(self)
          self.filename = vim.fn.expand("%:.")
          if self.filename == "" then self.filename = "[No Name]" end
        end,
        provider = function(self)
          return " " .. self.filename .. " "
        end,
        hl = { fg = colors.fg, bg = colors.bg0 },
      }

      local FileFlags = {
        {
          condition = function() return vim.bo.modified end,
          provider = symbols.FileModified .. " ",
          hl = { fg = colors.yellow, bg = colors.bg0 },
        },
        {
          condition = function() return not vim.bo.modifiable or vim.bo.readonly end,
          provider = symbols.FileReadOnly .. " ",
          hl = { fg = colors.red, bg = colors.bg0 },
        },
      }

      local Diagnostics = {
        condition = conditions.has_diagnostics,
        init = function(self)
          self.errors   = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
          self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
          self.hints    = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
          self.info     = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
        end,
        update = { "DiagnosticChanged", "BufEnter" },
        {
          provider = function(self)
            return self.errors > 0 and (" " .. symbols.Error .. " " .. self.errors) or ""
          end,
          hl = { fg = colors.red, bg = colors.bg0 },
        },
        {
          provider = function(self)
            return self.warnings > 0 and (" " .. symbols.Warn .. " " .. self.warnings) or ""
          end,
          hl = { fg = colors.yellow, bg = colors.bg0 },
        },
        {
          provider = function(self)
            return self.info > 0 and (" " .. symbols.Info .. " " .. self.info) or ""
          end,
          hl = { fg = colors.cyan, bg = colors.bg0 },
        },
        {
          provider = function(self)
            return self.hints > 0 and (" " .. symbols.Hint .. " " .. self.hints) or ""
          end,
          hl = { fg = colors.dark_cyan, bg = colors.bg0 },
        },
        { provider = " ", hl = { bg = colors.bg0 } },
      }

      local Spacer = { provider = "%=", hl = { bg = colors.bg0 } }

      local FileType = {
        provider = function()
          return " " .. vim.bo.filetype .. " "
        end,
        hl = { fg = colors.grey, bg = colors.bg1 },
      }

      local Ruler = {
        provider = " %l:%c %P ",
        hl = { fg = colors.fg, bg = colors.bg1, bold = true },
      }

      local LSPActive = {
        condition = conditions.lsp_attached,
        update    = { "LspAttach", "LspDetach" },
        provider  = function()
          local names = {}
          for _, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
            table.insert(names, server.name)
          end
          if #names == 0 then return "" end
          return "  " .. table.concat(names, ", ") .. " "
        end,
        hl = { fg = colors.green, bg = colors.bg1 },
      }

      local StatusLine = {
        ViMode,
        GitBranch,
        GitDiff,
        FileName,
        FileFlags,
        Diagnostics,
        Spacer,
        LSPActive,
        FileType,
        Ruler,
      }

      require("heirline").setup({
        statusline = StatusLine,
        opts = {
          colors = colors,
        },
      })
    end,
  },
}
