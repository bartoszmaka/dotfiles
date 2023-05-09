return {
  'romgrk/barbar.nvim',
  lazy=false,
  config = function()
    local nnoremap = require('config_helper').nnoremap
    vim.g.mapleader = ' '

    require('barbar').setup({
      animation = true,
      auto_hide = false,
      tabpages = true,
      maximum_padding = 2,
      minimum_padding = 2,
      maximum_length = 100,
      no_name_title = ' - ',
      icons = {
        button = '',
      }
    })

    nnoremap('<leader>[', ':BufferPrevious<CR>')
    nnoremap('<leader>]', ':BufferNext<CR>')
    nnoremap('<leader>{', ':BufferMovePrevious<CR>')
    nnoremap('<leader>}', ':BufferMoveNext<CR>')
    nnoremap('<leader>1', ':BufferGoto 1<CR>')
    nnoremap('<leader>2', ':BufferGoto 2<CR>')
    nnoremap('<leader>3', ':BufferGoto 3<CR>')
    nnoremap('<leader>4', ':BufferGoto 4<CR>')
    nnoremap('<leader>5', ':BufferGoto 5<CR>')
    nnoremap('<leader>6', ':BufferGoto 6<CR>')
    nnoremap('<leader>7', ':BufferGoto 7<CR>')
    nnoremap('<leader>8', ':BufferGoto 8<CR>')
    nnoremap('<leader>9', ':BufferLast<CR>')
    nnoremap('<leader>q', ':close<CR>')
    nnoremap('<leader>w', ':BufferClose<CR>')
    nnoremap('<leader><leader>!', ':BufferCloseAllButCurrent<CR>')

    vim.cmd[[
      augroup barbar_overrides
        autocmd!
        highlight! BufferCurrent        guifg=#f2cc81 guibg=#1a212e
        highlight! BufferCurrentMod     guifg=#8bcd5b guibg=#1a212e
        highlight! BufferVisible        guifg=#93a4c3 guibg=#1a212e
        highlight! BufferVisibleMod     guifg=#1b6a73 guibg=#1a212e
        highlight! BufferVisibleSign    guifg=#93a4c3 guibg=#1a212e
        highlight! BufferInactive       guifg=#93a4c3 guibg=#2a324a
        highlight! BufferInactiveMod    guifg=#34bfd0 guibg=#2a324a
        highlight! BufferInactiveSign   guifg=#93a4c3 guibg=#2a324a
      augroup END
    ]]
  end
}

-- return {
--   "akinsho/bufferline.nvim",
--   -- event = "VeryLazy",
--   lazy=false,
--   keys = {
--     { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>",            desc = "Toggle pin" },
--     { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
--     { "<leader>{",  "<Cmd>BufferLineMovePrev<CR>",             desc = "Move buffer left" },
--     { "<leader>}",  "<Cmd>BufferLineMoveNext<CR>",             desc = "Move buffer right" },
--     { "<leader>[",  "<Cmd>BufferLineCyclePrev<CR>",            desc = "Go to prev buffer" },
--     { "<leader>]",  "<Cmd>BufferLineCycleNext<CR>",            desc = "Go to next buffer" },
--     { "<leader>1",  "<Cmd>BufferLineGoToBuffer 1<CR>",         desc = "Go to 1st buffer" },
--     { "<leader>2",  "<Cmd>BufferLineGoToBuffer 2<CR>",         desc = "Go to 2nd buffer" },
--     { "<leader>3",  "<Cmd>BufferLineGoToBuffer 3<CR>",         desc = "Go to 3rd buffer" },
--     { "<leader>4",  "<Cmd>BufferLineGoToBuffer 4<CR>",         desc = "Go to 4th buffer" },
--     { "<leader>5",  "<Cmd>BufferLineGoToBuffer 5<CR>",         desc = "Go to 5th buffer" },
--     { "<leader>6",  "<Cmd>BufferLineGoToBuffer 6<CR>",         desc = "Go to 6th buffer" },
--     { "<leader>7",  "<Cmd>BufferLineGoToBuffer 7<CR>",         desc = "Go to 7th buffer" },
--     { "<leader>8",  "<Cmd>BufferLineGoToBuffer 8<CR>",         desc = "Go to 8th buffer" },
--   },
--   opts = {
--     options = {
--       diagnostics = "nvim_lsp",
--       always_show_bufferline = false,
--       diagnostics_indicator = function(_, _, diag)
--         local icons = require("config_helper/symbols")
--         local ret = (diag.error and icons.error .. diag.error .. " " or "")
--             .. (diag.warning and icons.warn .. diag.warning or "")
--         return vim.trim(ret)
--       end,
--       offsets = {
--         {
--           filetype = "neo-tree",
--           text = "Neo-tree",
--           highlight = "Directory",
--           text_align = "left",
--         },
--       },
--     },
--   },
-- }
