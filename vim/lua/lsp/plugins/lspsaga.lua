local saga = require 'lspsaga'
local action = require("lspsaga.codeaction")

saga.init_lsp_saga({
  border_style = "rounded",  -- "single" | "double" | "rounded" | "bold" | "plus"
  saga_winblend = 0,
  move_in_saga = { prev = '<C-p>',next = '<C-n>'},
  diagnostic_header = { " ", " ", " ", " " },
  max_preview_lines = 15,
  code_action_icon = "💡",
  code_action_num_shortcut = true,
  code_action_lightbulb = {
    enable = true,
    sign = true,
    enable_in_insert = true,
    sign_priority = 20,
    virtual_text = false,
  },
  -- finder icons
  finder_icons = {
    def = '  ',
    ref = ' ',
    link = '  ',
  },
  -- custom finder title winbar function type
  -- param is current word with symbol icon string type
  -- return a winbar format string like `%#CustomFinder#Test%*`
  finder_action_keys = {
    open = "o",
    vsplit = "s",
    split = "i",
    tabe = "t",
    quit = "<esc>",
    scroll_down = "<C-f>",
    scroll_up = "<C-b>", -- quit can be a table
  },
  code_action_keys = {
    quit = "<esc>",
    exec = "<CR>",
  },
  rename_action_quit = "<C-c>",
  rename_in_select = true,
  -- show symbols in winbar must nightly
  -- symbol_in_winbar = {
  --   in_custom = false,
  --   enable = false,
  --   separator = ' ',
  --   show_file = true,
  --   click_support = false,
  -- },
  show_outline = {
    win_position = 'right',
    --set special filetype win that outline window split.like NvimTree neotree
    -- defx, db_ui
    win_with = '',
    win_width = 30,
    auto_enter = true,
    auto_preview = true,
    virt_text = '┃',
    jump_key = 'o',
    auto_refresh = true,
  },
  -- if you don't use nvim-lspconfig you must pass your server name and
  -- the related filetypes into this table
  -- like server_filetype_map = { metals = { "sbt", "scala" } }
  server_filetype_map = {},
})

vim.g.mapleader = ' '
vim.keymap.set("n", "<leader>gh", "<cmd>Lspsaga peek_definition<CR>", { silent = true })
vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true,noremap = true })
vim.keymap.set("v", "<leader>ca", "<cmd><C-U>Lspsaga range_code_action<CR>", { silent = true,noremap = true })
vim.keymap.set("n", "<leader>K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
vim.keymap.set("n", "<leader><C-k>", "<Cmd>Lspsaga signature_help<CR>", { silent = true,noremap = true })
-- scroll down hover doc or scroll in definition preview
-- vim.keymap.set("n", "<C-f>", function()
--     action.smart_scroll_with_saga(1)
-- end, { silent = true })
-- -- scroll up hover doc
-- vim.keymap.set("n", "<C-b>", function()
--     action.smart_scroll_with_saga(-1)
-- end, { silent = true })

vim.keymap.set("n", "<leader>cd", require("lspsaga.diagnostic").show_line_diagnostics, { silent = true,noremap = true })
vim.keymap.set("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true,noremap= true })

-- or use command
vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "gr", "<cmd>Lspsaga lsp_finder<CR>", { silent = true,noremap = true})
