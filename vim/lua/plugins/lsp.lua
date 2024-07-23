return {
  {
    'neovim/nvim-lspconfig',
    event = "BufReadPre",
    keys = {
      { "<leader>cl", ":LspInfo<CR>", desc = "Lsp Info" },
      { "<leader>cm", ":Mason<CR>",   desc = "Mason" }
    },
    dependencies = {
      { 'williamboman/mason.nvim',           build = ":MasonUpdate", },
      { 'williamboman/mason-lspconfig.nvim', },
      { 'nvim-lua/lsp-status.nvim' },
      { 'b0o/schemastore.nvim' }, -- schemas for jsonls (common rc files)
      { 'RishabhRD/nvim-lsputils',           dependencies = { 'RishabhRD/popfix' } },
    },
    config = function()
      require('lsp.setup_servers')
      require('lsp.setup_mappings')
      require('lsp.setup_diagnostics')
    end
  },
}
