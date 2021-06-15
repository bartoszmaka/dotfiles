local vim = vim
local galaxyline = require('galaxyline')
local config_helper = require('config_helper')
local onedark = require('config_helper.colors').onedark
-- local lsp_status = require('lsp-status')
-- lsp_status.register_progress()

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

section.right[3] = {
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

section.right[2] = {
	GitIcon = {
		provider = function() return ' ' end,
		condition = buffer_not_empty,
    separator = ' ',
		highlight = {colors.fg_active,colors.bg_active},
    separator_highlight = { colors.black, colors.section_bg },
	}
}

section.right[1] = {
  Diagnostics = {
    provider = function()
      if string.len(vim.fn["gutentags#statusline"]()) > 0 then ctags = ' ♺' else ctags = '' end
      if vim.g.ale_linting then lint = ' Linting' else lint = '' end
      if vim.g.ale_fixing then fix = ' Fixing' else fix = '' end

      return ' '..ctags..fix..lint
    end,
    separator = ' ',
    highlight = { colors.yellow, colors.section_bg },
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

    -- function! LspStatus() abort
    --   let sl = ''
    --   if luaeval('not vim.tbl_isempty(vim.lsp.buf_get_clients(0))')
    --     let sl.='%#MyStatuslineLSP#E:'
    --     let sl.='%#MyStatuslineLSPErrors#%{luaeval("vim.lsp.diagnostic.get_count(0, [[Error]])")}'
    --     let sl.='%#MyStatuslineLSP# W:'
    --     let sl.='%#MyStatuslineLSPWarnings#%{luaeval("vim.lsp.diagnostic.get_count(0, [[Warning]])")}'
    --   else
    --       let sl.='%#MyStatuslineLSPErrors#off'
    --   endif
    --   return sl
    -- endfunction
    -- let &l:statusline = '%#MyStatuslineLSP#LSP '.LspStatus()

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
vim.cmd[[
let g:ale_linting = v:false
let g:ale_fixing = v:false
augroup galaxyline_triggers
  autocmd!

  autocmd User ALELintPre let g:ale_linting = v:true | lua require("galaxyline").load_galaxyline()
  autocmd User ALELintPost let g:ale_linting = v:false | lua require("galaxyline").load_galaxyline()
  autocmd User ALEFixPre let g:ale_fixing = v:true | lua require("galaxyline").load_galaxyline()
  autocmd User ALEFixPost let g:ale_fixing = v:false | lua require("galaxyline").load_galaxyline()
  autocmd User GutentagsUpdating lua require("galaxyline").load_galaxyline()
  autocmd User GutentagsUpdated lua require("galaxyline").load_galaxyline()
augroup END]]
    -- let s:ale_running = 0
    -- let l:stl .= '%{s:ale_running ? "[linting]" : ""}'
    -- augroup ALEProgress
    --     autocmd!
    --     autocmd User ALELintPre  let s:ale_running = 1 | redrawstatus
    --     autocmd User ALELintPost let s:ale_running = 0 | redrawstatus
    -- augroup END
