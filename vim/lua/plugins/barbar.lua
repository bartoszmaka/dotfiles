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
--   event = "VeryLazy",
--   keys = {
--     { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
--     { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
--     { "<leader>[", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
--     { "<leader>]", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
--     { "<leader>{", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer left" },
--     { "<leader>}", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer right" },
--     { "<leader>1", "<cmd>BufferLineGoToBuffer 1<cr>", desc = "Pick buffer 1" },
--     { "<leader>2", "<cmd>BufferLineGoToBuffer 2<cr>", desc = "Pick buffer 2" },
--     { "<leader>3", "<cmd>BufferLineGoToBuffer 3<cr>", desc = "Pick buffer 3" },
--     { "<leader>4", "<cmd>BufferLineGoToBuffer 4<cr>", desc = "Pick buffer 4" },
--     { "<leader>5", "<cmd>BufferLineGoToBuffer 5<cr>", desc = "Pick buffer 5" },
--     { "<leader>6", "<cmd>BufferLineGoToBuffer 6<cr>", desc = "Pick buffer 6" },
--     { "<leader>7", "<cmd>BufferLineGoToBuffer 7<cr>", desc = "Pick buffer 7" },
--     { "<leader>8", "<cmd>BufferLineGoToBuffer 8<cr>", desc = "Pick buffer 8" },
--     { "<leader>9", "<cmd>BufferLineGoToBuffer 9<cr>", desc = "Pick buffer 9" },
--   },
--   opts = {
--     options = {
--       -- stylua: ignore
--       close_command = function(n) require("mini.bufremove").delete(n, false) end,
--       -- stylua: ignore
--       right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
--       diagnostics = "nvim_lsp",
--       always_show_bufferline = false,
--       diagnostics_indicator = function(_, _, diag)
--         local icons = require("lazyvim.config").icons.diagnostics
--         local ret = (diag.error and icons.Error .. diag.error .. " " or "")
--           .. (diag.warning and icons.Warn .. diag.warning or "")
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

