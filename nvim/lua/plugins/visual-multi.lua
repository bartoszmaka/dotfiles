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
    vim.g.VM_custom_remaps = {
      ['v'] = '<Tab>',
    }

    -- Pre-source VM autoload files so the first <M-j>/<M-k> doesn't pay the parse cost.
    -- Calling vm#init_buffer / vm#reset here would corrupt state and crash insert mode,
    -- so we only `runtime!` the script files — no state-mutating function calls.
    vim.api.nvim_create_autocmd('VimEnter', {
      once = true,
      callback = function()
        vim.defer_fn(function()
          pcall(vim.cmd, 'silent! runtime! autoload/vm.vim')
          pcall(vim.cmd, 'silent! runtime! autoload/vm/*.vim')
          pcall(vim.cmd, 'silent! runtime! autoload/vm/maps/*.vim')
        end, 200)
      end,
    })

    nnoremap([[<M-j>]], [[<Plug>(VM-Add-Cursor-Down)]])
    nnoremap([[<M-k>]], [[<Plug>(VM-Add-Cursor-Up)]])
  end,
}
