return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require("astroui.status")
    local components = require('helper.heirline_components')

    opts.tabline = { -- tabline
      status.heirline.make_buflist(status.component.tabline_file_info()), -- component for each buffer tab
      status.component.fill({ hl = { bg = "tabline_bg" } }), -- fill the rest of the tabline with background color
      { -- tab list
        condition = function()
          return #vim.api.nvim_list_tabpages() >= 2
        end, -- only show tabs if there are more than one
        status.heirline.make_tablist({ -- component for each tab
          provider = status.provider.tabnr(),
          hl = function(self)
            return status.hl.get_attributes(
              status.heirline.tab_type(self, "tab"),
              true
            )
          end,
        }),
        { -- close button for current tab
          provider = status.provider.close_button({
            kind = "TabClose",
            padding = { left = 1, right = 1 },
          }),
          hl = status.hl.get_attributes("tab_close", true),
          on_click = {
            callback = function()
              require("astrocore.buffer").close_tab()
            end,
            name = "heirline_tabline_close_tab_callback",
          },
        },
      },
    }

    opts.statusline = nil
    opts.statuscolumn = {
      init = function(self)
        self.bufnr = vim.api.nvim_get_current_buf()
      end,
      status.component.foldcolumn(),
      status.component.signcolumn(),
      status.component.numbercolumn(),
    }
  end,
}
