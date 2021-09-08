local colors = require('config_helper.colors').onedark
local custom_onedark = require'lualine.themes.onedark'
custom_onedark.normal.b.bg = colors.bg0
custom_onedark.normal.c.bg = colors.bg0

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
  if string.len(vim.fn["gutentags#statusline"]()) > 0 then table.insert(flags, ' ♺') end
  -- if vim.g.ale_linting then table.insert(flags, 'Linting') end
  -- if vim.g.ale_fixing then table.insert(flags, 'Fixing') end

  return table.concat(flags, ' ')..' '
end

require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = custom_onedark,
    component_separators = {'', ''},
    section_separators = {'', ''},
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {
      {
        'filename',
        file_status = true, -- displays file status (readonly status, modified status)
        path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
      },
    },
    lualine_c = {
      getTreesitterContext
    },
    lualine_x = {
      {
        getFlags
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
        colored = false, -- displays diff status in color if set to true
        -- all colors are in format #rrggbb
        color_added = nil, -- changes diff's added foreground color
        color_modified = nil, -- changes diff's modified foreground color
        color_removed = nil, -- changes diff's removed foreground color
        symbols = {added = '+', modified = '~', removed = '-'} -- changes diff symbols
      },
      {
        'filetype',
        colored = true,
      },
    },
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {{
        'diff',
        colored = false, -- displays diff status in color if set to true
        -- all colors are in format #rrggbb
        color_added = nil, -- changes diff's added foreground color
        color_modified = nil, -- changes diff's modified foreground color
        color_removed = nil, -- changes diff's removed foreground color
        symbols = {added = '+', modified = '~', removed = '-'} -- changes diff symbols
      }},
    lualine_y = {'location'},
    lualine_z = {}
  },
  tabline = {},
  extensions = {'quickfix', 'fzf', 'nvim-tree'}
}
