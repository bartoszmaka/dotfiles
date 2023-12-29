return {
  {
    'ibhagwan/fzf-lua',
    dependencies = {
      'kyazdani42/nvim-web-devicons',
      { 'junegunn/fzf', build = './install --bin' },
      { 'pbogut/fzf-mru.vim' },
    },
    lazy = false,
    config = function()
      local function setup(str, opts)
        return vim.tbl_deep_extend("keep", opts or {},
          {
            prompt = "❯ ",
            winopts = {
              title = " " .. str .. " ",
              title_pos = "center",
            },
            multiprocess = true,
          })
      end
      local helper = require('helper')
      local nnoremap = helper.nnoremap
      local vnoremap = helper.vnoremap
      local symbols = helper.symbols
      local actions = require "fzf-lua.actions"
      local presets = {
        fzf_opts = {
          -- ['--ansi']              = '',
          ['--prompt']            = ' >',
          ['--info']              = 'inline-right',
          ['--height']            = '100%',
          ['--layout']            = 'reverse',
          ['--no-separator']      = '',
          ['--border']            = 'none',
          ['--preview-window']    = 'border-sharp',
        },
        winopts = {
          big_window = {
            win_height = 0.60,     -- window height
            win_width  = 0.90,     -- window width
            win_row    = 0.40,     -- window row position (0=top, 1=bottom)
            win_col    = 0.50,     -- window col position (0=left, 1=right)
            win_border = symbols.corners.sharp,
            -- hl_normal  = 'Normal', -- window normal color
            -- hl_border  = 'Normal', -- change to 'FloatBorder' if exists
            fullscreen = false,
          },
          bottom_pane = {
            win_row    = 1,
            win_col    = 0,
            win_height = 0.20,
            win_width  = 1,
            win_border = symbols.corners.none,
          },
          small_window = {
            win_row    = 0.25,
            win_col    = 0.50,
            win_height = 0.35,
            win_width  = 0.15,
            win_border = symbols.corners.none,
            preview = {
              hidden = 'hidden',
            }
          },
          medium_window = {
            win_row    = 0.30,
            win_col    = 0.50,
            win_height = 0.45,
            win_width  = 0.45,
            win_border = symbols.corners.none,
            preview = {
              horizontal = "right:50%"
            },
          }
        }
      }
      vim.g.fzf_command_prefix = 'Fzf'
      vim.g.fzf_mru_relative = 1
      vim.g.fzf_mru_no_sort = 1
      vim.g.fzf_colors = { bg = { 'bg', 'NormalDarker' } }
      vim.g.fzf_layout = { window = { width = 0.90, height = 0.66 } }
      vim.g.fzf_action = { ['ctrl-s'] = 'split', ['ctrl-v'] = 'vsplit' }

      vim.cmd [[
        command! -bang -nargs=? FZFFreshMruPreview call fzf_mru#actions#mru(<q-args>,
          \{
            \'options': [
              \'--preview', 'bat {}',
              \'--preview-window', 'right:40%',
              \'--reverse',
              \'--preview-window', 'border-sharp',
              \'--border', 'sharp',
              \'--info', 'inline-right',
              \'--prompt', '> ',
              \'--ansi',
              \'--color', 'dark,gutter:#141b24,border:#93a4c3',
              \'--bind', 'f3:toggle-preview-wrap,f4:toggle-preview',
            \]
          \}
        \)
      ]]
      vim.cmd [[
        autocmd FileType fzf tnoremap <buffer> <esc> <esc>
      ]]

      require('fzf-lua').setup {
        global_resume             = true,
        global_resume_query       = true,
        winopts                   = vim.tbl_deep_extend("force", presets.winopts.big_window, {
          preview = {
            border = 'noborder',
            layout = 'flex',
            horizontal = "right:40%"
          },
          -- on_create = function()
          --   vim.cmd [[
          --     set winhighlight=Normal:Error,SignColumn:SignColumnDarker,EndOfBuffer:EndOfBufferDarker
          --   ]]
          -- end
        }),
        keymap                    = {
          builtin                 = {
            ["<F2>"]              = "toggle-fullscreen",
            ["<F3>"]              = "toggle-preview-wrap",
            ["<F4>"]              = "toggle-preview",
            ["<F5>"]              = "toggle-preview-ccw",
            ["<F6>"]              = "toggle-preview-cw",
            ["<S-down>"]          = "preview-page-down",
            ["<S-up>"]            = "preview-page-up",
            ["<S-left>"]          = "preview-page-reset",
          },
          fzf                     = {
            ["ctrl-z"]            = "abort",
            ["ctrl-u"]            = "unix-line-discard",
            ["ctrl-f"]            = "half-page-down",
            ["ctrl-b"]            = "half-page-up",
            ["ctrl-a"]            = "beginning-of-line",
            ["ctrl-e"]            = "end-of-line",
            ["alt-a"]             = "toggle-all",
            ["f3"]                = "toggle-preview-wrap",
            ["f4"]                = "toggle-preview",
            ["shift-down"]        = "preview-page-down",
            ["shift-up"]          = "preview-page-up",
          },
        },
        fzf_opts                  = presets.fzf_opts,
        fzf_colors                = {
          ["bg"]                  = { "bg", "NormalDarker" },
          ["gutter"]              = { "bg", "NormalDarker" },
        },
        hls = {
          normal = "NormalDarker",
          border = "NormalDarker",
          title = "NormalDarker",
          preview_normal = "NormalDarker",
          preview_border = "NormalDarker",
          preview_title = "NormalDarker",
          help_normal = "NormalDarker",
          help_border = "NormalDarker",
        },
        previewers                = {
          git_diff                = { cmd = 'git diff', args = "--color", pager = "delta" },
          builtin                 = {
            delay                 = 100, -- delay(ms) displaying the preview
            title                 = true, -- preview title?
            scrollbar             = true, -- scrollbar?
            scrollchar            = '▋', -- scrollbar character
            extensions      = {
              ["png"]       = { "viu", "-b" },
              ["jpg"]       = { "viu", "-b" },
              ["gif"]       = { "viu", "-b" },
              -- ["svg"]       = { "chafa", "<file>" },
              -- ["jpg"]       = { "ueberzug" },
            },

          },
        },
        files                     = setup("Files",
          {
            rg_opts               = "--color=never --no-ignore-vcs --files --hidden --follow -g '!.git' -g '!node_modules' -g '!.next/'",
            fd_opts               = "--color=never --no-ignore-vcs --type f --hidden --follow --exclude .git --exclude tmp --exclude .idea --exclude node_modules --exclude .next --exclude vendor",
            fzf_opts              = presets.fzf_opts,
            actions               = {
              ["default"]         = actions.file_edit,
              ["ctrl-s"]          = actions.file_split,
              ["ctrl-v"]          = actions.file_vsplit,
            },
            winopts = vim.tbl_deep_extend("force", presets.winopts.big_window, {
              preview = { horizontal = "right:60%" },
            })
          }
        ),
        buffers                   = setup("Buffers", { winopts = presets.winopts.medium_window }),
        tabs                      = setup("Tabs"),
        lines                     = setup("Lines"),
        blines                    = setup("Buffer Lines", { winopts = presets.winopts.bottom_pane }),
        grep                      = setup("Search", {
          fzf_opts                = presets.fzf_opts,
          rg_glob                 = true,
          -- rg_opts                 = "--hidden --column --line-number --no-heading --color=always --smart-case -g '!{*.min.js,*.js.map}' -g '!{.git,node_modules,storybook/storybook-static,vendor/assets}/*'",
          rg_opts                 = "--hidden --column --line-number --no-heading --color=always --fixed-strings --smart-case -g '!{*.min.js,*.js.map}' -g '!{.git,node_modules,storybook/storybook-static,vendor/assets}/*'",
          git_icons      = true, -- show git icons?
          file_icons     = true, -- show file icons?
          color_icons    = true, -- colorize file|git icons
          experimental   = false,
          glob_flag      = "--iglob", -- for case sensitive globs use '--glob'
          glob_separator = "%s%-%-" -- query separator pattern (lua): ' --'
        }),
        git                       = {
          files                   = setup("Git Files"),
          status                  = setup("Git Status", {
            previewer = "git_diff",
            winopts = vim.tbl_deep_extend("force", presets.winopts.big_window, {
              preview = { horizontal = "right:50%" },
            })
          }),
          commits                 = setup("Git Commits"),
          bcommits                = setup("Git BCommits", {
            cmd                   = "git log --pretty=oneline --abbrev-commit --color",
            preview               = "git show --pretty='%Cred%H%n%Cblue%an%n%Cgreen%s' --color {1}",
            actions               = {
              ["default"]         = actions.git_buf_edit,
              ["ctrl-s"]          = actions.git_buf_split,
              ["ctrl-v"]          = actions.git_buf_vsplit,
              ["ctrl-t"]          = actions.git_buf_tabedit,
            },

          }),
          branches                = setup("Git Branches", {
            cmd                   = "git branch --all --color",
            preview               = "git log --graph --pretty=oneline --abbrev-commit --color {1}",
            actions               = { ["default"] = actions.git_switch },
          }),
          stash                   = setup("Git Stash"),
        },
        args                      = setup("Args"),
        oldfiles                  = setup("Oldfiles", {
          cwd_only                = true,
          include_current_session = true,
        }),
        quickfix                  = setup("Quickfix List", { winopts = presets.winopts.bottom_pane }),
        quickfix_stack            = setup("Quickfix List Stack"),
        loclist                   = setup("Location List"),
        loclist_stack             = setup("Location List Stack"),
        tags                      = setup("Tags"),
        btags                     = setup("Buffer Tags"),
        colorschemes              = setup("Colorschemes"),
        highlights                = setup("Highlights"),
        helptags                  = setup("Neovim Help"),
        manpages                  = setup("Man Pages"),
        lsp                       = setup("LSP", {
          winopts                 = presets.winopts.bottom_pane,
          async_or_timeout        = true, -- timeout(ms) or false for blocking calls
          symbols                 = setup("LSP", { symbol_icons = symbols, winopts = presets.winopts.medium_window, }),
          finder                  = setup("LSP Finder", { fzf_opts = presets.fzf_opts, winopts = presets.winopts.bottom_pane }),
          code_actions            = setup("Code Actions"),
          icons                   = {
            ["Error"]             = { icon = symbols.Error, color = "red" },    -- error
            ["Warning"]           = { icon = symbols.Warn, color = "yellow" },  -- warning
            ["Information"]       = { icon = symbols.Info, color = "blue" },    -- info
            ["Hint"]              = { icon = symbols.Hint, color = "magenta" }, -- hint
          },
        }),
        diagnostics               = setup("Diagnostics", { winopts = presets.winopts.bottom_pane }),
        builtin                   = setup("FzfLua Builtin", { winopts = presets.winopts.small_window }),
        profiles                  = setup("FzfLua Profiles"),
        marks                     = setup("Marks"),
        jumps                     = setup("Jumps"),
        tagstack                  = setup("Tagstack"),
        commands                  = setup("Commands", { winopts = presets.winopts.small_window }),
        autocmds                  = setup("Autocmds"),
        command_history           = setup("Command history"),
        search_history            = setup("Search history"),
        keymaps                   = setup("Keymaps", { winopts = presets.winopts.big_window }),
        spell_suggest             = setup("Spell Suggestions", { winopts = presets.winopts.small_window }),
        filetypes                 = setup("Filetypes", { winopts = presets.winopts.small_window }),
        packadd                   = setup("Packer Packadd"),
        menus                     = setup("Menus"),
        tmux                      = setup("Tmux Buffers"),
        dap                       = {
          commands                = setup("DAP Commands"),
          configurations          = setup("DAP Configurations"),
          variables               = setup("DAP Variables"),
          frames                  = setup("DAP Frames"),
          breakpoints             = setup("DAP Breakpoints"),
        },
      }

      nnoremap('<leader>pr', ':FZFFreshMruPreview()<CR>')

      nnoremap('<C-p><C-p>', [[:lua require("fzf-lua").files()<CR>]])
      vnoremap('<C-p><C-p>', [[y<esc>:lua require("fzf-lua").files()<CR>p]])
      nnoremap('<C-p><C-f>', [[:lua require("fzf-lua").live_grep()<CR>]])
      vnoremap('<C-p><C-f>', [[<esc>:lua require("fzf-lua").grep_visual()<CR>]])
      nnoremap('<C-p><C-r>', [[:lua require("fzf-lua").oldfiles()<CR>]])
      nnoremap('<leader>fW', [[:lua require("fzf-lua").grep_cWORD()<CR>]])

      nnoremap('<leader>pa', [[:lua require("fzf-lua").builtin()<CR>]])
      nnoremap('<C-p><C-a>', [[:lua require("fzf-lua").builtin()<CR>]]) -- Mapped to Cmd + Shift + P in alacritty
      nnoremap('<leader>pp', [[:lua require("fzf-lua").files()<CR>]])
      -- nnoremap('<leader>pr', [[:lua require("fzf-lua").oldfiles()<CR>]])
      nnoremap('<leader>pg', [[:lua require("fzf-lua").git_status()<CR>]])
      nnoremap('<leader>pb', [[:lua require("fzf-lua").buffers()<CR>]])
      nnoremap('<leader>pB', [[:lua require("fzf-lua").git_branches()<CR>]])
      nnoremap('<leader>pf', [[:lua require("fzf-lua").live_grep()<CR>]])
      nnoremap('<leader>pF', [[:lua require("fzf-lua").live_grep_resume()<CR>]])
      nnoremap('<leader>pq', [[:lua require("fzf-lua").quickfix()<CR>]])
      nnoremap('<leader>/', [[:lua require("fzf-lua").blines()<CR>]])
      nnoremap('<leader>pc', [[:lua require("fzf-lua").git_bcommits()<CR>]])
      nnoremap('<leader>p;', [[:lua require("fzf-lua").commands()<CR>]])
      nnoremap('<leader>pK', [[:lua require("fzf-lua").keymaps()<CR>]])
      nnoremap('gd', [[:lua require("fzf-lua").lsp_definitions({ jump_to_single_result = true })<CR>]])
      nnoremap('gF', [[:lua require("fzf-lua").lsp_finder()<CR>]])
      nnoremap('gr', [[:lua require("fzf-lua").lsp_references({ ignore_current_line = true })<CR>]])
      nnoremap('<leader>pe', [[:lua require("fzf-lua").lsp_document_diagnostics()<CR>]])
      nnoremap('<leader>pE', [[:lua require("fzf-lua").lsp_workspace_diagnostics()<CR>]])
      nnoremap('<C-f><C-f><C-h>', [[:lua require("fzf-lua").lsp_workspace_diagnostics()<CR>]]) -- Mapped to Cmd + Shift + M in alacritty
      nnoremap('<leader>ps', [[:lua require("fzf-lua").lsp_document_symbols()<CR>]])
      nnoremap('<leader>pS', [[<cmd>lua require('fzf-lua').lsp_workspace_symbols({winopts = {win_height = 0.60, win_width = 0.90, win_row = 0.40, win_col = 0.50}})<CR>]])
      nnoremap('z=', [[:lua require("fzf-lua").spell_suggest()<CR>]])
      nnoremap('<leader>p.', [[:lua require("fzf-lua").filetypes()<CR>]])


      -- vim.keymap.set({ "i" }, "<C-x><C-f>",
      --   function()
      --     require("fzf-lua").complete_file({
      --       cmd = "rg --files",
      --       winopts = { preview = { hidden = "nohidden" } }
      --     })
      --   end, { silent = true, desc = "Fuzzy complete file" })
    end
  },
}
