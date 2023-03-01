local telescope = require('telescope')
local config_helper = require('config_helper')
local nnoremap = config_helper.nnoremap
local actions = require('telescope.actions')
local action_layout = require("telescope.actions.layout")

telescope.setup {
  defaults = {
    sorting_strategy = 'ascending',
    layout_config = {
      prompt_position = 'top'
    },
    mappings = {
      i = {
        ["<esc"] = actions.close,
        ["<C-u>"] = false,
        ["<F4>"] = action_layout.toggle_preview
      },
      n = {
        ["<F4>"] = action_layout.toggle_preview
      },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    },
    media_files = {
      filetypes = {"png", "webp", "jpg", "jpeg"},
      find_cmd = "rg"
    }
  }
}
telescope.load_extension('fzf')
telescope.load_extension('ultisnips')
-- telescope.load_extension("media_files")

-- vim.g.mapleader = ' '
-- nnoremap('<leader>pp', [[<Cmd>lua require('telescope.builtin').find_files()<CR>]])
-- nnoremap('<leader>pr', [[<Cmd>lua require('telescope.builtin').oldfiles()<CR>]])
-- nnoremap('<leader>pg', [[<Cmd>lua require('telescope.builtin').git_status()<CR>]])
-- nnoremap('<leader>pb', [[<Cmd>lua require('telescope.builtin').find_buffers()<CR>]])
-- nnoremap('<leader>pf', [[<Cmd>lua require('telescope.builtin').live_grep()<CR>]])
-- nnoremap('<leader>pv', [[<Cmd>lua require('telescope.builtin').git_bcommits()<CR>]])
-- nnoremap('<leader>pm', [[<Cmd>lua require('telescope.builtin').marks()<CR>]])
-- nnoremap('<leader>pc', [[<Cmd>lua require('telescope.builtin').git_bcommits()<CR>]])
-- nnoremap('<leader>pt', [[<Cmd>lua require('telescope.builtin').help_tags()<CR>]])
-- nnoremap('<leader>pq', [[<Cmd>lua require('telescope').extensions.media_files.media_files()<CR>]])

vim.cmd[[
  autocmd FileType TelescopePrompt imap <esc> <c-c>
]]
