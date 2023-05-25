return {
  {
    'williamboman/mason.nvim',
    build = ":MasonUpdate",
  },
  {
    'williamboman/mason-lspconfig.nvim',
  },
  { 'neovim/nvim-lspconfig' },
  { 'jose-elias-alvarez/typescript.nvim' },
  { 'nvim-lua/lsp-status.nvim' },
  { 'b0o/schemastore.nvim' }, -- schemas for jsonls (common rc files)
}
