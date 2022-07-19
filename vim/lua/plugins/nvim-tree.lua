local config_helper = require('config_helper')
local nnoremap = config_helper.nnoremap
-- local tree_cb = require "nvim-tree.config".nvim_tree_callback
local g = vim.g

function _G.nvim_tree_os_open()
  local lib = require "nvim-tree.lib"
  local node = lib.get_node_at_cursor()
  if node then
    vim.fn.jobstart("open '" .. node.absolute_path .. "' &", { detach = true })
  end
end

vim.cmd[[
  highlight NvimTreeIndentMarker guifg=#455574
]]

g.nvim_tree_allow_resize = 1

nnoremap('<C-k><C-r>', ':NvimTreeToggle<CR>')
nnoremap('<C-k><C-e>', ':NvimTreeFindFileToggle<CR>')

require('nvim-tree').setup {
  actions = {
    open_file = {
      quit_on_open = false,
      resize_window = true
    }
  },
  filters = {
    dotfiles = false
  },
  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_setup       = false,
  ignore_ft_on_setup  = {},
  -- auto_close          = false,
  open_on_tab         = false,
  -- update_to_buf_dir   = {
  --   enable = true,
  --   auto_open = true,
  -- },
  hijack_cursor       = false,
  update_cwd          = false,
  -- lsp_diagnostics     = false,
  update_focused_file = {
    enable      = false,
    update_cwd  = false,
    ignore_list = {}
  },
  system_open = {
    cmd  = nil,
    args = {}
  },
  git = {
    ignore = false,
  },

  view = {
    width = 60,
    height = 30,
    side = 'left',
    mappings = {
      custom_only = true,
      list = {
        { key = {"<CR>", "o", "<2-LeftMouse>"}, action = "edit" },
        { key = {"<2-RightMouse>", "<C-]>"},    action = "cd" },
        { key = {"<C-v>", "s"},                 action = "vsplit" },
        { key = "<C-x>",                        action = "split" },
        { key = "<C-t>",                        action = "tabnew" },
        { key = "<",                            action = "prev_sibling" },
        { key = ">",                            action = "next_sibling" },
        { key = "P",                            action = "parent_node" },
        -- { key = "<BS>",                         action = "close_node" },
        { key = "<S-CR>",                       action = "close_node" },
        { key = "<Tab>",                        action = "preview" },
        { key = "<leader>k",                    action = "first_sibling" },
        { key = "<leader>j",                    action = "last_sibling" },
        { key = "I",                            action = "toggle_ignored" },
        { key = "H",                            action = "toggle_dotfiles" },
        { key = "R",                            action = "refresh" },
        { key = "a",                            action = "create" },
        { key = "d",                            action = "remove" },
        { key = "r",                            action = "rename" },
        { key = "<C-r>",                        action = "full_rename" },
        { key = "x",                            action = "cut" },
        { key = "c",                            action = "copy" },
        { key = "p",                            action = "paste" },
        { key = "y",                            action = "copy_name" },
        { key = "Y",                            action = "copy_path" },
        { key = "gy",                           action = "copy_absolute_path" },
        { key = "g?",                           action = "toggle_help" },
        { key = "f",                            action = "live_filter" },
        { key = "F",                            action = "clear_live_filter" } ,

        { key = "X", action = "close_node", },
        { key = "ma", action = "create", },
        { key = "md", action = "remove", },
        { key = "mm", action = "rename", },
        { key = "y", action = "cut", },
        { key = "cn", action = "copy_name", },
        { key = "cf", action = "copy_path", },
        { key = "gy", action = "copy_absolute_path", },
        { key = "[g", action = "prev_git_item", },
        { key = "]g", action = "next_git_item", },
        { key = "<C-o>", cb = "<Cmd>lua _G.nvim_tree_os_open()<CR>" },
      }
    }
  },
  renderer = {
    highlight_git = true,
    highlight_opened_files = "all",
    root_folder_modifier = ":t",
    icons = {
      show = {
        git = true,
        folder = true,
        file = true,
        folder_arrow = false,
      },
      glyphs = {
        default = " ",
        symlink = " ",
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌"
        },
        folder = {
          arrow_open = "",
          arrow_closed = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        -- lsp = {
        --   hint = "",
        --   info = "",
        --   warning = "",
        --   error = "",
        -- }
      }
    },
    indent_markers = {
      enable = true
    }
  }
}
