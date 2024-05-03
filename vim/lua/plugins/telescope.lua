return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = {
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      { 'fhill2/telescope-ultisnips.nvim' },
      { 'nvim-lua/plenary.nvim' },
      { 'pbogut/fzf-mru.vim' }
    },
    config = function()
      local telescope = require('telescope')
      local helper = require('helper')
      local actions = require('telescope.actions')
      local actions_layout = require("telescope.actions.layout")
      local nnoremap = helper.nnoremap
      local vnoremap = helper.vnoremap
      local colors = helper.colors.onedark
      -- local dropdown_theme = require('telescope.themes').get_dropdown

      local mappings = {
        ["<C-h>"] = "which_key",
        ["<esc>"] = actions.close,
        ["<C-u>"] = false,
        ["<C-e>"] = false,
        ["<C-s>"] = actions.file_split,
        ["<C-v>"] = actions.file_vsplit,
        ["<F4>"] = actions_layout.toggle_preview,
        ["<F2>"] = actions_layout.cycle_layout_next,
        ["<C-q>"] = actions.send_selected_to_qflist,
        -- ["<C-g>"] = actions.to_fuzzy_refine,
        -- ["<C-[>"] = actions.cycle_previewers_prev,
        -- ["<C-]>"] = actions.cycle_previewers_next,
        -- ["<C-{>"] = actions_layout.cycle_layout_prev,
        -- ["<C-}>"] = actions_layout.cycle_layout_next,
      }
      local layouts = {
        horizontal = {
          height = 0.6,
          preview_cutoff = 120,
          prompt_position = "top",
          width = 0.8
        },
        bottom_pane = {
          height = 0.2,
          preview_cutoff = 120,
          prompt_position = "top"
        },
        center = {
          height = 0.25,
          preview_cutoff = 0,
          prompt_position = "top",
          width = 0.25,
        },
        cursor = {
          height = 0.2,
          preview_cutoff = 80,
          width = 0.75,
          prompt_position = "top",
        },
        vertical = {
          height = 0.2,
          preview_cutoff = 80,
          width = 0.25,
          prompt_position = "top",
        },
      }
      local layout_presets = {
        big_window = vim.tbl_deep_extend('force', layouts.horizontal, {
          layout_strategy = "horizontal",
        }),
        bottom_pane = vim.tbl_deep_extend('force', layouts.bottom_pane, {
          layout_strategy = "bottom_pane",
        }),
        cursor_full = vim.tbl_deep_extend('force', layouts.cursor, {
          layout_strategy = "cursor",
        }),
        cursor_small = vim.tbl_deep_extend('force', layouts.cursor, {
          layout_strategy = "cursor",
          previewer = false,
          width = 0.25
        }),
        small_window = vim.tbl_deep_extend('force', layouts.center, {
          layout_strategy = "horizontal",
          previewer = false,
          height = 0.25,
          preview_cutoff = 120,
          prompt_position = "top",
          width = 0.15
        }),
        -- vertical = vim.tbl_deep_extend('force', layouts.vertical, {
        --   layout_strategy = "vertical",
        -- }),
      }

      telescope.setup {
        defaults = {
          border = true,
          borderchars = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
          sorting_strategy = 'ascending',
          scroll_strategy = 'limit',
          layout_strategy = 'horizontal',
          cycle_layout_list = { 'horizontal', 'vertical', 'center', 'bottom_pane', 'cursor' },
          -- vimgrep_arguments = {
          --   "rg",
          --   "--color=always",
          --   "--no-heading",
          --   "--column",
          --   "--smart-case",
          --   "--hidden",
          --   "--line-number",
          --   "--fixed-strings",
          --   "-g '!{*.min.js,*.js.map}'",
          --   "-g '!{.git,node_modules,storybook/storybook-static,vendor/assets}/*'",
          -- },
          layout_config = layouts,
          mappings = { i = mappings, n = mappings, },
        },
        pickers = {
          -- find_files = {},
          builtin = layout_presets.small_window,
          diagnostics = layout_presets.bottom_pane,
          lsp_references = layout_presets.cursor_full,
          lsp_definition = layout_presets.cursor_full,
          lsp_incoming_calls = layout_presets.cursor_full,
          lsp_outgoing_calls = layout_presets.cursor_full,
          lsp_implementations = layout_presets.cursor_full,
          lsp_document_symbols = layout_presets.cursor_full,
          lsp_type_definitions = layout_presets.cursor_full,
          lsp_workspace_symbols = layout_presets.cursor_full,
          lsp_dynamic_workspace_symbols = layout_presets.cursor_full,
          filetypes = layout_presets.small_window,
          quickfix = layout_presets.bottom_pane,
          buffers = {},
          git_branches = layout_presets.bottom_pane,
          resume = {},
          git_bcommits = {},
          commands = layout_presets.small_window,
          keymaps = layout_presets.small_window,
          current_buffer_fuzzy_find = {},
          spell_suggest = layout_presets.cursor_small,
        },
        extensions = {
          fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
          },
        }
      }
      telescope.load_extension('fzf')
      telescope.load_extension('fzf_mru')
      telescope.load_extension('ultisnips')

      local TelescopePrompt = {
        TelescopePromptNormal = { bg = colors.bg_d, },
        TelescopePreviewNormal = { bg = colors.bg_d, },
        TelescopeResultsNormal = { bg = colors.bg_d, },
        TelescopePromptBorder = { bg = colors.bg_d, },
        TelescopePreviewBorder = { bg = colors.bg_d, },
        TelescopeResultsBorder = { bg = colors.bg_d, },
        TelescopePromptTitle = { bg = colors.bg_d, },
        TelescopePreviewTitle = { bg = colors.bg_d, },
        TelescopeResultsTitle = { bg = colors.bg_d, },
        TelescopeMatching = { fg = colors.bg_yellow },
        TelescopeSelection = { fg = colors.white, bg = colors.bg1, bold = true },
      }
      for hl, col in pairs(TelescopePrompt) do
        vim.api.nvim_set_hl(0, hl, col)
      end
      vim.cmd [[
        augroup telescope_fixes
          autocmd!
          autocmd User TelescopeFindPre highlight! CursorLineNR guibg=#21283b | echom('FindPre')
          autocmd User TelescopePreviewerLoaded highlight! CursorLineNR guibg=#21283b | echom("Previewer Loaded")
          autocmd User TelescopeResumePost echom("Resume post")
        augroup END
      ]]

      nnoremap('<C-p><C-r>', [[<Cmd>Telescope fzf_mru<CR>]], {                                           desc = "Recent files" })
      nnoremap('<leader>pr', [[<Cmd>Telescope fzf_mru<CR>]], {                                           desc = "Recent files" })
      nnoremap('<leader>pA', [[<Cmd>lua require('telescope.builtin').builtin()<CR>]], {                  desc = "Actions (Telescope)" })
      nnoremap('<leader>pp', [[<Cmd>lua require('telescope.builtin').find_files()<CR>]], {               desc = "Files" })
      nnoremap('<C-p><C-p>', [[<Cmd>lua require('telescope.builtin').find_files()<CR>]], {               desc = "Files" })
      -- nnoremap('<leader>pe', [[:lua require('telescope.builtin').diagnostics({ bufnr = 0 })<CR>]], {     desc = "File Diagnostics" })
      -- nnoremap('<leader>pE', [[:lua require('telescope.builtin').diagnostics()<CR>]], {                  desc = "Project Diagnostics" })
      -- nnoremap('<C-f><C-f><C-h>', [[:lua require('telescope.builtin').diagnostics()<CR>]], {             desc = "Project Diagnostics" })
      -- nnoremap('<leader>pq', [[<Cmd>lua require('telescope.builtin').quickfix()<CR>]], {                 desc = "Quickfix" })
      -- nnoremap('<leader>pb', [[<Cmd>lua require('telescope.builtin').buffers()<CR>]], {                  desc = "Buffer" })
      -- nnoremap('<leader>pB', [[<Cmd>lua require('telescope.builtin').git_branches()<CR>]], {             desc = "Branches" })
      -- nnoremap('<leader>pP', [[<Cmd>lua require('telescope.builtin').resume()<CR>]], {                   desc = "Resume Telescope" })
      -- nnoremap('<leader>pc', [[<Cmd>lua require('telescope.builtin').git_bcommits()<CR>]], {             desc = "File commits" })
      -- nnoremap('<leader>p;', [[<Cmd>lua require('telescope.builtin').commands()<CR>]], {                 desc = "Commands" })
      -- nnoremap('<leader>pK', [[<Cmd>lua require('telescope.builtin').keymaps()<CR>]], {                  desc = "Keymaps" })
      -- nnoremap('<leader>ps', [[<Cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], {     desc = "File Symbols" })
      -- nnoremap('<leader>pS', [[<Cmd>lua require('telescope.builtin').lsp_workspace_symbols()<CR>]], {    desc = "Project Symbols" })
      -- nnoremap('<leader>.', [[<Cmd>lua require('telescope.builtin').filetypes()<CR>]], {                 desc = "Filetypes" })
      -- nnoremap('<leader>/', [[<Cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], { desc = "File lines" })
      -- nnoremap('z=', [[<Cmd>lua require('telescope.builtin').spell_suggest()<CR>]], {                    desc = "Spell" })
      -- nnoremap('gd', [[:lua require('telescope.builtin').lsp_definitions()<CR>]], {                      desc = "Definitions" })
      -- nnoremap('gr', [[:lua require('telescope.builtin').lsp_references()<CR>]], {                       desc = "References" })
      -- nnoremap('<C-p><C-f>', [[<Cmd>lua require('telescope.builtin').live_grep()<CR>]], { desc = "live_grep" })
      -- vnoremap('<C-p><C-f>', [[<Cmd>lua require('telescope.builtin').grep_string()<CR>]], { desc = "grep_string" })
      -- nnoremap('<leader>pg', [[<Cmd>lua require('telescope.builtin').git_status()<CR>]], { desc = "git_status" })
      -- nnoremap('<leader>pf', [[<Cmd>lua require('telescope.builtin').live_grep()<CR>]], { desc = "live_grep" })
      -- nnoremap('<leader>pd', [[<Cmd>lua require('telescope.builtin').lsp_definitions()<CR>]], { desc = "lsp_definitions" })
      -- nnoremap('<leader>pR', [[<Cmd>lua require('telescope.builtin').lsp_references()<CR>]], { desc = "lsp_references" })
      -- nnoremap('<leader>pE', [[<Cmd>lua require('telescope.builtin').diagnostics()<CR>]], { desc = "diagnostics" })
    end
  },
}
