return {}
-- return {
--   "Bekaboo/dropbar.nvim",
--   dependencies = {
--     'nvim-telescope/telescope-fzf-native.nvim'
--   },
--   event = "UIEnter",
--   opts = {},
--   config = function(_, opts)
--     vim.cmd [[
--       highlight! link DropBarMenuCurrentContext Visual
--     ]]
--     -- DropBarMenuSbar                    `{ link = 'PmenuSbar' }`
--     -- DropBarMenuThumb                   `{ link = 'PmenuThumb' }`

--     require("dropbar").setup(opts)
--   end
-- }
