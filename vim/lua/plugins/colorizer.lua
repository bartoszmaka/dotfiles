return {
  'norcalli/nvim-colorizer.lua',
  config = function()
    require('colorizer').setup()
  end,
}

-- return {
--   'NvChad/nvim-colorizer.lua',
--   event = "VeryLazy",
--   opts = {
--     user_default_options = {
--       tailwind = true,
--     },
--   },
--   config = function(_, opts)
--     require('colorizer').setup(opts)
--   end,
-- }
