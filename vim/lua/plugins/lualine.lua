return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'kyazdani42/nvim-web-devicons' },
  event = "VeryLazy",
  opts = function()
    local components = require('helper.lualine').components
    local colors = require('helper.colors').onedark

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
        lualine_b = { components.navic },
        lualine_c = { },
        lualine_x = { 'lsp_progress', components.recording, 'searchcount' , components.flags, components.diagnostics },
        lualine_y = { 'tabnine', { 'filetype', color = { bg = colors.bg_d } }, 'filesize', components.diff },
        lualine_z = { components.location }
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
      },
      inactive_winbar = {
        lualine_b = { components.winbar_filetype_inactive, components.winbar_filename_inactive }
      },
      winbar = {
        lualine_b = { components.winbar_filetype, components.winbar_filename }
      },
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
  -- config = function(_, opts)
  --   local colors = require('helper').colors.onedark

  --   require('lualine').setup(opts)

  --   vim.cmd(string.format("highlight! BufferTabpages guibg=%s", colors.bg_d))
  --   vim.cmd(string.format("highlight! BufferTabpagesSep guibg=%s", colors.bg_d))
  -- end
}
