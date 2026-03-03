return {
  {
    'ibhagwan/fzf-lua',
    dependencies = {
      'kyazdani42/nvim-web-devicons',
    },
    lazy = false,
    config = function()
      local helper = require('helper')
      local nnoremap = helper.nnoremap
      local vnoremap = helper.vnoremap
      local symbols = helper.symbols
      local actions = require "fzf-lua.actions"

      local winopts = {
        big_window = {
          height = 0.60,
          width  = 0.80,
          row    = 0.50,
          col    = 0.50,
          border = symbols.corners.none,
          fullscreen = false,
        },
        bottom_pane = {
          row    = 1,
          col    = 0,
          height = 0.20,
          width  = 1,
          border = symbols.corners.none,
        },
        small_window = {
          row    = 0.25,
          col    = 0.50,
          height = 0.25,
          width  = 0.15,
          border = symbols.corners.none,
          preview = { hidden = 'hidden' },
        },
        medium_window = {
          row    = 0.30,
          col    = 0.50,
          height = 0.45,
          width  = 0.45,
          border = symbols.corners.none,
          preview = { horizontal = "right:50%" },
        },
      }

      local fzf_colors = {
        ["gutter"]     = { "bg", "NormalDarker" },
        ["bg"]         = { "bg", "NormalDarker" },
        ["preview-bg"] = { "bg", "NormalDarker" },
        ["bg+"]        = { "bg", "CursorLine" },
        ["fg+"]        = { "fg", "CursorLine" },
        ["hl"]         = { "fg", "CmpItemAbbrMatch" },
        ["hl+"]        = { "fg", "CmpItemAbbrMatch" },
      }

      require('fzf-lua').setup {
        defaults = {
          prompt       = "❯ ",
          multiprocess = true,
        },
        no_hide             = true,
        global_resume       = true,
        global_resume_query = true,
        winopts             = vim.tbl_deep_extend("force", winopts.big_window, {
          backdrop = 100,
          preview = {
            delay      = 100,
            title      = true,
            scrollbar  = true,
            scrollchar = '▋',
            border     = 'noborder',
            layout     = 'flex',
            horizontal = "right:40%",
          },
        }),
        keymap = {
          builtin = {
            ["<F2>"]     = "toggle-fullscreen",
            ["<F3>"]     = "toggle-preview-wrap",
            ["<F4>"]     = "toggle-preview",
            ["<F5>"]     = "toggle-preview-ccw",
            ["<F6>"]     = "toggle-preview-cw",
            ["<S-down>"] = "preview-page-down",
            ["<S-up>"]   = "preview-page-up",
            ["<S-left>"] = "preview-page-reset",
          },
          fzf = {
            ["ctrl-z"]     = "abort",
            ["ctrl-f"]     = "half-page-down",
            ["ctrl-b"]     = "half-page-up",
            ["alt-a"]      = "toggle-all",
            ["f3"]         = "toggle-preview-wrap",
            ["f4"]         = "toggle-preview",
            ["shift-down"] = "preview-page-down",
            ["shift-up"]   = "preview-page-up",
          },
        },
        fzf_opts = {
          ['--prompt']         = ' >',
          ['--info']           = 'inline-right',
          ['--height']         = '100%',
          ['--layout']         = 'reverse',
          ['--no-separator']   = '',
          ['--border']         = 'none',
          ['--preview-window'] = 'border-left',
        },
        fzf_colors = fzf_colors,
        hls = {
          normal         = "NormalDarker",
          border         = "NormalDarker",
          title          = "NormalDarker",
          search         = "Search",
          preview_normal = "NormalDarker",
          preview_border = "NormalDarker",
          preview_title  = "NormalDarker",
          help_normal    = "NormalDarker",
          help_border    = "NormalDarker",
        },
        previewers = {
          git_diff = { cmd = 'git diff', args = "--color", pager = "delta" },
        },
        files = {
          rg_opts = "--color=never --no-ignore-vcs --files --hidden --follow -g '!.git' -g '!node_modules' -g '!.next/'",
          fd_opts = "--color=never --no-ignore-vcs --type f --hidden --follow --exclude .git --exclude tmp --exclude .idea --exclude node_modules --exclude .next --exclude vendor",
          actions = {
            ["default"] = actions.file_edit,
            ["ctrl-s"]  = actions.file_split,
            ["ctrl-v"]  = actions.file_vsplit,
          },
          winopts = vim.tbl_deep_extend("force", winopts.big_window, {
            preview = { horizontal = "right:60%" },
          }),
        },
        buffers = { winopts = winopts.medium_window },
        blines  = { winopts = winopts.bottom_pane },
        grep = {
          rg_glob        = true,
          rg_opts        = "--hidden --column --line-number --no-heading --color=always --fixed-strings --smart-case -g '!{*.min.js,*.js.map}' -g '!{.git,node_modules,storybook/storybook-static,vendor/assets}/*'",
          glob_flag      = "--iglob",
          glob_separator = "%s%-%-",
        },
        git = {
          status = {
            previewer = "git_diff",
            winopts = vim.tbl_deep_extend("force", winopts.big_window, {
              preview = { horizontal = "right:50%" },
            }),
          },
          bcommits = {
            cmd     = "git log --pretty=oneline --abbrev-commit --color",
            preview = "git show --pretty='%Cred%H%n%Cblue%an%n%Cgreen%s' --color {1}",
            actions = {
              ["default"] = actions.git_buf_edit,
              ["ctrl-s"]  = actions.git_buf_split,
              ["ctrl-v"]  = actions.git_buf_vsplit,
              ["ctrl-t"]  = actions.git_buf_tabedit,
            },
          },
          branches = {
            cmd     = "git branch --all --color",
            preview = "git log --graph --pretty=oneline --abbrev-commit --color {1}",
            actions = { ["default"] = actions.git_switch },
          },
        },
        oldfiles = {
          cwd_only                = true,
          include_current_session = true,
          multiprocess            = false,
        },
        quickfix    = { winopts = winopts.bottom_pane },
        lsp = {
          multiprocess     = false,
          winopts          = winopts.bottom_pane,
          async_or_timeout = true,
          symbols      = { symbol_icons = symbols, winopts = winopts.medium_window },
          finder       = { winopts = winopts.bottom_pane },
          code_actions = { winopts = winopts.bottom_pane },
          icons = {
            ["Error"]       = { icon = symbols.Error, color = "red" },
            ["Warning"]     = { icon = symbols.Warn, color = "yellow" },
            ["Information"] = { icon = symbols.Info, color = "blue" },
            ["Hint"]        = { icon = symbols.Hint, color = "magenta" },
          },
        },
        diagnostics   = { winopts = winopts.bottom_pane },
        builtin       = { winopts = winopts.small_window },
        commands      = { winopts = winopts.small_window },
        keymaps       = { winopts = winopts.big_window },
        spell_suggest = { winopts = winopts.small_window },
        filetypes     = { winopts = winopts.small_window },
      }

      -- File navigation
      nnoremap('<leader>pp', [[:lua require("fzf-lua").files()<CR>]], { desc = "Files" })
      nnoremap('<leader>pr', [[:lua require("fzf-lua").oldfiles()<CR>]], { desc = "Recent Files" })
      nnoremap('<C-p><C-p>', [[:lua require("fzf-lua").files()<CR>]], { desc = "Files" })
      nnoremap('<C-p><C-r>', [[:lua require("fzf-lua").oldfiles()<CR>]], { desc = "Recent Files" })
      vnoremap('<C-p><C-p>', [[y<esc>:lua require("fzf-lua").files()<CR>p]], { desc = "Files" })
      nnoremap('<leader>pa', [[:lua require("fzf-lua").builtin()<CR>]], { desc = "Actions (FZF)" })
      nnoremap('<C-p><C-a>', [[:lua require("fzf-lua").builtin()<CR>]], { desc = "Actions (FZF)" })

      -- Search
      nnoremap('<C-p><C-f>', [[:lua require("fzf-lua").live_grep()<CR>]], { desc = "Find in project" })
      vnoremap('<C-p><C-f>', [[<esc>:lua require("fzf-lua").grep_visual()<CR>]], { desc = "Find in project" })
      nnoremap('<leader>fW', [[:lua require("fzf-lua").grep_cWORD()<CR>]], { desc = "Find word in project" })
      nnoremap('<leader>pf', [[:lua require("fzf-lua").live_grep()<CR>]], { desc = "Find in project" })
      nnoremap('<leader>pF', [[:lua require("fzf-lua").live_grep_resume()<CR>]], { desc = "Resume find in project" })

      -- Git
      nnoremap('<leader>pg', [[:lua require("fzf-lua").git_status()<CR>]], { desc = "Git status" })

      -- LSP
      nnoremap('<leader>ps', [[:lua require("fzf-lua").lsp_document_symbols()<CR>]], { desc = "File Symbols" })
      nnoremap('<leader>pS', [[<cmd>lua require('fzf-lua').lsp_workspace_symbols({winopts = {height = 0.60, width = 0.90, row = 0.40, col = 0.50}})<CR>]], { desc = "Project Symbols" })
      nnoremap('<leader>pe', [[:lua require("fzf-lua").lsp_document_diagnostics()<CR>]], { desc = "File Diagnostics" })
      nnoremap('<leader>pE', [[:lua require("fzf-lua").lsp_workspace_diagnostics()<CR>]], { desc = "Project Diagnostics" })
      nnoremap('<C-f><C-f><C-h>', [[:lua require("fzf-lua").lsp_workspace_diagnostics()<CR>]], { desc = "Project Diagnostics" })

      -- Misc
      nnoremap('<leader>/', [[:lua require("fzf-lua").blines()<CR>]], { desc = "File Lines" })
      nnoremap('<leader>p.', [[:lua require("fzf-lua").filetypes()<CR>]], { desc = "Filetypes" })
      nnoremap('z=', [[:lua require("fzf-lua").spell_suggest()<CR>]], { desc = "Spell" })
      nnoremap('<leader>pb', [[:lua require("fzf-lua").buffers()<CR>]], { desc = "Buffers" })
      nnoremap('<leader>pB', [[:lua require("fzf-lua").git_branches()<CR>]], { desc = "Branches" })
      nnoremap('<leader>pq', [[:lua require("fzf-lua").quickfix()<CR>]], { desc = "Quickfix" })
      nnoremap('<leader>pc', [[:lua require("fzf-lua").git_bcommits()<CR>]], { desc = "File Commits" })
      nnoremap('<leader>p;', [[:lua require("fzf-lua").commands()<CR>]], { desc = "Commands" })
      nnoremap('<leader>pK', [[:lua require("fzf-lua").keymaps()<CR>]], { desc = "Keymaps" })

      -- LSP goto
      nnoremap('gd', [[:lua require("fzf-lua").lsp_definitions({ jump1 = true })<CR>]], { desc = "Definitions" })
      nnoremap('gD', function() vim.lsp.buf.definition() end, { desc = "Definitions" })
      nnoremap('gF', [[:lua require("fzf-lua").lsp_finder()<CR>]], { desc = "LSP Finder" })
      nnoremap('gr', [[:lua require("fzf-lua").lsp_references({ ignore_current_line = true })<CR>]], { desc = "References" })
    end
  },
}
