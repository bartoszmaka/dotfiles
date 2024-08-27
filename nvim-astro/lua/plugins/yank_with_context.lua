return {
  "dominikduda/vim_yank_with_context",
  config = function()
    vim.cmd [[
      let g:vim_yank_with_context#custom_path_expand_string = "%:."
    ]]
  end,
}
