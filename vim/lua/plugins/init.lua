return {
  -- syntax
  { 'jparise/vim-graphql' },

  -- utils
  { 'tpope/vim-abolish' },                 -- swap case
  { 'windwp/nvim-ts-autotag' },            -- automatically add matching tags
  { 'tpope/vim-surround' },                -- surround motion
  { 'dominikduda/vim_yank_with_context', config = function()
    vim.cmd [[
      let g:vim_yank_with_context#custom_path_expand_string = "%:."
    ]]
  end }, -- yank with file name and line numbers
  -- { 'lmeijvogel/vim-yaml-helper', lazy = false },
  { 'mogelbrod/vim-jsonpath' },
  -- UI
  { 'ldelossa/gh.nvim' },
  { 'jacquesbh/vim-showmarks' },
}
