return {
  'kyazdani42/nvim-tree.lua', -- project tree
  dependencies = { 'kyazdani42/nvim-web-devicons' },
  config = function()
    local nnoremap = require('config_helper').nnoremap
    local g = vim.g

    local function on_attach(bufnr)
      local api = require('nvim-tree.api')

      local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end
      vim.keymap.set('n', '<CR>',           api.node.open.edit, opts('Open'))
      vim.keymap.set('n', 'o',              api.node.open.edit, opts('Open'))
      vim.keymap.set('n', '<2-LeftMouse>',  api.node.open.edit, opts('Open'))
      vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node, opts('CD'))
      vim.keymap.set('n', '<C-]>',          api.tree.change_root_to_node, opts('CD'))
      vim.keymap.set('n', '<C-v>',          api.node.open.vertical, opts('Open: Vertical Split'))
      vim.keymap.set('n', 's',              api.node.open.vertical, opts('Open: Vertical Split'))
      vim.keymap.set('n', '<C-x>',          api.node.open.horizontal, opts('Open: Horizontal Split'))
      vim.keymap.set('n', '<C-t>',          api.node.open.tab, opts('Open: New Tab'))
      vim.keymap.set('n', '<',              api.node.navigate.sibling.prev, opts('Previous Sibling'))
      vim.keymap.set('n', '>',              api.node.navigate.sibling.next, opts('Next Sibling'))
      vim.keymap.set('n', 'P',              api.node.navigate.parent, opts('Parent Directory'))
      vim.keymap.set('n', '<S-CR>',         api.node.navigate.parent_close, opts('Close Directory'))
      vim.keymap.set('n', '<Tab>',          api.node.open.preview, opts('Open Preview'))
      vim.keymap.set('n', '<leader>k',      api.node.navigate.sibling.first, opts('First Sibling'))
      vim.keymap.set('n', '<leader>j',      api.node.navigate.sibling.last, opts('Last Sibling'))
      vim.keymap.set('n', 'I',              api.tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))
      vim.keymap.set('n', 'H',              api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
      vim.keymap.set('n', 'R',              api.tree.reload, opts('Refresh'))
      vim.keymap.set('n', 'a',              api.fs.create, opts('Create'))
      vim.keymap.set('n', 'd',              api.fs.remove, opts('Delete'))
      -- vim.keymap.set('n', 'r',              api.fs.rename, opts('Rename'))
      vim.keymap.set('n', 'r',              api.fs.rename_sub, opts('Rename: Omit Filename'))
      vim.keymap.set('n', 'x',              api.fs.cut, opts('Cut'))
      vim.keymap.set('n', 'c',              api.fs.copy.node, opts('Copy'))
      vim.keymap.set('n', 'p',              api.fs.paste, opts('Paste'))
      vim.keymap.set('n', 'y',              api.fs.copy.filename, opts('Copy Name'))
      vim.keymap.set('n', 'Y',              api.fs.copy.relative_path, opts('Copy Relative Path'))
      vim.keymap.set('n', 'gy',             api.fs.copy.absolute_path, opts('Copy Absolute Path'))
      vim.keymap.set('n', 'g?',             api.tree.toggle_help, opts('Help'))
      vim.keymap.set('n', 'f',              api.live_filter.start, opts('Filter'))
      vim.keymap.set('n', 'F',              api.live_filter.clear, opts('Clean Filter'))
      vim.keymap.set('n', 'X',              api.node.navigate.parent_close, opts('Close Directory'))
      vim.keymap.set('n', 'ma',             api.fs.create, opts('Create'))
      vim.keymap.set('n', 'md',             api.fs.remove, opts('Delete'))
      vim.keymap.set('n', 'mm',             api.fs.rename, opts('Rename'))
      vim.keymap.set('n', 'y',              api.fs.cut, opts('Cut'))
      vim.keymap.set('n', 'cn',             api.fs.copy.filename, opts('Copy Name'))
      vim.keymap.set('n', 'cf',             api.fs.copy.relative_path, opts('Copy Relative Path'))
      vim.keymap.set('n', 'gy',             api.fs.copy.absolute_path, opts('Copy Absolute Path'))
      vim.keymap.set('n', '[g',             api.node.navigate.git.prev, opts('Prev Git'))
      vim.keymap.set('n', ']g',             api.node.navigate.git.next, opts('Next Git'))

    end

    g.nvim_tree_allow_resize = 1

    require('nvim-tree').setup {
      on_attach           = on_attach,
      disable_netrw       = true,
      hijack_netrw        = true,
      update_cwd          = false,
      update_focused_file = {
        enable      = false,
        update_cwd  = false,
        ignore_list = {}
      },
      system_open         = { cmd = nil, args = {} },
      git                 = { ignore = false, },
      filters             = { dotfiles = false },
      live_filter         = { always_show_folders = false },
      renderer            = {
        highlight_git = true,
        highlight_opened_files = "icon",
        root_folder_modifier = ":t",
        full_name = true,
        icons = {
          show = {
            git = false,
            folder = true,
            file = true,
            folder_arrow = false,
          },
          glyphs = {
            default = "",
            symlink = "",
            git = {
              unstaged = "✗",
              staged = "✓",
              unmerged = "",
              renamed = "➜",
              untracked = "+",
              deleted = "-",
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
      },
      diagnostics         = {
        enable = true,
        show_on_dirs = true,
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },
      view                = {
        -- adaptive_size = true,
        width = 60,
        mappings = {
        }
      }
    }

    nnoremap('<C-k><C-r>', ':NvimTreeToggle<CR>')
    nnoremap('<C-k><C-e>', ':NvimTreeFindFileToggle<CR>')

    vim.cmd [[
highlight NvimTreeIndentMarker guifg=#455574
]]

    vim.cmd [[
highlight! NvimTreeNormal guibg=#141b24
highlight! NvimTreeEndOfBuffer guibg=#141b24
]]
  end,
}
-- {
--   "nvim-neo-tree/neo-tree.nvim",
--   cmd = "Neotree",
--   keys = {
--     {
--       "<leader>fe",
--       function()
--         require("neo-tree.command").execute({ toggle = true, dir = require("lazyvim.util").get_root() })
--       end,
--       desc = "Explorer NeoTree (root dir)",
--     },
--     {
--       "<leader>fE",
--       function()
--         require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
--       end,
--       desc = "Explorer NeoTree (cwd)",
--     },
--     { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true },
--     { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
--   },
--   deactivate = function()
--     vim.cmd([[Neotree close]])
--   end,
--   init = function()
--     vim.g.neo_tree_remove_legacy_commands = 1
--     if vim.fn.argc() == 1 then
--       local stat = vim.loop.fs_stat(vim.fn.argv(0))
--       if stat and stat.type == "directory" then
--         require("neo-tree")
--       end
--     end
--   end,
--   opts = {
--     filesystem = {
--       bind_to_cwd = false,
--       follow_current_file = true,
--       use_libuv_file_watcher = true,
--     },
--     window = {
--       mappings = {
--         ["<space>"] = "none",
--       },
--     },
--     default_component_configs = {
--       indent = {
--         with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
--         expander_collapsed = "",
--         expander_expanded = "",
--         expander_highlight = "NeoTreeExpander",
--       },
--     },
--   },
--   config = function(_, opts)
--     require("neo-tree").setup(opts)
--     vim.api.nvim_create_autocmd("TermClose", {
--       pattern = "*lazygit",
--       callback = function()
--         if package.loaded["neo-tree.sources.git_status"] then
--           require("neo-tree.sources.git_status").refresh()
--         end
--       end,
--     })
--   end,
-- },
