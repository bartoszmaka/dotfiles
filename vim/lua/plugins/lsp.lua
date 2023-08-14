return {
  {
    'neovim/nvim-lspconfig',
    event = "BufReadPre",
    keys = {
      { "<leader>cl", ":LspInfo<CR>", desc = "Lsp Info" },
      { "<leader>cm", ":Mason<CR>", desc = "Mason" }
    },
    dependencies = {
      { 'williamboman/mason.nvim', build = ":MasonUpdate", },
      { 'williamboman/mason-lspconfig.nvim', },
      { 'jose-elias-alvarez/typescript.nvim' },
      { 'nvim-lua/lsp-status.nvim' },
      { 'b0o/schemastore.nvim' }, -- schemas for jsonls (common rc files)
    },
    config = function()
      require('lsp.setup_servers').setup_servers()
      require('lsp.setup_mappings').setup_mappings()
      require('lsp.setup_diagnostics').setup_diagnostics()
      require('lsp.plugins.lsp-status').setup_lsp_status()
    end
  },
}
