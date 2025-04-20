return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  cmd = "Neotree",
  keys = {
    {
      "<C-f><C-f>b", -- Mapped to Cmd-b in alacritty
      "<cmd>Neotree close<CR>",
      desc = "Close NeoTree panel",
    },
    {
      "<C-f><C-f>g", -- Mapped to ctrl-shift-g in alacritty
      function()
        require("neo-tree.command").execute({
          toggle = true,
          dir = vim.loop.cwd(),
          reveal = true,
          source =
          "git_status"
        })
      end,
      desc = "Git changed files tree",
    },
    {
      "<C-f><C-f>e", -- Mapped to cmd+shift+e in alacritty
      function() require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd(), reveal = true }) end,
      desc = "Explorer NeoTree",
    },
    {
      "<C-k><C-e>",
      function() require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd(), reveal = true }) end,
      desc = "Explorer NeoTree",
    },
    {
      "<C-k><C-g>",
      function()
        require("neo-tree.command").execute({
          toggle = true,
          dir = vim.loop.cwd(),
          reveal = true,
          source =
          "git_status"
        })
      end,
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
      version = "v1.*",
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
  opts = function()
    local symbols = require('helper.symbols')
    local shared_mappings = {
      ["/"] = "noop",
      ["<BS>"] = "noop",
      ["U"] = "navigate_up",
      ["F"] = "fuzzy_finder",
      ["<space>"] = "noop",
      ["O"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "O" } },
      ["Oc"] = { "order_by_created", nowait = false },
      ["Od"] = { "order_by_diagnostics", nowait = false },
      ["Om"] = { "order_by_modified", nowait = false },
      ["On"] = { "order_by_name", nowait = false },
      ["Os"] = { "order_by_size", nowait = false },
      ["Ot"] = { "order_by_type", nowait = false },
      ["S"] = "split_with_window_picker",
      ["o"] = { "open_with_window_picker", nowait = true },
      ["s"] = "vsplit_with_window_picker",
      ["oc"] = "noop",
      ["od"] = "noop",
      ["og"] = "noop",
      ["om"] = "noop",
      ["on"] = "noop",
      ["os"] = "noop",
      ["ot"] = "noop",
      ["z"] = "close_node",
      ["Z"] = "close_all_nodes",
      ["t"] = "noop",
    }

    return {
      sources = { "filesystem", "buffers", "git_status", "document_symbols" },
      source_selector = {
        winbar = true,
        statusline = false,
        sources = {
          { source = "filesystem", display_name = "  Files " },
          { source = "buffers", display_name = "  Buffers " },
          { source = "git_status", display_name = "  Git " },
          { source = "document_symbols", display_name = "  Symbols " },
        },
      },
      default_component_configs = {
        diagnostics = {
          symbols = {
            hint  = symbols.hint,
            info  = symbols.info,
            warn  = symbols.warn,
            error = symbols.error,
          },
        },
        git_status = {
          symbols = {
            added     = symbols.added,
            modified  = symbols.modified,
            deleted   = symbols.deleted,
            renamed   = symbols.renamed,
            untracked = symbols.untracked,
            ignored   = symbols.ignored,
            unstaged  = symbols.unstaged,
            staged    = symbols.staged,
            conflict  = symbols.conflict,
          }
        },
        icon = {
          folder_closed = symbols.FolderClosed,
          folder_open = symbols.FolderOpen,
          folder_empty = symbols.FolderEmpty,
        },
        indent = {
          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
      },
      window = {
        width = 60,
      },
      filesystem = {
        bind_to_cwd = false,
        follow_current = { enabled = false },
        use_libuv_file_watcher = true,
        window = {
          mappings = shared_mappings
        }
      },
      buffers = {
        window = {
          mappings = shared_mappings
        }
      },
      git_status = {
        window = {
          mappings = shared_mappings
        }
      },
      document_symbols = {
        follow_cursor = true,
        client_filters = {
          ignore = { "solargraph" }
        }
      },
    }
  end,
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

    vim.cmd [[
      highlight NeoTreeTabActive guibg=#141b24
      highlight NeoTreeTabInactive guibg=#141b24
      highlight NeoTreeTabSeparatorInactive guibg=#141b24 guifg=#141b24
      highlight NeoTreeWinSeparator guibg=#141b24 guifg=#141b24
      highlight NeoTreeWinSeparator guibg=#141b24 guifg=#141b24
    ]]

    vim.cmd [[
      autocmd FileType neo-tree nnoremap <buffer> <leader>q :lua require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd(), reveal = true })<CR>
    ]]
  end,
}
