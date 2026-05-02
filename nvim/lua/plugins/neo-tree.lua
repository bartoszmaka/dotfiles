return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  cmd = 'Neotree',
  keys = {
    {
      "<C-f><C-f>b", -- Cmd + Shift + e in kitty config
      "<cmd>Neotree close<CR>",
      desc = "Close NeoTree panel",
    },
    {
      "<C-f><C-f>g", -- Ctrl + Shift + g in kitty config
      function()
        require("neo-tree.command").execute({
          toggle = true,
          dir = vim.uv.cwd(),
          reveal = true,
          source = "git_status",
        })
      end,
      desc = "Git changed files tree",
    },
    {
      "<C-f><C-f>e",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd(), reveal = true })
      end,
      desc = "Explorer NeoTree",
    },
    {
      "<C-k><C-e>",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd(), reveal = true })
      end,
      desc = "Explorer NeoTree",
    },
    {
      "<C-k><C-g>",
      function()
        require("neo-tree.command").execute({
          toggle = true,
          dir = vim.uv.cwd(),
          reveal = true,
          source = "git_status",
        })
      end,
      desc = "GitStatus NeoTree",
    },
  },
  deactivate = function()
    vim.cmd('Neotree close')
  end,
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-tree/nvim-web-devicons" },
    { "MunifTanjim/nui.nvim" },
    {
      "s1n7ax/nvim-window-picker",
      version = "2.*",
      config = function()
        local colors = require('helper').colors
        require("window-picker").setup({
          selection_chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
          filter_rules = {
            include_current_win = false,
            autoselect_one = true,
            bo = {
              filetype = { "neo-tree", "neo-tree-popup", "notify" },
              buftype = { "terminal", "quickfix" },
            },
          },
          highlights = {
            enabled = true,
            statusline = {
              focused = {
                fg = colors.onedark.white,
                bg = colors.onedark.bg_blue,
                bold = true,
              },
              unfocused = {
                fg = colors.onedark.white,
                bg = colors.onedark.blue,
                bold = true,
              },
            },
            winbar = {
              focused = {
                fg = colors.onedark.white,
                bg = colors.onedark.blue,
                bold = true,
              },
              unfocused = {
                fg = colors.onedark.white,
                bg = colors.onedark.blue,
                bold = true,
              },
            },
          },
        })
      end,
    },
  },
  opts = function()
    local symbols = require('helper.symbols')
    local function shared_mappings(tab_name)
      local mappings = {
        ["/"]      = "noop",
        -- ["<C-r>"]  = "noop",
        ["<space>"] = "noop",
        ["O"]      = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "O" } },
        ["Oc"]     = { "order_by_created", nowait = false },
        ["Od"]     = { "order_by_diagnostics", nowait = false },
        ["Om"]     = { "order_by_modified", nowait = false },
        ["On"]     = { "order_by_name", nowait = false },
        ["Os"]     = { "order_by_size", nowait = false },
        ["Ot"]     = { "order_by_type", nowait = false },
        ["oc"]     = "noop",
        ["od"]     = "noop",
        ["og"]     = "noop",
        ["om"]     = "noop",
        ["on"]     = "noop",
        ["os"]     = "noop",
        ["ot"]     = "noop",
        ["S"]      = "split_with_window_picker",
        ["o"]      = { "open_with_window_picker", nowait = true },
        ["s"]      = "vsplit_with_window_picker",
        ["za"]     = "toggle_node",
        ["<BS>"]   = "noop",
        -- ["z"]      = "close_node",
        -- ["Z"]      = "close_all_nodes",
        -- ["NeoTreeFileNameOpenedt"]      = "noop",
      }

      if tab_name == "filesystem" then
        mappings["U"] = "navigate_up"
        mappings["F"] = "fuzzy_finder"
      else
        mappings["U"] = "noop"
        mappings["F"] = "noop"
      end

      return mappings
    end

    return {
      sources = { "filesystem", "buffers", "git_status", "document_symbols" },
      source_selector = {
        winbar = true,
        statusline = false,
        separator = { left = " ", right= " " },
        separator_active = { left = " ", right= " " },
        sources = {
          { source = "filesystem", display_name = "  Files " },
          -- { source = "buffers", display_name = "  Buffers " },
          { source = "git_status", display_name = "  Git " },
          -- { source = "document_symbols", display_name = "  Symbols " },
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
      },
      window = { width = 60 },
      filesystem = {
        bind_to_cwd = false,
        follow_current = { enabled = false },
        use_libuv_file_watcher = true,
        window = { mappings = shared_mappings("filesystem") },
      },
      buffers = {
        window = { mappings = shared_mappings("buffers") },
      },
      git_status = {
        window = { mappings = shared_mappings("git_status") },
      },
      document_symbols = {
        follow_cursor = true,
        client_filters = { ignore = { "solargraph" } },
      },
      event_handlers = {
        {
          event = 'neo_tree_window_after_open',
          handler = function(args)
            vim.wo[args.winid].colorcolumn = ""
            vim.wo[args.winid].signcolumn = "no"
          end
        }
      }
    }
  end,
  config = function(_, opts)
    require("neo-tree").setup(opts)

    local ok_git, neo_tree_git = pcall(require, "neo-tree.git")
    if ok_git and not neo_tree_git._dotfiles_untracked_tuned then
      local original_git_status = neo_tree_git.status
      neo_tree_git.status = function(path, base_lookup, skip_bubbling, status_opts)
        status_opts = status_opts or {}
        if status_opts.untracked_files == "all" then
          status_opts = vim.tbl_extend("force", status_opts, { untracked_files = "normal" })
        end
        return original_git_status(path, base_lookup, skip_bubbling, status_opts)
      end
      neo_tree_git._dotfiles_untracked_tuned = true
    end

    vim.api.nvim_create_autocmd("TermClose", {
      pattern = "*lazygit",
      callback = function()
        if package.loaded["neo-tree.sources.git_status"] then
          require("neo-tree.sources.git_status").refresh()
        end
      end,
    })

    local colors = require('helper.colors').onedark
    vim.api.nvim_set_hl(0, 'NeoTreeTabActive', { fg = colors.fg, bg = colors.bg1, bold = true })
    vim.api.nvim_set_hl(0, 'NeoTreeTabInactive', { bg = colors.bg_d })
    vim.api.nvim_set_hl(0, 'NeoTreeTabSeparatorActive', { fg = colors.bg1, bg = colors.bg1 })
    vim.api.nvim_set_hl(0, 'NeoTreeTabSeparatorInactive', { fg = colors.bg_d, bg = colors.bg_d })
    vim.api.nvim_set_hl(0, 'NeoTreeWinSeparator', { fg = colors.bg_d, bg = colors.bg_d })

    local neo_tree_augroup = vim.api.nvim_create_augroup("NeoTreeLocalConfig", { clear = true })

    local function clear_statuscolumn(bufnr)
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_buf(win) == bufnr then
          vim.api.nvim_set_option_value("statuscolumn", "", { scope = "local", win = win })
        end
      end
    end

    vim.api.nvim_create_autocmd({ "FileType", "BufWinEnter", "WinEnter" }, {
      group = neo_tree_augroup,
      callback = function(args)
        local ft = vim.bo[args.buf].filetype
        if ft ~= "neo-tree" and ft ~= "neo-tree-popup" then
          return
        end

        clear_statuscolumn(args.buf)
        vim.schedule(function()
          if vim.api.nvim_buf_is_valid(args.buf) then
            clear_statuscolumn(args.buf)
          end
        end)
      end,
    })

    -- vim.api.nvim_create_autocmd("FileType", {
    --   group = neo_tree_augroup,
    --   pattern = "neo-tree",
    --   callback = function(args)
    --     vim.keymap.set("n", "<leader>q", function()
    --       require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd(), reveal = true })
    --     end, { buffer = args.buf, silent = true })
    --   end,
    -- })
  end,
}
