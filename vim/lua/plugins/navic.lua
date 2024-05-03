return {
  "SmiteshP/nvim-navic",
  lazy = true,
  opts = function()
    vim.g.navic_silence = true
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
      lsp = {
        preference = {
          'ruby_ls',
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
  config = function(_, opts)
    local colors = require("helper.colors").onedark

    require("nvim-navic").setup(opts)

    local highlight_names = {
      "NavicIconsFile",
      "NavicIconsModule",
      "NavicIconsNamespace",
      "NavicIconsPackage",
      "NavicIconsClass",
      "NavicIconsMethod",
      "NavicIconsProperty",
      "NavicIconsField",
      "NavicIconsConstructor",
      "NavicIconsEnum",
      "NavicIconsInterface",
      "NavicIconsFunction",
      "NavicIconsVariable",
      "NavicIconsConstant",
      "NavicIconsString",
      "NavicIconsNumber",
      "NavicIconsBoolean",
      "NavicIconsArray",
      "NavicIconsObject",
      "NavicIconsKey",
      "NavicIconsNull",
      "NavicIconsEnumMember",
      "NavicIconsStruct",
      "NavicIconsEvent",
      "NavicIconsOperator",
      "NavicIconsTypeParameter",
      "NavicText",
      "NavicSeparator",
    }

    for _, name in ipairs(highlight_names) do
      vim.cmd(string.format(
        "highlight! %s guibg=%s",
        name, colors.bg_d
      ))
    end
  end
}
