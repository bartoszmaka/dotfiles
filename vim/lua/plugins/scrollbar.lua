return {
  'petertriho/nvim-scrollbar',
  lazy=false,
  config = function()
    require("scrollbar").setup({
      handle = {
        color = '#93a4c3'
      }
    })
  end
}
