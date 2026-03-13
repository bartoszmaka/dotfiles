return {
  {
    "Saghen/blink.cmp",
    version = "1.*",
    dependencies = {
      "echasnovski/mini.icons",
    },
    opts = {
      enabled = function()
        local disabled_filetypes = { "NvimTree", "neo-tree" }
        return not vim.tbl_contains(disabled_filetypes, vim.bo.filetype)
      end,
      snippets = { preset = "luasnip" },
      fuzzy = {
        implementation = "prefer_rust_with_warning",
        sorts = { "exact", "score", "sort_text" },
      },
      keymap = {
        preset = "default",
        ["<C-j>"] = { "show", "fallback" },
        ["<Tab>"] = { "snippet_forward", "accept", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "accept", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
      },
      signature = {
        enabled = true,
        window = {
          direction_priority = { "n", "s" },
          border = "single",
        },
      },
      completion = {
        list = { selection = { preselect = true, auto_insert = false } },
        trigger = {
          show_on_insert = true,
          show_on_blocked_trigger_characters = {},
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 100,
          treesitter_highlighting = true,
          window = {
            winhighlight = "Pmenu:NormalDarker,Normal:NormalDarker,SignColumn:SignColumnDarker,EndOfBuffer:EndOfBufferDarker,WinSeparator:WinSeparatorDarker",
            border = "solid",
            min_width = 40,
            direction_priority = {
              menu_north = { "e", "w" },
              menu_south = { "e", "w" },
            },
          },
        },
        menu = {
          scrollbar = false,
          border = "none",
          winhighlight = "Pmenu:NormalDarker,Normal:NormalDarker,SignColumn:SignColumnDarker,EndOfBuffer:EndOfBufferDarker,WinSeparator:WinSeparatorDarker",
        },
        ghost_text = { enabled = true },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        providers = {
          lsp = {
            override = {
              get_trigger_characters = function(self)
                local trigger_characters = self:get_trigger_characters()
                vim.list_extend(trigger_characters, { "\n", "\t", " " })
                return trigger_characters
              end,
            },
          },
        },
      },
    },
  },
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load({
        paths = { vim.fn.stdpath("config") .. "/snippets" },
      })
      require("luasnip.loaders.from_lua").lazy_load({
        paths = { vim.fn.stdpath("config") .. "/lua/snippets" },
      })
      local ls = require("luasnip")
      ls.filetype_extend("javascript", { "javascriptreact" })
      ls.filetype_extend("javascript", { "jsdoc" })
      ls.filetype_extend("javascript", { "next" })
      ls.filetype_extend("javascript", { "react-es7" })
      ls.filetype_extend("javascript", { "react-native" })
      ls.filetype_extend("typescript", { "tsdoc" })
      ls.filetype_extend("typescript", { "next-ts" })
      ls.filetype_extend("typescript", { "react-ts" })
      ls.filetype_extend("typescript", { "react-native-ts" })
    end,
  },
}
