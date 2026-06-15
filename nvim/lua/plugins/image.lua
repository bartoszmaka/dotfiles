return {
  '3rd/image.nvim',
  -- Loaded before any buffer content is read so `hijack_file_patterns` reliably
  -- fires even when an image file is the first thing opened (`nvim foo.png`).
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    backend = 'kitty',
    processor = 'magick_cli',
    integrations = {
      markdown = {
        enabled = true,
        only_render_image_at_cursor = true,
        only_render_image_at_cursor_mode = 'popup',
        download_remote_images = true,
        filetypes = { 'markdown', 'codecompanion' },
      },
    },
    hijack_file_patterns = { '*.png', '*.jpg', '*.jpeg', '*.gif', '*.webp', '*.avif' },
    tmux_show_only_in_active_window = true,
    max_width_window_percentage = 80,
    max_height_window_percentage = 80,
  },
  config = function(_, opts)
    require('image').setup(opts)

    vim.keymap.set('n', '<leader>mi', function()
      local image = require('image')
      if image.is_enabled() then
        image.disable()
        vim.notify('Image rendering disabled', vim.log.levels.INFO)
      else
        image.enable()
        vim.notify('Image rendering enabled', vim.log.levels.INFO)
      end
    end, { desc = 'Toggle image rendering' })
  end,
}
