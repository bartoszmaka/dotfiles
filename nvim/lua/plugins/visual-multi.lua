return {
  'mg979/vim-visual-multi',
  -- lazy = false,
  config = function()
    local nnoremap = require('helper').nnoremap

    vim.g.VM_theme = 'purplegray'
    vim.g.VM_highlight_matches = ''
    vim.g.VM_mouse_mappings = 1
    vim.g.VM_silent_exit = 1
    vim.g.VM_maps = {
      ["Skip Region"]       = '<C-x>',
      ["Add Cursor At Pos"] = '<leader>gm',
      ["Goto Prev"]         = '',
      ["Seek Down"]         = '<M-f>',
      ["Goto Next"]         = '',
      ["Switch Mode"]       = '<Tab>'
    }

    -- Warm up visual-multi after startup so the first <M-j>/<M-k> doesn't lag.
    -- Lazy-loaded VM otherwise initialises on the first cursor add, which is jarring.
    vim.api.nvim_create_autocmd('VimEnter', {
      once = true,
      callback = function()
        vim.defer_fn(function()
          pcall(function()
            vim.fn['vm#init_buffer'](0)
            vim.fn['vm#reset'](1)
          end)
        end, 800)
      end,
    })

    nnoremap([[<M-j>]], [[<Plug>(VM-Add-Cursor-Down)]])
    nnoremap([[<M-k>]], [[<Plug>(VM-Add-Cursor-Up)]])
  end,
}
