local telescope = require('telescope')
local config_helper = require('config_helper')
local nnoremap = config_helper.nnoremap
local actions = require('telescope.actions')

telescope.setup {
  defaults = {
    sorting_strategy = "ascending",
    prompt_position = "top",
    prompt_prefix = " ",
    selection_caret = " ",
    layout_defaults = {
      horizontal = {
        mirror = false,
        preview_width = 0.5
      },
      vertical = {
        mirror = false
      }
    },
    borderchars = {"─", "│", "─", "│", "╭", "╮", "╯", "╰"},
    color_devicons = true,
    use_less = true,
    set_env = {["COLORTERM"] = "truecolor"}, -- default = nil,
    file_previewer = require "telescope.previewers".vim_buffer_cat.new,
    grep_previewer = require "telescope.previewers".vim_buffer_vimgrep.new,
    qflist_previewer = require "telescope.previewers".vim_buffer_qflist.new,
    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require "telescope.previewers".buffer_previewer_maker
  },
  mappings = {
    i = {
      -- ["<esc"] = actions.close,
    },
    n = {
      -- ["<esc>"] = actions.close,
    },
  },
  extensions = {
    media_files = {
      filetypes = {"png", "webp", "jpg", "jpeg"},
      find_cmd = "rg"
    }
  }
}

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
