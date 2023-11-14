return {
  'petertriho/nvim-scrollbar',
  lazy=false,
  config = function()
    local colors = require('helper/colors').onedark
    require("scrollbar").setup({
      handle = {
        color = colors.bg3
      }
    })
  end
}
