return {
  { 'tpope/vim-abolish' },      -- swap case
  {
    'dominikduda/vim_yank_with_context',
    config = function()
      vim.cmd [[
        let g:vim_yank_with_context#custom_path_expand_string = "%:."
      ]]
    end
  },     -- yank with file name and line numbers
  -- { 'lmeijvogel/vim-yaml-helper', lazy = false },
  { 'mogelbrod/vim-jsonpath', ft = { "json", "jsonb" } },
  -- UI
  -- { 'ldelossa/gh.nvim' },
  -- { 'jacquesbh/vim-showmarks' },
  -- {
  --   'jackMort/ChatGPT.nvim',
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "nvim-telescope/telescope.nvim"
  --   },
  --   opts = function()
  --     return {
  --       -- api_key_cmd = "head " .. vim.fn.expand("$HOME") .. "/.config/nvim-key.txt | base64 --decode",
  --       api_key_cmd = "head " .. vim.fn.expand("$HOME") .. "/.config/nvim-key",
  --     }
  --   end
  -- },
}
