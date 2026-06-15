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
    -- Hide the kitty-graphics image while another window/float (e.g. fzf) covers
    -- it, then redraw once uncovered. Without this the image draws on top of
    -- everything since the terminal renders it above neovim's UI.
    window_overlap_clear_enabled = true,
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

    -- Show basic image metadata (dimensions, format, size) in a window-local
    -- winbar pinned above the rendered image. The winbar is tagged so it can be
    -- cleared again if the window later shows a non-image buffer.
    local image_exts = {
      png = true, jpg = true, jpeg = true, gif = true,
      webp = true, avif = true, bmp = true, tiff = true, ico = true,
    }

    local function is_image_buf(buf)
      local name = vim.api.nvim_buf_get_name(buf)
      local ext = name:match('%.([%w]+)$')
      return ext ~= nil and image_exts[ext:lower()] == true
    end

    local function apply_winbar(buf)
      local info = vim.b[buf].image_info
      if not info then return end
      for _, win in ipairs(vim.fn.win_findbuf(buf)) do
        vim.api.nvim_set_option_value('winbar', '  󰋩 ' .. info, { scope = 'local', win = win })
        vim.api.nvim_win_set_var(win, 'image_winbar', true)
      end
    end

    local group = vim.api.nvim_create_augroup('ImageInfoWinbar', { clear = true })

    vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufWinEnter' }, {
      group = group,
      pattern = { '*.png', '*.jpg', '*.jpeg', '*.gif', '*.webp', '*.avif', '*.bmp', '*.tiff', '*.ico' },
      callback = function(args)
        local buf = args.buf
        if vim.b[buf].image_info then
          apply_winbar(buf)
          return
        end
        local file = vim.api.nvim_buf_get_name(buf)
        if file == '' then return end
        -- `[0]` reads only the first frame so multi-frame GIFs yield one line.
        vim.system(
          { 'magick', 'identify', '-format', '%wx%h  %m  %b', file .. '[0]' },
          { text = true },
          function(res)
            vim.schedule(function()
              if not vim.api.nvim_buf_is_valid(buf) then return end
              local info = vim.trim(res.stdout or '')
              if info == '' then return end
              vim.b[buf].image_info = info
              apply_winbar(buf)
            end)
          end
        )
      end,
    })

    -- Clear our winbar when the window moves on to a non-image buffer.
    vim.api.nvim_create_autocmd('BufWinEnter', {
      group = group,
      callback = function(args)
        local win = vim.api.nvim_get_current_win()
        local ok, tagged = pcall(vim.api.nvim_win_get_var, win, 'image_winbar')
        if ok and tagged and not is_image_buf(args.buf) then
          vim.api.nvim_set_option_value('winbar', '', { scope = 'local', win = win })
          vim.api.nvim_win_set_var(win, 'image_winbar', false)
        end
      end,
    })
  end,
}
