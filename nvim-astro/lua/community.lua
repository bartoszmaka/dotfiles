-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.prisma" },
  { import = "astrocommunity.pack.typescript-all-in-one" },
  { import = "astrocommunity.recipes.heirline-vscode-winbar" },
  { import = "astrocommunity.bars-and-lines.dropbar-nvim" },
  { import = "astrocommunity.completion.cmp-cmdline" },
  { import = 'astrocommunity.scrolling.nvim-scrollbar' },
  { import = 'astrocommunity.colorscheme.catppuccin' },
  { import = 'astrocommunity.colorscheme.github-nvim-theme' },
  { import = 'astrocommunity.editing-support.nvim-treesitter-endwise' },
}
