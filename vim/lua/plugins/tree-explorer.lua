return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v2.x",
  cmd = "Neotree",
  keys = {
    {
      "<C-k><C-e>",
      function() require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd(), reveal = true }) end,
      desc = "Explorer NeoTree",
    },
    {
      "<C-k><C-g>",
      function() require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd(), reveal = true, source = "git_status" }) end,
      desc = "GitStatus NeoTree",
    },
  },
  deactivate = function()
    vim.cmd([[Neotree close]])
  end,
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-tree/nvim-web-devicons", name = "tree-nvim-web-devicons" }, -- not strictly required, but recommended
    { "MunifTanjim/nui.nvim" },
    {
      's1n7ax/nvim-window-picker',
      tag = "v1.*",
      opts = function()
        local colors = require('helper').colors
        return {
          autoselect_one = true,
          selection_chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
          include_current = false,
          filter_rules = {
            bo = {
              -- if the file type is one of following, the window will be ignored
              filetype = { 'neo-tree', "neo-tree-popup", "notify" },

              -- if the buffer type is one of following, the window will be ignored
              buftype = { 'terminal', "quickfix" },
            },
          },
          other_win_hl_color = colors.onedark.blue,
        }
      end,
    }
  },
  init = function()
    vim.g.neo_tree_remove_legacy_commands = 1
    if vim.fn.argc() == 1 then
      local stat = vim.loop.fs_stat(vim.fn.argv(0))
      if stat and stat.type == "directory" then
        require("neo-tree")
      end
    end
  end,
  opts = {
    filesystem = {
      bind_to_cwd = false,
      follow_current_file = false,
      use_libuv_file_watcher = true,
    },
    window = {
      width = 60,
      mappings = {
        ["<space>"] = "none",
        ["<leader>f"] = "fuzzy_finder",
        ["/"] = false,
        ["S"] = "split_with_window_picker",
        ["s"] = "vsplit_with_window_picker",
        ["o"] = "open_with_window_picker",
      },
    },
    default_component_configs = {
      indent = {
        with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
        expander_collapsed = "",
        expander_expanded = "",
        expander_highlight = "NeoTreeExpander",
      },
    },
  },
  config = function(_, opts)
    require("neo-tree").setup(opts)
    vim.api.nvim_create_autocmd("TermClose", {
      pattern = "*lazygit",
      callback = function()
        if package.loaded["neo-tree.sources.git_status"] then
          require("neo-tree.sources.git_status").refresh()
        end
      end,
    })
  end,
}