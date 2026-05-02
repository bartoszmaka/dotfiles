return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    plugins = {
      marks = true,
      registers = true,
      spelling = { enabled = true, suggestions = 20 },
    },
    win = {
      border = 'single',
    },
  },
  config = function(_, opts)
    local wk = require('which-key')
    wk.setup(opts)

    wk.add({
      { '<leader>A', group = 'AI (CodeCompanion)' },
      { '<leader>c', group = 'Code' },
      { '<leader>g', group = 'Git' },
      { '<leader>p', group = 'Picker (FZF)' },
      { '<leader>t', group = 'Test / Toggle' },
      { '<leader>u', group = 'UI' },
      { '<leader>m', group = 'Splitjoin' },
      { '<leader>f', group = 'Find / Fold' },
    })
  end,
}
