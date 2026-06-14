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

      -- peek opens a standalone macOS webview window ("Peek preview") and
      -- exposes no geometry API, so reposition it to the right half / full
      -- height via System Events. Requires Accessibility permission for the
      -- terminal app (System Settings > Privacy & Security > Accessibility).
      local function position_preview()
        if vim.fn.has('mac') ~= 1 then
          return
        end
        local script = [[
          tell application "Finder"
            set deskBounds to bounds of window of desktop
          end tell
          set screenW to item 3 of deskBounds
          set screenH to item 4 of deskBounds
          set menuBar to 25
          set winW to screenW div 2
          set winX to screenW - winW
          tell application "System Events"
            repeat 60 times
              set didPlace to false
              repeat with proc in (every process)
                try
                  set targetWin to (first window of proc whose title is "Peek preview")
                  set position of targetWin to {winX, menuBar}
                  set size of targetWin to {winW, screenH - menuBar}
                  set didPlace to true
                  exit repeat
                end try
              end repeat
              if didPlace then exit repeat
              delay 0.1
            end repeat
          end tell
        ]]
        vim.fn.jobstart({ 'osascript', '-e', script })
      end

      vim.keymap.set('n', '<leader>mp', function()
        if peek.is_open() then
          peek.close()
        else
          peek.open()
          position_preview()
        end
      end, { desc = 'Markdown preview (peek)' })
    end,
  },
}
