return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { 'markdown', 'codecompanion' },
    opts = {
      file_types = { 'markdown', 'codecompanion' },
      bullet = { enabled = false },
      code = {
        enabled = false,
        conceal_delimiters = false,
      },
      quote = { enabled = false },
    },
  },
  {
    -- Live side preview in a standalone webview window.
    -- Requires the Deno runtime: `brew install deno`
    'toppair/peek.nvim',
    build = 'deno task --quiet build:fast',
    ft = 'markdown',
    opts = {
      app = 'webview',
    },
    config = function(_, opts)
      local peek = require('peek')
      peek.setup(opts)
      vim.keymap.set('n', '<leader>mp', function()
        if peek.is_open() then
          peek.close()
        else
          peek.open()
        end
      end, { desc = 'Markdown preview (peek)' })
    end,
  },
}
