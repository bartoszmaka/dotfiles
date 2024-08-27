return {
  'kevinhwang91/nvim-hlslens',
  keys = {
    {
      "n",
      [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
      desc = "Next occurence"
    },
    {
      "N",
      [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
      desc = "Next occurence"
    },
    {
      "*",
      [[*<Cmd>lua require('hlslens').start()<CR>]],
      desc = "Next occurence"
    },
    {
      "#",
      [[#<Cmd>lua require('hlslens').start()<CR>]],
      desc = "Next occurence"
    },
    {
      "g*",
      [[g*<Cmd>lua require('hlslens').start()<CR>]],
      desc = "Next occurence"
    },
    {
      "g#",
      [[g#<Cmd>lua require('hlslens').start()<CR>]],
      desc = "Next occurence"
    },

  },
  config = function()
    require('hlslens').setup({})
    vim.cmd [[
      augroup hlslens_overrides
      autocmd!
      highlight! default link CurSearch IncSearch
      highlight! default link HlSearchNear IncSearch
      highlight! default link HlSearchLens Comment
      highlight! default link HlSearchLensNear IncSearch
      highlight! default link HlSearchFloat IncSearch
      augroup END
      ]]
  end,
}
