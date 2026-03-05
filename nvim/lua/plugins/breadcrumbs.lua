local colors = require "helper.colors"
return {
  {
    "SmiteshP/nvim-navic",
    event = "LspAttach",
    opts = {
      highlight = true,
      separator = " > ",
      depth_limit = 5,
    },
    config = function(_, opts)
      local navic = require("nvim-navic")
      navic.setup(opts)

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("nvim_navic_attach", { clear = true }),
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
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      show_modified = true,
      show_navic = true,
      show_dirname = false,
      show_basename = false,
      theme = {
        normal = { bg = colors.onedark.bg_d }
      }
    },
    config = function(_, opts)
      require("barbecue").setup(opts)
    end,
  },
}
