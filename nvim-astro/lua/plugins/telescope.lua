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

      local mappings = {
        ["<leader>lD"] = false,
        ["<leader>ls"] = false,
        ["<Space>lD"] = false,
        ["<Space>ls"] = false,
        ["<C-h>"] = "which_key",
        ["<esc>"] = actions.close,
        ["<C-u>"] = false,
        ["<C-e>"] = false,
        ["<C-s>"] = actions.file_split,
        ["<C-v>"] = actions.file_vsplit,
        ["<F4>"] = actions_layout.toggle_preview,
        ["<F2>"] = actions_layout.cycle_layout_next,
        ["<C-q>"] = actions.send_selected_to_qflist,
      }

      telescope.setup {
        defaults = {
          border = true,
          borderchars = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
          sorting_strategy = 'ascending',
          scroll_strategy = 'limit',
          layout_strategy = 'horizontal',
          cycle_layout_list = { 'horizontal', 'vertical', 'center', 'bottom_pane', 'cursor' },
          mappings = { i = mappings, n = mappings, },
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

      nnoremap('<C-p><C-r>', [[<Cmd>Telescope fzf_mru<CR>]], {                                           desc = "Recent files" })
      nnoremap('<leader>pr', [[<Cmd>Telescope fzf_mru<CR>]], {                                           desc = "Recent files" })
      nnoremap('<leader>pA', [[<Cmd>lua require('telescope.builtin').builtin()<CR>]], {                  desc = "Actions (Telescope)" })
    end
  },
}