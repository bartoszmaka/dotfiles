local galaxyline = require('galaxyline')
local config_helper = require('config_helper')
local colors = require('config_helper.colors').onedark
local ft = vim.bo.filetype
-- local throttle = require('config_helper.throttle').throttle_leading
local statusline_segments = require('config_helper.statusline_segments')
local extension = require('galaxyline.provider_extensions')

local section = galaxyline.section
galaxyline.short_line_list = { 'defx', 'packager', 'vista' }

-- local getTreesitterContextThrottled = (function()
--   local timer = vim.loop.new_timer()
--   local ran_recently = false
--   local cached_result = nil
--   local throttle_ms = 1000

--   local wrapped_fn = function()
--     if not ran_recently then
--       timer:start(throttle_ms, 0, function()
--         ran_recently = false
--       end)
--       cached_result = statusline_segments.getTreesitterContext()
--       ran_recently = true
--     end
--     return cached_result
--   end
--   return wrapped_fn
-- end)()

-- Local helper functions
local buffer_not_empty = function()
  return not config_helper.is_buffer_empty()
end

local mode_color = function()
  local mode_colors = {
    n = colors.green,
    i = colors.blue,
    c = colors.orange,
    V = colors.purple,
    [''] = colors.purple,
    v = colors.purple,
    R = colors.red,
  }

  local color = mode_colors[vim.fn.mode()]

  if color == nil then
    color = colors.red
  end

  return color
end

-- LEFT
section.left = {
  {
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
          t = 'TERMINAL',
        }
        vim.api.nvim_command('hi GalaxyViMode gui=bold guibg='..mode_color())
        local alias_mode = alias[vim.fn.mode()]
        if alias_mode == nil then
          alias_mode = vim.fn.mode()
        end
        return '  '..alias_mode..' '
      end,
      separator = ' ',
      highlight = { colors.bg0, colors.bg0 },
      separator_highlight = {colors.bg0, colors.bg0 },
    },
  },
  {
    FileIcon = {
      provider = 'FileIcon',
      condition = buffer_not_empty,
      highlight = { require('galaxyline.provider_fileinfo').get_file_icon_color, colors.bg0 },
    },
  },
  {
    FileName = {
      provider = function ()
        return vim.fn.expand('%f')
      end,
      condition = function()
        return buffer_not_empty() and ft ~= "fzf" and ft~= "NvimTree"
      end,
      highlight = { colors.fg, colors.bg0 },
      separator_highlight = {colors.fg, colors.bg0 },
      separator = ' '
    },
  },
  {
    VistaPlugin = {
      provider = extension.vista_nearest,
      highlight = { colors.grey, colors.bg0 },
    }
  },
  -- {
  --     nvimGPS = {
  --       provider = function()
  --         return gps.get_location()
  --       end,
  --       condition = function()
  --         return gps.is_available()
  --       end
  --     }
  --   }
  -- {
  --   Context = {
  --     provider = getTreesitterContextThrottled,
  --     -- provider = statusline_segments.getTreesitterContext,
  --     condition = function()
  --       -- if string.len(vim.fn.expand('%f')) + 40 > vim.fn.winwidth(0) then
  --       --   return false
  --       -- end
  --       return buffer_not_empty() and ft ~= "fzf" and ft~= "NvimTree"
  --     end,
  --     highlight = { colors.fg, colors.bg0 },
  --     separator_highlight = {colors.fg, colors.bg0 },
  --     separator = ' '
  --   }
  -- }
}

-- RIGHT
section.right = {
  {
    Flags = {
      provider = function()
        local flags = {}
        if string.len(vim.fn["gutentags#statusline"]()) > 0 then table.insert(flags, ' ♺') end
        if vim.g.ale_linting then table.insert(flags, 'Linting') end
        if vim.g.ale_fixing then table.insert(flags, 'Fixing') end

        return table.concat(flags, ' ')..' '
      end,
      separator = ' ',
      condition = buffer_not_empty,
      highlight = { colors.bg_yellow, colors.bg0 },
      separator_highlight = { colors.black, colors.bg0 },
    }
  },
  {
    CustomDiagnosticError = {
      provider = function()
        local errors = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR})
        local count = table.getn(errors)
        if count > 0 then
          return count
        else
          return ''
        end
      end,
      condition = buffer_not_empty,
      icon = '   ',
      highlight = {colors.red, colors.bg0 },
    },
  },
  {
    CustomDiagnosticWarn = {
      provider = function()
        local warns = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN})
        local count = table.getn(warns)
        if count > 0 then
          return count
        else
          return ''
        end
      end,
      icon = '   ',
      highlight = {colors.orange, colors.bg0 },
    },
  },
  {
    CustomDiagnosticInfo = {
      provider = function()
        local hints = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT})
        local info = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO})
        local count = table.getn(hints) + table.getn(info)
        if count > 0 then
          return count
        else
          return ''
        end
      end,
      icon = '   ',
      highlight = {colors.blue, colors.bg0 },
    },
  },
  {
    GitInfo = {
      provider = statusline_segments.getGitInfo,
      condition = buffer_not_empty,
      highlight = {colors.fg_active,colors.bg3},
      separator_highlight = { colors.bg, colors.bg },
      separator=' '
    }
  },
  {
    LineColumn = {
      provider = function ()
        vim.api.nvim_command('hi GalaxyLineColumn guibg='..mode_color())
        local max_lines = vim.fn.line('$')
        local line = vim.fn.line('.')
        local column = vim.fn.col('.')
        return string.format("  %3d/%d:%2d ", line, max_lines, column)
      end,
      highlight = { colors.black, mode_color() },
    }
  }
}

section.short_line_left = {
  {
    SpacerInactive = {
      provider = function()
        return '  '
      end,
      highlight = { colors.fg, colors.bg3 },
      separator_highlight = {colors.fg, colors.bg3 },
    }
  },
  {
    FileIconInactive = {
      provider = 'FileIcon',
      condition = buffer_not_empty,
      separator = ' ',
      highlight = { colors.fg, colors.bg3 },
      separator_highlight = { require('galaxyline.provider_fileinfo').get_file_icon_color,  colors.bg3 },
    }
  },
  {
    FileNameInactive = {
      provider = function ()
        return vim.fn.expand('%f')
      end,
      separator = ' ',
      condition = buffer_not_empty,
      highlight = { colors.fg, colors.bg3 },
      separator_highlight = { colors.fg, colors.bg3 },
    }
  },
}

section.short_line_right = {
  {
    GitInfoInactive = {
      provider = statusline_segments.getGitInfo,
      condition = buffer_not_empty,
      highlight = {colors.fg_active,colors.bg3},
      separator_highlight = { colors.fg, colors.bg3 },
    }
  },
  {
    LineColumnInactive= {
      provider = function ()
        local max_lines = vim.fn.line('$')
        local line = vim.fn.line('.')
        local column = vim.fn.col('.')
        return string.format("  %3d/%d:%2d ", line, max_lines, column)
      end,
      highlight = { colors.fg, colors.bg3 },
    }
  }
}

galaxyline.load_galaxyline()
vim.cmd[[
let g:ale_linting = v:false
let g:ale_fixing = v:false

augroup galaxyline_triggers
autocmd!
autocmd User GutentagsUpdating lua require("galaxyline").load_galaxyline()
autocmd User GutentagsUpdated lua require("galaxyline").load_galaxyline()
augroup END
]]
