return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'kyazdani42/nvim-web-devicons' },
  config = function()
    local navic = pcall(require, "nvim-navic")
    local gps = require "nvim-gps"
    local colors = require('config_helper.colors').onedark
    local onedark_custom = {
      normal = {
        a = { fg = colors.bg0, bg = colors.green, gui = 'bold' },
        b = { fg = colors.fg, bg = colors.bg0 },
        c = { fg = colors.fg, bg = colors.bg0 },
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

    local getFlags = function()
      local flags = {}
      if string.len(vim.fn["gutentags#statusline"]()) > 0 then table.insert(flags, '♺') end

      return table.concat(flags, ' ')
    end

    local configured_sections = {
      diagnostics = {
        'diagnostics',
        sources = { 'nvim_lsp' },
        sections = { 'error', 'warn', 'info', 'hint' },
        color_error = colors.red, -- changes diagnostic's error foreground color
        color_warn = colors.orange, -- changes diagnostic's warn foreground color
        color_info = colors.blue, -- Changes diagnostic's info foreground color
        color_hint = colors.blue, -- Changes diagnostic's hint foreground color
        symbols = { error = '  ', warn = '  ', info = '  ', hint = '  ' }
      },
      diff = {
        'diff',
        icon = '  ',
        colored = false, -- displays diff status in color if set to true
        -- all colors are in format #rrggbb
        color_added = nil, -- changes diff's added foreground color
        color_modified = nil, -- changes diff's modified foreground color
        color_removed = nil, -- changes diff's removed foreground color
        symbols = { added = '+', modified = '~', removed = '-' } -- changes diff symbols
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
      gps = { gps.get_location, cond = gps.is_available, color = { fg = colors.grey } },
      flags = { getFlags, color = { fg = colors.yellow } },
    }

    require('lualine').setup({
      options = {
        icons_enabled = true,
        theme = onedark_custom,
        component_separators = { '', '' },
        section_separators = { '', '' },
        disabled_filetypes = {
          statusline = {},
          winbar = {}
        },
        ignore_focus = {},
        globalstatus = false,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        }
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { configured_sections.filetype, configured_sections.filename, },
        lualine_c = { configured_sections.gps },
        lualine_x = { configured_sections.flags, configured_sections.diagnostics },
        lualine_y = { configured_sections.diff, },
        lualine_z = { configured_sections.location }
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = { configured_sections.filetype, configured_sections.filename, },
        lualine_c = {},
        lualine_x = {},
        lualine_y = { configured_sections.diff },
        lualine_z = { configured_sections.location }
      },
      tabline = {},
      -- winbar = {
      --   lualine_a = {},
      --   lualine_b = {},
      --   lualine_c = { configured_sections.gps },
      --   lualine_x = {},
      --   lualine_y = {},
      --   lualine_z = {},
      -- },
      -- inactive_winbar = {
      --   lualine_a = {},
      --   lualine_b = {},
      --   lualine_c = { configured_sections.gps },
      --   lualine_x = {},
      --   lualine_y = {},
      --   lualine_z = {},
      -- },
      extensions = { 'quickfix', 'fzf', 'nvim-tree', 'fugitive', 'man', 'mundo', 'symbols-outline' }
    })
  end
}
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   event = "VeryLazy",
  --   opts = function()
  --     local icons = require("lazyvim.config").icons
  --     local Util = require("lazyvim.util")

  --     return {
  --       options = {
  --         theme = "auto",
  --         globalstatus = true,
  --         disabled_filetypes = { statusline = { "dashboard", "alpha" } },
  --       },
  --       sections = {
  --         lualine_a = { "mode" },
  --         lualine_b = { "branch" },
  --         lualine_c = {
  --           {
  --             "diagnostics",
  --             symbols = {
  --               error = icons.diagnostics.Error,
  --               warn = icons.diagnostics.Warn,
  --               info = icons.diagnostics.Info,
  --               hint = icons.diagnostics.Hint,
  --             },
  --           },
  --           { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
  --           { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
  --           -- stylua: ignore
  --           {
  --             function() return require("nvim-navic").get_location() end,
  --             cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
  --           },
  --         },
  --         lualine_x = {
  --           -- stylua: ignore
  --           {
  --             function() return require("noice").api.status.command.get() end,
  --             cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
  --             color = Util.fg("Statement"),
  --           },
  --           -- stylua: ignore
  --           {
  --             function() return require("noice").api.status.mode.get() end,
  --             cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
  --             color = Util.fg("Constant"),
  --           },
  --           -- stylua: ignore
  --           {
  --             function() return "  " .. require("dap").status() end,
  --             cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
  --             color = Util.fg("Debug"),
  --           },
  --           { require("lazy.status").updates, cond = require("lazy.status").has_updates, color = Util.fg("Special") },
  --           {
  --             "diff",
  --             symbols = {
  --               added = icons.git.added,
  --               modified = icons.git.modified,
  --               removed = icons.git.removed,
  --             },
  --           },
  --         },
  --         lualine_y = {
  --           { "progress", separator = " ", padding = { left = 1, right = 0 } },
  --           { "location", padding = { left = 0, right = 1 } },
  --         },
  --         lualine_z = {
  --           function()
  --             return " " .. os.date("%R")
  --           end,
  --         },
  --       },
  --       extensions = { "neo-tree", "lazy" },
  --     }
  --   end,
  -- },
