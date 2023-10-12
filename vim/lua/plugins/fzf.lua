return {
  {
    'bartoszmaka/fzf-mru.vim',
    dependencies = {
      { 'kyazdani42/nvim-web-devicons' },
      { 'junegunn/fzf', build = './install --bin' },
      { 'junegunn/fzf.vim' },
    },
    lazy = false,
    config = function()
      vim.cmd [[
        let $FZF_DEFAULT_OPTS='--layout=reverse'
        let g:fzf_command_prefix = 'Fzf'
        let g:fzf_mru_relative = 1
        let g:fzf_mru_no_sort = 1
        let g:fzf_colors = { 'bg': ['bg', 'FZFNormal'] }
        let g:fzf_layout = { 'window': { 'width': 0.90, 'height': 0.67 }}

        autocmd FileType fzf tnoremap <buffer> <esc> <esc>
      ]]
    end
  },
  { 'ibhagwan/fzf-lua',
    dependencies = {
      'kyazdani42/nvim-web-devicons',
      { 'junegunn/fzf', build = './install --bin' }
    },
    lazy = false,
    config = function()
      vim.cmd [[
        autocmd FileType fzf tnoremap <buffer> <esc> <esc>
      ]]

      local helper = require('helper')
      local nnoremap = helper.nnoremap
      local vnoremap = helper.vnoremap
      local symbols = helper.symbols

      vim.g.mapleader = ' '
      local actions = require "fzf-lua.actions"
      require('fzf-lua').setup {
        global_resume       = true,
        global_resume_query = true,
        winopts             = {
          win_height = 0.60, -- window height
          win_width  = 0.90, -- window width
          win_row    = 0.40, -- window row position (0=top, 1=bottom)
          win_col    = 0.50, -- window col position (0=left, 1=right)
          win_border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
          hl_normal  = 'Normal', -- window normal color
          hl_border  = 'Normal', -- change to 'FloatBorder' if exists
          fullscreen = false, -- start fullscreen?
        },
        keymap              = {
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
            ["ctrl-u"]     = "unix-line-discard",
            ["ctrl-f"]     = "half-page-down",
            ["ctrl-b"]     = "half-page-up",
            ["ctrl-a"]     = "beginning-of-line",
            ["ctrl-e"]     = "end-of-line",
            ["alt-a"]      = "toggle-all",
            ["f3"]         = "toggle-preview-wrap",
            ["f4"]         = "toggle-preview",
            ["shift-down"] = "preview-page-down",
            ["shift-up"]   = "preview-page-up",
          },
        },
        fzf_opts            = {
          ['--ansi']   = '',
          ['--prompt'] = ' >',
          ['--info']   = 'inline',
          ['--height'] = '100%',
          ['--layout'] = 'reverse',
        },
        fzf_colors          = {
          ["bg"] = { "bg", "FZFNormal" },
        },
        preview_border      = 'border', -- border|noborder
        preview_wrap        = 'nowrap', -- wrap|nowrap
        preview_opts        = 'nohidden', -- hidden|nohidden
        preview_vertical    = 'down:45%', -- up|down:size
        preview_horizontal  = 'right:55%', -- right|left:size
        preview_layout      = 'flex', -- horizontal|vertical|flex
        flip_columns        = 120, -- #cols to switch to horizontal on flex
        default_previewer   = "bat",
        previewers          = {
          cat = {
            cmd  = "cat",
            args = "--number",
          },
          bat = {
            cmd    = "bat",
            args   = "--style=numbers,changes --color always",
            theme  = 'TwoDark', -- bat preview theme (bat --list-themes)
            config = nil, -- nil uses $BAT_CONFIG_PATH
          },
          head = {
            cmd  = "head",
            args = nil,
          },
          git_diff = {
            cmd   = 'git diff',
            args  = "--color",
            pager = "delta"
          },
          builtin = {
            delay          = 100, -- delay(ms) displaying the preview
            title          = true, -- preview title?
            scrollbar      = true, -- scrollbar?
            scrollchar     = '█', -- scrollbar character
            syntax         = true, -- preview syntax highlight?
            syntax_limit_l = 100, -- syntax limit (lines), 0=nolimit
            syntax_limit_b = 128 * 128, -- syntax limit (bytes), 0=nolimit
            hl_cursor      = 'Cursor', -- cursor highlight
            hl_cursorline  = 'CursorLine', -- cursor line highlight
          },
        },
        -- provider setup
        files               = {
          multiprocess = true,
          previewer    = "bat", -- uncomment to override previewer
          prompt       = 'Files❯ ',
          cmd          = '', -- "find . -type f -printf '%P\n'",
          git_icons    = true, -- show git icons?
          file_icons   = true, -- show file icons?
          color_icons  = true, -- colorize file|git icons
          rg_opts      = "--color=never --no-ignore-vcs --files --hidden --follow -g '!.git' -g '!node_modules' -g '!.next/'",
          fd_opts      = "--color=never --no-ignore-vcs --type f --hidden --follow --exclude .git --exclude tmp --exclude .idea --exclude node_modules --exclude .next --exclude vendor",
          actions      = {
            ["default"] = actions.file_edit,
            ["ctrl-s"]  = actions.file_split,
            ["ctrl-v"]  = actions.file_vsplit,
            ["ctrl-t"]  = actions.file_tabedit,
            ["alt-q"]   = actions.file_sel_to_qf,
            ["ctrl-y"]  = function(selected) print(selected[1]) end,
          }
        },
        git                 = {
          files = {
            multiprocess = true,
            prompt       = 'GitFiles❯ ',
            cmd          = 'git ls-files --exclude-standard',
            git_icons    = true, -- show git icons?
            file_icons   = true, -- show file icons?
            color_icons  = true, -- colorize file|git icons
          },
          status = {
            multiprocess = true,
            prompt       = 'GitStatus❯ ',
            cmd          = "git status -s",
            previewer    = "git_diff",
            file_icons   = true,
            git_icons    = true,
            color_icons  = true,
          },
          commits = {
            multiprocess = true,
            prompt       = 'Commits❯ ',
            cmd          = "git log --pretty=oneline --abbrev-commit --color",
            preview      = "git show --pretty='%Cred%H%n%Cblue%an%n%Cgreen%s' --color {1} | delta",
            actions      = {
              ["default"] = actions.git_checkout,
            },
          },
          bcommits = {
            multiprocess = true,
            prompt       = 'BCommits❯ ',
            cmd          = "git log --pretty=oneline --abbrev-commit --color",
            preview      = "git show --pretty='%Cred%H%n%Cblue%an%n%Cgreen%s' --color {1}",
            actions      = {
              ["default"] = actions.git_buf_edit,
              ["ctrl-s"]  = actions.git_buf_split,
              ["ctrl-v"]  = actions.git_buf_vsplit,
              ["ctrl-t"]  = actions.git_buf_tabedit,
            },
          },
          branches = {
            multiprocess = true,
            prompt       = 'Branches❯ ',
            cmd          = "git branch --all --color",
            preview      = "git log --graph --pretty=oneline --abbrev-commit --color {1}",
            actions      = {
              ["default"] = actions.git_switch,
            },
          },
          icons = {
            ["M"] = { icon = "M", color = "yellow" },
            ["D"] = { icon = "D", color = "red" },
            ["A"] = { icon = "A", color = "green" },
            ["?"] = { icon = "?", color = "magenta" },
          },
        },
        grep                = {
          multiprocess   = true,
          prompt         = 'Rg❯ ',
          input_prompt   = 'Grep For❯ ',
          rg_opts        = "--hidden --column --line-number --no-heading " ..
          "--color=always --smart-case -g '!{.git,node_modules,storybook/storybook-static,vendor/assets}/*'",
          git_icons      = true, -- show git icons?
          file_icons     = true, -- show file icons?
          color_icons    = true, -- colorize file|git icons
          experimental   = false,
          -- live_grep_glob options
          glob_flag      = "--iglob", -- for case sensitive globs use '--glob'
          glob_separator = "%s%-%-" -- query separator pattern (lua): ' --'
        },
        args                = {
          multiprocess = true,
          prompt       = 'Args❯ ',
          files_only   = true,
          actions      = {
            ["ctrl-x"] = actions.arg_del,
          }
        },
        oldfiles            = {
          multiprocess            = true,
          prompt                  = 'History❯ ',
          cwd_only                = true,
          stat_file               = true,
          include_current_session = true,
          cwd                     = vim.loop.cwd()
        },
        buffers             = {
          multiprocess  = true,
          prompt        = 'Buffers❯ ',
          file_icons    = true, -- show file icons?
          color_icons   = true, -- colorize file|git icons
          sort_lastused = true, -- sort buffers() by last used
          actions       = {
            ["default"] = actions.buf_edit,
            ["ctrl-s"]  = actions.buf_split,
            ["ctrl-v"]  = actions.buf_vsplit,
            ["ctrl-t"]  = actions.buf_tabedit,
            ["ctrl-x"]  = actions.buf_del,
          }
        },
        blines              = {
          multiprocess = true,
          previewer    = "builtin", -- set to 'false' to disable
          prompt       = 'BLines❯ ',
          actions      = {
            ["default"] = actions.buf_edit,
            ["ctrl-s"]  = actions.buf_split,
            ["ctrl-v"]  = actions.buf_vsplit,
            ["ctrl-t"]  = actions.buf_tabedit,
          }
        },
        colorschemes        = {
          prompt       = 'Colorschemes❯ ',
          live_preview = true, -- apply the colorscheme on preview?
          actions      = {
            ["default"] = actions.colorscheme,
            ["ctrl-y"]  = function(selected) print(selected[1]) end,
          },
          winopts      = {
            win_height = 0.55,
            win_width  = 0.30,
          },
        },
        quickfix            = {
          multiprocess = true,
          file_icons   = true,
          git_icons    = true,
        },
        diagnostics ={
          winopts      = {
            win_row    = 1, -- window row position (0=top, 1=bottom)
            win_col    = 0, -- window col position (0=left, 1=right)
            win_height = 0.20,
            win_width  = 1,
          },
        },
        lsp                = {
          multiprocess     = true,
          prompt           = '❯ ',
          cwd_only         = false, -- LSP/diagnostics for cwd only?
          async_or_timeout = true, -- timeout(ms) or false for blocking calls
          file_icons       = true,
          git_icons        = false,
          lsp_icons        = true,
          severity         = "hint",
          icons            = {
            ["Error"]       = { icon = "", color = "red" }, -- error
            ["Warning"]     = { icon = "", color = "yellow" }, -- warning
            ["Information"] = { icon = "", color = "blue" }, -- info
            ["Hint"]        = { icon = "", color = "magenta" }, -- hint
          },
          winopts      = {
            win_row    = 0, -- window row position (0=top, 1=bottom)
            win_col    = 1, -- window col position (0=left, 1=right)
            win_height = 0.20,
            win_width  = 0.4,
          },
          symbols = {
            async_or_timeout  = true,       -- symbols are async by default
            symbol_style      = 1,          -- style for document/workspace symbols
            -- symbol_icons = symbols,
            symbol_icons = {
              File          = "󰈙",
              Module        = "",
              Namespace     = "󰦮",
              Package       = "",
              Class         = "󰆧",
              Method        = "ƒ",
              Property      = "",
              Field         = "",
              Constructor   = "",
              Enum          = "",
              Interface     = "",
              Function      = "󰊕",
              Variable      = "󰀫",
              Constant      = "󰏿",
              String        = "",
              Number        = "󰎠",
              Boolean       = "󰨙",
              Array         = "󱡠",
              Object        = "",
              Key           = "󰌋",
              Null          = "󰟢",
              EnumMember    = "",
              Struct        = "󰆼",
              Event         = "",
              Operator      = "󰆕",
              TypeParameter = "󰗴",
            },
            winopts      = {
              win_row    = 0.60, -- window row position (0=top, 1=bottom)
              win_col    = 0.50, -- window col position (0=left, 1=right)
              win_height = 0.20,
              win_width  = 0.20,
            },
            symbol_hl         = function(s) return "@" .. s:lower() end,
            symbol_fmt        = function(s, opts) return "[" .. s .. "]" end,
            child_prefix      = true,
          },
        },

        tags           = {
          prompt       = 'Tags❯ ',
          ctags_file   = "tags",
          multiprocess = true,
          file_icons   = true,
          git_icons    = true,
          color_icons  = true,
          -- 'tags_live_grep' options, `rg` prioritizes over `grep`
          rg_opts      = "--no-heading --color=always --smart-case",
          grep_opts    = "--color=auto --perl-regexp",
          actions      = {
            -- actions inherit from 'actions.files' and merge
            -- this action toggles between 'grep' and 'live_grep'
            ["ctrl-g"] = { actions.grep_lgrep }
          },
          no_header    = false, -- hide grep|cwd header?
          no_header_i  = false, -- hide interactive header?
        },
        file_icon_padding   = '',
        file_icon_colors    = {
          ["lua"] = "blue",
        },
      }

      nnoremap('<C-p><C-p>', ':FzfLua files<CR>')
      nnoremap('<C-p><C-r>', ':FzfLua oldfiles<CR>')
      nnoremap('<C-p><C-f>', ':FzfLua grep<CR><CR>')
      vnoremap('<C-p><C-f>', '<esc>:FzfLua grep_visual<CR>')
      nnoremap('<C-p><C-r>', ':FZFFreshMruPreview<CR>')
      -- nnoremap('<leader>fw', ':FzfLua grep_cword<CR>')
      nnoremap('<leader>fW', ':FzfLua grep_cWORD<CR>')
      -- nnoremap('<C-p><C-g>', ':FzfLua git_status<CR>')

      nnoremap('<leader>pa', ':FzfLua<CR>')
      nnoremap('<leader>pp', ':FzfLua files<CR>')
      -- nnoremap('<leader>pr', ':FZFFreshMruPreview<CR>')
      nnoremap('<leader>pr', ':FzfLua oldfiles<CR>')
      nnoremap('<leader>pg', ':FzfLua git_status<CR>')
      nnoremap('<leader>pb', ':FzfLua git_branches<CR>')
      nnoremap('<leader>pf', ':FzfLua grep<CR><CR>')
      nnoremap('<leader>pF', ':FzfLua live_grep_resume<CR>')
      nnoremap('<leader>pq', ':FzfLua quickfix<CR>')
      nnoremap('<leader>pl', ':FzfLua blines<CR>')
      nnoremap('<leader>pL', ':FzfLua lines<CR>')
      nnoremap('<leader>pc', ':FzfLua git_commits<CR>')
      nnoremap('<leader>pC', ':FzfLua git_bcommits<CR>')
      nnoremap('<leader>p;', ':FzfLua commands<CR>')
      nnoremap('<leader>pd', ':FzfLua lsp_definitions<CR>')
      nnoremap('<leader>pu', ':FzfLua lsp_references<CR>')
      nnoremap('<leader>pe', ':FzfLua lsp_document_diagnostics<CR>')
      nnoremap('<leader>pE', ':FzfLua lsp_workspace_diagnostics<CR>')
      nnoremap('<leader>ps', ':FzfLua lsp_document_symbols<CR>')
      nnoremap('<leader>pS', ':FzfLua lsp_workspace_symbols<CR>')
      nnoremap('z=', ':FzfLua spell_suggest<CR>')

    end
  },
}
