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

    -- VM buffer-maps <CR>/<Up>/<Down>/<C-b>/<C-f>/<C-e> in insert mode, deliberately
    -- clobbering existing buffer-local imaps (see s:assign in autoload/vm/maps.vim:
    -- insert mode only logs "Overwritten imap" and maps anyway). On exit it runs
    -- `silent! iunmap <buffer> <CR>` & co., which *deletes* blink.cmp's mappings
    -- instead of restoring them.
    --
    -- blink re-applies its keymaps on InsertEnter, but bails early if the buffer
    -- still has any `blink.cmp: ` imap. <Tab>/<C-n>/<C-j> survive (VM doesn't map
    -- those in insert mode), so the guard always trips and <CR>/<Up>/<Down> stay
    -- dead in that buffer forever -- selection keys stop working and Enter inserts
    -- a newline. Re-apply blink's keymaps ourselves after every VM session.
    vim.api.nvim_create_autocmd('User', {
      pattern = 'visual_multi_exit',
      callback = function()
        local ok, apply = pcall(require, 'blink.cmp.keymap.apply')
        if not ok then return end

        -- clear blink's leftovers first, or its "already applied" guard bails
        local buf = vim.api.nvim_get_current_buf()
        for _, mode in ipairs({ 'i', 's' }) do
          for _, m in ipairs(vim.api.nvim_buf_get_keymap(buf, mode)) do
            if m.desc and vim.startswith(m.desc, apply.DESC_PREFIX) then
              pcall(vim.api.nvim_buf_del_keymap, buf, mode, m.lhs)
            end
          end
        end

        local mappings = require('blink.cmp.keymap').get_mappings(require('blink.cmp.config').keymap, 'default')
        apply.keymap_to_current_buffer(mappings)
      end,
    })

    nnoremap([[<M-j>]], [[<Plug>(VM-Add-Cursor-Down)]])
    nnoremap([[<M-k>]], [[<Plug>(VM-Add-Cursor-Up)]])
  end,
}
