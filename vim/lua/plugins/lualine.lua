return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'kyazdani42/nvim-web-devicons' },
  event = "VeryLazy",
  opts = function()
    local navicLoaded, navic = pcall(require, "nvim-navic")
    -- local gpsLoaded, gps = pcall(require, "nvim-gps")
    local copilotLoaded, _ = pcall(require, "copilot.api")
    local helper = require('helper')
    local colors = helper.colors.onedark
    local symbols = helper.symbols
    local getFlags = helper.lualine.getFlags

    local copilot_colors = {
      [""] = { fg = colors.green },
      ["Normal"] = { fg = colors.green },
      ["Warning"] = { fg = colors.orange },
      ["InProgress"] = { fg = colors.blue },
    }

    local sections = {
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
      navic = {
        function()
          return " " .. navic.get_location()
        end,
        cond = function()
          return navicLoaded and navic.is_available()
        end,
        padding = { left_padding = 2, right_padding = 0 }
      },
      flags = { getFlags, color = { fg = colors.yellow } },
      copilot = copilotLoaded and {
        function()
          local icon = helper.symbols.Copilot
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
      } or {}
    }

    local options = {
      options = {
        icons_enabled = true,
        theme = require('helper').lualine.theme.onedark,
        component_separators = { '', '' },
        section_separators = { '', '' },
        disabled_filetypes = {
          statusline = {},
          winbar = { 'neo-tree' }
        },
        ignore_focus = {},
        globalstatus = true,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        }
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = {},
        lualine_c = { sections.navic },
        lualine_x = { 'lsp_progress', helper.lualine.recording, 'searchcount' , sections.flags, sections.diagnostics },
        lualine_y = { 'tabnine', 'filetype', sections.diff, },
        lualine_z = { sections.location }
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
        -- lualine_b = { sections.filetype, sections.filename, },
        -- lualine_y = { sections.diff },
        -- lualine_z = { sections.location }
      },
      -- inactive_winbar = {
      --   lualine_b = {
      --     { 'filetype', colored = false, icon_only = true },
      --     { 'filename', path = 1,        file_status = true, color = { fg = colors.grey } },
      --   }
      -- },
      -- winbar = {
      --   -- For some reason coloring breaks stuff only in winbar
      --   lualine_b = {
      --     { 'filetype', colored = false, icon_only = true },
      --     { 'filename', path = 1,        file_status = true },
      --     -- { 'filetype', colored = false, icon_only = true,   color = { bg = colors.bg0 } },
      --     -- { 'filename', path = 1,        file_status = true, color = { bg = colors.bg0 } },
      --   }
      -- },
      tabline = {},
      extensions = {
        'quickfix',
        'fzf',
        'neo-tree',
        'fugitive',
        'man',
        'mason',
        'mundo',
        'symbols-outline',
        'neo-tree',
        'lazy',
      }
    }

    return options
  end,
  config = function(_, opts)
    local colors = require('helper').colors.onedark

    require('lualine').setup(opts)

    vim.cmd(string.format("highlight! BufferTabpages guibg=%s", colors.bg_d))
    vim.cmd(string.format("highlight! BufferTabpagesSep guibg=%s", colors.bg_d))
  end
}
