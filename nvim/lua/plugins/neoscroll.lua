return {
  'karb94/neoscroll.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  config = function()
    local neoscroll = require('neoscroll')

    neoscroll.setup({
      -- Keyboard scrolling keys neoscroll should animate. Mouse wheel is
      -- handled separately below (neoscroll does not map it by default).
      mappings        = { '<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
      hide_cursor     = true,  -- hide the cursor while scrolling
      stop_eof        = true,  -- stop at <EOF> instead of scrolling past it
      respect_scrolloff = false,
      easing          = 'sine',
    })

    -- Animate the mouse wheel too. Two knobs control the feel:
    --   wheel_lines    = how many lines one wheel tick covers (distance / speed)
    --   wheel_duration = ms the animation takes (lower = snappier, less lag when
    --                    spinning fast, since per-tick animations queue up)
    -- `move_cursor = false` keeps the cursor put so the wheel just pans the view.
    local wheel_lines    = 5
    local wheel_duration = 15
    vim.keymap.set({ 'n', 'v' }, '<ScrollWheelUp>', function()
      neoscroll.scroll(-wheel_lines, { move_cursor = false, duration = wheel_duration })
    end, { desc = 'Neoscroll: smooth wheel up' })
    vim.keymap.set({ 'n', 'v' }, '<ScrollWheelDown>', function()
      neoscroll.scroll(wheel_lines, { move_cursor = false, duration = wheel_duration })
    end, { desc = 'Neoscroll: smooth wheel down' })
  end,
}
