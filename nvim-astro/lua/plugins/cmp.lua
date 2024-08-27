return { -- override nvim-cmp plugin
  "hrsh7th/nvim-cmp",
  dependencies = {
    {
      "roobert/tailwindcss-colorizer-cmp.nvim",
      config = function()
        require("tailwindcss-colorizer-cmp").setup({
          color_square_width = 1,
        })
      end
    }
  },
  opts = function(_, opts)
    local cmp = require("cmp")
    local symbols = require("helper.symbols")
    local tailwind_formatter = require("tailwindcss-colorizer-cmp").formatter
    local get = require('helper').get

    local format_entry = function(entry, vim_item)
      local source = ''
      local lsp_name_shorthand = ({
        emmet_language_server = 'emmet',
      })
      local source_tag = ({
        buffer = '[Buf]',
        omni = '[Omni]',
        ultisnips = '[Snip]',
        spell = '[Spell]',
        cmp_tabnine = '[AI]',
        copilot = '[AI]',
        cmdline = '[CMD]',
        nvim_lsp_signature_help = '[Arg]',
      })[entry.source.name] or entry.source.name or ''

      local icon = symbols[vim_item.kind]

      if entry.source.name == 'nvim_lsp' then
        local ls_name = get(entry, 'source.source.client.config.name')
        source = lsp_name_shorthand[ls_name] or ls_name or ''
        source_tag = '(' .. source .. ')'
        if source == "emmet" and vim_item.kind == "Text" then
          icon = symbols.Emmet
        end

        if ls_name == 'tailwindcss' and vim_item.kind == 'Color' then
          local formatted = tailwind_formatter(entry, vim_item)

          if formatted.kind == "X" then
            formatted.kind = formatted.kind
          end
        end
      end

      vim_item.menu = ' ' .. vim_item.kind .. ' ' .. source_tag
      vim_item.kind = ' ' .. icon .. ' '

      return vim_item
    end

    opts.formatting = {
      fields = { 'kind', 'abbr', 'menu' },
      format = format_entry
    }

    opts.window = {
      completion = {
        winhighlight = 'Normal:NormalDarker,FloatBorder:NormalDarker,Search:None',
        col_offset = -3,
        side_padding = 0,
      },
      documentation = {
        winhighlight = 'Normal:NormalDarker,FloatBorder:NormalDarker,Search:None',
      },
    }

    opts.sources = cmp.config.sources({
      { name = "nvim_lsp", priority = 1000 },
      { name = "luasnip", priority = 750 },
      { name = "buffer", priority = 500 },
      { name = "path", priority = 250 },
      { name = "spell", priority = 200 },
    })
  end,
}
