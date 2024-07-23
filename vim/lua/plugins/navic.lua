return {
  "SmiteshP/nvim-navic",
  lazy = true,
  opts = function()
    vim.g.navic_silence = false
    local symbols = require("helper.symbols")
    local icons = {}
    for key, value in pairs(symbols) do
      if type(value) == 'string' then
        icons[key] = value .. " "
      end
    end

    return {
      separator = ' > ',
      highlight = true,
      depth_limit = 8,
      icons = icons,
      click = true,
      lsp = {
        preference = {
          'ruby_lsp',
          'tsserver',
          'solargraph',
          'tailwindcss',
          'stylelint_lsp',
          'emmet_language_server',
          'graphql',
          'efm',
          'copilot',
        }
      }
    }
  end,
}
