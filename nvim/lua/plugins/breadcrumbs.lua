return {
  {
    'SmiteshP/nvim-navic',
    event = 'LspAttach',
    opts = {
      highlight = true,
      separator = ' > ',
      depth_limit = 5,
    },
    config = function(_, opts)
      local navic = require('nvim-navic')
      local colors = require('helper.colors').onedark
      navic.setup(opts)

      local navic_hls = {
        'NavicText', 'NavicSeparator',
        'NavicIconsFile', 'NavicIconsModule', 'NavicIconsNamespace', 'NavicIconsPackage',
        'NavicIconsClass', 'NavicIconsMethod', 'NavicIconsProperty', 'NavicIconsField',
        'NavicIconsConstructor', 'NavicIconsEnum', 'NavicIconsInterface', 'NavicIconsFunction',
        'NavicIconsVariable', 'NavicIconsConstant', 'NavicIconsString', 'NavicIconsNumber',
        'NavicIconsBoolean', 'NavicIconsArray', 'NavicIconsObject', 'NavicIconsKey',
        'NavicIconsNull', 'NavicIconsEnumMember', 'NavicIconsStruct', 'NavicIconsEvent',
        'NavicIconsOperator', 'NavicIconsTypeParameter',
      }
      for _, hl_name in ipairs(navic_hls) do
        local existing = vim.api.nvim_get_hl(0, { name = hl_name, link = false })
        existing.bg = tonumber(colors.bg_d:sub(2), 16)
        vim.api.nvim_set_hl(0, hl_name, existing)
      end

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('nvim_navic_attach', { clear = true }),
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.server_capabilities.documentSymbolProvider then
            navic.attach(client, args.buf)
          end
        end,
      })
    end,
  },
  {
    'utilyre/barbecue.nvim',
    name = 'barbecue',
    enabled = false,
  },
}
