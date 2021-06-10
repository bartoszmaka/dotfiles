local vim = vim
local galaxyline = require('galaxyline')
local config_helper = require('config_helper')
local onedark = require('config_helper.colors').onedark

local section = galaxyline.section
galaxyline.short_line_list = { 'defx', 'packager', 'vista' }

-- Colors
local colors = {
  bg = onedark.bg0,
  bg_inactive = onedark.bg3,
  fg = onedark.fg,
  fg_focus = '#f8f8f2',
  section_bg = onedark.bg0,
  yellow = onedark.bg_yellow,
  cyan = onedark.cyan,
  green = onedark.green,
  orange = onedark.orange,
  magenta = onedark.purple,
  blue = onedark.blue,
  red = onedark.red,
  black = onedark.black,
}

-- Local helper functions
local buffer_not_empty = function()
  return not config_helper.is_buffer_empty()
end

local mode_color = function()
  local mode_colors = {
    n = colors.green,
    i = colors.blue,
    c = colors.orange,
    V = colors.magenta,
    [''] = colors.magenta,
    v = colors.magenta,
    R = colors.red,
  }

  local color = mode_colors[vim.fn.mode()]

  if color == nil then
    color = colors.red
  end

  return color
end

section.left[1] = {
  ViMode = {
    provider = function()
      local alias = {
        n = 'NORMAL',
        i = 'INSERT',
        c = 'COMMAND',
        V = 'VISUAL',
        [''] = 'VISUAL',
        v = 'VISUAL',
        R = 'REPLACE',
      }
      vim.api.nvim_command('hi GalaxyViMode gui=bold guibg='..mode_color())
      local alias_mode = alias[vim.fn.mode()]
      if alias_mode == nil then
        alias_mode = vim.fn.mode()
      end
      return '  '..alias_mode..' '
    end,
    separator = ' ',
    highlight = { colors.bg, colors.section_bg },
    separator_highlight = {colors.bg, colors.section_bg },
  },
}

section.left[2] = {
  FileIcon = {
    provider = 'FileIcon',
    condition = buffer_not_empty,
    highlight = { require('galaxyline.provider_fileinfo').get_file_icon_color, colors.section_bg },
  },
}

section.left[3] = {
  FileName = {
    provider = function ()
      return vim.fn.expand('%f')
    end,
    condition = buffer_not_empty,
    highlight = { colors.fg, colors.section_bg },
    separator_highlight = {colors.fg, colors.section_bg },
  }
}

section.right[1]= {
  LineColumn = {
    provider = function ()
      vim.api.nvim_command('hi GalaxyLineColumn guibg='..mode_color())
      local max_lines = vim.fn.line('$')
      local line = vim.fn.line('.')
      local column = vim.fn.col('.')
      return string.format(" %3d/%d:%d ", line, max_lines, column)
    end,
    separator = ' ',
    highlight = { colors.black, mode_color() },
    separator_highlight = { colors.black, colors.section_bg },
  }
}

section.short_line_left[1] = {
  SpacerInactive = {
    provider = function()
      return '  '
    end,
    highlight = { colors.fg, colors.bg_inactive },
    separator_highlight = {colors.fg, colors.bg_inactive },
  }
}

section.short_line_left[2] = {
  FileIconInactive = {
    provider = 'FileIcon',
    condition = buffer_not_empty,
    separator = ' ',
    highlight = { colors.fg, colors.bg_inactive },
    separator_highlight = { require('galaxyline.provider_fileinfo').get_file_icon_color,  colors.bg_inactive },
  }
}
section.short_line_left[3] = {
  FileNameInactive = {
    provider = function ()
      return vim.fn.expand('%f')
    end,
    separator = ' ',
    highlight = { colors.fg, colors.bg_inactive },
    separator_highlight = { colors.fg, colors.bg_inactive },
  }
}

section.short_line_right[1] = {
  LineColumnInactive = {
    provider = 'LineColumn',
    separator = ' ',
    highlight = { colors.fg, colors.bg_inactive },
    separator_highlight = { colors.fg, colors.bg_inactive },
  }
}

galaxyline.load_galaxyline()

-- gls.left[3] = {
--   AleErrorCount = {
--     provider = function()
--       local ale_counts = vim.fn["ale#statusline#Count"](vim.fn.bufnr())
--       return ale_counts.error
--     end,
--     highlight = 'LspDiagnosticsSignError',
--     icon = ' ' .. vim.g.ale_sign_error .. ' ',
--     condition = function()
--       local ale_counts = vim.fn["ale#statusline#Count"](vim.fn.bufnr())
--       return ale_counts.error > 0
--     end,
--   }
-- }
-- gls.left[4] = {
--   AleWarningCount = {
--     provider = function()
--       local ale_counts = vim.fn["ale#statusline#Count"](vim.fn.bufnr())
--       return ale_counts.warning
--     end,
--     highlight = 'LspDiagnosticsSignWarning',
--     icon = ' ' .. vim.g.ale_sign_warning .. ' ',
--     condition = function()
--       local ale_counts = vim.fn["ale#statusline#Count"](vim.fn.bufnr())
--       return ale_counts.warning > 0
--     end,
--   }
-- }
-- gls.left[5] = {
--   AleInfoCount = {
--     provider = function()
--       local ale_counts = vim.fn["ale#statusline#Count"](vim.fn.bufnr())
--       return ale_counts.info
--     end,
--     highlight = 'LspDiagnosticsSignInformation',
--     icon = ' ' .. vim.g.ale_sign_info .. ' ',
--     condition = function()
--       local ale_counts = vim.fn["ale#statusline#Count"](vim.fn.bufnr())
--       return ale_counts.info > 0
--     end,
--   }
-- }
-- vim.cmd('autocmd User ALELintPost lua require("galaxyline").load_galaxyline()')
