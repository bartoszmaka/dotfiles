-- local navic_loaded, navic = pcall(require, "nvim-navic")
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
    a = { fg = colors.gray1, bg = colors.bg, gui = 'bold' },
    b = { fg = colors.gray1, bg = colors.bg },
    c = { fg = colors.gray1, bg = colors.bg },
    z = { fg = colors.gray1, bg = colors.bg, gui = 'none' },
  },
}

local getTreesitterContext = function()
  local f = require'nvim-treesitter'.statusline({
    indicator_size = vim.fn.winwidth(0) / 3,
    type_patterns = {"class", "function", "method", "interface", "type_spec", "table", "if_statement", "for_statement", "for_in_statement"},
    separator = ' > ',
    transform_fn = function(line)
      return line
        :gsub('%s*[%[%(%{]*%s*$', '')
        :gsub("(.*) <.*","%1")
    end
  })
  local context = string.format("%s", f) -- convert to string, it may be a empty ts node

  if context == "vim.NIL" then
    return ""
  end
  return context
end

local getFlags = function()
  local flags = {}
  if string.len(vim.fn["gutentags#statusline"]()) > 0 then table.insert(flags, '♺') end
  -- if vim.g.ale_linting then table.insert(flags, 'Linting') end
  -- if vim.g.ale_fixing then table.insert(flags, 'Fixing') end

  return table.concat(flags, ' ')
end

require('lualine').setup({
  options = {
    icons_enabled = true,
    theme = onedark_custom,
    component_separators = {'', ''},
    section_separators = {'', ''},
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
    lualine_a = {'mode'},
    lualine_b = {
      {
        'filetype',
        colored = true,
        icon_only = true,
      },
      {
        'filename',
        file_status = true, -- displays file status (readonly status, modified status)
        path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
      },
    },
    lualine_c = {
      {
        gps.get_location,
        cond = function()
          return gps.is_available()
        end,
        color = { fg = colors.grey },
      },
      -- {
      --   getTreesitterContext,
      --   color = { fg = colors.grey },
      -- }
    },
    lualine_x = {
      {
        getFlags,
        color = { fg = colors.yellow }
      },
      {
        'diagnostics',
        sources = { 'nvim_lsp' },
        sections = {'error', 'warn', 'info', 'hint'},
        color_error = colors.red, -- changes diagnostic's error foreground color
        color_warn = colors.orange, -- changes diagnostic's warn foreground color
        color_info = colors.blue, -- Changes diagnostic's info foreground color
        color_hint = colors.blue, -- Changes diagnostic's hint foreground color
        symbols = {error = '  ', warn = '  ', info = '  ', hint = '  '}
      }
    },
    lualine_y = {
      {
        'diff',
        icon = '  ',
        colored = false, -- displays diff status in color if set to true
        -- all colors are in format #rrggbb
        color_added = nil, -- changes diff's added foreground color
        color_modified = nil, -- changes diff's modified foreground color
        color_removed = nil, -- changes diff's removed foreground color
        symbols = {added = '+', modified = '~', removed = '-'} -- changes diff symbols
      },
    },
    lualine_z = {
      {
        'location',
        fmt = function ()
          local max_lines = vim.fn.line('$')
          local line = vim.fn.line('.')
          local column = vim.fn.col('.')
          return string.format(" %3d/%d:%2d ", line, max_lines, column)
        end
      }
    }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {
      {
        'filetype',
        colored = true,
        icon_only = true,
      },
      {
        'filename',
        file_status = true, -- displays file status (readonly status, modified status)
        path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
      },
    },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {
      {
        'diff',
        colored = false, -- displays diff status in color if set to true
        color_added = nil, -- changes diff's added foreground color
        color_modified = nil, -- changes diff's modified foreground color
        color_removed = nil, -- changes diff's removed foreground color
        symbols = {added = '+', modified = '~', removed = '-'} -- changes diff symbols
      }
    },
    lualine_z = {'location'},
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {'quickfix', 'fzf', 'nvim-tree', 'fugitive', 'man', 'mundo', 'symbols-outline'}
})
